Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6A5277C9A
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 21:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761167955; cv=none; b=Dpw96i082x1A0y+mc2v1MaFUyMSo7iT3EsqT+dB8aSC3PSt2JvaWE+nYVbZEGj88J4iQB6oS4Z/U+8H3A9MIRxCqAKc9TaawX3VcmtTc8IoCwMxj3wtCqmzUO4k0Nzur8gworyrhqDmsXDVMtGMyC87W3iQeBGLX0ZcqIqwxjKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761167955; c=relaxed/simple;
	bh=V7SO6wqsUXQwb5STXa2sFdElwsRGM8PZEDuaC4sdg8E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Wr1jUm14yWMSBV2clCU159u9AhugpU/LwjhhwUVu2A0qoPIU+0rHxp/Etpbi6sfTtSmlDJBhNWFoAXKwnR++0RX6tl6dfNnK+vLxDw1ARmDAPKSIuzAYlm02g1EfLdAFpO+XxeFNAibW4cVwU119p7HfBgYDeS85BYay+QBypmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VtZuBnLv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=v7Z4+28O; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VtZuBnLv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v7Z4+28O"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 6F2D6EC01CE;
	Wed, 22 Oct 2025 17:19:12 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Wed, 22 Oct 2025 17:19:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761167952; x=1761254352; bh=E8rKdkbZNP
	jxCd8Wskx7vHxRpoytR2NugGMjxjAtG8o=; b=VtZuBnLvlrBgY3nv01CjC6r83h
	1qK0x32ezKBBIxIXrU4Q4zPqEIVuOnK0oRSopt9Q52EQewZFW/kZfFgcSFW45Vki
	q2R7q9/B5LWhk5JMtVx2PtoWyf0ybuB9z7ldeOKSLpchT757/1sJSsd2Qr4UeXf+
	3yCngrMqrCVTJujViGmGgf7OmXM0ERudoSpqD+s6+2seeib6fX87fwD7UroyvEs6
	aaXiUfG/YTRlwXRLsuR36eUr/Q8a88nEJ/L8d5xSoW/yFk4+60NfiLa+LAiC+81e
	niAtV4GCcDpbfc/Dos2rlzlr0Ps1smRcu9Fql0mmrkCeEzuOWmSAiQX0hhcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761167952; x=1761254352; bh=E8rKdkbZNPjxCd8Wskx7vHxRpoytR2NugGM
	jxjAtG8o=; b=v7Z4+28O3+6pa6iKUrseAMk/xRKZqXrVJdfGeX2cypGEbGltDw0
	W4A2dq9ySyo27fMsfp6iwHQ8XkvRT7H/eRDrIuCW9BGsuzkFnwWCJar0MuqD9wBW
	IF0mtEdSe2PvvV9Qc1v7XBcC5fUaQXINoS5xci/Xj9/D376nJmEOLH6i9A3fmr+U
	s6fSi40Hpw3IvLcWwgXQ9UdI/7ooBjH622ZdWUhu6h3hcfszo11dhvmAItfH9cuM
	UFZdbTcpewHyK3g/wOKY66xajPKzh6M8AV+fKpsJJntFHeH/aoADik1ihgrhBu+1
	3ICg0Ohysb7YW4K5vUGTdjjihreOlcfXkEw==
X-ME-Sender: <xms:T0r5aPPU5D25c3L0SBwwEU-mFC33juT2Q2jLy9hDRTTPP3K3KtEK9A>
    <xme:T0r5aFydi6h95-n7tRIMCMMzs9gsX-OjHUh8c8U-PrEMeZ1Zxupxw3nuK-G-lBXuc
    vfPqey4lC76Y_E03NgtAe7_pEW2ouge7B-GCYlEm5ChkWcElHWv6g>
X-ME-Received: <xmr:T0r5aEvMCSfx8h6Z7BIEI9yeWKs-WObQBJnuoQqQ1tXkw_7F10uEB-NIGjIGUO3QA0tqY4CydihRuVfrSd72ZNttnxEuaWRjqDL_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeegieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepudehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehsihguughhrghrthhhrghsthhhrghnrgefudesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgt
    phhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtph
    htthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdr
    ihhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtph
    htthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:T0r5aAZjBmBLcEZ0jUlT1ddL1VmU_D1kUDY601TmXZD1_G2aGkrA6Q>
    <xmx:T0r5aL0A4lA10ssC32Ar0goMZQeAafFu9GvAF642WxxkUjIu-PF4YA>
    <xmx:T0r5aKuOA3LZeJ1j5ucrn7OSTqP0k2EgFkb2OR5w66jmqSUb_b5alA>
    <xmx:T0r5aHAw5-ORkRakTeKlgAHD5vRgP177I_xXY6WlvYRA0qNejpI3qQ>
    <xmx:UEr5aHDu8CANCPMJGRRkccWoI9kRZToDznRY_vkzXl92PvDNyFty91_H>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Oct 2025 17:19:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Siddharth Asthana <siddharthasthana31@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,
  phillip.wood123@gmail.com,  phillip.wood@dunelm.org.uk,
  newren@gmail.com,  ps@pks.im,  karthik.188@gmail.com,
  code@khaugsbakk.name,  rybak.a.v@gmail.com,  jltobler@gmail.com,
  toon@iotcl.com,  johncai86@gmail.com,  johannes.schindelin@gmx.de
Subject: Re: [PATCH v4 2/3] replay: make atomic ref updates the default
 behavior
In-Reply-To: <20251022185045.29256-3-siddharthasthana31@gmail.com> (Siddharth
	Asthana's message of "Thu, 23 Oct 2025 00:20:44 +0530")
References: <20251013183311.33329-1-siddharthasthana31@gmail.com>
	<20251022185045.29256-1-siddharthasthana31@gmail.com>
	<20251022185045.29256-3-siddharthasthana31@gmail.com>
Date: Wed, 22 Oct 2025 14:19:09 -0700
Message-ID: <xmqq7bwmy6r6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Siddharth Asthana <siddharthasthana31@gmail.com> writes:

> diff --git a/builtin/replay.c b/builtin/replay.c
> index b64fc72063..1246add636 100644
> --- a/builtin/replay.c
> +++ b/builtin/replay.c
> @@ -20,6 +20,11 @@
>  #include <oidset.h>
>  #include <tree.h>
>  
> +enum ref_action_mode {
> +	REF_ACTION_UPDATE,
> +	REF_ACTION_PRINT
> +};
> +

We allow and encourage the last item in enum definition to have
trailing comma, i.e.

        enum ref_action_mode {
                REF_ACTION_UPDATE,
                REF_ACTION_PRINT,
        };

unless the last one is somehow special and we are not supposed to
add any new item after that (e.g., a sentinel REF_ACTION_MAX that is
supposed to give the upper limit of the values).  That way, future
developers can add new items with minimum patch noise.

> @@ -434,10 +491,15 @@ int cmd_replay(int argc,
> ...
> +					ret = error(_("failed to update ref %s: %s"),
> +						    decoration->name, transaction_err.buf);

Hmph, don't we want to use '%s' when reporting the ->name thing?
Documentation/CodingGuidelines has this:

   Error Messages

    - Do not end a single-sentence error message with a full stop.

    - Do not capitalize the first word, only because it is the first word
      in the message ("unable to open '%s'", not "Unable to open '%s'").  But
      "SHA-3 not supported" is fine, because the reason the first word is
      capitalized is not because it is at the beginning of the sentence,
      but because the word would be spelled in capital letters even when
      it appeared in the middle of the sentence.

    - Say what the error is first ("cannot open '%s'", not "%s: cannot open").

    - Enclose the subject of an error inside a pair of single quotes,
      e.g. `die(_("unable to open '%s'"), path)`.

    - Unless there is a compelling reason not to, error messages from
      porcelain commands should be marked for translation, e.g.
      `die(_("bad revision %s"), revision)`.

    - Error messages from the plumbing commands are sometimes meant for
      machine consumption and should not be marked for translation,
      e.g., `die("bad revision %s", revision)`.

    - BUG("message") are for communicating the specific error to developers,
      thus should not be translated.

