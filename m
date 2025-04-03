Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0E0254877
	for <git@vger.kernel.org>; Thu,  3 Apr 2025 19:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743710214; cv=none; b=HTGLVMNK9SG5IzJrpSEczp7MoPJRP3PJlePqB3292mA1b1B9ArwkHuzB8fpK3qNmnX49VRH0Ks7SbYZ6/JbKKMzpt7esbbZeIu1Q9BXiDqevGsqIehPvV1bS/lak3+dDsJQlqjzOlKLlec4x+m4xKKKGlsR4xGxfKHtPFQxDNPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743710214; c=relaxed/simple;
	bh=lvU/BC99/+hRPveqPwRRoyX50p2C597vGPSxEEpmS0w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KskYRnUFnHQ9+K++e6wkQ4dc8Zk9m4NZoipcK9JKlzKMuRsy4SuqYQ5R9M/DHPfXpl09On3VhfryUA/0GoNaM5CXmVArI11tusPlQXZQuB+ZIw0RBQFv42VWWS6sCYiqCjudtdrCKkaSY+/xZHKSUBSzrGid0M58pK2QbRQjfm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=avVNdr7N; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avVNdr7N"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-85e1b1f08a5so32567339f.2
        for <git@vger.kernel.org>; Thu, 03 Apr 2025 12:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743710211; x=1744315011; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V41c7VyXdPxnH7jGN5tcoGCmepKLGtFY5J2RV9jqzNE=;
        b=avVNdr7NDvLN5IUMvTBy+P0KDJO9lLpev3P94Kf6r8tBpR5UvyPFH9tsJ2sNCSBfxZ
         zQFmZgHm6JMszDrTSMDF+Y2a7vYbN3DknlFDX9JXUkpAB1tbqJXy3BekewBR3k/FmR5D
         LViY/a7LfE8PMgp+sBjw0eT8cBTNt+HjP937iPXTOg+dU6+kDb/WMSyVTBVGhEd4AzGT
         UwRiAhhH/vJhHQ0E0PbIwJzBwlNvQAd3IuVjxfxhLPeixsuPLrAIrh7BB80dGmJeN5KH
         C2NH9zqPo78oWQ8fivb16sHWMhDeUr9H0bo/9kl/jZhHpZOFZFWFDMUlR4eLkCLhPoC4
         +dDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743710211; x=1744315011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V41c7VyXdPxnH7jGN5tcoGCmepKLGtFY5J2RV9jqzNE=;
        b=NhGfnGopox9GNHpCEQISFRKKV3HhdwdlMOjm0bNJEXuKuxxpUhWOLqn4fuoGOCPsZz
         wjsAJBEgu1EsvuEYMrV5Gb7lD6cMfErYErN6jqcL06HlFNBIiJuhdCokKBqjHlgVKsxI
         hbFr8Pzz3F9mZT4k/G1ZE9tKVQR91+hsYdEn+jfIIF+D29PlK+bXWf/fHB78N73lQpoS
         UVWYF8AcesQ4z84Q0u0jXa3qsi1wRn1qFl580wtW5wlxx8iiAq+0sNutrjJOCd1eXwjL
         8vdrWrhgR907Ttqo5sq7ejDBVmtdkg2WvdZ3GLVKz9SqlXxL5lTJtGDIBgZD4obQ0pF1
         4PvQ==
X-Gm-Message-State: AOJu0Yya5Z4r3yni7725FXgPuWcDGEKUFAWBoNfQ3rGkQZzrUNwOlSH7
	lbLu/UBvhNVxHGAhiPKg1Fbtk3k/JfE5tX+vi3ksfH9pTYQ5K2dU3iB73FOk787OYkiZDS5+B79
	8ZC7aBLOGgKrF3hJjKoQTwaWdKXY=
X-Gm-Gg: ASbGncuZ6BEeB7d6qup4RfnfiO2wH2SXaggyggKnohfdy/zwnJgzlRm9O7Cekc/tf7x
	PNBYtVNWm1ZCQMRN7j/wjyGukaTHw/f5IUcZ9lvMPY4XWDsXtXDPzxdjSXqArw+n8EKBX6R0G1B
	xtpjG60cJrQC0YWDQGbWsIy3A92tUv5eBPYJ+pybf6ygXshkJwEEcV4lYK5yY=
X-Google-Smtp-Source: AGHT+IHCbBfu83Tz95LEndiky9R1vAM3/U/sHyn47yxmoFmUEdYPrNTbfacMVEjLz9hnR1has+iM7xK2saOrL9TtO9A=
X-Received: by 2002:a05:6602:4811:b0:85e:2e83:52a5 with SMTP id
 ca18e2360f4ac-8611b422ef9mr121690739f.4.1743710211528; Thu, 03 Apr 2025
 12:56:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312-pks-update-ref-optimization-v6-0-f778e0414f55@pks.im> <20250312-pks-update-ref-optimization-v6-14-f778e0414f55@pks.im>
In-Reply-To: <20250312-pks-update-ref-optimization-v6-14-f778e0414f55@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 3 Apr 2025 12:56:39 -0700
X-Gm-Features: AQ5f1JoUx9-SqaaiFD3YXEDOyScmtgIuof7Dz2-q-PPkDekE4nSYXHF99cjMWbE
Message-ID: <CABPp-BFBqC_t5QSexRQpYsqXBa11WK+OqGt167E=K=xod=buQw@mail.gmail.com>
Subject: Re: [PATCH v6 14/16] refs/iterator: implement seeking for packed-ref iterators
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, Jeff King <peff@peff.net>, 
	Junio C Hamano <gitster@pobox.com>, shejialuo <shejialuo@gmail.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 11:42=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wro=
te:
>

> @@ -951,12 +954,41 @@ static int packed_ref_iterator_advance(struct ref_i=
terator *ref_iterator)
>                                             &iter->oid, iter->flags))
>                         continue;
>
> +               while (prefix && *prefix) {
> +                       if (*refname < *prefix)
> +                               BUG("packed-refs backend yielded referenc=
e preceding its prefix");

I just triggered this bug upon a "git pull" in an internal repository:

$ git pull
remote: Enumerating objects: 161255, done.
remote: Counting objects: 100% (55884/55884), done.
remote: Compressing objects: 100% (5518/5518), done.
remote: Total 161255 (delta 54253), reused 50509 (delta 50364),
pack-reused 105371 (from 4)
Receiving objects: 100% (161255/161255), 309.90 MiB | 16.87 MiB/s, done.
Resolving deltas: 100% (118048/118048), completed with 13416 local objects.
From github.com:github/github
   97ab7ae3f3745..8fb2f9fa180ed  master
                    -> origin/master
[...snip many screenfuls of updates to origin remotes...]
BUG: refs/packed-backend.c:984: packed-refs backend yielded reference
preceding its prefix
error: fetch died of signal 6



I made a backup of the repo with rsync.

It leaves around a lock file, which after I clear out and run `git
fetch --update-head-ok` again, it'll hit the same error.

If I put a little debugging into the while loop:

        while (prefix && *prefix) {
            if (*refname < *prefix) {
                printf("Comparing %s to %s\n",
                       refname, prefix);
                BUG("packed-refs backend yielded reference preceding
its prefix");

then my fetch produces:

Comparing =F0=9F=8D=A7 to zuora-params-orders-sorbet/
(in case that doesn't come through well, that's a shaved-ice-emoji,
according to a google search, which someone decided to use within one
of their branch names)

In this case, the utf-8 characters will have individual bytes whose
values are greater than 127, which for a signed character will be
represented by a negative number.  I tried tweaking the loop to:

        while (prefix && *prefix) {
            if ((unsigned char)*refname < (unsigned char)*prefix) {
                printf("Comparing %d to %d\n",
                       *refname, *prefix);
                printf("Comparing %s to %s\n",
                       refname, prefix);
                BUG("packed-refs backend yielded reference preceding
its prefix");

but that just lets it proceed through the loop four times before dying:

Comparing 0 to 97
Comparing  to a-params-orders-sorbet/
BUG: refs/packed-backend.c:988: packed-refs backend yielded reference
preceding its prefix
Aborted (core dumped)

meaning it eats up the four bytes from the shaved-ice-emoji and the
first four bytes of prefix "zuor" and then hits the error, so I
suspect it needs to handle comparisons a little more broadly.
