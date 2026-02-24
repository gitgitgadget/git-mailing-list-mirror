Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206CE1C84B8
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 22:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771972922; cv=none; b=DFZR3YX5r4ichi6u8kPskWHc2jE/wypl9UahYan6+/pi1Kvq2Ex/czmrLB738tKraCt7AcERyffQ7o991yCvzsuZD8APXO9XE5QHSlo9vC7pLUF7PuYlRlzGulPTMwA6U8hF3immzgriVUeQQM3DfADSqaNGzI4XWq8oXUORTuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771972922; c=relaxed/simple;
	bh=fmm76pfFy3FnOgQKAImQtv2ObC/6V+HZo6+V1w4VnBc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p3a7sKoPrvWXPKusXJrfvlzc1mrnAoqKAbzuLnijLWDhChddmRSsC1i/kBwgDW945GzqAq4Sqbhv+d7ecugOzyMUvRheV69PG4a9bW1LIz+ouSApgdVFkjZU8OzjBLtneboSFiTFwfnIox2P5VcJyQSqMLWBPsVHSzx4heznBsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fGEdKjZ7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E+mqQGfV; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fGEdKjZ7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E+mqQGfV"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E56617A010D;
	Tue, 24 Feb 2026 17:41:59 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Tue, 24 Feb 2026 17:42:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771972919; x=1772059319; bh=Ols/UNCIlb
	QMZJFLv2RarZg/S59xiIZfrvBinZPNVRw=; b=fGEdKjZ7Ig0Oz/jOx0R8Rz4SjH
	mBGJ0BdQ9K7xPkWNrGE4laO6Qg99X1lrdMYtxCV4eRJPciobEyGdpost8sdTrRcK
	f61Fmq9nFwbPVpUQjkc5+1dTqu4WpDOusWN7Vk1w43nYrW1cuXhZtP2DlQQNcyd4
	Xv9SB64QYOHltIBx2yOa0mM1rxZyhNSJjoteq/ckVy60ntHNltFZap1dQgDJNZ8p
	Qr8vnWvCVPeum9B+hFbel5HjbybEF8dvvJyuoIu3yMLZhE+LGl3RcWBlg1wRLwbC
	xWCuJyMr8D02kY0uNbOGdlDItxilhOpMLgmnLJa8N6VMXizK4j3fbnUlJZXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771972919; x=1772059319; bh=Ols/UNCIlbQMZJFLv2RarZg/S59xiIZfrvB
	inZPNVRw=; b=E+mqQGfVXf+PAryMOOsHPFnzHzNfqVn4iqBTjAtfM0dGYagTbS4
	teQ7VppG7Vi/Z4wyCHlvM5IeqNfvmfs4AvT9/ZqW+y+ykbAl/1RwdHtnnRg+BU6B
	rk58WAGbzi4Rop9rkPa/uZxxCIjKIFIjXovB7nP2CjZh9+MUwKhnhJL/u9L3Z47W
	RgCb9OQ2ZoTHEpBOCSFEvSaG++MnAciBjLlS4U5bV9BtAyRXsD2sR6DxdJ593Xmh
	zZap3+dxrnEkUWT70jw4FjSqVHzYpmG7Oior9DsB7uUvjKihQh6d+HOBBk30UB1u
	4tkn0DN9dc/Te0/eEbaPBGSl0ETEUARGEkg==
X-ME-Sender: <xms:Nymeafr-Vd9BhnD_LXkkrT80kw52ykNR-LhC7u-gdx0_aP3CQVJ_LA>
    <xme:Nymeab4w-DOIN_XwyfgWsO32-SkjJv8NAN9kvG2kzFS0TA-TXulWVRuOps1aKKvqX
    NyFoPqy-3kK9mqOqY9yIybiEEfVbgH0S6oYu_vV2xVtCtL6BqXESQ>
X-ME-Received: <xmr:NymeaedQ47qBQZXWqMXrxKAtWpUHqdnqBDzafqzvSh9RBKhjSdX_EBrU9ASAyM1m3cA1yDBJH6xVEwSxtJw3UKwtL23RwY-weg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgedugedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhephefgjeevuedujedvvdeigedtheffueekueetheelfefhueelgfdtffffgfet
    gedvnecuffhomhgrihhnpehgihhtrdgtihenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggp
    rhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjohhnrghtrg
    hnsehjohhnthgvshdrphgrghgvpdhrtghpthhtohepjhgrtghosgdrvgdrkhgvlhhlvghr
    sehinhhtvghlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepsggvnhhk
    nhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhush
    hthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:NymeaY5qHEPv8WJWK9kuoZ_EKDg0LarulMZDGbep2fDJlIRGB3rcIg>
    <xmx:NymeadvGccFPU6bfr0YAF705GoWcr-iIZ7howxyacq3OA3yncXN-ig>
    <xmx:NymeaQjNSyREpljCNQ7uNJw7jt9FA36mQP8U_mt_zww6sDb8nBFxCg>
    <xmx:NymeaQrYtfVSn1pCG7EOLxE3A6gS8SJzPtnh6VQggpVsXQ5anA9OZQ>
    <xmx:NymeaaZhtn4YcqxdhawxYO12QJqvtQzWyLNwH8fwW8adVdquCNBsqC1P>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Feb 2026 17:41:59 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jonatan Holmgren <jonatan@jontes.page>,  Jacob Keller
 <jacob.e.keller@intel.com>
Cc: <git@vger.kernel.org>,  <peff@peff.net>,  "D . Ben Knoble"
 <benknoble@gmail.com>,  "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v7 1/4] help: use list_aliases() for alias listing
In-Reply-To: <6953f6f2-22e8-4efb-8169-395e1c52634f@intel.com> (Jacob Keller's
	message of "Tue, 24 Feb 2026 14:19:36 -0800")
References: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
	<20260218215737.1181147-1-jonatan@jontes.page>
	<20260218215737.1181147-2-jonatan@jontes.page>
	<6953f6f2-22e8-4efb-8169-395e1c52634f@intel.com>
Date: Tue, 24 Feb 2026 14:41:58 -0800
Message-ID: <xmqq1pi9epc9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jacob Keller <jacob.e.keller@intel.com> writes:

> SUMMARY: AddressSanitizer: 1453 byte(s) leaked in 37 allocation(s).
>
> This leak occurs because you now copy and store the value of the alias 
> in the util element, but the call of list_aliases() in list_cmd() 
> doesn't clean these up, since its string_list_clear passes 0 to the 
> free_util argument.
>
> The following fixed it for me:
>
> diff --git c/git.c i/git.c
> index 744cb6527e06..aeb099ab1162 100644
> --- c/git.c
> +++ i/git.c
> @@ -119,7 +119,7 @@ static int list_cmds(const char *spec)
>          }
>          for (size_t i = 0; i < list.nr; i++)
>                  puts(list.items[i].string);
> -       string_list_clear(&list, 0);
> +       string_list_clear(&list, 1);
>          return 0;
>   }

Thanks. This looks like one of the right things to do.  I checked
all list_*() that are called from the loop in this list_cmds(), and
list_aliases() is the only thing that uses .util member of the
string_list_item instances.

However, we need to be a bit careful with list_cmds_by_config().  It
sorts the list accumulated so far, uses remove_duplicates() on it
without passing free_util=1, so there is also the same kind of leak
there, I suspect, until we adjust the call there.
