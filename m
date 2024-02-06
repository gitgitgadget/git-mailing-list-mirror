Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B04C1CD07
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 10:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707215998; cv=none; b=J9DsjjYSiLWYaMf9LFe5w4xbR5yWK02f7ZxBe0fmA4U+h18yxvl5/NrBifceCAPp8vfb4luuMBo62sdhBe3mf3xLCAAuepCKcGaFjpfsoUX9QSEPrIwZ/g0ZNl92hfnrlspwjZLAoU35+9+9xe55QMV7KBgnfo/8mNWK5zliX/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707215998; c=relaxed/simple;
	bh=q9AGWY8lJcl57rA4mgXYKOVUhjwgLkkaMljeJWzQllM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=L58oby7x9nz24QYeNJZCIIJHg72MIUmK0ezg+7Gb9kLbMAbfn1PccWaeiFM6iMGpF1K9Y8uLdR6eVQVDBYEIepKRcxuFPmnTcm/oHl2dwnIyYCA5m8ulXFd837AQmYo2tgjdPD05kIavJRk/6xhHsJG1WUrVgf+fi3vGWOkCFjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZGSeNdFI; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZGSeNdFI"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a3510d79ae9so639669566b.0
        for <git@vger.kernel.org>; Tue, 06 Feb 2024 02:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707215994; x=1707820794; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SEVgCQH5JVAXDd2YowmNy4cAfCYJttfDJNL6EMGM7LM=;
        b=ZGSeNdFI7dvusqLkpch2WO64MNyy7r4Ol8Smkx8xxRQ/WWqcXZyFjJ7FxmtY0FbV8E
         Vq/arfnnWiJIFBpTdEcFV1MZ3NAHPyA3EMUTNMWCKACv6SRCY25RPRFAoP5PLj3rRXsC
         +sN5p1qD7j/ko0iFq6mjAdlCyZkbVffi4/cmrNblnAhSqSSt5r0b2QAVjOCmE789/Dra
         ukHH0CIHukzGShpqL55Bai4zG8kkeFDq/lhv4jkNgjlh08Wnkf5TnA1kjwu7UjxD3jOl
         RImy25azQEldtrzshB0uz6DGmXgLI8kD2yuIkU+xpH7kdPYBQDxifOw901gvaW5EFNG7
         gg8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707215994; x=1707820794;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SEVgCQH5JVAXDd2YowmNy4cAfCYJttfDJNL6EMGM7LM=;
        b=Rtgv3XKyJvjO5AnB6DTzZUMXPpl7NRSQlRgLwE/kkuUeuE4vfqkiKzpHYcGdaBojV5
         sKkcH4b23FQqjakUz0ZXR1IcEZBkRLT1HXjxYZSeLTuok/ioj/0JS8knpKUr0PtuGM5g
         KpaH+7vF1CAsWvPaAzOAHYb0xoRMydRonC9jUpFunyQpu3i8u57Lgc2ZYZ9+4q1elemQ
         n+VnF6/xeSzuc9/6w5JRzA49vrSI6ctsBei/yVGmXeKpeTrrLkDNCqX1Fx4dH/GAp7CM
         KsVv2Sv8ippDIbUcQL357JWJM250RTxgeV918rRe9pDf37fqlNtuqbgQzvD2Rv5LCCCz
         Uu1Q==
X-Gm-Message-State: AOJu0YwdoAbrzvVPXi1IuAImsXuysBqztaj1AqtVlBta79B6sGZDsQ0t
	iLPMGyw4ypZkdhQiuZ6KbXBrRqZ8KFEcF4f8uLpk+XoZITXzKZWVRXP+aYUlIGeDzCE9Iwwwr5h
	iZJ1NOSHU5mVT9TkM2rKVLr0HI0CB9xL1Dio=
X-Google-Smtp-Source: AGHT+IH0N+TzuQAzUPDe/6Ydm5cYVrXewjhvd1cVYozx7T6g6fa62KulcimMR3fk22S8BfIusO3spY0CK3UgmeksqcA=
X-Received: by 2002:a17:907:60ce:b0:a30:db53:5bb5 with SMTP id
 hv14-20020a17090760ce00b00a30db535bb5mr1415014ejc.58.1707215994454; Tue, 06
 Feb 2024 02:39:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Britton Kerin <britton.kerin@gmail.com>
Date: Tue, 6 Feb 2024 01:39:43 -0900
Message-ID: <CAC4O8c_xuXxryq1Wf02Epk4KH1TNzqWghvTDZMfsOKiKfRv7nQ@mail.gmail.com>
Subject: gitk view could use a checkbox for stash
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

If the Branches & tags field of gitk view is populated then stash ends
up filtered out.

If stash is added to the list it shows, but then an error ends up
happening if there is no stash.

These behaviors are literally correct so certainly shouldn't be
changed, but they're potentially confusing and unlikely to be what the
user actually wants.

Perhaps adding a Stash checkbox to the list of checkboxes would be
worthwhile?  It would actually mean 'Stash (if present)' but I think
it would be clear enough.  IMO it would then be good to have it
checked by default in new views.

A similar consideration applies when there's an ongoing interactive
rebase: it's unfortunate that the commits and staged and unstaged
changes on the in-progress rebase end up filtered out.  They can be
explicitly added back in by adding 'git rev-list --ignore-missing
REBASE_HEAD..HEAD' to the 'Command to generate more commits to
include:' field, but it might be nice if there was a more obvious way
to achieve this.  It's less obvious here what it might be though.

The general thing here is that it would be nice if branch views had an
obvious way to show the stuff that users probably want to see when
working on branches.  I'm definitely not in favor of outright cheating
and making filter options not really do what they say (keeping
interface and interface close is more important than usability in
context of git IMO) but if there was some box to check to "show all
that stuff" and it was reasonably clear what the stuff was I'd be
happy to click it :)

Britton
