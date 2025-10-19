Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6021870808
	for <git@vger.kernel.org>; Sun, 19 Oct 2025 16:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760889642; cv=none; b=RTwX+/x4JUFLYMfzlqugIJNvD9BPYzTy9UapiwX7eH2SEic9Fe1/wjGwKOfLI+oMqYRLNs7AKvk8USq3Oi2maRmCl8Wxcx7olelbXvD5toNMiJafXTkJDCeXg2ky3OnC4NIBIkDQ3MwD25H+Sj2CsWPEM7TkFU2/qtxwU1nUzhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760889642; c=relaxed/simple;
	bh=gvZTlY9CMlSdqBIMptx8sokdmSV+66Bscq7b87KEFsg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HyupU3Yu3/l2c1F5SlMSF5Wl3ckM43tvM2MF99WcaaROX8jw/shaQTOeqvJ54jvqotShwCVk8/2nxa5tVYPm65ngJMlu2kqNWGgpLXTTYTEE6CQJ0otpA7/BWoT+oVarfm7zaDd0/Edy22DS8nT9poGhQczJqOWUMhWSSv/sfC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GMeRtlhc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O8YKQBat; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GMeRtlhc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O8YKQBat"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 363677A00F4;
	Sun, 19 Oct 2025 12:00:39 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Sun, 19 Oct 2025 12:00:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760889638; x=1760976038; bh=GKLYRTeSQs
	8hVtoJhfgQ5lAKCwNXWomoB/VGw94zsx8=; b=GMeRtlhcVXPeSNwNnJepKp3ZJP
	iXYgrDc49P1B632h0CvdjHf2qvNzY+JDPT21JaKzJuRdH7dtoWVAw+rYiNvVSYcM
	vYYdZbIldnyqdF+XxRRFsn6oZIonIAFc1mVNmYlNHzqylJ8hja8uY52YEBPm+xDH
	q4PLdUQh2i9ZtIgVHXWNh72nX8HMcK1eGlukgiBN0NWmj7KL0/5x3mfafJegZdIV
	SlOKtGig2OHOY1wKwZqwo+mwSqXaWzMeja2yKh4UTaFKvrj7UZUQj/IA1nNchvul
	62kP88TafnAZloQ5HNOywD7I0ZPy3ckQuxuFZD/qVJRGBbhd/p9ZWcbS8T4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760889638; x=1760976038; bh=GKLYRTeSQs8hVtoJhfgQ5lAKCwNXWomoB/V
	Gw94zsx8=; b=O8YKQBatq2/l9bwsQJkzeqh57haHOgwly1U3jAyAEVC3YT7dWdd
	lL7qo309W8swZ+Ftgds7TQS7vMZ7eNT7jW178X/j8UX/E1TicUMJP6/MZ7PXFJ5Y
	eSfNSUdF8B/JEgubPMgloRBlNE6gQmTyN4Ks1Nr+EW+AEM0i56ftz2QsITlcUOYE
	agaimegj/m5gbf2aJwS1U9+011wl+XU+oniFYiJoLpfB1N/ot4/R8ApZdtQCAvl6
	f3sAAvNRPw+K2twAOBN1YpG3dBQ2GpNp2dj7UPGE4LJBZSfywKHdV42ATVc6PkMM
	YwVJH8jTCIQ1Ak1dkTSOm6r6x/mrcL1oUQw==
X-ME-Sender: <xms:JQv1aG7X6vwe0PSHhUsFIA0oqgS1fXAajQnxrKaUDMwhQHsp7BzdZQ>
    <xme:JQv1aDnPY6IqXfF-_5AOJBcVus-juGCJlUegGYtHSKXcoCNR90B9sj7PjzTaiiRVj
    k6mlGekXpLLZM4HX7xq_ql0GAiDAH4Z-iqNmLPkEOncuR6wn1_4MA>
X-ME-Received: <xmr:JQv1aPTL-4-erH39_22SPYsPaGnSS1V1H7HC_UQNi9x7Cgr80B34eCMOWwZfmQjWpHh-NuO0NiflR98J8ph4tD_xt3o9_2bQgVcL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeehfeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhgffffkgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeetieejgfeiudehfffhteeggeegtd
    dvfeeiieduvdduteekteegfeetjeejgffhjeenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsvghlkhhi
    ugelkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepuhhsmhgrnhgrkhhinhihvghmihdvtddvsehgmhgrihhl
    rdgtohhmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:JQv1aKF-UAilldPr3RKdPwk4irI-P_emgXPA5efprY5tdDYpXwFpvQ>
    <xmx:JQv1aMFf7JyNywB05RsTxS05DB7dRVn04SsqYL-5xf4wmT_7F76dEw>
    <xmx:JQv1aARKyGE_Mtnyvs3E3NcvAG_mzk43LSk7V7dVdHjhrGJ1EGYtbg>
    <xmx:JQv1aFKSf1byprGvlqyBzh3cVCq08knwt0yL0tieLqgxsheLv6J48w>
    <xmx:Jgv1aCffofZkXUxeP6KhSDAYb1G7w3ZkbOacbf4iFGLpT3SK4_yx45YQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 Oct 2025 12:00:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Olamide Caleb Bello <belkid98@gmail.com>
Cc: git@vger.kernel.org,  usmanakinyemi202@gmail.com,
  christian.couder@gmail.com,  Junio Hamano <gitster@pobox.com>
Subject: Re: [Outreachy PATCH v3 2/2] gpg-interface: use
 string_list_split*() instead of strbuf_split*()
In-Reply-To: <9a6eb6ff8b92a94de990303cc78026029a669cf8.1760869186.git.belkid98@gmail.com>
	(Olamide Caleb Bello's message of "Sun, 19 Oct 2025 12:07:43 +0000")
References: <cover.1760869186.git.belkid98@gmail.com>
	<9a6eb6ff8b92a94de990303cc78026029a669cf8.1760869186.git.belkid98@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Sun, 19 Oct 2025 09:00:36 -0700
Message-ID: <xmqqikga3mqj.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Olamide Caleb Bello <belkid98@gmail.com> writes:

> In get_default_ssh_signing_key(), the default ssh signing key is
> retrieved in `key_stdout`, which is then split using
> strbuf_split_max() into two tokens
>
> The string in `key_stdout` is then split using strbuf_split_max() into
> two tokens at a new line and the first token is returned as a `char *`
> and not a strbuf.
> This makes the function lack the use of strbuf API as no edits are
> performed on the split tokens.
>
> Replace strbuf_split_max() with string_list_split_in_place() for
> simplicity
>
> Note that strbuf_split_max() uses `2` to indicate the number of tokens
> to extract from the string, while string_list_split_in_place() uses `1`
> to specify the number of times the split will be done on the string,
> so 1 gives 2 tokens as it is in the original instance.
>
> string_list_split_in_place() returns the number of substrings added to the
> list keys.items, so we check that at least one substring is added to the
> list since we just want to return the first substring.
>
> Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
> Reported-by: Junio Hamano <gister@pobox.com>
> Helped-by: Christian Couder <christian.couder@gmail.com>
> ---
>  gpg-interface.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Exactly the same comment as [1/2] (including the part about the
first paragraph seemingly missing something at the end ;-).

Also, it may not be necessary to highlight the quirky way the
string_list_split*() function counts numbers again, as it is done in
the previous patch so readers have already been warned against it.

And the same comment applies about the round-about way the original
was written in the first place.  Isn't it merely the matter of
finding the first line-feed and making a copy of a string up to that
point?

Perhaps we would be better off if we revise the theme of the topic
"use string_list_split*() to replace strbuf_split*()" to "do not use
misdesigned strbuf_split*() function" and do the rewrite without
using string_list_split*() after all?  It may result in a much
cleaner and simpler code at the end.

Thanks.

> diff --git a/gpg-interface.c b/gpg-interface.c
> index cb182f4c11..3b9d85a5ef 100644
> --- a/gpg-interface.c
> +++ b/gpg-interface.c
> @@ -862,7 +862,7 @@ static char *get_default_ssh_signing_key(void)
>  	struct child_process ssh_default_key = CHILD_PROCESS_INIT;
>  	int ret = -1;
>  	struct strbuf key_stdout = STRBUF_INIT, key_stderr = STRBUF_INIT;
> -	struct strbuf **keys;
> +	struct string_list keys = STRING_LIST_INIT_NODUP;
>  	char *key_command = NULL;
>  	const char **argv;
>  	int n;
> @@ -884,19 +884,19 @@ static char *get_default_ssh_signing_key(void)
>  			   &key_stderr, 0);
>  
>  	if (!ret) {
> -		keys = strbuf_split_max(&key_stdout, '\n', 2);
> -		if (keys[0] && is_literal_ssh_key(keys[0]->buf, &literal_key)) {
> +		if (string_list_split_in_place(&keys, key_stdout.buf, "\n", 1) > 0 &&
> +			is_literal_ssh_key(keys.items[0].string, &literal_key)) {
>  			/*
>  			 * We only use `is_literal_ssh_key` here to check validity
>  			 * The prefix will be stripped when the key is used.
>  			 */
> -			default_key = strbuf_detach(keys[0], NULL);
> +			default_key = xstrdup(keys.items[0].string);
>  		} else {
>  			warning(_("gpg.ssh.defaultKeyCommand succeeded but returned no keys: %s %s"),
>  				key_stderr.buf, key_stdout.buf);
>  		}
>  
> -		strbuf_list_free(keys);
> +		string_list_clear(&keys, 0);
>  	} else {
>  		warning(_("gpg.ssh.defaultKeyCommand failed: %s %s"),
>  			key_stderr.buf, key_stdout.buf);
