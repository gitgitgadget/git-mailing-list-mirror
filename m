Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B301A76AE
	for <git@vger.kernel.org>; Sat,  3 May 2025 09:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746263689; cv=none; b=SMZwwjHLCjYV6dtubjCnl+RthRSSgfuHoM5ZGKhjM9KKedT6JE2Uo+JQQz/i8s15QehqbqnZRdCR+VPaRuxhjyWz+GC6WllijY3PusB0axNmurfNA3IsV6TkgyIYQxTzhc5lALod5zM0Ixp0Jw5PyHZvdG1V5MDybPim/iayMPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746263689; c=relaxed/simple;
	bh=/T45IhOLVrkDwtfZA7/iEM3wNcGtWau6ytlqhCqHMJM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=utS0CQnZ1LnfNh91cuSjyEgYshmV8yFgIYgWdUCx8PjVK6+oo2uTpAupX0G55gPaTMTd6LAsOpw+mySgrnvhCkNyD7tA97klFuyRBd9ZjsQbmYw11Ooa0MdjfsXRWhmIN5gaeA1UCXhU2jQO3APQ/G+BybrFJ1xudIvrPDKWpiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WLrYFvpB; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLrYFvpB"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-708a853c362so25456167b3.2
        for <git@vger.kernel.org>; Sat, 03 May 2025 02:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746263685; x=1746868485; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LvkKsF5niF7VcftXS23tOsjx9QCWlz2+plPxhQDrDHA=;
        b=WLrYFvpBE9D6rpONhk3A6i0PQnFs48WpFmz7yBSSG43y8Fjf2zZHBBIViojukybcby
         J4Z3Ojgw8vAauQY0wl52mEfJPlmy6XmIajAwvQeb+UltjTXGfbq/+PW5ZpAcBw+IEa4y
         GE5FZGGDX/06FA+dEH/MtCGQrbz4hCnDimdfS6joVXVq9AUc0J7LzP560Gm1d0uDiLYx
         Yrlx5ZmwK6P/axukn57JzymE7EnYfMHBAo69GaDpE/BD9QKLgX1rpqiCi0lFkwWxmtU9
         a0B0Tt9AOXg3P5fvcJ1ZNISEVQHeMl1B3+s7AU40yf5Ie4Og+RRXnVLbAqQYNIoKZdTw
         UJ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746263685; x=1746868485;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LvkKsF5niF7VcftXS23tOsjx9QCWlz2+plPxhQDrDHA=;
        b=i11xpMfZooWc2cnL9aeS61CbPc5NaLi261d0JA8vgwTrOyJqmrOd5pso+wSqRNwSoQ
         TwNpI8qZgQ7OqDy7+f93nWB8nUA1e+6Y4K8tJhCEhViImKg8524exJw+r5NfCB6AJNNf
         XWr9psKh+/6H5a+OxCTZnOAiZwZk5AWFl3y58XaPmZ6myctZPeBp8164CIWkUPiv28HQ
         QHbOOqFXLlWyHV3YG2UH794R0CMmYwgEo6lWcdVfVbjV25etoVBECHNXOD+y05+6g53S
         qIAoySFfv7vCMjMPBEFovZYNLfm5/LVvjHTHXWQnGFiJ/vTeImHQgOU1uFSnbV8eP8LQ
         i6Pg==
X-Gm-Message-State: AOJu0YyvXZEFsC9Swvnm4YRoNiaYKlYZ+NZ678Zfy4iXsTfCVG1s4JH7
	soe/IcI29Fk2hW2eLqzmSnQB6ZeRhbrOB35VV6RXFhWJAvKHZ82/mecwBds6MycaC8zeZlTypp1
	NgFmcJWveTWz/aOLd/nRaf6XRes+nanev
X-Gm-Gg: ASbGncu7QWqVF1/89Ex4ziD2i2XJ4XdSC2TePMpEdiDlNiu4mDOHo/8k66x83G1eVCJ
	bndo5VlocSl1aImh77I2OCLKksdjcPXajlAT2WeQGUopd9eZegrm8cpqnX7xsRDnPVwXIXSt9Nb
	BqUyVg+4V3nPYhS1PhgwQ=
X-Google-Smtp-Source: AGHT+IF4PI/17cL+Rs8NYeCCgjQyJudFGVnYmdpYrj9bFRVe79mNnZrvWLSh4D2blWXpcnOsIyg/OeANxjLsw1wYz4g=
X-Received: by 2002:a05:690c:488a:b0:708:43f1:10a with SMTP id
 00721157ae682-708e11b64b8mr27268057b3.10.1746263685335; Sat, 03 May 2025
 02:14:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jordan Macdonald <macdjord@gmail.com>
Date: Sat, 3 May 2025 05:14:34 -0400
X-Gm-Features: ATxdqUHCHkHDwWGZBQCbD7AxDF_49EPQmoZUHdib_YE2uGJK49g5mG8R15rzUfg
Message-ID: <CAAg4dd0b8q6cGnk+bEbomCRkBX2PkG7q15YK+DkngMJaq84pYg@mail.gmail.com>
Subject: Feature Request: Support character escapes in .gitignore
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Summary: .gitignore rules should support using character escapes to
match for non-printable and non-ASCII characters in paths, e.g. '\r'
for carriage-return.

Background: After a recent incident in my project where a bunch of
.DS_store files got accidentally committed to our repo, I decided to
update our .gitignore file to exclude a bunch of common metadata files
and other cruft.

One of the files my research turned up as something we would want to
exclude was MacOS's Icon file (
https://superuser.com/questions/298785/icon-file-on-os-x-desktop ).
However, there was a complication: the full name of these files is
"Icon\r", i.e. the last character of the file name is a ASCII
carriage-return. I look into how to write a .gitignore rule that would
match this, and was distressed to discover the only way to do so would
be to have a literal ASCII carriage-return in the .gitignore file.

Now, including a literal carriage-return in the file was undesirable
for a number of reasons:
- There are a number of tools in our dev environments (various
different editors, linters, even Git itself with the 'core.whitespace'
and 'core.autocrlf' options) which might incorrectly warn about the
carriage-return as a line-break of the incorrect type, or worse try to
'fix' it automatically
- Most editors would either display it as nothing at all or as a
line-break, either of which would be misleading and make it easy to
break while editing the file
- It is just a bad idea in general  to have ASCII control characters
is a text file if you aren't using them for their control-character
purpose

The workaround I ended up using was to add a rule, 'Icon?', which
ignored 'Icon' followed by any one character, then another rule,
'!Icon[ -~]`, which un-ignored 'Icon' followed by any printable ASCII
character. (This had the minor side-effect of causing git to also
ignore any file named 'Icon' followed by a control character other
than carriage return, and the more major side-effect of causing git to
ignore any file named 'Icon' followed by a non-ASCII character.)

The proper solution would instead be for .gitignore to have some
mechanism to include non-printable characters in a rule without
requiring those characters to literally be in the file. .gitignore
already supports using backslash as an escape character to disable the
special effects of certain punctuation characters (e.g. *, [, leading
! or #), so the obvious choice is to enable its use for character
escapes as well. (I'd suggest borrowing the list of escapes used by
Python ( https://docs.python.org/3.11/reference/lexical_analysis.html#escape-sequences
).)

One potential issue: ensuring this does not break compatibility by
changing the function of existing .gitignore files. The .gitignore
documentation doesn't define the semantics of a backslash applied to a
non-special character, so I'm not sure what the current behaviour is.
One option to mitigate the issue would be to only enable these escapes
inside [character classes], which would reduce the probability of
triggering it accidentally at the cost of making it a bit more
cumbersome to use intentionally.

-- 
So many books, so little time... - Anon.

You haven't lived
'Till you've heard the floor ring
To the whoop and the call
Of 'Balance and swing!'
