Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9651E5701
	for <git@vger.kernel.org>; Sat, 22 Feb 2025 02:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740191213; cv=none; b=eipYGkAieINDab0skkLueKUsX3M6R5UMgLKhltNEm4kI1q8uT00I9+4LLnfAdwoRZN03bDhYBlK04NmNSlrx2fI0vQZGwpFj4JhPngw/yVoK8TkpGzuWroJsTyjIxIok7JVu4C4golRGfKhUsahjOtai9Q5DZrpt4beGn1YQUR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740191213; c=relaxed/simple;
	bh=7oX4cn/50BcE5XfTOjxG8ZS9i9N0UHUYm9MG3bPlqiI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=StuBpymG2aew4h/hXl2edtrHQiEgEtikzCYs18ts5K/u//UzEdtyZluUeeycMCZR9J44EnmPnaRhr7UWbbuCkEpIm9+CX4kb90BqglkSvF4kizJvvE3x2wkWbUmw6zvMZ+8a8r4ZsMu+su3SAeVS2fwaKEdRpBqgLP7u6nR8HLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=03v9938j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RSS3b8pZ; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="03v9938j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RSS3b8pZ"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id C73A113809AB;
	Fri, 21 Feb 2025 21:26:49 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Fri, 21 Feb 2025 21:26:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740191209; x=1740277609; bh=Xbi/uNrM0J
	GDfW1aTau2lQpvXTkw1QT6dMMUp7niWWk=; b=03v9938jXtLemzpbFqSUOg4msE
	xb6NySEbdA47+A3B4/po+Hb/FpCb0nyR2Zy42LlMSmPDKXV3t6/LgcxL9FMp4QN4
	zj+jsgRbf1UQEhwy0CjjCEHjtNdohHYPBPSWb/V23lIZiYCW/Wo6Q0EaJyb6L+Z/
	YqWw5aD/RbdPb/U4IjPxAtreAmepCv3brA4/kJPSQ8MfUnk3COHDQEGnXnMB+EZ+
	DC/wdzzhBmwD+YdvZhhtr/XQypgTtvbMqJ8aLn7iM9adjlWwmaBrJgtq4+Jka/Q1
	s2DQjgutabpVdHCMunSdUSruraG4vlrJKYThsSxHRjtGJ81KSI9xFQ3TA0rA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740191209; x=1740277609; bh=Xbi/uNrM0JGDfW1aTau2lQpvXTkw1QT6dMM
	Up7niWWk=; b=RSS3b8pZw09/uo8PRw90N7fbKJmQ8DR4IHNNJfxLpwrNdLsh6ol
	cq0LsXDym1ItGmD9Ingv/ISi6yns/W9BwhJXspNczr2lqImHdVAAwM2KlwPsqze1
	8G3c+xK2XbYDIWT6helBcFV7cuJ4Np8Qp306iEEPu7A7/mnO71J6KRDfApxx32yf
	V4dMcP4ZOoSfPk8CNjgeePL7JffjoepeGWfvu8OtDMFhQviyvqEUsOY6afMD//D6
	HOfbttX200uxZwAIxsRfBMZWcjOdNlbCNs2D755TzxCF5adbI4Aji5mgnBzX72pS
	lWou0s92hTEMoZR8EPgRmmwNKicvvQ/BFqg==
X-ME-Sender: <xms:6TW5Z6FKYV-gvys5zJzl64TgYnjYRnwe8UVZAXfSiC-3Ptt88ewqLg>
    <xme:6TW5Z7WI27dcuSfjG7H46sQLZx1M9bHge_QbFhZaVGtcFFCD_0AuQbYjEmrJYuI5q
    fbXc8JvQAhiqUjAGw>
X-ME-Received: <xmr:6TW5Z0IriHmbKPm0aU5XlWDbM5Ru0ICJE5XIs14sLYiMwr1h_maF5RKOJWz0MvvkcEabniUJfGtJ72oxQvlI1grW7Oc6pVPBRwdtOZk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejudeilecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeettddtveffueeiieelffeftdeigfefkeev
    teevveeutdelhfdtudfgledtjeeludenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhs
    thgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepjhgrtghosgdrvgdrkhgvlhhlvghrsehinhhtvghlrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hjrggtohgsrdhkvghllhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:6TW5Z0Ejk3f5dBv4yAgTu3ItihFsr2uUz2xfAkJ3NUHIBGfzHxbbSg>
    <xmx:6TW5ZwUtgjWzQD21ySdaEUftNdvUiWXRDV3Aqj8-CdmQSkRlzTb7vQ>
    <xmx:6TW5Z3NFYhQrPrs-4pTHoYhefRvXMecj5UZ8OtPkib7e94lIcuCI1Q>
    <xmx:6TW5Z3113ioORhZ_cx9f4eYxyfy7UbL3SSIcvU9Onu9kn7cOvErdpg>
    <xmx:6TW5Z-xWqKTtvGE5k8IOnevsnEwhJFs-2S44rRzIKvxbyxyQiwr6HnGE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Feb 2025 21:26:49 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: git <git@vger.kernel.org>,  Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v2] mailmap: fix check-mailmap with full mailmap line
In-Reply-To: <20250221-jk-fix-sendemail-mailinfo-v2-1-9aca7dc05dbb@gmail.com>
	(Jacob Keller's message of "Fri, 21 Feb 2025 15:47:58 -0800")
References: <20250221-jk-fix-sendemail-mailinfo-v2-1-9aca7dc05dbb@gmail.com>
Date: Fri, 21 Feb 2025 18:26:48 -0800
Message-ID: <xmqqh64m90k7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jacob Keller <jacob.e.keller@intel.com> writes:

> From: Jacob Keller <jacob.keller@gmail.com>
>
> I recently had reported to me a crash from a coworker using the recently
> added sendemail mailmap support:
>
>   3724814 Segmentation fault      (core dumped) git check-mailmap "bugs@company.xx"
>
> This appears to happen because of the NULL pointer name passed into
> map_user(). Fix this by passing "" instead of NULL so that we have a
> valid pointer.
>
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---
> Changes in v2:
> - Just fix the NULL pointer dereference, leave mailmap resolution as-is
> - Link to v1: https://lore.kernel.org/r/20250213-jk-fix-sendemail-mailinfo-v1-1-c0b06c215f21@gmail.com
> ---
>  builtin/check-mailmap.c |  2 +-
>  t/t4203-mailmap.sh      | 12 ++++++++++++
>  2 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/check-mailmap.c b/builtin/check-mailmap.c
> index df00b5ee13adb87881b8c1e92cac256e6ad319d1..be2cebe12152e38d3bb8cf12948823c8d710bdda 100644
> --- a/builtin/check-mailmap.c
> +++ b/builtin/check-mailmap.c
> @@ -35,7 +35,7 @@ static void check_mailmap(struct string_list *mailmap, const char *contact)
>  		mail = ident.mail_begin;
>  		maillen = ident.mail_end - ident.mail_begin;
>  	} else {
> -		name = NULL;
> +		name = "";
>  		namelen = 0;
>  		mail = contact;
>  		maillen = strlen(contact);

OK.  I audited all users of map_user(), and everybody else
(including the other side of the if/else we see here) follows the
pattern to point name and mail into an "ident" instance, which would
never be NULL.  The way an "ident" instance signals that there is no
name is to have the name_begin and name_end members point at the same
byte.

So this change obviously is a good thing to do.

The callee, map_user() does assume both email and name pointers
point at valid strings, passes them to lookup_prefix(), and have
them receive what a mailmap_info instance records.  We may want
to document the calling convention a bit better, but that is
obviously outside the scope of this immediate fix.

Thanks.  Will queue.


> diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
> index 24214919312777b76e4d3b2b784bcb953583750a..4a6242ff99b59ea1a46eb14ca812c94e5e620162 100755
> --- a/t/t4203-mailmap.sh
> +++ b/t/t4203-mailmap.sh
> @@ -113,6 +113,18 @@ test_expect_success 'check-mailmap --stdin simple address: no mapping' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'check-mailmap name and address: mapping' '
> +	test_when_finished "rm .mailmap" &&
> +	cat >.mailmap <<-EOF &&
> +	Bug Reports <bugs-new@company.xx> Bugs <bugs@company.xx>
> +	EOF
> +	cat >expect <<-EOF &&
> +	<bugs@company.xx>
> +	EOF
> +	git check-mailmap "bugs@company.xx" >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'No mailmap' '
>  	cat >expect <<-EOF &&
>  	$GIT_AUTHOR_NAME (1):
>
> ---
> base-commit: b838bf1938926a7a900166136d995d86f8a00e24
> change-id: 20250213-jk-fix-sendemail-mailinfo-32f027b1b9e7
>
> Best regards,
