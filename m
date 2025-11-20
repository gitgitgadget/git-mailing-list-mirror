Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B72C221D92
	for <git@vger.kernel.org>; Thu, 20 Nov 2025 07:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763622155; cv=none; b=R4CURqDWjw8usdylKYwCsXz6Theh/NGa5uucXw3tLwh6Npcpluc34BHItpo6/xEe+k8nCDbpJd3pV8FO2GT5r/N/amovylPsF7Enyd9gJP6EhDnbLXi0BUbmIxmq0/LqnBZIptIkMM74vu5B/mb+y3/ZtprCOTqF8iqVz788iZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763622155; c=relaxed/simple;
	bh=crPgiON7gmCHveXLc2iVz/tbYlm+ThuxY8d7uzH6Kb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IWBufCUoPXSWjH00USiCUJYLxAXybGu9sc/8dqswoEZcpXyeGs8FDN1NXRgKdSiWANgtfCy1Zldp8sVf0jr9QCXBQcBiHMs6j6E3lo/+OvjwkeJEGpckRl6Iakv++ByjC/jvgiUycpeXHLYJQSUZNz67XIKRLsyvO6JI+wgyVDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nsjNwX5r; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nsjNwX5r"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-949031532f9so23714939f.0
        for <git@vger.kernel.org>; Wed, 19 Nov 2025 23:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763622151; x=1764226951; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+CVZDqOOUG5n3eJfHT/VK2BTLiMEZMRhr0Db911rF44=;
        b=nsjNwX5r7eZL1jvvu6Y9lC99754EJIi2aBDgFnSGECiyLTTfL9s3ctwJnNX1GG8Pk3
         f7zcFEkyeGtdklgyYoKjdpdOym0vlq7b5VezQYmAEvu31L23uQJWxryBGgJRa72syrVS
         Ks27UwUIscoBSinlBr3jaaGw2oIj+3Geo8U54UbQRuo53blmrUPFpR+21qSRRCXZqmgW
         dytFia9ityiq3JJ9K4EvxnenVPnnC9ib0/2ItfsOegKJZHNrDzmZr+T5t186aZwydC9z
         TE+V8WzCVoJLU0KaiJNcoiQSSLrUbthsBDKLrbnU5KfJ0VPYyxyGE0cJLmrYEKgl4tUn
         lY5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763622151; x=1764226951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+CVZDqOOUG5n3eJfHT/VK2BTLiMEZMRhr0Db911rF44=;
        b=eJlXPujrwl2qgfDI6qXZ43kJ/CTRGeuocHcUMF0N2eaOHCdbtYVf7TOrfFZjdniSCq
         hFeBR6SpYWnFtCk6tiNaXQxFB63i5/+1qaCwMWStI7j3VzSBfq55UKAGHsXzInjo9u2T
         wlGboTqN/uK78TFsqUsHr/iKSGjHdaUJTUqZrlIDVh2vNCVX/QLEynDYFWf8Ldm/Jjrk
         ANxvpqK2BpRsnnvERc1+Ej9C5UeyvVooJSv0ilL3XYkXXW2m4hgCcecOcrW8nHiecHAT
         MJ48kSErQbMTHvo8WrpFnGRTDyyt4LWcGAKVu1E/jU1b9YqA2NqerpxZBQvsrnw4kYfS
         tEFQ==
X-Gm-Message-State: AOJu0YyqeMCZVQJsyyZoA4YMIEfxvn+BQ7gUG88/GPQK1r2joAZGNvvV
	Ke+jXIhouVNVrawoxfdSik/RJmNCyBgYsSZ0S3pRLY/wkk8ZdjjmG3yI7PMyZUh15yIlqY3lSFU
	roXwO9Y8sszRiJavNhv87eAHn15OpttE=
X-Gm-Gg: ASbGnctY1AekK8UjRK5PSeSMTfvOEFFGj7osCWRXsZafXPzOkomXJWSPr+zQ3GLb85H
	VX/58jrj+YB5dnLW31/OqkQF9L519QyW85TIpdKeS/iUAXACj2CzzqkiMywUrrBIvTPS9744yer
	G8PnD+xfb+h2/cSWdAjMIvd5QEhepzsA5ClV8EnE1EsIP/BZ/4Dhi8I+awjFbRYMgJv+yQqrWgO
	5+hlxNUF8DlNjnG7rjieKbLoIBwtq4gSGMOxFT9caVG/FNFChI06+gWjwR/5boytLLTRrAFrqp5
	m1fbL1jrWxrx5b8ts1U/t4suSYTW
X-Google-Smtp-Source: AGHT+IF5qXK0wkYFNy/OmVMvO2mbOf2yai+5A2W7Pp0nsWZbWFsCmyhSaRhrL2A751+xiedWkvfqGJtGndNmaqRpI3E=
X-Received: by 2002:a05:6638:4d9a:b0:5b7:11f4:232 with SMTP id
 8926c6da1cb9f-5b9568b2623mr979029173.9.1763622151382; Wed, 19 Nov 2025
 23:02:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027-b4-pks-history-builtin-v6-0-407dd3f57ad3@pks.im> <20251027-b4-pks-history-builtin-v6-4-407dd3f57ad3@pks.im>
In-Reply-To: <20251027-b4-pks-history-builtin-v6-4-407dd3f57ad3@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 19 Nov 2025 23:02:20 -0800
X-Gm-Features: AWmQ_blz2hSyqR3wQ3qq9Ie5CauVCjXlcHBSQDuJzM4N5uobhNsR-aUHMc-mZ4w
Message-ID: <CABPp-BGSYKPB7met4U_4ECNgA9vb5y_AWnMWfpiisOHnd_OyhQ@mail.gmail.com>
Subject: Re: [PATCH v6 04/11] builtin: add new "history" command
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
	=?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>, 
	Martin von Zweigbergk <martinvonz@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

In addition to what Phillip commented on...

On Mon, Oct 27, 2025 at 4:34=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
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
> While these operations are all doable, it often feels needlessly kludgey
> to do so by doing an interactive rebase, using the editor to say what
> one wants, and then perform the actions. Furthermore, some operations
> like splitting up a commit into two are way more involved than that and
> require a whole series of commands.
>
> Add a new "history" command to plug this gap. This command will have
> several different subcommands to imperatively rewrite history for common
> use cases like the above. These subcommands will be implemented in
> subsequent commits.

"...*Some of* these subcommands will be implemented...", right?  You
only implement two of them in this series, not all of them, or am I
reading wrong?
