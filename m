Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BADC1756A
	for <git@vger.kernel.org>; Sat, 20 Jul 2024 07:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721459781; cv=none; b=pxhoCXYTNXWRxyTtIlrwbP8s4+G5IFMSaiXSGuWmevB2t/cF5SBNwFF+ZJQLYpUwlL3qA0+bqKQHnxIxDsC4RKs1k27xS7+iOQYDul75HH/O4Wo/kJVobDI/90atr5hj/OOkj4GZ/WAzUI0AtJO9Ze0SRbDpYE8G/exEVNyk7v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721459781; c=relaxed/simple;
	bh=WZrSE3WBuVJnNY8bqXMLb6MqER+YQNwBQmg3dQYsgy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eNieYpbLlZ8nCMYyyazUtUD9I+ionM5c+VUIP+q0j9Hw3oZPymQFXgc+j6jZA2Eds+UdH8vodtpI/Oko9pTWDmVFsStrqyls+HDZA5OJOdb/1wlxrMjbzDOD/wg3iPoYel8/PNe718Bl8Fp/XVX+3TgsLQhgcoL7JnNT6XV9O+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GipZAAGC; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GipZAAGC"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5a1c496335aso824355a12.1
        for <git@vger.kernel.org>; Sat, 20 Jul 2024 00:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721459778; x=1722064578; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/CNFhGxhgqNLiqFXEnzqbixa5/NXJDPb13KBzy4j4G4=;
        b=GipZAAGCv8rZIJSTr7J4Z3W4YNE/3lxoka/hMOshnV1tMI3UMofWLDBqNWIGSQcpkQ
         OgwkfUjAA/hftWB5TVosfhQIhp7xXYKhEEdO8kZrsPrwT66/sUhiP66sCR2E9oXpZhzr
         dfwKRoc5+ALYEd57h2lmAeVFmMWyg249GWVHhCPl95EvlLCpHS8fuF2bLYV9ZAdGOS3H
         kMi1X0gabWUGJ/7yTvo+88iyTDXHsY5NbNtsfa0rxKrys9mJ5xi7JQW8hwbnL9xSkICt
         fAoPr5fE/YbUC1X8o+ZH4MqMl6794NgWChweUI9DJcr5QbSOoaUvVTPsdGiVpnHDi5uW
         7BGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721459778; x=1722064578;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/CNFhGxhgqNLiqFXEnzqbixa5/NXJDPb13KBzy4j4G4=;
        b=OTEMItJX740i0zGTvssnD+yhQwM1lNnRKB029MCzV607uqY95S397zJusz18wnfKLg
         2sak6qlbfeTPu2rxqtsLd5+whykOgMkhYMAlRpGGzcPpTvgaVWL8feS0ck/L2ve983NC
         v35eIWt8G/cuDoVU7Jrl3dZx4OziTB7Qq0dR4LwU7B9TCZYljKu4VU5NweMQij1tcnhI
         Liz5Y4aocbDrLy9Qn/Xb/e97GPq/PchNirbiYr1yrNawufeiD2ctlK7a6tK2VFEzRQwk
         WB5HiG1idJHvIXTJ6xFR+yttmizeZN4AobEU5ulWOKG/liaBcbg8aJVD+DvgbFPV8bn3
         EwHg==
X-Gm-Message-State: AOJu0YyEHFthKXmSFtiGYUCh6tiVNm+nbaZX+wNuApAMNGyTIRljWC3N
	5cnslQVmUnY7SrdaIfIyiX3I1AhSX0ORlqQsnTshWYyO7X+/l2HttTPCOBuaVFlHx3DxxNv6PGI
	AmEvxK42z9WnevGNA03S0qnqhMuY=
X-Google-Smtp-Source: AGHT+IGPd7R2Rdjf4tUtyb6rB3OeeUI+0OUUMgdG6oyrKyKE/Xsl/fjHOBawbWPKjXJNabempHUA6f4lfisfsgi9zYA=
X-Received: by 2002:a50:8ad0:0:b0:5a2:3df7:bb6a with SMTP id
 4fb4d7f45d1cf-5a47b1de9c9mr516835a12.31.1721459777708; Sat, 20 Jul 2024
 00:16:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZpPEdmUN1Z5tqbK3@ArchLinux> <ZpPFbYOqDVWKz0ic@ArchLinux> <CAOLa=ZRYoYfY-P-dzpYbz0Yq44_TYGyJamf1hufJ0fxGZb3Z0Q@mail.gmail.com>
In-Reply-To: <CAOLa=ZRYoYfY-P-dzpYbz0Yq44_TYGyJamf1hufJ0fxGZb3Z0Q@mail.gmail.com>
From: shejialuo <shejialuo@gmail.com>
Date: Sat, 20 Jul 2024 15:16:20 +0800
Message-ID: <CAH-kW5dAup6aJHbC9HGGg8288+eSMuMub52QXGZkOrHgGRuNOQ@mail.gmail.com>
Subject: Re: [GSoC][PATCH v11 10/10] fsck: add ref content check for files backend
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, 
	Eric Sunshine <sunshine@sunshineco.com>, Justin Tobler <jltobler@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Karthik Nayak <karthik.188@gmail.com> writes:
>
> shejialuo <shejialuo@gmail.com> writes:
> > +     /*
> > +      * If the ref is a symref, we need to check the destination name and
> > +      * connectivity.
> > +      */
> > +     if (referent.len && (type & REF_ISSYMREF)) {
> > +             strbuf_addf(&pointee_path, "%s/%s", gitdir, referent.buf);
> > +             strbuf_rtrim(&referent);
> > +
> > +             ret = files_fsck_symref_target(o, refname.buf, referent.buf,
> > +                                            pointee_path.buf);
> > +             goto clean;
> > +     } else {
> > +             /*
> > +              * Only regular refs could have a trailing garbage. Should
> > +              * be reported as a warning.
> > +              */
>
> What happens if a symbolic reference has trailing garbage ?
>

The "parse_loose_ref_contents" will return the referent. In this function,
it will skip the prefix "ref:" to get the pointee. If there are some trailing
garbage, it will be reported by the "files_fsck_symref_target".

"files_fsck_symref_target" will use "check_refname_format" function
to check the pointee. For example, if the content is "ref: refs/heads/
master garbage". The "refs/heads/master garbage" is a bad name.

However, in my design, the trailing spaces or newline will be ignored,
I thought we may not report this problem. And I use "strbuf_rtrim" here
to ignore spaces and newlines.

And I think there are some differences between symbolic refs and
regular refs when parsing. For regular refs, git will ignore any trailing
garbage, however for symbolic refs, git will only ignore the newlines
and spaces garbage. And git will not parse "refs/heads/master gar",
it's an error here. But for regular refs, for example "edaca... garbage",
git will parse it normally without any warnings.

So question comes here, should we warn the user about the trailing
newlines or spaces. When using "git symbolic-ref refs/heads/maint
refs/heads/main", the "refs/heads/maint" will contain the newline
'\n' here and git also accepts content without newline '\n'. And I
think we should not warn the user about one newline or no newline.

In my opinion, we should do this. It's not hard to do that. We only
warn the user for the following two situations:

1. two or more newlines.
2. one or more spaces.

I will improve code in the next version.

Thanks,
Jialuo
