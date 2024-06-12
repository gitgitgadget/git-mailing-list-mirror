Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5951616C875
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 09:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718184180; cv=none; b=kc4TLf3NUXGRYwRsU1zAbiXhpDHjmpcUJDskIaOwPDMkmoi/4r722xfZ8EY46SE82EGdqOIVggMlYHcqgCVJCftI8nkTMODDr/G4rXEucbn2yDKIQcskthvwneTsBd6Mma7wu939NzRryaLkSBdyI1rgPC8rbg9okzSZ5lCKR4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718184180; c=relaxed/simple;
	bh=FZNg3gTdzbOpfGPSFvciSjauSNNzzYjTSnBNvfQxHUI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jHD5e3a0Q3daz4UJ1eCI7JyUe4UfSS/a3dP7hJiFkecuYl+rF95biK7IlLlW8sKUEA1HfCY7AnhIbcY0Fb+RHVjE1bq52KlW7pQK1v9Ypa0SZNZ+qqtnYJXrsAwTNofYlbdAxLGQph1mJp/0i7xjyvHlM25HdFLjqYUjxTgjwiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cj4EpZTs; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cj4EpZTs"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3d2220a11a8so1304286b6e.0
        for <git@vger.kernel.org>; Wed, 12 Jun 2024 02:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718184178; x=1718788978; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qm6Pcs4ZwfmrHQ2iMq21STq85PecxNedsnB3mGnoG2I=;
        b=cj4EpZTsf47wAldicMP9O5sqdI8a4BVaThvmheNCTJ1Qy4DHR5kWr2PB2O8DebYsp8
         qBpGfY/a57GkMfm1w6K6F7CoCuFisKC/C9pDF/Snuis7kuxaMqTtTWhpcEjj00a9Mi2q
         EzprYB5bvQoAuV2sFInK3hW++MVxEeAc9gaxUQtonNeGw6f4YgZ2+YKAluS1+W1VfQhB
         hxNupCiKCspFcWc9orQZQTK24B6hBim0ajtw9MkIN+hBkZ1nwSkERD/9NsO5qXWu7Dwe
         eyiz1VaDRNVfQXe3cfrdj95QDo4UcG4yqBfsSi6ZrSI8+ydCO9CxB4FYSVzgOV3oPVsf
         ysSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718184178; x=1718788978;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qm6Pcs4ZwfmrHQ2iMq21STq85PecxNedsnB3mGnoG2I=;
        b=EhkxxgbExIfLiiAKpU/TvKWWufLGvW+k6jAnXtp6kd8aDN9Xw6V0o8bEcj0NCk1/Xe
         A33uwvV2L23PQMQVLzu9od3GixkNCx8QUT0+cxYgiDpZJ1oq4xDD4cXZvlCZdk9ZzvyR
         UkE8fu2qmlvlKuCCHO416ks7DYOsi927xTXqGx/olunSTCvR6hA+zqWnLThMufh5Afts
         KLuP+UuK5EYHCp9YkJirC30qqe7F4KX/IZwtgqHLzLWspu88rN5lNR49JURNIQoG1OEs
         K50zRDAl/06iR96ifcKZ2PVzsbY5u9S5/HkvJzN74/mHJBkGbZSFABxxFiC/0sWA2Cv1
         YHPg==
X-Forwarded-Encrypted: i=1; AJvYcCUZsr71C/bPOO3eL3C3+OxvwecY7P7mexDNLKVLVYaaOJYNvoeZH73HSIudN45kPU7SPR08d0D4Rknz2f4fxlH1ozeI
X-Gm-Message-State: AOJu0YwHdiDUl5zDmSsHq6isbWubYQchLvHCiOs7keEYbujb91Ill040
	tkG+Mq6bJZBro/xbAs/yxvqD8FTeN/+yJeiFT8a5G3G1jOU5bhucTkx4oG3WO+fdgmKYFPU19vg
	hf4d6MK8nr1P5qp766KZXASXSJBQ=
X-Google-Smtp-Source: AGHT+IGLATKhBF/YfuMLCeK71rNRy5GuIjvh5MIoLit0OD1jV1eVyVQFUlcdONzidfbENHLqK5X/DI1AFw2WZrQv+ik=
X-Received: by 2002:a05:6870:c6a9:b0:254:8666:34cd with SMTP id
 586e51a60fabf-25514ba6a00mr1356334fac.14.1718184178026; Wed, 12 Jun 2024
 02:22:58 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 12 Jun 2024 09:22:57 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <b48c50dd92769c7acc5c561f746a7d64dd4d2263.1718178996.git.ps@pks.im>
References: <CAO_smVimsHAPbMxy09mcYZY8apFgCbpnS9eSF7UOL6_BLqntNw@mail.gmail.com>
 <cover.1718178996.git.ps@pks.im> <b48c50dd92769c7acc5c561f746a7d64dd4d2263.1718178996.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 12 Jun 2024 09:22:57 +0000
Message-ID: <CAOLa=ZTLfN665svPMaCJvBT7rjVrg2_=CiZmb3u5XfmmOR6_aQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] config: fix segfault when parsing "core.abbrev"
 without repo
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Kyle Lippincott <spectral@google.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="000000000000972b5a061aadedf8"

--000000000000972b5a061aadedf8
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> The "core.abbrev" config allows the user to specify the minimum length
> when abbreviating object hashes. Next to the values "auto" and "no",
> this config also accepts a concrete length that needs to be bigger or
> equal to the minimum length and smaller or equal to the hash algorithm's
> hex length. While the former condition is trivial, the latter depends on
> the object format used by the current repository. It is thus a variable
> upper boundary that may either be 40 (SHA-1) or 64 (SHA-256).
>
> This has two major downsides. First, the user that specifies this config
> must be aware of the object hashes that its repository use. If they want
> to configure the value globally, then they cannot pick any value in the
> range `[41, 64]` if they have any repository that uses SHA-1. If they
> did, Git would error out when parsing the config.
>
> Second, and more importantly, parsing "core.abbrev" crashes when outside
> of a Git repository because we dereference `the_hash_algo` to figure out
> its hex length. Starting with c8aed5e8da (repository: stop setting SHA1
> as the default object hash, 2024-05-07) though, we stopped initializing
> `the_hash_algo` outside of Git repositories.
>
> Fix both of these issues by not making it an error anymore when the
> given length exceeds the hash length. Instead, leave the abbreviated
> length intact. `repo_find_unique_abbrev_r()` handles this just fine
> except for a performance penalty which we will fix in a subsequent
> commit.
>
> Reported-by: Kyle Lippincott <spectral@google.com>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  config.c         |  4 ++--
>  t/t4202-log.sh   | 12 ++++++++++++
>  t/t5601-clone.sh |  7 +++++++
>  3 files changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/config.c b/config.c
> index abce05b774..0416b0f2b6 100644
> --- a/config.c
> +++ b/config.c
> @@ -1460,10 +1460,10 @@ static int git_default_core_config(const char *var, const char *value,
>  		if (!strcasecmp(value, "auto"))
>  			default_abbrev = -1;
>  		else if (!git_parse_maybe_bool_text(value))
> -			default_abbrev = the_hash_algo->hexsz;
> +			default_abbrev = GIT_MAX_HEXSZ;

So if the value is set to 'no'ish, we set it to the max value possible.

>  		else {
>  			int abbrev = git_config_int(var, value, ctx->kvi);
> -			if (abbrev < minimum_abbrev || abbrev > the_hash_algo->hexsz)
> +			if (abbrev < minimum_abbrev)
>  				return error(_("abbrev length out of range: %d"), abbrev);
>  			default_abbrev = abbrev;
>  		}
>

I was wondering if the documentation for 'core.abbrev' needs to be
modified, but seems like we don't mention how the max value can error
out in the first place so all good there.

> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
> index 86c695eb0a..e97826458c 100755
> --- a/t/t4202-log.sh
> +++ b/t/t4202-log.sh
> @@ -1237,6 +1237,18 @@ test_expect_success 'log.abbrevCommit configuration' '
>  	test_cmp expect.whatchanged.full actual
>  '
>
> +test_expect_success '--abbrev-commit with core.abbrev=false' '
> +	git log --no-abbrev >expect &&
> +	git -c core.abbrev=false log --abbrev-commit >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success '--abbrev-commit with core.abbrev=9000' '
> +	git log --no-abbrev >expect &&
> +	git -c core.abbrev=9000 log --abbrev-commit >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'show added path under "--follow -M"' '
>  	# This tests for a regression introduced in v1.7.2-rc0~103^2~2
>  	test_create_repo regression &&
> diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
> index cc0b953f14..5d7ea147f1 100755
> --- a/t/t5601-clone.sh
> +++ b/t/t5601-clone.sh
> @@ -46,6 +46,13 @@ test_expect_success 'output from clone' '
>  	test $(grep Clon output | wc -l) = 1
>  '
>
> +test_expect_success 'output from clone with core.abbrev does not crash' '
> +	rm -fr dst &&
> +	echo "Cloning into ${SQ}dst${SQ}..." >expect &&
> +	git -c core.abbrev=12 clone -n "file://$(pwd)/src" dst >actual 2>&1 &&
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'clone does not keep pack' '
>
>  	rm -fr dst &&
> --
> 2.45.2.457.g8d94cfb545.dirty

--000000000000972b5a061aadedf8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 44d0d7f6e0fa1ce0_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1acGFPOFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOVZJQy85dkR0NUV1REFPVVFKbGU0SjZscUlnT29FRgpXRWtoYXVZS29v
ZFpsVGltQlVWSklRdnBlMWh6eHAvbkN6NmVPdjdlQjQ0Z1pzSnFqK3FpTmlSYld0TWxOc3c2CkQw
SGhXVW5oOGZlUGFNU2tWUzBid3JhUXpYV2x1RHlsb3J5V1dWa2NENmxzZ1JnNXNGQ2hlOEx2eVJi
c3BmTU0KTThndUw1SDJNOEx4TFdtVFA1enJKQVN3MG1aM1E1R2h5ZlFHV2h0U25wUmFvZWZJVHND
eFk1ZEcxdXdaZ3Iwdwo1YWlUazJYYVdjcjZQYWFRVHRMajBmdCtnY0RBOTkvRjNQdXFGcXNqand5
L1BmWlorcDVZRG1PSnJMSG92NXN4CkkzbGhvL2E4NFhuTFcwalFNQ0xMZHkyYSs5WEI2SE1YQlZL
cFlWN2FtaERlTDZlY210S0Jma2lOOGl6blh5SFYKSDVRSlhPQ1NGejJQS2FCbUQxUlJEbHhFK1hB
ZCtCU3BiN2Z3YnBVMXZ2Tkk2eEhnOFNJcHpRYkhDUjFuaGluSQpkOGNlNUtFOXdMd2pySWxQRUxt
ZUVTMTgrdVBmTmJ0TjJBbm1PaWd1OWFsU0FsWDNQTVJJWGNYcUxCUUdsMmJECmpQejVlMk9ELzhh
WE1VTWhpWGtqV3lDaVA1WHM3RjE5WjVaQ01BTT0KPXVrbmMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000972b5a061aadedf8--
