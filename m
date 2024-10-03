Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6ED1A76AE
	for <git@vger.kernel.org>; Thu,  3 Oct 2024 17:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727977523; cv=none; b=EWabJK1HfFiUp9TyjBbxIQNpjYBbuENra4EK41RvSZMu+5n4wtBpxJhAFHvfgvIzJhAOFLgsVao2OI70Jxw+sNjY28YIIAy/P0z1wLoY4oO/v6rrjdUJFsrOPpPxhZFwphnR7Ydi4zHb+26OFW4GuiDRkRuBYaokF1aJm2rVFb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727977523; c=relaxed/simple;
	bh=bVhhAOBOERAHk479talEmzgXkF0O16YYtPrMckGcSTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mcYj0GlgwlHjyuunqlf3W1AUfKLhDWlIGqlorrnewLnkOpF9l1uEr7iK3US9EnxE5jdN038SO69eaSrogtaSlu+ln80XcJouYwIuPtV48lzUFbMeY1Uw+cnbJ1USXjocm8yD5N1kL8SC1c20xagOqoAndGWUWwRqWVOSpfFOveI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ndmc8prZ; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndmc8prZ"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fadb636abaso14197371fa.3
        for <git@vger.kernel.org>; Thu, 03 Oct 2024 10:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727977520; x=1728582320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IIsnSUicCmWgiVSARLmKXI/5WQc39oWthJ2c8pgu1eQ=;
        b=ndmc8prZ7YN4iv6JVES/I2wN7KhnYsYhI+JQlxSKT0lOZBmxIz3Xhxw79+RttIc8CO
         e+ysigDjr27G3nUDoQstCDNc2eMae8U6gP6YE0qvs2FSIH10Weo1KI3keQEpOP5pywsO
         rYCCJB3kLNmxIfbDOfpPx9k/aBuo1+Mi5W5Whfuy6JEVJfyKaZWmqmEaNTPZP9e1K23Y
         dikw1OpKSeLIfJRHdEv2VrHh2wn72kHsTrOMqgIo4e/ctUDmlbmQxLki6qgbZF10klZT
         KGZyi21cbf0YJzSi6mHK5EBE7He2UvcW/OGbHTf5Ct431U+MZgutTgitMeGTf1N32sue
         s2kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727977520; x=1728582320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IIsnSUicCmWgiVSARLmKXI/5WQc39oWthJ2c8pgu1eQ=;
        b=xA1q/qFSBJdIKqy1mw46VrjJ8rxwoudjG2JagVVvey+O1SsGAXrwqwzEvDxi/nvysW
         QolPzVE1IP0wTZn6MrkYXx9+gl8Tud5qYyfsq+yriSMGVtH07Hgryn04yQx/9x1nhyiY
         qd3oceN7J1BVnss49hyOkqjUTe+mS8RyMv5EuePj4S+hwC2VY2b6cSS9j3NCxIW0JdNa
         4dx94w+m5UWLPTH5p4DLUnjWfGrhFcurdoki02v8mI/MMXv3n5o0suOgqSrhZJRwHIGF
         81nShezbVXiveO0Q731IOpk9oAkwOec9QLjfFkd0nwdesgRlrDk7HM38AvRZJ66Lnsth
         pd+w==
X-Forwarded-Encrypted: i=1; AJvYcCVWK0BeHXqzc16c8OrTs+5t7nSYaT3b3ek8bAbAr3VhOSXhnzYnNQjaeeSFsdiXOtHitgE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8UaxDUIfyyjCb3lz4rsyyqkAmV6XZRudKLAGvZlX2PULgW9qj
	ni3b1xyHdiLX0RwRy2vneBTQJgjyC6E6GsHr01XF4zLDAM/t5d66DqWFSolG80oEz9nQeDwrWid
	dR1zWXbxumHfM+Mk4/h5gXcS53OqqGezIPIo=
X-Google-Smtp-Source: AGHT+IFvmlcj2NRFs3V+rushABdM/PnClYs2TvT1AiEDxvNoMwAmduRRypjCgfHLh68G1HfHXs4sxj3XDejVzCAfrQc=
X-Received: by 2002:a2e:b8cb:0:b0:2fa:ca00:80d2 with SMTP id
 38308e7fff4ca-2fae0ffccc3mr54843701fa.2.1727977519818; Thu, 03 Oct 2024
 10:45:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANp3UNBGd=jiSZyFSAdPjayvgHbP5SF4Dm-uCNwna_H16bRgRA@mail.gmail.com>
 <CANp3UNCXqLJmAj2Vc7jB+i9qRjfKzrri_Mr9VvG4J5tUR-1HeQ@mail.gmail.com>
 <Zv5SpewqUmlvhOl-@tapette.crustytoothpaste.net> <xmqq34ldjiup.fsf@gitster.g>
In-Reply-To: <xmqq34ldjiup.fsf@gitster.g>
From: Sparr <sparr0@gmail.com>
Date: Thu, 3 Oct 2024 13:45:07 -0400
Message-ID: <CANp3UNB_4_mcK4CV3WF7p3AWaLTK6qb13tS3imDBGU5XBOzG0A@mail.gmail.com>
Subject: Re: Lack of system-level excludesFile
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 11:40=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
> If you take the reasoning one step further [*], it may make sense to
> have a list of ignored patterns that applies to everybody on the
> system, regardless of who they are, what editor they use, and what
> project they work on.
>
> Having said all that, wouldn't that be already supported?  What
> prevents you to set core.excludesFile in /etc/gitconfig?

I tried to cover this in my original email. You can set that and it
will apply to all users who haven't set up their own
core.excludesFile. But this has two problems.

1. It will disable the default behavior of a user being able to put
their own ignore rules in $XDG_CONFIG_HOME/git/ignore which I suspect
more than a few current git users rely on.

2. As soon as a user sets core.excludesFile in their account-level
config, to be able to create account-level ignore rules, such as based
on their desktop environment or editor or all the other stuff people
typically want to put in their excludesFile, they will lose the
functionality provided by the system level ignore file.

>  * This may be a larger step though, as the set of projects that a
>    single user works on is much narrower than the set of projects
>    that any users on the same system work on (hence the types of
>    files that are potentially tracked by these projects are much
>    wider for system-wide exclude list to take into consideration).

I agree that these two scopes are very different, and that's why I
want to be able to set them both! ~Every user on a macOS computer
(which might be a few on a family desktop, and was dozens last time I
managed a macOS server) wants to ignore `.DS_Store`, `.AppleDouble`,
and `.LSOverride` in ~every repo they work on.

>    On the other hand, are massively multi-user systems (like the
>    time-shared system studends 30-years ago used at Universities)
>    still a thing?  If not, then having a pattern that may hurt
>    people with other preference on the system-wide list would not be
>    a problem at all---after all, you have the entire system without
>    anybody else.  But at that point, system-wide and per-user would
>    become the same thing ;-)

That's not quite true even on single-user computers. It's pretty
common that one user might run things as their user account or as
root. It's less common but not unheard of for one user to have
multiple accounts (e.g. one for work and one for not work) or for
non-user accounts to perform git operations.
