Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B7A1F0E4A
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 12:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736254124; cv=none; b=ahyyZ4Zlife6IqW48fYKZIOhzFfB7rWB7llJMbcmznSgqw9fHMJs6v3aXHxjifEljChd1X8KdRr4tDcU5zoSbDlB90S7ngnLqhd5egQrQSTp+gh5JE6SLycbmy3d55zF+VzSYulPN28nCL3dNZVHyJXl6GVGT+EIbUDPn+tRaSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736254124; c=relaxed/simple;
	bh=lQNkgnscVwhFKnIfCCgbnvGXEkXqgXu1DDp9o960hwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iyQefAFgN3kZYmddumNhBvsGjX8/brq2wQ6yE/n1RWIMGJGeF/n3WTT/6eBFxtuNFanaQqdaV6iZI5aujJXzjqfF3xORVQ+OiCmo908fb6hE+4r4etresbUz5W/NXX3axQMTryVcWJeuG5huGTgJxOxSiDB5ElPzChmQjVjx7j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WKxFFqNp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OwPmZ0fH; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WKxFFqNp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OwPmZ0fH"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id B9DC51380265;
	Tue,  7 Jan 2025 07:48:39 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 07 Jan 2025 07:48:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736254119;
	 x=1736340519; bh=tBmbzhfvPgB19HVt8PzwZyIQ75NxXKpBSgWAdTDYLBM=; b=
	WKxFFqNpCgZ7xXeNjJwe5fnF8vSw/+rHFs8Dfs3i2h1aAsqw0PMB/lo52B7wy2IL
	s5Xg3CFgnP87AeotMZmVB4UnuD+CtoN+WJkaMXFHHm/karTa84npiivzCvTitzxX
	A5aglS8c76nBR+fcjY0EYaiNfp650yzU9Yiwwa7FHvwbvVUD7nSZidcyE44jfUFy
	J+prK4BWP+GOZEyOIzG7+Wvcq6jNSx0gixLRnXBzYfhSbbOMLiz8UBBlMUjDDRxu
	3GSjo3n8nAOUjZmc4xk9z1E3RAwwcs1sU9BgrwgggB/wF9NeY/UdtjdzczAYU0oC
	2cqrhhk6mCqekp+Mr7vDtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736254119; x=
	1736340519; bh=tBmbzhfvPgB19HVt8PzwZyIQ75NxXKpBSgWAdTDYLBM=; b=O
	wPmZ0fHRQpjk39eXcQUU0MRbKKsZaGdncivrTUsAOJUzs6T2kVNtQKO7iTUw4ASs
	2MXLWr0pdyxfwJyrGWosQo/aBX+d9GcFLfmsrFwCM6i/vT446kHzsAhR4S+tCKzZ
	Vu9EEe8xbuOYiLdF3nL5f7HmZBhMPw0+N1Dwv5nXvfo/AlaL7aBtG3zKQUOlXWS+
	Ldnz2NMs/tgCYseZNyBG9OnoOt4v+c2Q7bY7KDrgvQuwtak8nFHDTafe/Cs4QciF
	OzBTAr+WtfZ7zRLJ32/ZuRZKpKBFd2bz1lB5DkugDKPqRsmDE/sISG7g/IKvlZen
	cJPMHuK+1hCtPxzHee6IA==
X-ME-Sender: <xms:pyJ9ZwO5PALBQJrCNFfbpYlq6qn4F5FtML9c6-_J5hVJkJ0Sjldwhg>
    <xme:pyJ9Z2-UzfJqF5uTFUEpuiTbfoWeKYYyKcEbt5SvQwh_NwHAln2OoyNzAfvW5A8Wc
    jHqbwgKwr5PNByuNA>
X-ME-Received: <xmr:pyJ9Z3RFmCQN_1ZBkiB-G4lkQ1AbgrW6B2p8LYJbJ6gI35vepg2YYQ-j0WTpr1V6NZox0iGB1Ii9cdQewpADQyyf33l_4gM65gdxXuVJTaJo3g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegvddggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedvveet
    ffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    tghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:pyJ9Z4s2D0d2N6lrgMQhU4Xx0XYtqMh9THD_5F1YYxYvX4Zf3rlmBA>
    <xmx:pyJ9Z4ff4vpylM-4H7TBCTItLVAISJGnM5buGer5LZ0ZXBbG2C9gow>
    <xmx:pyJ9Z80Sx0rC-UinaeKzDYZuTsIzKgz8w3iLay3sk_qrASUB9vODoQ>
    <xmx:pyJ9Z8_AQD8qvRsbszq083vtXFqbcpGEm4__JEJ9vJUzDsLQhUIqKw>
    <xmx:pyJ9Zw4loDhNLvVjUSW9IgxrdFIlaNmLAEAlSijK1V3_gsgQ8zO8g3j9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Jan 2025 07:48:38 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c7f628c5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 Jan 2025 12:48:37 +0000 (UTC)
Date: Tue, 7 Jan 2025 13:48:36 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH v2 2/5] ci: merge linux-gcc-default into linux-gcc
Message-ID: <Z30ipNB88iyaWMBT@pks.im>
References: <20250106-pks-remote-branches-deprecation-v2-0-2ce87c053536@pks.im>
 <20250106-pks-remote-branches-deprecation-v2-2-2ce87c053536@pks.im>
 <CAP8UFD1ALC2f9iQady35MCdm18V3u9+b0iRhgx2Zd_UTeCY8vA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD1ALC2f9iQady35MCdm18V3u9+b0iRhgx2Zd_UTeCY8vA@mail.gmail.com>

On Mon, Jan 06, 2025 at 02:25:23PM +0100, Christian Couder wrote:
> On Mon, Jan 6, 2025 at 8:51 AM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > The "linux-gcc-default" job is mostly doing the same as the "linux-gcc"
> > job, except for a couple of minor differences:
> >
> >   - We use an explicit GCC version instead of the default version
> >     provided by the distribution. We have other jobs that test with
> >     "gcc-8", making this distinction pointless.
> >
> >   - We don't set up the Python version explicitly, and instead use the
> >     default Python version. Python 2 has been end-of-life for quite a
> >     while now though, making this distinction less interesting.
> >
> >   - We set up the default branch name to be "main" in "linux-gcc". We
> >     have other testcases that don't and also some that explicitly use
> >     "master".
> >
> > So overall, the job does not add much to our test coverage. Merge it
> > into our "linux-gcc" job to reduce our test matrix a bit.
> 
> I understand that the subject uses "merge" as the space is limited
> there, but it might be better to be a bit more explicit here about
> what the patch is doing, which is:
> 
>   - making the "linux-gcc" job use the default version of gcc provided
> by the distribution (which is ubuntu-20.04) instead of "gcc-8",
>   - removing the "linux-gcc-default" job.

But isn't that what "merging" is about? One merges the diff of side A
into B and then removes A. I don't have an idea for a better subject,
honestly.

> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  .github/workflows/main.yml | 4 ----
> >  .gitlab-ci.yml             | 4 ----
> >  ci/lib.sh                  | 5 -----
> >  3 files changed, 13 deletions(-)
> >
> > diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> > index 808ddc19b8a799abc414c6d6ba078a6e5be6bdfb..32d35d2257812f02121b20c3cae342d626481553 100644
> > --- a/.github/workflows/main.yml
> > +++ b/.github/workflows/main.yml
> > @@ -271,7 +271,6 @@ jobs:
> >              pool: ubuntu-latest
> >            - jobname: linux-gcc
> >              cc: gcc
> > -            cc_package: gcc-8
> >              pool: ubuntu-20.04
> 
> So linux-gcc uses ubuntu-20.04...
> 
> >            - jobname: linux-TEST-vars
> >              cc: gcc
> > @@ -286,9 +285,6 @@ jobs:
> >            - jobname: osx-gcc
> >              cc: gcc-13
> >              pool: macos-13
> > -          - jobname: linux-gcc-default
> > -            cc: gcc
> > -            pool: ubuntu-latest
> 
> ...while linux-gcc-default uses ubuntu-latest.
> 
> This is not a big issue but I didn't see that mentioned in the
> differences between the two jobs listed in the commit message.

Fair, added now.

Patrick
