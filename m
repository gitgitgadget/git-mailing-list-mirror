Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECDA46D2B8
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 11:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789038635; cv=pass; b=LBObwZ42BSp4zDDuJWtO/ZY4LfrUr02MEMqbqGAnfY6vtAUQ0gySPAWzUGXVOGArYSHk3hsnavB0lojj0OzGU9CCQUFOArfP6pdToV/+YXXerKQHVptCw0b9GImQZBSgDDq60/mB+3KUa8VXih/sKMVT+IjV1dXnSpujydL4790=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789038635; c=relaxed/simple;
	bh=A6ux1djoKeO4J/ZdzFpIXAnuKHkElRtkE23bDf6I2pQ=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=own5a0ANIAv6EqkLXt3q/L5FbBAJyfvCKFSvKKPU4HKWYm0GGTLWkTcy9D2aBfoP8y7svSjJKyFq53Z9n9A+UO2v82UdHTOsoGF5WKeU/4bvga5S/ImeDD2XXp2NVTABWiJV+as2bAUQ5ueOsOvgckWyHi/eR7aP9pOVZBBOU6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vthkz0bt; arc=pass smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vthkz0bt"
Received: by mail-vs2-f12.google.com with SMTP id ada2fe7eead31-78564319a92so296095137.1
        for <git@vger.kernel.org>; Thu, 10 Sep 2026 04:10:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789038632; cv=none;
        d=google.com; s=arc-20260327;
        b=rHdKfgWXZt9TL3jLRq3xQJXo2jzoIldt/gpize5ra51fHHSmV6PS+qxpZVbv3KQq0k
         cIReJtyj3j5FGCWTbexAWE/fCvqTuHFWgUTBnQ5Bc1DVZ2nFT0NqKjHWCCNOS1Xkxt3K
         +b7PS6fIRd1OkKB8txhpjrZ3su2J9T5D7mbWyG1G85emBAdfkirM7ghudVlR0X8q/3EG
         S5ibefM20B4EkWJRrA1QPCQ6K2C3CFhV5eHLkVpmiUNgQidCJxeydF7/03Px0zdkKqnB
         J32jALblUijabmBsmxTqa9mak/IJrOYW+TpwM7I0u3DjF0Y9SMP7ENMihs/kuM+w9uGZ
         yzvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=NdViJJKvcZjWIVzum0cOYihfcuayyzpxE1qpgQ8/aaQ=;
        fh=RHrV25WUkb8NMF/olzZVhQdEwcTS7QX+UpnYMG7ayiA=;
        b=QjXUw+QsF6Ov+kpC7BWRbk8Bz+4LNilSUvrSYG50wyfWrR26/trC78Nu6Sz+7o6eBm
         7hPw0JzSTUOna7pHwd3L58IUgrCGRvxMGg+Iv4qOt+PeeQzGipxyMWWdXUPg+a+23k79
         rw/Ge0r/v+HuJnYXm5nlMMkX5DUvuYdmHxkctpszq3TmpiLuwQVft+ckfWlu+L0q8U/L
         3sBt36dw/dbhXz20S0ViJzRYIlI3EcxK0QMAlsJccCPrFGf51NfbWU9DsyOZuDAkeGKO
         bdKbgIVKwk8sYAsbdMYlW+U+EgcpDJURyDX8eZtbFE10d0wwU4YGSo9sMVDha8DP5e7+
         4cLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789038632; x=1789643432; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NdViJJKvcZjWIVzum0cOYihfcuayyzpxE1qpgQ8/aaQ=;
        b=Vthkz0btPqXbQ8IiJXnDdFf82c+khzd1m/N0VYoWOUNS1nMw3NTm9XE8hMQ3JLwTZY
         0PVABCMoWzQ7xFFc5tUAsN9S+Vha3AZY2wkL3w+mGN57XoAvCcdX5i4dNxwtnmElkqvo
         qYYHjG7RldJrxKMgmeWyqHNFuaYv7a59+bqxzxCca0eGyHtWC3SNdBrPVI+vZow96e5C
         UL6XXx4Ms31MdftJnpy0R25zaASZq7dDGDJ1cizsBo54VFRAX8pZfgVABAEDuvNUevQJ
         sLuJAKzHZL/fJzEVcghZhqN2xqMgmsEPjPXfB8KZIeU6NzX1jUlgMwVq9lMa9VPrSH6Q
         Hr9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789038632; x=1789643432;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NdViJJKvcZjWIVzum0cOYihfcuayyzpxE1qpgQ8/aaQ=;
        b=focTrTwnozl/koPK9vRg+HP38Uo7NH4fKbL6KgCRyi4kTd2W3jQN2zhFwTQOZ0kHiJ
         QPYto/xVfFL/UuZ1TV+vBrmDrz0uLZWHCiTafUWnkMVeGLJ8hccrSDxqb9z1QQsXIluD
         7o5wL8jbC4HvsjamM/VfRaACg8CloGfx/SgU7wnDzAUNot0qMkJ0KIpLXkpIiMualk+T
         xvZZ04KcoJkhQtpU3/70SeRWKDPp+RDLjbdR7CD0VHadpVN863bh6MmFPfqDcarJkBSx
         jxualdBCUZ1bSSS8oSFBwjGuwpWX4AIauIipET6qVj7xESJ9jVbZ9h0UEgUJzm3GTeO0
         7C7Q==
X-Forwarded-Encrypted: i=1; AKwUvBxKbHVSiR78hRbw8zrjuZZP/j6oZM57OicO3lMVBGTGbNX7nk8GrvbFW9PHCC/A2w6GLUE=@vger.kernel.org
X-Gm-Message-State: AFuF++k61bgCdS56pG+gQiznze8ENFHI+FaKOEs9e3IAD5hk4X7JPEQ8
	Mieb27eiyJcGnij4hV1FwRyuQmLFsXVYzVaS8USFiPGx9w5erCSIjCgeh0JNe2KzkqRUZr7wGJ1
	vtmmoO3To3e6jxOle8X8cVEMoZhiEOwo=
X-Gm-Gg: AYBFou3VZMYGO5kz5eTVf015IPRhMVdnKdSBDfXkEkxfqtQkodEcwvPrfC40nkOQHew
	WIaVEIDmbeVTBK157ecn7HoCg4F1fJHgvRIHSZTEPB3maLWtI5Vbl6LxwbdTVHHVRfmKnI5j/O5
	7SzZvIbWFC448PVLGaxWHPpIoHumvgoGvBpgcglz4cVBV3iDr7WP85XUz2k4blR8VhfaRk/HoBV
	xM5kcuoTjHxkRd9r+h8BSiqnMG6oPJ4Ezw5BS3eRFYudODejBTDTqS6099kYAKa8E2X7hik+ca0
	ORF49S6ejZRJqTa4VGDG0NTZztn90Mcm43GEJuSjv0Wq9rt7jHckwy67OAVGy90oKsEa3XcqIIT
	IGPLqSn43U/jPGQwG0vGnFqhQ+1C3AmapxbXBszdHIAZdGgltr8OKLLo=
X-Received: by 2002:a05:6102:3e95:b0:790:2ae8:32c3 with SMTP id
 ada2fe7eead31-79075f973bamr3412881137.6.1789038632130; Thu, 10 Sep 2026
 04:10:32 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 10 Sep 2026 04:10:31 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 10 Sep 2026 04:10:31 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260909-pks-odb-write-alternates-at-creation-time-v4-7-d8a78ffc32e4@pks.im>
References: <20260909-pks-odb-write-alternates-at-creation-time-v4-0-d8a78ffc32e4@pks.im>
 <20260909-pks-odb-write-alternates-at-creation-time-v4-7-d8a78ffc32e4@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 10 Sep 2026 04:10:31 -0700
X-Gm-Features: AcwNN1Vk3ZV3OHyO_oaiOIb5ylzSxbH6yjiqrS65HMhFuVpnz0QEZpX6XbI3O1o
Message-ID: <CAOLa=ZQaPstiQmXm9=TyWPUxL6X2=Lcqeg6y2XeXzSJDpq-GBA@mail.gmail.com>
Subject: Re: [PATCH v4 7/9] odb/source: support writing alternates when
 creating the database
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Junio C Hamano <gitster@pobox.com>, 
	Justin Tobler <jltobler@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000289004065b1f0445"

--000000000000289004065b1f0445
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Add the ability to write alternates when creating the object database.
> This change allows us to remove the `write_alternates()` callback in a
> subsequent patch.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  odb/source-files.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  odb/source.h       | 17 +++++++++---
>  setup.c            |  4 ++-
>  3 files changed, 91 insertions(+), 6 deletions(-)
>
> diff --git a/odb/source-files.c b/odb/source-files.c
> index b7b3a297bb..8fe65d91f8 100644
> --- a/odb/source-files.c
> +++ b/odb/source-files.c
> @@ -18,6 +18,7 @@
>  #include "run-command.h"
>  #include "strbuf.h"
>  #include "string-list.h"
> +#include "strmap.h"
>  #include "strvec.h"
>  #include "tree.h"
>  #include "write-or-die.h"
> @@ -51,9 +52,14 @@ static void odb_source_files_close(struct odb_source *source)
>  	odb_source_close(&files->packed->base);
>  }
>
> -static int odb_source_files_create_on_disk(struct odb_source *source)
> +static int odb_source_files_create_on_disk(struct odb_source *source,
> +					   const struct odb_create_on_disk_options *opts)
>  {
> +	struct lock_file alternates_lock = LOCK_INIT;
>  	struct strbuf path = STRBUF_INIT;
> +	struct strset seen = STRSET_INIT;
> +	struct strbuf line = STRBUF_INIT;
> +	int ret;
>
>  	safe_create_dir(source->odb->repo, source->path, 1);
>
> @@ -64,8 +70,74 @@ static int odb_source_files_create_on_disk(struct odb_source *source)
>  	strbuf_addf(&path, "%s/info", source->path);
>  	safe_create_dir(source->odb->repo, path.buf, 1);
>
> +	if (opts->alternates && opts->alternates->nr) {
> +		FILE *alternates, *orig;
> +

So this is similar to what we already do in
`odb_source_files_write_alternate()`.

> +		strbuf_reset(&path);
> +		strbuf_addf(&path, "%s/info/alternates", source->path);
> +
> +		repo_hold_lock_file_for_update(source->odb->repo, &alternates_lock,
> +					       path.buf, LOCK_DIE_ON_ERROR);
> +
> +		alternates = fdopen_lock_file(&alternates_lock, "w");
> +		if (!alternates) {
> +			ret = error_errno(_("unable to fdopen alternates lockfile"));
> +			goto out;
> +		}
> +
> +		/*
> +		 * The alternates file may already exist, e.g. when it has been
> +		 * seeded from a template directory. Read any preexisting
> +		 * entries so that we don't end up writing duplicates.
> +		 */
> +		orig = fopen(path.buf, "r");
> +		if (orig) {
> +			while (strbuf_getline(&line, orig) != EOF) {
> +				strset_add(&seen, line.buf);
> +				fprintf(alternates, "%s\n", line.buf);
> +			}
> +
> +			if (ferror(orig)) {
> +				ret = error_errno(_("unable to read alternates file"));
> +				fclose(orig);
> +				goto out;
> +			}

Shouldn't this be checked inside the for loop with every `fprintf` call?

> +
> +			fclose(orig);
> +		} else if (errno != ENOENT) {
> +			ret = error_errno(_("unable to read alternates file"));
> +			goto out;
> +		}
> +
> +		for (size_t i = 0; i < opts->alternates->nr; i++) {
> +			const char *alternate = opts->alternates->v[i];
> +			if (!strset_add(&seen, alternate))
> +				continue;
> +			fprintf(alternates, "%s\n", alternate);
> +		}
> +
> +		if (ferror(alternates)) {
> +			ret = error_errno(_("unable to write alternates file"));
> +			goto out;
> +		}
> +

same here.

> +		if (commit_lock_file(&alternates_lock)) {
> +			ret = error_errno(_("unable to commit alternates file"));
> +			goto out;
> +		}
> +	}
> +
> +	/* Reprepare the object database to activate alternates. */
> +	odb_reprepare(source->odb);
> +
> +	ret = 0;
> +
> +out:
> +	rollback_lock_file(&alternates_lock);
> +	strbuf_release(&line);
>  	strbuf_release(&path);
> -	return 0;
> +	strset_clear(&seen);
> +	return ret;
>  }
>
>  static void odb_source_files_prepare(struct odb_source *source,
> diff --git a/odb/source.h b/odb/source.h
> index ea8675247e..63f1c0c531 100644
> --- a/odb/source.h
> +++ b/odb/source.h
> @@ -36,6 +36,15 @@ struct object_id;
>  struct odb_stream;
>  struct strvec;
>
> +struct odb_create_on_disk_options {
> +	/*
> +	 * Alternates that shall be written into the newly created object
> +	 * database. Whether or not this option can be handled is specific to
> +	 * the backend.
> +	 */

Would it make sense to formalize errors thrown by backends, so we know
when a backend specifically cannot handle alternates?

> +	const struct strvec *alternates;
> +};
> +

[snip]

--000000000000289004065b1f0445
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 302c25373da81cd5_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xaWtDVVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meVZLQy85YVVPQXRvYnN3U2ZvM3BPUVVoVGphcnA1Vgp5ZWFlL0dhcmFh
MEtaSzM2VmJINzhGZENTUUdURHJlUmdxemtoUFhKSm03UG95Umxva1FGZjZrZkZSZWdpam13Cmts
QnZTdzUxOEp1dXhzaHhDWlNYbFRFWVF4NzlMRkVDeWpDYXk4N2p3VjdLbUk2bWZTU2JaY2FFRHNM
SHRmY2IKUjZ4aGk4d1IvRzcwTXB1TWlnTC8zQlVoSGZxUFVLb3VHN3JSc3A3ZHdrUk5kM1FJU3Js
QUdhSkNnVXNmR0pPWAplWDZxU1YwS2xJNWRtY2UySTB1ZHovY2RYK3NHb05yT0JGTy82U3JUeUF6
bE04dFIyWXlzWUFqeW8zVUdZcitUCjFKYXFYaWI4WHM4S2xLR3FhRzNMUzliRUxIRTlUWUhIT0VF
QUNNMTc3RXJvNkdJNnhmR3p4SWhiZmhndHU0bUYKZmhtMTZRT2RXcjFXdDRQUTNyNnQ4dGQrUGdO
RnpSZTkzQStVQ1pGQkk5QzhrQWg0SHpiVnF6T1pGRTNUV1FIWQplSzZVZFRiTEZrTHhCa3ZQY0t6
aXJlR2ZGMGFVR0V3Rk4yWmM1ZnRUYXU0YTdicjJhZHE4N2w2dWI5bDc0ZzJBCks0a0NzeUlScjV0
UXp4RjB5MzNWeXdNa3pNdGpUOFNKTlVpVDFkdz0KPWFWaEUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000289004065b1f0445--
