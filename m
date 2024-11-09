Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A1415D1
	for <git@vger.kernel.org>; Sat,  9 Nov 2024 06:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731132115; cv=none; b=Kkz2Y1rxmao5ecGHS2/XqrwUYVeGeT32Q8CshJAvREa8soQDOEM+ccs6Rk92w409xa5uOXvJJ+yaU/OSbY2HPWMn7QSGLgdbzKjtPmUH9cd7HQztSabJNdNJL7b78o13UOJM5G8rFyPTlvrPoDrqkcoDu9VhGEX51qJfXStIpW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731132115; c=relaxed/simple;
	bh=gaSc1Log9/Puolex15B/dete7ft9zBsQDC9jtxHgPz0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=mCfmmCw98ViYVCu14+n4iquA6Xk2JhiIh8+XPBdCQslHrre6cYnD/a2fOQemPhVwAXr4PorRUMjxFgmPzJwOyT6a2Qwqisxs7Cfh3BGEh2goGX3wKp9WV/QFvIoEc5k9sHOUWKqdd6PcJsJOpkIkE8ctsuGy2vSSFQyEkgwmyWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a4ByXeo6; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4ByXeo6"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-84fc7b58d4dso1003917241.0
        for <git@vger.kernel.org>; Fri, 08 Nov 2024 22:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731132112; x=1731736912; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gaSc1Log9/Puolex15B/dete7ft9zBsQDC9jtxHgPz0=;
        b=a4ByXeo6Pgw6PPcJjuvcDUHgQ+BZaV4Cs6G9/JfPifUgRsWOcZIVN1V6K03+bJ7QSz
         2Ktm6eqCvSNkE4ZWg0IWPtr0oqn96XFAG6ts+aZ+CTdlXnXi0SnExC1+vneyv13CcoR8
         ZdWHy0eqT1AN5O2DKKLSsESfa0WnWDtqMDlJmTwRRZAVxnNkrfZJIzocKjxNyKhapHvo
         1hx776kzvfa4zQy4CAEiyFPVsZ5xPojppWhKMURveeUhqpZWdjBwd/Y6W3PX41HvqDQL
         XUeKg/UXqpoeNCjA/iViO/5MGicmZwO8OZyBcO4/lJlqMWVxMguUx+ZY8YZ5NTKOEMUu
         DhbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731132112; x=1731736912;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gaSc1Log9/Puolex15B/dete7ft9zBsQDC9jtxHgPz0=;
        b=PWNfIW5XWgOM3ALZAZYp5gw0JZ4EHZYSPSnhIILvEF0fPpGcmyU8qHtZSQzu9aJN9w
         itq0xg6M3D16FMLLaG76WysWIpA1G7mClEVqTWxtdB8oqcQvaHAamRLiGW7NlRxhqjlK
         /aCpbrVMZS+gakE0D5mxbJkHJwzSHbgsBpRybM7RijRptIo8QZIjflil6Rl2A+qSuaOv
         NlNtHSiIlUrnMVY6NTAjKtILCYIEfX3qnxvYSIgYcm4JmDtyIWrTkgyRppHpoEhhhjXf
         3q+kzK8zGIKXNP36z3CIk51KOiqaqc6yIF040q1BsmimpsYVG3OybkPR10z+S2Mq9yWC
         uyFA==
X-Gm-Message-State: AOJu0YzghMBvnR52sH2o5MaDjkDcZUxg6lJhsAQHEBD/iMaN6WBW7kCE
	HJQTZ3r/cVX5Xscr7xjEFRmu1/gfVp6Y4Pvv0Zi2twLn93fPMvMNnYPJoq88kTPZXdWINzz2VJO
	PnSPzlL6JDC5MzKavLGdNcRirB9PgZ1bE
X-Google-Smtp-Source: AGHT+IFa2Bl9dWG4o1D/P/cH+C8lKgg102N3egwkgfewB+W87+pFP0w3cgk/ggDrCOFm9YAZB7lu1X+rsKegBH0mOTk=
X-Received: by 2002:a05:6102:e10:b0:4a4:8a29:a8ff with SMTP id
 ada2fe7eead31-4aae1637856mr6594038137.17.1731132112261; Fri, 08 Nov 2024
 22:01:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Sat, 9 Nov 2024 01:01:41 -0500
Message-ID: <CAPSxiM9GZLKNbyCmgpz6b7Z-MLe8TfMaatR8FPNwvsHA411dtA@mail.gmail.com>
Subject: [RFC]: Test Were failing on Fedora Linux.
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I was trying to build the Git project on Fedora Linux. I just
installed the Fedora.

I followed through the steps in the Submitting a Patch. About 42 tests
were failing.

I noticed that there are some directories created that did not get deleted.

*'trash directory.t0000-basic'
'trash directory.t0001-init'
'trash directory.t0003-attributes'
'trash directory.t0004-unwritable'
'trash directory.t0008-ignores'
'trash directory.t0012-help'
'trash directory.t0017-env-helper'
'trash directory.t0018-advice'
'trash directory.t0020-crlf'
'trash directory.t0021-conversion'
'trash directory.t0027-auto-crlf'
'trash directory.t0040-parse-options'
'trash directory.t0041-usage'
'trash directory.t0061-run-command'
'trash directory.t0070-fundamental'
'trash directory.t0090-cache-tree'
'trash directory.t0202-gettext-perl'
'trash directory.t0203-gettext-setlocale-sanity'
'trash directory.t0210-trace2-normal'
'trash directory.t0300-credentials'
'trash directory.t0301-credential-cache'
'trash directory.t0302-credential-store'
'trash directory.t0303-credential-external*

Any idea of what I am missing ?

Thank you.
Usman.
