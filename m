Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AE729992B
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 09:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758013680; cv=none; b=V/+fh6+/6XGvnTIpwZrMDgvDt8zE2yE65hg+siztePvhA10tlQqmGuF6j6bAr8ris+FhM8sGbWr3Axi29Zbg9BAXMhuhTzH1Nvbliw6OJnBinsYoNseiLYQbVzLuLHbEk/oQbnaR59ZWzIfmwx9RiuKbJ8V6Okhntbd66vn29MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758013680; c=relaxed/simple;
	bh=Dx4cpWY117V37Uo2UtR6Kl76C7llMmDSiH3BzOdsXyI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TWKVvkYq7lHBa3oxRrhSIaZieADYjbJ7zfKriAdJI+Q5fi4IdZwUs9c3URvzz0HOBO36z7GonCk36/URWaUT2oKYhQuxPZtbVkUkniiyrAE5yWux9qxQLBQ0kgvsbY4arKIdfiMII6rAC30AY4lJcL+MJJXW7sq3x90Gwd0xFMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D7AR4Krr; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7AR4Krr"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-5300b29615cso4347907137.0
        for <git@vger.kernel.org>; Tue, 16 Sep 2025 02:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758013677; x=1758618477; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=WfmefmzP6unIWa/6rUeOJGID4fe6YUfrEnv+/JATpfI=;
        b=D7AR4KrrjTDX/dIvG7T0bbuc1xWNo4DdEdF5KacXm2ZXLoyW/YGWW5lUBy8EG7J/NP
         5usogXOYPQA0bcI6MrT6yTzuHPZwocEHhpp+hMoQ0kbnX+1ZJkuj8J322eAc0fyyYAS1
         5/d5/F1uFJ3UaTAe/hvvw7VEK6u8qOGdCnC66I0ZEQbu0Zt4uVK3gsVIKU6IT/+/yr9e
         pDbFTlBXhaRaHY6Ryc3TdgOO/7XHQsmpw4LiqnaWz5ZClih0VXcmX81R+mBxuK5/JgFH
         W7en3BvBwWE0MkzJ0Mh3KANWxOEXCm3aLUrl5BKhGzNL/bCo/txP2arJD7hJQtQ3vw0r
         WwhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758013677; x=1758618477;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WfmefmzP6unIWa/6rUeOJGID4fe6YUfrEnv+/JATpfI=;
        b=EUG9ZRBw6IH1Ihr+sQWqxFRGCpe4e14u+jnabs7FNs6LghfmhhARxLxjqWaRWiZCET
         GU/f/ppYV1F7Y6POt63D1/6e8FH9hN1pZoZ0sojBC9iucRJMmZQrCkVHTD0BPXvKhXfV
         ArC1QZCPEl1WDI97MOkV6DICMJ4ctEoZxA2WrCjO2zbeUwEHd8NKLamjK0/vBxaYlQLF
         44bwkf7haYQGLM/e0sCpfNDudQ1mZa+lE554h05azH6oDGyIyFoiLiT/rP/z76tALxYR
         qeYRAF7tgaxwIvtWTlwoYDBRUtIj4FGdkikyTgvqe/3UgZRJuQ/4ftoyltKqeOYXlUku
         yjHg==
X-Forwarded-Encrypted: i=1; AJvYcCV0TZZjZbNyEH31jEDLoPLz9sk/wTGJWR1r/XTmderQtH3TqBirxEJaqulnZ5yaRnbXK+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxDwJp/71zUKACSMyT51fa4r6duiu1wwJaSKidRIuKvAXnXElq
	Cxgbp8ysFdryMuqdhc/pz1qHZ09kiKcTZYW70tlr0yWMJvn9PKfnHpakaG27nu9sNczp1KuV9Us
	SlJf5w9dDqUmGuHOBaBcCOq6A+ZCqWi9vgQi9
X-Gm-Gg: ASbGncsH8A5q66CAEBzvWUu0pbDkxVCOArXuMgaDr2w6F80Jee/xLZ0R5yFkZO+Pcno
	HYesD9keDi0j7P98jCBHcdVELbOkrnEkBSgSG2yRk7yfysa9odnAPjIOZpcIBzdbIrx6s7ZZeBm
	I47P2kMqJyfBGCpEeIQYGs4JG7T+BRCkm3MziGKeOhd1VQuhmsGNY7kSkCAPpNLLKppG7kyQltJ
	idQc4bcalW9lQ4UCBakE4S7rFKzcesRPHFC0Sr00XrtHM6H2ugu
X-Google-Smtp-Source: AGHT+IG+2ZLnZQhygyyY85TjB4jMBskhr4uKLmm2HinDTm1c1Bgg8UTT8UgggtOwvXt9OSZCAApnB7OeXDkdPR5zCFA=
X-Received: by 2002:a05:6102:f89:b0:523:e010:df0f with SMTP id
 ada2fe7eead31-55601ab980dmr6845648137.0.1758013677459; Tue, 16 Sep 2025
 02:07:57 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 16 Sep 2025 02:07:56 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 16 Sep 2025 02:07:56 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250915202956.3784935-3-jltobler@gmail.com>
References: <20250909191134.555689-1-jltobler@gmail.com> <20250915202956.3784935-1-jltobler@gmail.com>
 <20250915202956.3784935-3-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 16 Sep 2025 02:07:56 -0700
X-Gm-Features: AS18NWCSe_qykpN19Y7YdaLTZMaxajCmSyDYEzH-FF-2rOeGVJW_CpSNUMYwKTA
Message-ID: <CAOLa=ZS_H2CKvYy09Xd1GPqS9Bd5v_dZYiOLjZRbKN4fbYRbVA@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] builtin/update-index: end ODB transaction when
 --verbose is specified
To: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org
Cc: ps@pks.im
Content-Type: multipart/mixed; boundary="000000000000c17843063ee7744e"

--000000000000c17843063ee7744e
Content-Type: text/plain; charset="UTF-8"

Justin Tobler <jltobler@gmail.com> writes:

> With 23a3a303 (update-index: use the bulk-checkin infrastructure,
> 2022-04-04), object database transactions were added to
> git-update-index(1) to facilitate writing objects in bulk. With
> transactions, newly added objects are instead written to a temporary
> object directory and migrated to the primary object database upon
> transaction commit.
>
> When the --verbose option is specified, each of the following objects is
> explicitly flushed via flush_odb_transaction() prior to reporting the
> update. Flushing the object database transaction migrates pending
> objects to the primary object database without marking the transaction
> as complete. This is done so objects are immediately visible to
> git-update-index(1) callers using the --verbose option and that rely on
> parsing verbose output to know when objects are written.
>
> Due to how git-update-index(1) parses options, each filename argument is
> evaluated with only the set of options that precede it. Therefore, it is
> possible for an initial set of objects to be written in a transaction
> before a --verbose option is encountered.
>
> As soon as the --verbose option is parsed in git-update-index(1), all
> subsequent object writes are flushed prior to being reported and thus no
> longer benefit from being transactional. Furthermore, the mechanism to
> flush a transaction without committing is rather awkward. Drop the call
> to flush_odb_transaction() in favor of ending the transaction early when
> the --verbose flag is encountered.
>
> Signed-off-by: Justin Tobler <jltobler@gmail.com>
> ---
>  builtin/update-index.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
>
> diff --git a/builtin/update-index.c b/builtin/update-index.c
> index 2ba2d29c95..d36bc55752 100644
> --- a/builtin/update-index.c
> +++ b/builtin/update-index.c
> @@ -70,14 +70,6 @@ static void report(const char *fmt, ...)
>  	if (!verbose)
>  		return;
>
> -	/*
> -	 * It is possible, though unlikely, that a caller could use the verbose
> -	 * output to synchronize with addition of objects to the object
> -	 * database. The current implementation of ODB transactions leaves
> -	 * objects invisible while a transaction is active, so flush the
> -	 * transaction here before reporting a change made by update-index.
> -	 */
> -	flush_odb_transaction(the_repository->objects->transaction);
>  	va_start(vp, fmt);
>  	vprintf(fmt, vp);
>  	putchar('\n');
> @@ -1150,6 +1142,21 @@ int cmd_update_index(int argc,
>  			const char *path = ctx.argv[0];
>  			char *p;
>
> +			/*
> +			 * It is possible, though unlikely, that a caller could
> +			 * use the verbose output to synchronize with addition
> +			 * of objects to the object database. The current
> +			 * implementation of ODB transactions leaves objects
> +			 * invisible while a transaction is active, so end the
> +			 * transaction here early before processing the next
> +			 * update. All further updates are performed outside of
> +			 * a transaction.
> +			 */
> +			if (transaction && verbose) {
> +				end_odb_transaction(transaction);
> +				transaction = NULL;
> +			}
> +

So with this change, we now have all objects updated before the
`--verbose` flag updated via a single transaction. Updates after the
`--verbose` flag will no longer use a transaction.

The older version would flush the transaction on every report, is there
is any benefits to the new flow with regards to performance?

>  			setup_work_tree();
>  			p = prefix_path(prefix, prefix_length, path);
>  			update_one(p);
> --
> 2.51.0.193.g4975ec3473b

--000000000000c17843063ee7744e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: d5f777bd8256538f_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qSktPc1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNlFWREFDYko5MVZ1amNlTHg5cGRvc2s0R0VlL2JSdQozTlovb1I3YXJv
Slp1Z0c5MnFWLy90aVhCVVNmQ0x6aktWbzhZckUvZlNTRXFrTGtGdkVLdWdOZVdscm5sYm5OClZy
TVFFbmZOM1JDU29vbDU5c1d5RngvU1lBaHlSbUFIQmtnT3NtbjdoeVQ2d1R6WVBMRHNHQThscmNl
eVYwdmkKMzBEV0pBOUpmY0JwOFZsSzVsZ3VNcmpLajZhNitOZjZVaW8zcXgzRVhjeFVxUW5ScGs1
ZE5pSFIrdDZMYnVJMgpaV0pQeFFpbWdubi9mRWZYd1JiMzhWVFVwN2pueEdzLzhxYVArbmZwV2Mr
Wlh1Q3EvT1BTY3U4M1V3K0RCOFdLCnRzbnFpQkhSVTZ3YjdPdWFGYU9Kb25oMnRCV2tibkJjeWtu
VHBHZUdxOEtSVVNyaHQ4M0QrWFhIWUdsQkpPU2cKa1pnUWY5SEI0Zk9PZjdEMHFnN3owZjlqWGtp
VkJjVXF2NEJ2ajBLeEM1emtiVFZ0dTQ5Ynd0cnJ0TkVYSWxZWQpidUtyK2padkNXRUFRZkhoaFNG
Mm9PSDNyaFk5OWVDT3loWWNHOWdmMEV3ZHNwUjVsS3QwRkNMQnY5cUVMOHU3Ckl0SXJTQVhrMksz
MWJ4NVZFeUFTR3h4SUZFSWJocDYyeGU2WVhuND0KPVpTb1gKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000c17843063ee7744e--
