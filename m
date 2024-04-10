Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5EB15920B
	for <git@vger.kernel.org>; Wed, 10 Apr 2024 21:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712783658; cv=none; b=Yf9Dh0POkRWpa2HgySxVRzl+EflZw3IW4WpQWXHq3b26JxFYm8W73oV+uyY2m2TicUzuszT6P1CZ2GD+l9GWzLD804aatILPrvyzkegIuEm5vdUkohKBL/RccuQBBzxi23gF9/MdGIDNki/7rnPyJH3+dHUGr+RCEusQADJrj1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712783658; c=relaxed/simple;
	bh=J4OAoZkgRdIqfAap9XiZRDm8eivYXrwavWZRKJBQATQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=s+n4fUaryCrz/wQB5CnRGwR75sXXDdpbhoNZYHHvIxUwl0NHOJZZIcnQHHcK/T2yXAUdtpfWI1ZOzAX4AiN3uJ6hM+u4gHpA5bazCup2ym41jwaHk+wHKqC3301qlU8X6j6DHSdMhBFRKWPMTskVSKAA1/1LMS6paRc4yL45i48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=KDjhsv3z; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="KDjhsv3z"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-479dbcdba2dso2347979137.3
        for <git@vger.kernel.org>; Wed, 10 Apr 2024 14:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1712783656; x=1713388456; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EQVLznUfuwgeXPH6JshEuM6gZMb4ncAksBSUewMhv/8=;
        b=KDjhsv3zrPvtESCk3sKrOwZJ+TtxPakX7Wj8zsImdOmz2Y35bYybD1PYPrcnMEoICW
         FNvCCD5kVP34mZFGcLnvAXO14FUuxRW9hiGSYBPwet4Rx2Ynl5t9COA8FndavqRI9zqM
         XltzZ3Ue92095tMlxaEjpDmUkUq4BAKCwbJU9fiSI57+uCVY7yi+rsFJ68iI2J4LFvoW
         Tl4ahNUBmn03hV4O1tVqZj4jiodHUdLyK5nv8IKUXfsdIHHtj3mgGXEjM4szDC4bCLqK
         GnTsTWejGslKaupHlsFgjDkDQuv1oBOeHrI92VbBtzPnJ7LZ2tBx4av7bcwVFzrGv2dB
         O0Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712783656; x=1713388456;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EQVLznUfuwgeXPH6JshEuM6gZMb4ncAksBSUewMhv/8=;
        b=JZfobXheuswqDpLFm1tJ2WYkJeS6/6QobmuFBzLv0e1e6izFsbztOrgf+z8qh8FPfx
         arxLC/UD3vZ7s79ln202NVxEPb5a7pNfjgJhWOcX/ZYB9p0R0PY6rS5l3MjCPVqgXzG7
         AcJyu2YPioO39gDlMm2ffhueQdtVvyM6jwF0OXpdV6hPbNbaPdtMhWyswmXYdFcXj1WC
         mBecrEW0kA13y+NCjr5ka0zP9rLIat+ZRjKyReDj+K9M7b9rjE+oeY2L0bT5266/SbHp
         n1YOBALeHc23KbzWm7Id8DbRVMqxlkKzpp4mFG2It7Tv3wIdpkF2r/EdU1DwGxJZcEYA
         HLRw==
X-Gm-Message-State: AOJu0YzS75VESMHTnCEy93fQ4Ct3URsIc9AYhcpPckhlrIevzxCEO2U7
	m87eFn0nFZxxG8tP7V4eG8HWSWIloVY4NvDbfdUNsxfN1dUmwVv1HdzWrlZ6ownhBNq0GFCdUPa
	dMcc=
X-Google-Smtp-Source: AGHT+IHED3gu0/aeDJaXgM6t7fVD8UYPE1L++F2Erwls7y+yC5nG73jfLY+z9i+/nL2/0q/YXuUz7Q==
X-Received: by 2002:a05:6102:32d1:b0:47a:31f9:163b with SMTP id o17-20020a05610232d100b0047a31f9163bmr951597vss.13.1712783655653;
        Wed, 10 Apr 2024 14:14:15 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id ej6-20020ad45a46000000b00696b1050be8sm19303qvb.133.2024.04.10.14.14.14
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 14:14:15 -0700 (PDT)
Date: Wed, 10 Apr 2024 17:14:13 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Subject: [ANNOUNCE] Virtual Contributor's Summit 2024
Message-ID: <ZhcBJSP4MxX0AMFM@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi everybody,

I've been thinking that it would be a good time to gather informally via
another Virtual Contributor's Summit.

I had been waiting to see whether GitHub was going to host a Git Merge
event in person this year, but it looks like the answer to that is
"probably not" (though I am hopeful for next year[^1]).

In lieu of meeting in person, I think it might make sense to meet
sometime in either this upcoming May or June (though we could extend
further depending on folks' availability) in the same style/format as
our last Summit [2], the details were as follows:

  - We'll host the Contributor's Summit on either Zoom or any other
    conferencing platform that works for folks. (I spoke with Emily
    Shaffer off-list and they mentioned that some Google folks were
    interested in Discord for a few reasons, so we could do that, too).

  - The schedule/duration is not fixed, and there are options to vote on
    preferred days, length, and timezones in the form(s) below. Last
    year we did two four-hour days, so we could do that again (or
    anything else that works better).

  - Like last time, in order to participate, you must be either (a) an
    active Git contributor, (b) planning on contributing soon, or (c)
    working on a Git-related project that has interest in Git's
    internals. If you aren't sure whether or not you are welcome, please
    ask!

Participants should fill out the following forms:

  - https://forms.gle/VVrJ7RbHVxurxZH99 (participants)
  - https://forms.gle/iGnfexF4hDuK6MQe9 (topics)
  - https://www.when2meet.com/?24557185-cHKWv (When2meet)

New this year is the When2meet, since this seems like a more efficient
way to collect which dates are open for folks within the next couple of
months.

The participants and topics lists are being recorded in the
spreadsheet below, and this is also the place to record your vote(s)
on topic selection.

  https://bit.ly/git-contributors-summit-2024

Please feel free to send any feedback or suggestions you have for this
year's Contributor's Summit to me on- or off-list. Like last year, my
hope is to have a small, remote-friendly, diverse, and efficient
discussion.

As we get closer to the date, we'll finalize the schedule, make sure
we have volunteers to take notes, etc.

I'm looking forward to seeing everybody (virtually) soon :-).

Thanks,
Taylor

[^1]: Coinciding with the project's 20th anniversary!
[2]: https://lore.kernel.org/git/ZMATKIaU1A1D0wJg@nand.local/
