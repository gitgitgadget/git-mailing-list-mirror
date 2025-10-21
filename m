Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499A732ED44
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 11:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761047027; cv=none; b=C3tWalvTEhR1B+9HAZ/kMOn9qPNd0r/3UQacEGS1R53BNjjyVdYlYj0a8Ve9ktLo0RE3Lo26taXl4UeQJIoPpb3wXYd7VGdW8K4JsweSYzuO0sFLF16YHHW6gCgjAHFqnUk4ZPq9hmbo/peEgiCpHVvMF1MACHHLdk5Y7b/YkD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761047027; c=relaxed/simple;
	bh=PKnD/MxvRC2ywGFuqzViYGLAqryUZy8T86HKdwFttMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cha2ZcMlJ5AFbxPyr/4yt1nhcUVT7UImtYvSNcPMhVkWiTX9cLMoL61X4xtttKQTZa38MbafUHDvJ8yZLCERwb+gDczJgFgmheqXrv2igr07OyU17UXzbHgGteh9w0Fblv5y5APHhRmrAzv2WHPW8qmvHrVzqPVZ9tUrTIPifK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DF5RBbTM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q7MUQewM; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DF5RBbTM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q7MUQewM"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 7AD0EEC0128;
	Tue, 21 Oct 2025 07:43:44 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 21 Oct 2025 07:43:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761047024; x=1761133424; bh=w2OB6n045i
	fF7GJzg80f0h4wjC9EAonrKJ4FlePDVpc=; b=DF5RBbTMbDLDwVZYYmzP9vhBfD
	wpVuKJXA5olX/eD+La9PAnRvDvqD0Uo8xPESek/KCqqsWU1Q0ONW1L8puuD9leQJ
	z0xh2Sq/4WrtX1nsTHMRTfUeOU6E0POXolW5tcsMO57Jsj7pFzFm8TWLs+ryX4gy
	ZhAONS3yKlJRQqhbT/gTxf7dSXxA138OsDms4If2hcIPvvH6zSxx+Ml4nqg7NUno
	8zYK4mFfOtVQZhsVYzvAiTuldVjAQOiy+IRG9UCtBvvoUbW9B8ANdydf25Hs0ETp
	kWlc/6Q+eOD0p+d42d9sAyksPnWjH5C4QrkGPG4It9g3G3SRU4cv25sSY4eQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761047024; x=1761133424; bh=w2OB6n045ifF7GJzg80f0h4wjC9EAonrKJ4
	FlePDVpc=; b=Q7MUQewMxR9KsU3hYiSevA+dgeY4iQtYFhkwy+mzQhN4B8Khb2e
	ixiuc+pm0paQuWU6LspFvK/qhaBHaHNmndmdPYUB/ClT9mLEaBZh8K8nlP1oOcRf
	BXld5bsnxf9bKULXYwBBtabq7PJau+hizTs10KhvixZPttMdG8L4gp8kTzTiQ2oK
	M4ZSv3y+Ol6xeJST83sPlndlDhHFrBbBGBfXyo9yosS+5unv9ro5S917v6+JRBbq
	8I2SUkXChNwn7koS3xfjUlO9bsO+0PpznX79OJ/4wnP80Vg5eySNdPYyV4+4i/Dk
	TUWv0RUj+BzEWHtwWfEBj3jGqmu1T+SeOhA==
X-ME-Sender: <xms:8HH3aEuPHRhjTWhh0-ghh51O6DxnXyKEE6ItetqtRFeguPhdDKFHlA>
    <xme:8HH3aEBFKynTF0xgLzROOrKnGSgraFlKnlpz1EnG2fjgFWWQvTK-DwHfj78TmmcLy
    U53FvXjPx0039PlINZC2O1hN8O8N2eFB5AwpZkUL3Mj_FBWD3r1Qvo>
X-ME-Received: <xmr:8HH3aDbRwUWC4k3ChzxsHUoKi6XorzP2N06zbFjyogD9oOrg_MxcqQCuLHAQYSzfKTwGe5L4H5n1JPKF6A5BxG-nUEo02_BPb0s3H_1Rg9phqg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedtieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhhishhtoh
    hffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrh
    gvvgdrfhhrpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepshhorhhgrghnohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrrh
    htihhnvhhonhiisehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudek
    keesghhmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:8HH3aHVN0ZTi3WcuYmkBYYf8I_7gaRFCquv1u2R0ggg39_cLULYWBg>
    <xmx:8HH3aKNIEcg4EB3_es6o18nZFBv-Y8scNDfmDwTjeuk3ZnbV-hkldg>
    <xmx:8HH3aJYVhBiWMeugE4Am7fLDJJgHwlq72jyD3iJh7IUmFMw_wXcB6w>
    <xmx:8HH3aB_x8N7pwemBDlJMcdsFm09S8SsxqPtIB-ClainbT9G8KB2I9w>
    <xmx:8HH3aM5y7Xgn4D-VU2VbZ-Av569MPaA37Q6sUkKpKrOmkLQwu5MMKbKV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 07:43:42 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c131cd9b (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 21 Oct 2025 11:43:42 +0000 (UTC)
Date: Tue, 21 Oct 2025 13:43:39 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sergey Organov <sorganov@gmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v4 05/12] builtin: add new "history" command
Message-ID: <aPdx68-hxXBBKOc6@pks.im>
References: <20251001-b4-pks-history-builtin-v4-0-8e61ddb86317@pks.im>
 <20251001-b4-pks-history-builtin-v4-5-8e61ddb86317@pks.im>
 <CAOLa=ZQSc0jHv9gK5T06GA_mprknucwCj5H_M2djZ-UWfRMbJQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQSc0jHv9gK5T06GA_mprknucwCj5H_M2djZ-UWfRMbJQ@mail.gmail.com>

On Tue, Oct 14, 2025 at 05:07:03AM -0400, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > new file mode 100644
> > index 0000000000..1537960374
> > --- /dev/null
> > +++ b/Documentation/git-history.adoc
> > @@ -0,0 +1,45 @@
> > +git-history(1)
> > +==============
> > +
> > +NAME
> > +----
> > +git-history - EXPERIMENTAL: Rewrite history of the current branch
> > +
> > +SYNOPSIS
> > +--------
> > +[synopsis]
> > +git history [<options>]
> > +
> > +DESCRIPTION
> > +-----------
> > +
> > +Rewrite history by rearranging or modifying specific commits in the
> > +history.
> > +
> > +This command is similar to linkgit:git-rebase[1] and uses the same
> > +underlying machinery. You should use rebases if you either want to
> > +reapply a range of commits onto a different base, or interactive rebases
> > +if you want to edit a range of commits.
> > +
> >
> 
> The either..or in the last sentence is a bit confusing; as it is not an
> either between 'want to reapply a range of commit onto a different base'
> & 'interactive rebases'.
> 
> Perhaps we can simply s/either//

Fair.

> > diff --git a/builtin/history.c b/builtin/history.c
> > new file mode 100644
> > index 0000000000..f6fe32610b
> > --- /dev/null
> > +++ b/builtin/history.c
> > @@ -0,0 +1,22 @@
> > +#include "builtin.h"
> > +#include "gettext.h"
> > +#include "parse-options.h"
> > +
> > +int cmd_history(int argc,
> > +		const char **argv,
> > +		const char *prefix,
> > +		struct repository *repo UNUSED)
> > +{
> > +	const char * const usage[] = {
> > +		N_("git history [<options>]"),
> > +		NULL,
> > +	};
> 
> Nit: We have pointer alignment set to 'Right' in our styling guide and
> also mentioned in our 'Documentation/CodingGuidelines'
> 
>    When declaring pointers, the star sides with the variable
>    name, i.e. "char *string", not "char* string" or
>    "char * string".  This makes it easier to understand code
>    like "char *string, c;".
> 
> The rest of the patch looks good!

This is one of the common exceptions though:

    $ git grep 'const char \* const' | wc -l
    186
    $ git grep 'const char \*const' | wc -l
    108

So when there is another keyword following the asterisk we tend to have
an additional space inbetween. We tend to only drop the space when the
next token is the variable name.

Patrick
