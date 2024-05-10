Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86BB16F8FA
	for <git@vger.kernel.org>; Fri, 10 May 2024 11:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715341421; cv=none; b=MYZg1gRzgN4TVnwtVTHf+Saljxiv6JOFO3rvWH0jjv5re4wRCkJbUcKU9JU0YinUigWw3pA/5jdWC+xwy3m2oJctXDx0cMxEp+0Jcnh+9sS26temtpDW/bXGIMzl0QwfsWLTFKQP+7IEcWgP9JouOCYIB/mHGtZ0ryl4MsraVug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715341421; c=relaxed/simple;
	bh=pijAX7Aw9F+KmBu0A8T5QzI1VbNEToI4ZgQb0r70RIM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u0pUrvy91QoZVKg/wzwXMyVy6GkZNlq8LRlkYk6acrXJiouoaVyPJ8CdyUY4O53nakrYSl2L1keEufxKfo4Gtw7oMCVTnozC3VUlQoDGTUDtBKToaOqbX+FcQJ8Vpu3piJHH78TFJnfBlwGIh7q7ogSA4UQWhOfsryvvlUQHlwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xfuhz7qt; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xfuhz7qt"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6f0e975f67fso538477a34.0
        for <git@vger.kernel.org>; Fri, 10 May 2024 04:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715341419; x=1715946219; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=eL8QyU9I730OBbAxTHaWfF6cRuc4hkd8wJnKvlE6dKk=;
        b=Xfuhz7qtGeSg+L7G80c1OxLWCsuM5jcnObwuU9k803+OYHcZCEBEmbY4/CT5kV8ROA
         sM3kyvOiZby1wxc9+n0y3E4Qd8kzQMIM9QbhkfjLH+oS2Ojvz9mzeUZNAt7EosVAcA9p
         O9ifPAD015jQzqV1zBt0vC9JbPSW1ONVVCHPs+q7uxvp0cnVlGfac2+NrHSwQ8p7xZ9M
         dsYe4nTebFbiK4SicL0w0oYjXgoUbUE/2WJPFoAyIhwPGUyiN6/1MhOADE2Un1Cchal9
         Itg1k6NNNde2ks6Y67s8KWjQFkc8aV9oeP4ZubAv0mLLoySXV6V0rehHQvyIgZz6PbH4
         PZxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715341419; x=1715946219;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eL8QyU9I730OBbAxTHaWfF6cRuc4hkd8wJnKvlE6dKk=;
        b=XgkVTLvAnPs7JXERocwv61fG0Jr3SZZXup1cKwjAdL3OYom/BZnPMxcViBtMSnETYl
         HvGHNeEFo7XHEvPtNg7VWgTccJnb420TjBjMa8rnOZ5DCJkY/xLCEE2kpZbiyJq0mTpD
         hptwWQWIvSwpGT2egZYBarpBv9nT2VCLRAbpAQn0uHqyOYPdFs8aXHMxVLxjtB7nloQz
         GTLkD5+RYlTyXVt4cf9UaTHg/wfG28QYq2z1/TUib5eNGu+lM9oDbk8D0kl4dJrfpxCq
         Q8hm6M10cYkfeP/tG88o3KNGzLiB61w0OmetK7B30EjE77AuUW8nSJnTrB6PgPLCKGzc
         73Kw==
X-Forwarded-Encrypted: i=1; AJvYcCWje4ZO6ZDJbtvMogxDvDQWS68tpRfgGZHYGn4puWW3xG71p8HPVfuQQbhzQA2qXCU56dfnjZ6qr1Z4F8R+frXYjVqw
X-Gm-Message-State: AOJu0Yzo27pRByNYRHRY0ne74y87H3DGJPmAze4asyyFt3eau5KwBMYz
	p2Ga+W77tLxGSoicRY3ku+0jRZ2lTlXXTV4SYqNqn3p+YNcnn3OFmc8sFWhhkStCrMXr95tYYc/
	nSyxpYHwBvdosGYn4VMniIpn2xK4yog==
X-Google-Smtp-Source: AGHT+IEKNRSAxBmE/t4D4UiMaS6Jp+g1zCbIZLqH2g5mJ1/Zh3O6V86nq+3DhfsGKz/VG2io9ig30QS8QNT3f6hvP1w=
X-Received: by 2002:a05:6871:6212:b0:232:fba4:4594 with SMTP id
 586e51a60fabf-24172fc5169mr2610141fac.49.1715341418629; Fri, 10 May 2024
 04:43:38 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 10 May 2024 04:43:36 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <cover.1715336797.git.ps@pks.im>
References: <cover.1714630191.git.ps@pks.im> <cover.1715336797.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 10 May 2024 04:43:36 -0700
Message-ID: <CAOLa=ZTJq40qhXLR=W0DSKKd+rehU-CzBafrkxP_nZH7xGJyWQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] reftable: expose write options as config
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000ed2a6d0618180b1b"

--000000000000ed2a6d0618180b1b
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this is the second version of my patch series that exposes various
> options of the reftable writer via Git configuration.
>
> Changes compared to v1:
>
>   - Drop unneeded return statements.
>
>   - Move default geometric factor into "constants.h".
>
>   - Fix a typo in a commit message.
>
> Thanks!
>
> Patrick
>
> Patrick Steinhardt (11):
>   reftable: consistently refer to `reftable_write_options` as `opts`
>   reftable: consistently pass write opts as value
>   reftable/writer: drop static variable used to initialize strbuf
>   reftable/writer: improve error when passed an invalid block size
>   reftable/dump: support dumping a table's block structure
>   refs/reftable: allow configuring block size
>   reftable: use `uint16_t` to track restart interval
>   refs/reftable: allow configuring restart interval
>   refs/reftable: allow disabling writing the object index
>   reftable: make the compaction factor configurable
>   refs/reftable: allow configuring geometric factor
>
>  Documentation/config.txt          |   2 +
>  Documentation/config/reftable.txt |  49 +++++
>  refs/reftable-backend.c           |  43 ++++-
>  reftable/block.h                  |   2 +-
>  reftable/constants.h              |   1 +
>  reftable/dump.c                   |  12 +-
>  reftable/merged_test.c            |   6 +-
>  reftable/reader.c                 |  63 +++++++
>  reftable/readwrite_test.c         |  26 +--
>  reftable/refname_test.c           |   2 +-
>  reftable/reftable-reader.h        |   2 +
>  reftable/reftable-stack.h         |   2 +-
>  reftable/reftable-writer.h        |  10 +-
>  reftable/stack.c                  |  57 +++---
>  reftable/stack.h                  |   5 +-
>  reftable/stack_test.c             | 118 ++++++------
>  reftable/writer.c                 |  20 +--
>  t/t0613-reftable-write-options.sh | 286 ++++++++++++++++++++++++++++++
>  18 files changed, 576 insertions(+), 130 deletions(-)
>  create mode 100644 Documentation/config/reftable.txt
>  create mode 100755 t/t0613-reftable-write-options.sh
>
> Range-diff against v1:
>  1:  47cee6e25e =  1:  7efa566306 reftable: consistently refer to `reftable_write_options` as `opts`
>  2:  d8a0764e87 =  2:  e6f8fc09c2 reftable: consistently pass write opts as value
>  3:  c040f81fba =  3:  aa2903e3e5 reftable/writer: drop static variable used to initialize strbuf
>  4:  ef79bb1b7b =  4:  5e7cbb7b19 reftable/writer: improve error when passed an invalid block size
>  5:  4d4407d4a4 =  5:  ed1c150d90 reftable/dump: support dumping a table's block structure
>  6:  b4e4db5735 !  6:  be5bdc6dc1 refs/reftable: allow configuring block size
>     @@ refs/reftable-backend.c: static int read_ref_without_reload(struct reftable_stac
>      +		if (block_size > 16777215)
>      +			die("reftable block size cannot exceed 16MB");
>      +		opts->block_size = block_size;
>     -+		return 0;
>      +	}
>      +
>      +	return 0;
>  7:  79d9e07ca9 =  7:  05e8d1df2d reftable: use `uint16_t` to track restart interval
>  8:  653ec4dfa5 !  8:  bc0bf65553 refs/reftable: allow configuring restart interval
>     @@ Documentation/config/reftable.txt: readers during access.
>
>       ## refs/reftable-backend.c ##
>      @@ refs/reftable-backend.c: static int reftable_be_config(const char *var, const char *value,
>     + 		if (block_size > 16777215)
>       			die("reftable block size cannot exceed 16MB");
>       		opts->block_size = block_size;
>     - 		return 0;
>      +	} else if (!strcmp(var, "reftable.restartinterval")) {
>      +		unsigned long restart_interval = git_config_ulong(var, value, ctx->kvi);
>      +		if (restart_interval > UINT16_MAX)
>      +			die("reftable block size cannot exceed %u", (unsigned)UINT16_MAX);
>      +		opts->restart_interval = restart_interval;
>     -+		return 0;
>       	}
>
>       	return 0;
>  9:  6f2c481acc !  9:  6bc240fd0c refs/reftable: allow disabling writing the object index
>     @@ Documentation/config/reftable.txt: A maximum of `65535` restart points per block
>
>       ## refs/reftable-backend.c ##
>      @@ refs/reftable-backend.c: static int reftable_be_config(const char *var, const char *value,
>     + 		if (restart_interval > UINT16_MAX)
>       			die("reftable block size cannot exceed %u", (unsigned)UINT16_MAX);
>       		opts->restart_interval = restart_interval;
>     - 		return 0;
>      +	} else if (!strcmp(var, "reftable.indexobjects")) {
>      +		opts->skip_index_objects = !git_config_bool(var, value);
>     -+		return 0;
>       	}
>
>       	return 0;
> 10:  30e2e33479 ! 10:  9d4c1f0340 reftable: make the compaction factor configurable
>     @@ Commit message
>
>          Signed-off-by: Patrick Steinhardt <ps@pks.im>
>
>     + ## reftable/constants.h ##
>     +@@ reftable/constants.h: license that can be found in the LICENSE file or at
>     +
>     + #define MAX_RESTARTS ((1 << 16) - 1)
>     + #define DEFAULT_BLOCK_SIZE 4096
>     ++#define DEFAULT_GEOMETRIC_FACTOR 2
>     +
>     + #endif
>     +
>       ## reftable/reftable-writer.h ##
>      @@ reftable/reftable-writer.h: struct reftable_write_options {
>
>     @@ reftable/reftable-writer.h: struct reftable_write_options {
>       /* reftable_block_stats holds statistics for a single block type */
>
>       ## reftable/stack.c ##
>     +@@ reftable/stack.c: license that can be found in the LICENSE file or at
>     +
>     + #include "../write-or-die.h"
>     + #include "system.h"
>     ++#include "constants.h"
>     + #include "merged.h"
>     + #include "reader.h"
>     + #include "refname.h"
>      @@ reftable/stack.c: static int segment_size(struct segment *s)
>       	return s->end - s->start;
>       }
>     @@ reftable/stack.c: static int segment_size(struct segment *s)
>       	size_t i;
>
>      +	if (!factor)
>     -+		factor = 2;
>     ++		factor = DEFAULT_GEOMETRIC_FACTOR;
>      +
>       	/*
>       	 * If there are no tables or only a single one then we don't have to
> 11:  861f2e72d9 ! 11:  e1282e53fb refs/reftable: allow configuring geometric factor
>     @@ Documentation/config/reftable.txt: reftable.indexObjects::
>       The default value is `true`.
>      +
>      +reftable.geometricFactor::
>     -+	Whenever the reftable backend appends a new table to the table it
>     ++	Whenever the reftable backend appends a new table to the stack, it
>      +	performs auto compaction to ensure that there is only a handful of
>      +	tables. The backend does this by ensuring that tables form a geometric
>      +	sequence regarding the respective sizes of each table.
>     @@ Documentation/config/reftable.txt: reftable.indexObjects::
>
>       ## refs/reftable-backend.c ##
>      @@ refs/reftable-backend.c: static int reftable_be_config(const char *var, const char *value,
>     + 		opts->restart_interval = restart_interval;
>       	} else if (!strcmp(var, "reftable.indexobjects")) {
>       		opts->skip_index_objects = !git_config_bool(var, value);
>     - 		return 0;
>      +	} else if (!strcmp(var, "reftable.geometricfactor")) {
>      +		unsigned long factor = git_config_ulong(var, value, ctx->kvi);
>      +		if (factor > UINT8_MAX)
>
> base-commit: d4cc1ec35f3bcce816b69986ca41943f6ce21377
> --
> 2.45.0

The range diff looks good to me, thanks for the quick iteration :)

--000000000000ed2a6d0618180b1b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 72e5a9c69dcf4b58_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZK0NHWVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMUpzQy85TlQ3Qm5nMnJGSG8yT0NhYlcxTElHQWFaMQpyWU9VOTVTQXlV
SmFsc1B5M1dWSnFCSkdiQWIvNERpaDZSYy83eU9Hd3YxTGNIYkYrSlI2OExMUWMrTWRoR2E2ClpG
MWEyazdsYVNTVFJXQjBId0hMRmF3a1ZqeTVMbm5uK25CcUs5MmZCYSs1aXpRVXNaM2ZpK2VFYzd6
NUdyN00KMEZtbHplazJGd0xDV0N0dmlTelpUTVR3LzE4QWxhT1l4N0Z4ZXQxUE9aSG1TeDJSUGk4
ODhKTFVIWEptd0QrcApLRW9LaGZYbUVpek56RXlNUTVPLzVhckNXeWsrMlJaTnBDaUtLQWhVeCs3
cVViV0hPWG9lZld5aUg2Zjl5Q2JkCk11T1Rxdi9YUXZnSXZUdDVVMU9FZUhSTnM5ekVpZjFKSjg4
K3l3K2t2cWVZTkdTSmZZTDZpUzB0YVZmTXFPWjkKWEliejZZLy9XTnM1aC92anZRTEV4VUw2bFN2
Y3Y5ZTNab3MyQThYWEFObUUvbForNXBUaURCeTdoZzA4WlAwUQpGL0d4SGhYYkxiR0I2bUdYanlt
azBVdjYraGNjd1NqZ0dmbnl2a3JLaTRNR3R6anVVZlVJUWtOeDRzNnRPSVErCjAvVVNDTUpzeHEy
T1N0Mk54RWJxWUpRd0FVL282bFg2K1FNdXNpbz0KPXF3Y2gKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000ed2a6d0618180b1b--
