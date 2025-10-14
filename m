Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690EA1C4A17
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 09:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760432827; cv=none; b=o9rF7+0YXI1/XlxMKfFwRBl1p+iRJRsLglUsc1Z4oco757y+ILIKaDVk2UAQwvexIk7EeKHDN6ZXnE04sbCsm0OpQplZP8Ej6QhiWsuMaXJ3px+LJaWUysH8m36KtnCzXCa7X3DdQkvh1SAU33cedxNIDJqOn3P7POHVkJQr3ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760432827; c=relaxed/simple;
	bh=lgryhoomhk1u2VcvqgpbTaARzh6rRYg7liTOMQwkXhc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QDqrlQ5BTwJkCzL+7fi0HlKk+CKDvXLXMyIlWCbwVOwVpo2PcwMzsUX3VPrWcvwNp4p7nO+uhtYs71uie38s5ItX2sXGaCdzuy/yeMQdTLZlJLqGDb8CRH0uXLvl+wcn9Lc17wTU3JgHbHKbULgzB7mv2LNbW+mD7hkve+cVhag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lpD0t0Nt; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lpD0t0Nt"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-554a7e98e19so3474413e0c.3
        for <git@vger.kernel.org>; Tue, 14 Oct 2025 02:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760432824; x=1761037624; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=OTwfUWjCe1t6py7Zy8JEkUoASDlaxB4WyiLz5ZUCrBs=;
        b=lpD0t0NtJrt/l2KPwCTc61DI1R4EdjUJBXZTZStKRdoKw6vyTtvd8xjdM0b+q40616
         NOIFk9mVmVbxbz9xTAV7O9luZpoxJqN0J51kEOLkg47CY6h3cJhErO9O2dX8OzsqI9pA
         hmw+ApZHdkoGXyrXOtVeug1ajxfjESMkU0yzqEOYhSSnfiDfmGobkErZsiOPf/X+t929
         YkIbknrdoBdpwZ6R2KNQhirE4S6tZSsAiFcPEGkVuJ2mH9/czCqVfcxlXeeSb++eYwPA
         vUheGj9u1WECPgB918az+c2W+Mcuw/dAdIQ6UxsxYKqAdHzcsmDNFbFETxc527eQaySa
         wmYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760432824; x=1761037624;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OTwfUWjCe1t6py7Zy8JEkUoASDlaxB4WyiLz5ZUCrBs=;
        b=j1gbPjhGxhiqdvwt8DMHNr3evfEXTDtzBK0dibPbUxQnbFLvefNYxHc2oz41bs3UMu
         xAdsYbw8rcId/vu7pBiqr7wDRZkf/+sdyDMQ9z9tpAVUvC05fu9RDqPEegEe/2DAW2py
         ZW82T9tH7ceGtUqZIt70Bpd1zws0LSoHfoGV2rc9emAg07Iq2ON1pYvAlEWroaDgvAAN
         dUeUiRQ++hXvY57M6o/iEqR6Bf6D4cF4pYx1WPayJLjcdWrXwHlTXOHpd42TsjZJLx+I
         EzcQusoMVRbgMZEYx7sU9XV+C2hqrQBD1ugaJbGqwLXWsPbeNaKpE+7nPXFcY9k9R+Bg
         pBsA==
X-Forwarded-Encrypted: i=1; AJvYcCW8+KrscTMZdSHo2fqscqWvyhHQRuAoxKggBIy0F7pQAxRD6LetlIB1hvf/wzGtV4Js0hU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+M1XMzGw1cp/Vm5ubn7fOYHGt1smN81VemNXQAucA+OgfASbm
	J528FquiKyFx2BQ/PTY/vi4eW9uUIO5SoZ6z3hbr5qe0NTjHfP0lttq4NgECwScbeZyC8McengK
	b5xT/u1KbTPqhOCHRuKkxOMHbXbKqkQ4=
X-Gm-Gg: ASbGncu5WdLH9GPqd7UUdF+YqZ6sJFGUjkZ8/bA6sRMBKD6LtAmVQuPO01JCAUv7fJC
	Vmodxf+Vsq8zU0pSovvqzmj1y2GyAKZUxaeWjqFGZa/byyhh29BCKp6RlYe2oLY3+7ASEBDFuUI
	YWaYaU6wevlEBuh5ZhYLjApdcGMcTO1lOAuKLLb/UPf+hcy1ndfftVRuMhBkUKXUOVBp2WuwlvS
	KC9MICpHi02IhElD5x+IxIBHhlCpC2PGDn4U8eAwKHLe1sXsM1XpjYebzLt+LOZ2tD+f1w=
X-Google-Smtp-Source: AGHT+IEFoKpUiYXY1L0TaRXC1xVdAV5biJCpEEYljWYaSAKrveWG8PisJgY8BvUK7bFCPkJtDcXGQlL4LfrDne6w5N0=
X-Received: by 2002:a05:6122:20a3:b0:543:e262:ade2 with SMTP id
 71dfb90a1353d-554b8bdee12mr8979288e0c.12.1760432824023; Tue, 14 Oct 2025
 02:07:04 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 14 Oct 2025 05:07:03 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 14 Oct 2025 05:07:03 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20251001-b4-pks-history-builtin-v4-5-8e61ddb86317@pks.im>
References: <20251001-b4-pks-history-builtin-v4-0-8e61ddb86317@pks.im> <20251001-b4-pks-history-builtin-v4-5-8e61ddb86317@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 14 Oct 2025 05:07:03 -0400
X-Gm-Features: AS18NWDFvmTWP8ALnkmFETgW9u_MTOhi-a59IIsmDsT42GE5lRTkHynhHhMKRRk
Message-ID: <CAOLa=ZQSc0jHv9gK5T06GA_mprknucwCj5H_M2djZ-UWfRMbJQ@mail.gmail.com>
Subject: Re: [PATCH v4 05/12] builtin: add new "history" command
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
	Sergey Organov <sorganov@gmail.com>, =?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>, 
	Martin von Zweigbergk <martinvonz@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Elijah Newren <newren@gmail.com>
Content-Type: multipart/mixed; boundary="00000000000020a46c06411ab554"

--00000000000020a46c06411ab554
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> When rewriting history via git-rebase(1) there are a couple of very
> common use cases:
>
>   - The ordering of two commits should be reversed.
>
>   - A commit should be split up into two commits.
>
>   - A commit should be dropped from the history completely.
>
>   - Multiple commits should be squashed into one.
>
> While these operations are all doable, it often feels needlessly cludgy
> to do so by doing an interactive rebase, using the editor to say what
> one wants, and then perform the actions. Furthermore, some operations
> like splitting up a commit into two are way more involved than that and
> require a whole series of commands.
>
> Add a new "history" command to plug this gap. This command will have
> several different subcommands to imperatively rewrite history for common
> use cases like the above. These commands will be implemented in

Nit: s/commands/subcommands

> subsequent commits.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>

[snip]

> new file mode 100644
> index 0000000000..1537960374
> --- /dev/null
> +++ b/Documentation/git-history.adoc
> @@ -0,0 +1,45 @@
> +git-history(1)
> +==============
> +
> +NAME
> +----
> +git-history - EXPERIMENTAL: Rewrite history of the current branch
> +
> +SYNOPSIS
> +--------
> +[synopsis]
> +git history [<options>]
> +
> +DESCRIPTION
> +-----------
> +
> +Rewrite history by rearranging or modifying specific commits in the
> +history.
> +
> +This command is similar to linkgit:git-rebase[1] and uses the same
> +underlying machinery. You should use rebases if you either want to
> +reapply a range of commits onto a different base, or interactive rebases
> +if you want to edit a range of commits.
> +
>

The either..or in the last sentence is a bit confusing; as it is not an
either between 'want to reapply a range of commit onto a different base'
& 'interactive rebases'.

Perhaps we can simply s/either//

> +Note that this command does not (yet) work with histories that contain
> +merges. You should use linkgit:git-rebase[1] with the `--rebase-merges`
> +flag instead.
> +
> +THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
> +
> +COMMANDS
> +--------
> +
> +This command requires a subcommand. Several subcommands are available to
> +rewrite history in different ways:
> +
> +CONFIGURATION
> +-------------
> +
> +include::includes/cmd-config-section-all.adoc[]
> +
> +include::config/sequencer.adoc[]
> +
> +GIT
> +---
> +Part of the linkgit:git[1] suite

[snip]

> diff --git a/builtin/history.c b/builtin/history.c
> new file mode 100644
> index 0000000000..f6fe32610b
> --- /dev/null
> +++ b/builtin/history.c
> @@ -0,0 +1,22 @@
> +#include "builtin.h"
> +#include "gettext.h"
> +#include "parse-options.h"
> +
> +int cmd_history(int argc,
> +		const char **argv,
> +		const char *prefix,
> +		struct repository *repo UNUSED)
> +{
> +	const char * const usage[] = {
> +		N_("git history [<options>]"),
> +		NULL,
> +	};

Nit: We have pointer alignment set to 'Right' in our styling guide and
also mentioned in our 'Documentation/CodingGuidelines'

   When declaring pointers, the star sides with the variable
   name, i.e. "char *string", not "char* string" or
   "char * string".  This makes it easier to understand code
   like "char *string, c;".

The rest of the patch looks good!

[snip]

--00000000000020a46c06411ab554
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: fe068c8efb110285_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qdUVyVVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNEw5REFDanlxd2l1aTBzMXB1cEh2S0pwUHNCeHFFRgphbWxWSWFDelda
K2RKRjlTdWtkaFpITTZHNW5YYWlVMWEycnF5aDdkKzVWd1RLdW5GejNsZldsdlpXRU9aQzhUClFw
TExCcjNTZnBNNGV4MUxZdGdDNWhRWVB6YVVBamZscklKR284dWFlRDV0eFZJNUhMYlo3S0ZSb3dQ
LzVrUVYKb012aWtYRUpZK2QzbElFbmhlV1VkN3F3T2dJVDR4dnlnSXhZak9SN1owSFpvSENTTDhS
ZzBua3JtZVMwSjlseApHMGdXVjNsQVE3bzlyNlJ0WGFkbnRBWXdaTUI3WGVsTHR6bTRVNklxMytR
L2NmODRvM1ZxdWFaazhDUWFrTUJZCnk0clN2SWFHWnRpMWhuUWRCaHZ1ZTllTUZ2UktYUkVIZ3J1
N1ZjeXZ3cFZlZCtZNURheHdXdzJzRUx1RnlwQ3oKNWdhMGJwWWRvSS9iUVhDelBzd1Ribk9ydHdt
VEkwZ3NBMGU3cGJ6dFZxMXExK0dhTXlkQlZFOEpvdUloNWt3NQowd3lTWndzVmhJeGlyUEdOdlBn
RE95YTNTT1FPZTZYQ3hJK1h6T0psMU0wWmpkZTRjYnRCNDVodlZ3UzRRamplCkg0V3U0V3Jua01R
RDB4OGxqazBCdjVCN0ltQ2xQNjVackNSdDNFRT0KPWJScmIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000020a46c06411ab554--
