Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842B621A424
	for <git@vger.kernel.org>; Sat, 26 Jul 2025 21:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753566680; cv=none; b=oFTAXa4WGGQ17vbfiaSEihPQh8hZrkdAvjCMYVg6jW2EVrEy78Gr+SHE5oguPPksrgquKE1XCVQsEQjW0dDEMvJLl4hZRZlyV95v4XFBFzH58YK5akqX1nUeVejjrKk8Ce6UyvUI9yx3suJyO7p0w4Qa+i5LCFXW1KPchs/4tgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753566680; c=relaxed/simple;
	bh=NHDaxn0QdbREMaVltEijFfuLoJIf7UvOAUfLYFEx0Gk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xul5q9moZwLQMUrct2ogrWFElt/6ITRPhy2verqEBPE+Wu2kBY2eazuwJtdKb8TOVr7/FN9ohN/1gCyglT3fPEjtzZyNKOCmz0qKwEqpXOm2IQXrgFDecKu3QKtrnhpH6RdR2wvCipStl/UptS1L5gYd3XX89s+8dIkUuSsbuBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WgPmFq2e; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WgPmFq2e"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4e9c689d538so780720137.0
        for <git@vger.kernel.org>; Sat, 26 Jul 2025 14:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753566677; x=1754171477; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uXC4rHJGvutbxHJzRMxUwFAriS1dLdSVo4M/vDJ56jI=;
        b=WgPmFq2ehRKZZV/+oPON59y8LFIC/gQStC7C7ZDt75E0EDwfj1yVT2UPPlqoIq2u4E
         MJqbe8zQmyOFsuccuTDP5b8zzmhB0hh98dGXSxZqlz0RaaA8eoy+Av36o28+BJg0h51f
         kcjQx/AoUTcrUrWkx048fzxQOsh+mz7lHHHa0B/EHr0INbkoGhvkeaosLbgEe+7deg34
         lk9vEC+pKdhASuP7HEFKpAZH28Y952BxDTwHAXRUQo+PqC9QogHNFLuR1eYCArtmu8t3
         FWUxNFzIIBHYYDLUuh63iytEW7J1an7f7PSTYeTy951zTLb9H6OuKhuN3NItpevdFVOn
         WMMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753566677; x=1754171477;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uXC4rHJGvutbxHJzRMxUwFAriS1dLdSVo4M/vDJ56jI=;
        b=MYYFRhevp+fv6bOygip0hwTMg6trB/i+tbwAR4vk/FEUfeFNjDRxrzKDGcS+i5h7Vw
         8hOs0tnCc9tSWiGTM49g2w3kLlmJzs5za5yyzDyLrbvhxP20ns6SrAsQQqhPsBpAG2Tg
         dIrNi/lXWoQ4PMs2fzAsIgF4wYIYjhiU7v0//hwAN+0MUAi9dpkQHDNqUDjNvf8GUt4b
         g//Pg4s/YCHDp6+XJe77iyQMaXv0A4oh5Olu0NYbt57ZogjYLAKpvI6btFCEkZ9QX6H2
         sGZZoNGiS0M7sbAwglV9SJF/JehioffB6RjJ4snHKP+toi10MWuWCHBt/t00T+3n6DhH
         V56Q==
X-Gm-Message-State: AOJu0YyOb/hvfL7aY3clyW5UYmcZtb4vfp175T0HL9Vx2yWxSzWgl32F
	U92MBsKGt/T9RVXtPbSY7r4Gz0NgWXuIKhWzTiJ4FecyITyMjHAcffWBgM+7qVkL6CTppSAwfYS
	WnJJdwNHQc2d5kZMblH4vnHqWc4KDhf84jBX+Ow8=
X-Gm-Gg: ASbGncsZOj9lx6AUWp82XBwCSLUilRhJyIj3MFCRtlHwfkSS7kKUFF/JAGDDQ8spj+Q
	5EEETU8b8tH9jIjJQzBKyNeB4qoOl9MWZJiv1VqkqGATz0j6YrWytKDFVaKb+nA/NLePTLq8mKR
	I+Pgtzlu+OuG/I8HnxruQKuoaCH+yETPvEguRwUhHpG8dNlvnaVh8e2PGLW+td/oAff3JuepliU
	HQJ7rwMSeFSvpXv7A==
X-Google-Smtp-Source: AGHT+IG1bWhB4l+SmVzYXv9KBZpniwGjU4ds+G5jwWeAGJsJ/ssmojcgREneQSoUds+2fXPm3dwI4TG78KRyR5P8irk=
X-Received: by 2002:a05:6102:358d:b0:4eb:f8aa:9c36 with SMTP id
 ada2fe7eead31-4fa3fa5950dmr2144110137.4.1753566677459; Sat, 26 Jul 2025
 14:51:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqcya63cqx.fsf@gitster.g> <20250721115519.140361-1-usmanakinyemi202@gmail.com>
 <20250721115519.140361-2-usmanakinyemi202@gmail.com> <CALnO6CCFXfPDZKzx1SBufwzkBJchZr0XYigo_8AQ_U=MuJa7xg@mail.gmail.com>
In-Reply-To: <CALnO6CCFXfPDZKzx1SBufwzkBJchZr0XYigo_8AQ_U=MuJa7xg@mail.gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Sun, 27 Jul 2025 03:21:06 +0530
X-Gm-Features: Ac12FXwf1_98EVzTfdJ8Pr66VXOMBiwGZJMmhVT0kYQLp99n6DJXm6fNeRNE2DU
Message-ID: <CAPSxiM_sP7MG5SDLe-_-FULhqmW10M=8Ssu3PMoZD8=rS6CkAA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] t/t1517: automate `git subcmd -h` tests outside a repository
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, chriscool@tuxfamily.org, 
	christian.couder@gmail.com, me@ttaylorr.com, ps@pks.im
Content-Type: text/plain; charset="UTF-8"

> > +for cmd in $(git --list-cmds=main)
> > +do
> > +       cmd=${cmd%.*} # strip .sh, .perl, etc.
> > +       case "$cmd" in
> > +       archimport | cvsexportcommit | cvsimport | cvsserver | daemon | \
> > +       difftool--helper | filter-branch | fsck-objects | get-tar-commit-id | \
> > +       http-backend | http-fetch | http-push | init-db | instaweb.sh | \
> > +       merge-octopus | merge-one-file | merge-resolve | mergetool | \
> > +       mktag | p4 | p4.py | pickaxe | quiltimport | remote-ftp | remote-ftps | \
> > +       remote-http | remote-https | replay | request-pull | send-email | \
> > +       sh-i18n--envsubst | shell | show | stage | submodule | svn | \
> > +       upload-archive--writer | upload-pack | web--browse | whatchanged)
>
> Sorry, one more thing: I spot-checked a few of these, and it seems the
> main issue that causes failures is the exit code; they seem to work
> with "-h" outside a repo. Out of scope for this series, but something
> worth tidying up as #leftoverbits ?
>
You meant the exit code of 129 right ?
