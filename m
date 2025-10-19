Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BFC2877D7
	for <git@vger.kernel.org>; Sun, 19 Oct 2025 15:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760889172; cv=none; b=NLMcAOYg5/sFePEFI2517Sy1xXira7mJYr6I8TJmdqSQQLYB8ihJcbbVUip6Mf9zpXiro/VthjKbIkucnhiM4uGmMiiDJgNiEPgEsDhm5TJ6MRgQsUaaOdaALVJM/EZlhA+xK/J7F788UchqzaBMgm9ZynzYBh0AAPm2DGxV8lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760889172; c=relaxed/simple;
	bh=DK+2xWB9919nwKStU2m0fPs+HBxZsZC3R5oVzgtJ2Gg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IsadkhZfVv0tTXS2Pxt659rJ2t+ROgR3d8TNp37uxjVOtOLZbctdNMVuQ2pVnuM2fNMQKtgS5vo4QRYsP36I89q+PFq/pnZKWGIWqO9mH0eY9/RWbTGfuU/qIwNvaohUN3nPQ4VK9g1rGmaxV1KU7Pl9bc1Ivdu2sxW/Mt4y6mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KSuwdzRC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qXIRn/CW; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KSuwdzRC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qXIRn/CW"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4834D7A004D;
	Sun, 19 Oct 2025 11:52:49 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Sun, 19 Oct 2025 11:52:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760889169; x=1760975569; bh=ezpdi5rBLb
	OrrzJ/G2Ohj73YNqCsY1l5SdfG/l82PEw=; b=KSuwdzRC+wHMP7tciPcMZhhaOy
	rfXlWxBpoDsGhix1ftUEV8XyoKihwgoMAIlfu2x9Y+42KLvlv8/93OLfTAuLqmt2
	xhv7Mgv/vzZ+epp87hlpoDICEZ4aZQVD19ag4Kjo9d74CBS9Xc4tjL93oddSjRYI
	UoLc+t6ZuatnVtGFSk32aw4tPVAkq1VZNEBT5nXbOAYMzatvFTMNVWhlcFfBh+3F
	mk7+7mhLHJE0OdY0hUWr3d2bq+zW0GafothjaUXp/zr0BtHxtj1LmpsB9f10YWr3
	LKG25R0/fohifaAv7xiPUsq5GheQl7sZAP7PyEKyxnIL5K86L2Fs0rT1xk0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760889169; x=1760975569; bh=ezpdi5rBLbOrrzJ/G2Ohj73YNqCsY1l5Sdf
	G/l82PEw=; b=qXIRn/CWEN91lrnhIjJRCt8zsgkPHMuWeoX/VV4HsDRVKknnu17
	IoarJqqLfj65rXAkom2Cr8ZtgPoR/vyCF3odxo2hV6QJYeN1monoUiCmH4RV6Oyp
	croniobRpwdRltTRFxzC50HxytpjCSRFrRTHzCsi9znKBJ5/ztS8GCSV5JaEcv+t
	9Kcwr+2dPlCw2c/saX9J6El02fUWDy4hFv/Lz2pKSwO3LfxOyd+RQ/s8lHlZXMzc
	QEqfbDQy7cfY6bb31BaUqAkr78FpJfZbIY87Fv7f7WGUALR9GaUmbmFLYkC8620i
	TcYS5+jITMw2ZZsDCkDnMR1Nb6F29EnvUfg==
X-ME-Sender: <xms:UAn1aCFuH3A2dMDqGrSoTyOR2b9xbI_ZxR5HSUWciDAFdz_IU_S5Bg>
    <xme:UAn1aKNw7Dkeyu48phqZ8z61jggrdYt5AMPqToghGW3AvgrPN9RqU6uxM2MELoQbs
    KObAq7HSbSFcoW9_rOUV90qzVMJ9dk9fKdYyXrqnjdqw9ARasHX_A>
X-ME-Received: <xmr:UAn1aEf6NOqfHaX18GL-BgbvWsmfloDbii25zd0cYSIN9GVLaaIu_HBR1oaBps73_ZUgv7sIivxF751QZ3r3D0Rxb31c8UoNwAyN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufeehfeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsvghlkhhi
    ugelkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepuhhsmhgrnhgrkhhinhihvghmihdvtddvsehgmhgrihhl
    rdgtohhmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:UAn1aHuEfyL32WYr5CWNCVh8X5lYXvjI6JVaGTY--SlPTUIRPOsNbQ>
    <xmx:UAn1aFmny0GhuS3j8hhNgWZysDRazweg2k1oVSebgX3YQHnMKsyewQ>
    <xmx:UAn1aJyQGHS9Uc2n-FETJqS6WyW9lIuNMmL_m47qNtveKLU5_YWR0g>
    <xmx:UAn1aHMCa27RN9E0Ppa3K-AarVzKsSXx9eH1TrhMGsRNj_HiDfrpRw>
    <xmx:UQn1aG8uJ78Mbvt5rWEIQRYOxZkJSAXkwc0fMtNaxngwKDZX7cYDcL6c>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 19 Oct 2025 11:52:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Olamide Caleb Bello <belkid98@gmail.com>
Cc: git@vger.kernel.org,  usmanakinyemi202@gmail.com,
  christian.couder@gmail.com
Subject: Re: [Outreachy PATCH v3 1/2] gpg-interface: replace strbuf_split*()
 with string_list_split*()
In-Reply-To: <7da4fded535984faea52d5f88793d3c8e47c0091.1760869186.git.belkid98@gmail.com>
	(Olamide Caleb Bello's message of "Sun, 19 Oct 2025 12:07:42 +0000")
References: <cover.1760869186.git.belkid98@gmail.com>
	<7da4fded535984faea52d5f88793d3c8e47c0091.1760869186.git.belkid98@gmail.com>
Date: Sun, 19 Oct 2025 08:52:47 -0700
Message-ID: <xmqqqzuy3n3k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Olamide Caleb Bello <belkid98@gmail.com> writes:

> In get_ssh_finger_print(), the output of the `ssh-keygen` command is
> put into `fingerprint_stdout

Something lost at the end?  I'd assume

	... into `fingerpritn_stdout` strbuf.

and tweak the copy I received locally before applying.

> The string in fingerprint_stdout is then split into 3 strbufs using

"into up to 3 strbufs", I think.  If we do not say so here, ...

> strbuf_split_max(), however they are not modified after the split thereby
> not making use of the strbuf API as the fingerprint token is merely
> returned as a char * and not a strbuf, hence they do not need to be
> strbufs.
>
> Use string_list_split_in_place() instead for simplicity.
>
> Note that strbuf_split_max() uses 3 to specify the number of tokens to
> extract from the string, while string_list_split_in_place() uses 2
> because it specifies the number of times the split will be done on
> the string, so 2 gives 3 tokens as it is in the original instance.
>
> string_list_split_in_place() returns the number of substrings added to
> the `split.items` so for a successful split of the string in
> fingerprint_stdout, at least two items should be added to split.items

... this "at least two items" would become contradictory.

> so we can always be certain that the substring at index 1 is the ssh
> fingerprint even if the key owner's identity part is missing from the
> string in fingerprint_stdout.
>
> Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
> Reported-by: Junio Hamano <gitster@pobox.com>
> Helped-by: Christian Couder <christian.couder@gmail.com>
> Helped-by: Junio Hamano <gitster@pobox.com>
> ---
>  gpg-interface.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/gpg-interface.c b/gpg-interface.c
> index 2f4f0e32cb..cb182f4c11 100644
> --- a/gpg-interface.c
> +++ b/gpg-interface.c
> @@ -14,6 +14,7 @@
>  #include "sigchain.h"
>  #include "tempfile.h"
>  #include "alias.h"
> +#include "string-list.h"
>  
>  static int git_gpg_config(const char *, const char *,
>  			  const struct config_context *, void *);
> @@ -821,7 +822,7 @@ static char *get_ssh_key_fingerprint(const char *signing_key)
>  	struct child_process ssh_keygen = CHILD_PROCESS_INIT;
>  	int ret = -1;
>  	struct strbuf fingerprint_stdout = STRBUF_INIT;
> -	struct strbuf **fingerprint;
> +	struct string_list split = STRING_LIST_INIT_NODUP;
>  	char *fingerprint_ret;
>  	const char *literal_key = NULL;
>  
> @@ -845,13 +846,12 @@ static char *get_ssh_key_fingerprint(const char *signing_key)
>  		die_errno(_("failed to get the ssh fingerprint for key '%s'"),
>  			  signing_key);
>  
> -	fingerprint = strbuf_split_max(&fingerprint_stdout, ' ', 3);
> -	if (!fingerprint[1])
> +	if (string_list_split_in_place(&split, fingerprint_stdout.buf, " ", 2) <= 1)

This may be just me, but when we expect at least 2, I would find it
more natural if we said "if (count < 2) then error", rather "if
(count <= 1) then error".  I'll let it pass, as there is nothing
mathematically incorrect here ;-).

>  		die_errno(_("failed to get the ssh fingerprint for key '%s'"),
>  			  signing_key);
>  
> -	fingerprint_ret = strbuf_detach(fingerprint[1], NULL);
> -	strbuf_list_free(fingerprint);
> +	fingerprint_ret = xstrdup(split.items[1].string);
> +	string_list_clear(&split, 0);

OK.  This is a straight-forward rewrite that is fairly faithful to
the original.

But I wonder why the original was written in such a convoluted way
to just extract the first part of a string that is space delimited
tokens.  It is obviously not your fault that the original is written
that way, bit I would have expected it to be done more like this:

    char *begin = fingerprint_stdout.buf;
    char *delim = strchr(begin, ' ');
    if (!delim)
	die_errno("Barf!");
    fingerprint_ret = xmemdupz(begin, end - begin);

Am I missing something?

That may or may not be outside the scope of this topic, which is to
reduce the calls to a misdesigned strbuf_split*() API functions.

Thanks.

>  	strbuf_release(&fingerprint_stdout);
>  	return fingerprint_ret;
>  }
