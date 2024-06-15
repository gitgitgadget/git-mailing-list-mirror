Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D751DA22
	for <git@vger.kernel.org>; Sat, 15 Jun 2024 14:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718463457; cv=none; b=LOw+oq81KsBPYSYamn2n5YqI+GOpImE+beEOlIxDCefxMMGUapSKLOS2Vo4ky0vD3Uof/mTukZNtjoGOZo2vVuaCsy42efEz3xBmSD5bemIdzAvgtwIVLvJae9aL9YXzEPJTp/pxCP50wWds5ernES8vozS2pJ/cb8Ty3JCIhoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718463457; c=relaxed/simple;
	bh=EmKOwRvRYUYMBJ01culAaJbuhNimBznhfvZoLb1nO9g=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CLuOB1i65q7UN+3Bc30RkP3cRuRNCzKRp7YbR8WVxOqp0FmLZpwtk65aXv49n+c4lEcCqt57xhWbHeKQCHXrUG/0MN93TVeZyVZ3aLjNVPp3Fg4mHXWikiLTWOsk8r6zmKz8qtyX4JFkSN5517r17uMcPUbIZtx2bsw66GPNiLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z+Xieh1A; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+Xieh1A"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2e72224c395so30109431fa.3
        for <git@vger.kernel.org>; Sat, 15 Jun 2024 07:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718463454; x=1719068254; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=WaLrR5vJnuR37x36BemUMxBkBprhEJ2T/kWPRX61EJg=;
        b=Z+Xieh1AflboVk+qDUFuyB4GfoeHEAWZgNHwtAr+qodGwcXhaZ4OYd7J/RWNlZdCfM
         U01u6K3MTTnjq4caUgJK77dvDrbweFc5ahB9eUeBfPmAt5kRVD+9of4AcUOfblSnX9Ze
         PDB372ufci1AavxHw2M8d/udx0pKMo1g63uRAmcFPyWp/0SU2xuxI80hgfvtAn8/9xE2
         O/74Bmyjhh8DpbtYV3fys0JeaP+3sI/jf5kCniDzZXuiRjf1T2ZgFwH5wf8JaCuDDlfP
         kXgRey9mb9q6MqYHBNz1bNi+j+QTxnfZ4pA+uRHPrpZlZMtxithsKqFCAXQ7R7vARome
         ptHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718463454; x=1719068254;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WaLrR5vJnuR37x36BemUMxBkBprhEJ2T/kWPRX61EJg=;
        b=Zy7cgKgbcpoBKkp+l5GMNne0oMtsVTiSLrv591uT11NRWea959n239x3DIVXkLfa8S
         aCDnQIMJen8g6Qe/7HY7cUqYKefrAmE1Pu+CGFw3npuCBzCRuxCagnPmvEwfrWk5meJz
         VHaDULIAxOIw6VirrDlFVKMgvsKY/P3XsXn9JNIkpndSX1No0qAz5rqPtIq9wwqFHrQh
         HXIrjhbi31FkY3M2PYnsn/vHHlePU6EGuN7ebJx7xHZQfLvfu0C3v5tecScA20C0vIMk
         iNStijd758AKosM6YtsNPWpQmHtkBkOp/EZKmKVTC5RgwPHTwgl8wec4gok4lcoi8lpa
         WMpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQFtHrlfexwiMuXCYnHqz6hJUVLOJekJcXTFE6PhZ9rOhr1vBkJfzT3fZRsvbL3rtBtcYI9YzyM9+Yqakdj+T+LYVj
X-Gm-Message-State: AOJu0YxIKUDMYDLXZgWTHrOdJOzqybqmgEhvCwM7biG1LD+nXEvCw9BM
	gE/l+9pn+U3xeaxQTj5wHM/B7gD2397IljmWV/43ImZTAFcUlKGfFLLZUYPXGIGG25G8exqSC/C
	zPfnO5ez3Oiwcrxc8/Z16bhtvo2M8lanK
X-Google-Smtp-Source: AGHT+IEGlzR5NbZeUzPlVB+ppL27XSldZyyiM04w2s1xC1F3zmR/0XgsdsSiG2FFpNRLWT68D2xoU8p/D4a91D3m1xo=
X-Received: by 2002:a2e:9acf:0:b0:2ea:e26e:e6d6 with SMTP id
 38308e7fff4ca-2ec0e5d13b6mr36813681fa.30.1718463453295; Sat, 15 Jun 2024
 07:57:33 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 15 Jun 2024 07:57:31 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20240612085349.710785-4-shejialuo@gmail.com>
References: <20240530122753.1114818-1-shejialuo@gmail.com> <20240612085349.710785-1-shejialuo@gmail.com>
 <20240612085349.710785-4-shejialuo@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 15 Jun 2024 07:57:31 -0700
Message-ID: <CAOLa=ZS+3_=Q=KNdauWrU3javdDNneHPaS5KaoM6iCTLP8O8mA@mail.gmail.com>
Subject: Re: [GSoC][PATCH v2 3/7] builtin/refs: add verify subcommand
To: shejialuo <shejialuo@gmail.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, 
	Eric Sunshine <sunshine@sunshineco.com>
Content-Type: multipart/mixed; boundary="000000000000b19215061aeef36c"

--000000000000b19215061aeef36c
Content-Type: text/plain; charset="UTF-8"

shejialuo <shejialuo@gmail.com> writes:

> Introduce a new subcommand "verify" in git-refs(1) to allow the user to
> check the reference database consistency.
>
> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> Signed-off-by: shejialuo <shejialuo@gmail.com>
> ---
>  Documentation/git-refs.txt | 11 ++++++++++
>  builtin/refs.c             | 45 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 56 insertions(+)
>
> diff --git a/Documentation/git-refs.txt b/Documentation/git-refs.txt
> index 5b99e04385..f9d36ea19d 100644
> --- a/Documentation/git-refs.txt
> +++ b/Documentation/git-refs.txt
> @@ -10,6 +10,7 @@ SYNOPSIS
>  --------
>  [verse]
>  'git refs migrate' --ref-format=<format> [--dry-run]
> +'git refs verify' [--strict] [--verbose]
>
>  DESCRIPTION
>  -----------
> @@ -22,6 +23,9 @@ COMMANDS
>  migrate::
>  	Migrate ref store between different formats.
>
> +verify::
> +	Verify reference database consistency.
> +
>  OPTIONS
>  -------
>
> @@ -39,6 +43,13 @@ include::ref-storage-format.txt[]
>  	can be used to double check that the migration works as expected before
>  	performing the actual migration.
>

Above it states that the options mentioned are "specific to 'git refs
migrate'", shouldn't we do something similar here?

> +--strict::
> +	Enable more strict checking, every WARN severity for the `Fsck Messages`
> +	be seen as ERROR.
> +
> +--verbose::
> +	When verifying the reference database consistency, be chatty.
> +
>  KNOWN LIMITATIONS
>  -----------------
>
> diff --git a/builtin/refs.c b/builtin/refs.c
> index 46dcd150d4..82ed0d57c1 100644
> --- a/builtin/refs.c
> +++ b/builtin/refs.c
> @@ -1,4 +1,6 @@
>  #include "builtin.h"
> +#include "config.h"
> +#include "fsck.h"
>  #include "parse-options.h"
>  #include "refs.h"
>  #include "repository.h"
> @@ -7,6 +9,9 @@
>  #define REFS_MIGRATE_USAGE \
>  	N_("git refs migrate --ref-format=<format> [--dry-run]")
>
> +#define REFS_VERIFY_USAGE \
> +	N_("git refs verify [--strict] [--verbose]")
> +
>  static int cmd_refs_migrate(int argc, const char **argv, const char *prefix)
>  {
>  	const char * const migrate_usage[] = {
> @@ -58,15 +63,55 @@ static int cmd_refs_migrate(int argc, const char **argv, const char *prefix)
>  	return err;
>  }
>
> +static int cmd_refs_verify(int argc, const char **argv, const char *prefix)
> +{
> +	const char * const verify_usage[] = {
> +		REFS_VERIFY_USAGE,
> +		NULL,
> +	};
> +	int ret = 0;
> +	unsigned int verbose = 0, strict = 0;
> +	struct fsck_refs_options fsck_refs_options = FSCK_REFS_OPTIONS_DEFAULT;
> +	struct option options[] = {
> +		OPT__VERBOSE(&verbose, N_("be verbose")),
> +		OPT_BOOL(0, "strict", &strict, N_("enable strict checking")),
> +		OPT_END(),
> +	};
> +
> +	argc = parse_options(argc, argv, prefix, options, verify_usage, 0);
> +	if (argc)
> +		usage(_("too many arguments"));
> +
> +	if (verbose)
> +		fsck_refs_options.verbose = 1;
> +	if (strict)
> +		fsck_refs_options.strict = 1;
> +
> +	git_config(git_fsck_refs_config, &fsck_refs_options);
> +	prepare_repo_settings(the_repository);
> +
> +	ret = refs_fsck(get_main_ref_store(the_repository), &fsck_refs_options);
> +
> +	/*
> +	 * Explicitly free the allocated array. This is necessary because
> +	 * this program is executed as child process of git-fsck(1) and the
> +	 * allocated array may not freed when git-fsck(1) aborts somewhere.
> +	 */
> +	free(fsck_refs_options.msg_type);

Nice, this is a good thing to do even if this isn't called as a child
process.

> +	return ret;
> +}
> +
>  int cmd_refs(int argc, const char **argv, const char *prefix)
>  {
>  	const char * const refs_usage[] = {
>  		REFS_MIGRATE_USAGE,
> +		REFS_VERIFY_USAGE,
>  		NULL,
>  	};
>  	parse_opt_subcommand_fn *fn = NULL;
>  	struct option opts[] = {
>  		OPT_SUBCOMMAND("migrate", &fn, cmd_refs_migrate),
> +		OPT_SUBCOMMAND("verify", &fn, cmd_refs_verify),
>  		OPT_END(),
>  	};
>
> --
> 2.45.2

--000000000000b19215061aeef36c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 75d33861627e4749_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1adHE5a1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNzFjREFDTk5ScUNnQmR5cDJMMTIyMG96WUNBUGhNUQpWakdWSWV0bkk2
T0oxV0RHVjRqYWpjd2lVbDJHRTV2WFI1Tm1DanAzNWQ4ZlRheCtIUFFxa3V6NFVqbmxzdWFNCndj
NHR3b0hXbjF2VWYycjN1ZTNQb05WRU56YVFKTWh4VTNLSU9HWFJqM0lZVFFZL2xhTTB3emtPbTVj
eTdpaTkKSm1lQ1p0WW5LckE1YkZJcDN1MktGYmViaytYS011U2cyNjZia0JuUDNOdk9WTFpjclJj
S25DekVGSXFBUmh3UQorUXBXME9DeVpxMS9HVzRpY1J1R1h0dHE4SWttZkdLcmplVkpMb2o5Ky9N
eVRsNW5jK2doMjM2M0s3UHE5ZE9qCnhTS1UzNFBMYThPUEVlWk9pakREY2F1eGkwcTIvVUVDeGVS
cnBoUXh0MWRqMy9RanFtZlJ2M0ZhcW1NOXNXcUMKK0NsNWNJOHFGbFlENEpvbVBxUVJWY21QRERo
dzBiMzVzeEJheGVpWHZQdDZoU2ZzaFJ3NUV6TnhJVis2SWtFVApSWHdkV3N5MmxUd0JGT3lpTmtl
a0dFKytPaHVwUk1zZENWMmEyekM2RXNJSXFmLzY0Qk5zbHdnUlhIQUdvbkRaCnUvUUtxQVRhZFJa
QTA0cUpPbjJ1d1BsTlMzbHMvbEZwdk83dExiST0KPXJGL1EKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000b19215061aeef36c--
