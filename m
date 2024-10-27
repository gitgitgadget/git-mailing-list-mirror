Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB84286A1
	for <git@vger.kernel.org>; Sun, 27 Oct 2024 22:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730069336; cv=none; b=bY40aVty7KlYkZ8rNvGwOfI6LBu8HBp/jzY6yar7uxjt8dQD/GuRFub78dSLArgEllWmEuYveIu5Iet9qN/3uO5kgXnuSbXL1RJKyT21oPE7VdBcB5GKiQ4otn3BlBOTyGxbB2Y4cGS7C2erLKE3xi9fXBvsuflBm4GlG2ZGBGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730069336; c=relaxed/simple;
	bh=bEQUD/wVYnjVSTnBtjywxHBYN7a+ClMU7/GnHTiNRYA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=fWnjEZoZ5xGBM56nlCYdTIkl+TOT1osSslN26eBJRf1FnpBXbz12N9U9Ig5RA8LshTi/yd4vTENcWv0yeF/EHVeQL78okIgMEGEP1ab16UQxGo31wd4Twbo5sP3QYhMmH1kEZ9+tTdUPvzFhL+ENeZBK9WUg1ceSOEsiSRvTDgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nR1qEJXV; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nR1qEJXV"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9acafdb745so674585366b.0
        for <git@vger.kernel.org>; Sun, 27 Oct 2024 15:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730069332; x=1730674132; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gxvGIj3FnO66QGoQkk+PQhr8QpvpBKQRUCWobud88Dw=;
        b=nR1qEJXVyGB6EmsRw4/XhCjlV6cMua6yIwCklACOE9SObY6R9YYSL5CjjsFj+839nr
         DzbUCGdof7c7Qg8Qp2tQcBcVAnbf9jppntoBMVwGdv40lvD/dSIVIuaGD/ppLJOBPxM5
         racfG/YqimqTFvtLtUcEFKQgk9WvVG5YGKW2rfp8dE16aUdLPjbd4akDxrElVoofTsI7
         ynTwlnn6OQi0t6Wu8e52kl9bbha5MMq/UZN9tc7s08HA8xE8w49kVbe81Xt0Hd56UDva
         jMhokVOWIfGRz5K7zxkTWFL8+deS0e7fK5mQtgyFXZcxV/TWzKkA8d7WlqPIL86I5m76
         /IRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730069332; x=1730674132;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gxvGIj3FnO66QGoQkk+PQhr8QpvpBKQRUCWobud88Dw=;
        b=oRX8+H1ljKipLejcSGlCmxNOCmD9YgNMekahiI2TAhT7CtDGoKK3BmwdQYpYLYbx6q
         7oj5WlBu9MSo0Gd2RUvFkl7tFM748Oz8SqXhzyZ25iEauNvKEvMi97KCY4Omyxy7pmnN
         d0ouayr2g7u2PhucKCDzo/qRMEnWhR4XuOjniI5CEaLBpJZ9jQKoxOyHEaQMEPEnYmNO
         w6I2wv19XCFz1lav8T89KmWJkiw015OcE1YXNIJtrVk30luHG0fRqElpmiH/1mdaMGIj
         d1ql7dmzxyB+O4H6c5adtdu2JW7KfXxqvFY5CGFwomMFd25PGrqTWB9QNr+Dq0l9c6gg
         3x/A==
X-Gm-Message-State: AOJu0YxhmZp3s+0ZlcdK/ZrtNt/5GDSUWzvcDNLNq87xr36W7kDu2nMM
	N4UD05tbNft/K7b52KdVC/qpgSsln+/44UdJULSDbrT5w5vb7SyDWGUZXRClwSY9MZPpN2+hm1w
	B9FmmB0dvj4YfWu5xESTMhZV0ebSINBM1OC0=
X-Google-Smtp-Source: AGHT+IGZqcQ+qlpKwynYvi9k4T6QgkGaYy8AAdnufTZamZnc9lBo/AzUw/AWpUZtthDdkt3OPM21bz8Vz+ei+AieM/c=
X-Received: by 2002:a17:907:94cd:b0:a99:5587:2a1f with SMTP id
 a640c23a62f3a-a9ad19c145emr1301553666b.15.1730069331394; Sun, 27 Oct 2024
 15:48:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Chizoba ODINAKA <chizobajames21@gmail.com>
Date: Sun, 27 Oct 2024 23:48:39 +0100
Message-ID: <CACwP9aqFY6kPOSzv2JWWZejwAiYbMEJJx2qxomEnyxnxKFvkvA@mail.gmail.com>
Subject: [Outreachy] My Final Application
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"

Hi,
This is my proposal for an internship position to participate in the Git
project, "Convert Unit Tests To Use Clar Testing Framework" as listed
in the Outreachy mentoring program.
---

# Convert unit tests to use Clar testing framework

## Personal information

Name: Chizoba James ODINAKA
Email: chizobajames21@gmail.com
Github: https://github.com/ZIHCO

## About Me

I was a teacher, with an interest in the tech industry, this interest
drove me to building a career in the tech space. I had enrolled in a
tech school to get the needed training. And recently, I completed a
software engineering course that required a 70 hours weekly input.
Upon the course completion, I stumbled on the Outreachy program,
and I am amazed by how they have been giving the under-represented
the opportunity to make their first contribution in the tech space.

Prior to my Outreachy application, I had made no contribution to any
FOSS project, but I have used a ton of these softwares (Git was the
version control I was taught software development with) and I love
the spirit behind their development, "The open source spirit: To let a
billion lemons go unsqueezed. To capture vanishingly less than you
create. To marvel at a vast commons of software, offered with no
strings attached, to any who might wish to build." I wish to contribute,
and I hope the Git community gives me an opportunity to.

## Overview and background

Referencing [1], there was a need to extend Git's home-grown unit
testing framework to avoid code duplication. Clar was proposed as an
alternative to enhancing Git owned test framework with macro, since
it would be nicer to not bother with having to enhance and maintain
the Git test framework.
Clar is  "easy to test and make clear the quality of your code".

### Potential goals

- consolidate the homegrown unit test framework by migrating to clar
framework
- implement additional assert functions for Git-specific types
- work with clar upstream to improve shortcomings discovered during
the integration of Git with Clar

## MicroProject

[2]  t6050: avoid pipes with upstream Git commands
Status: will merged into master
Description:
In pipes, the exit code of a chain of commands is determined by
the final command. In order not to miss the exit code of a failed
Git command, avoid pipes instead write output of Git commands
into a file.
For better debugging experience, instances of "grep" were changed
to "test_grep". "test_grep" provides more context in case of  a
failed "grep".

## Learning the source code

I will continue to study the source code especially as relates to the
task at hand, referring to previous works done by the two GSoC interns,
who have previous worked on this task.

## Timeline

Phase 1  (December 9 - December 30)
Community bonding. Talk with mentors. Read Documentation.
Write backlog.

Phase 2  (December 31 - January 27)
Begin migrating unittests to use Clar framework. Send patches
implementing the migration, get reviews, make changes based on
mentors and community recommendations.

Phase 3 (January 28 - February 25)
Look at implement additional assert functions for Git-specific types

Final phase (February 26 - March 7)
Working with clar upstream to improve shortcomings discovered during
the integration of Git with Clar.

## Availability

I will be available to make a time commit of 30 hours weekly for the
whole span of the internship, 13 weeks.

## Giving back to the community

I already love it here, and I will always come back to make contribution
here, and If given the opportunity, post-Outreachy I would stay back in
the community helping in grooming the next set of interns in the same
open spirit with which I have been groomed.

## Conclusion

In conclusion. I want to say a big thank you to everyone that made a
comment on my patch, your comment(s) had helped me to progress
this far in this journey. Thank you. And to every member of Git
community, thank you for sticking around and putting in the efforts,
offering this great opportunity to any, with no strings attached, who
might wish to build. Thank you.

## References

[1] https://lore.kernel.org/git/cover.1722415748.git.ps@pks.im/
[2] https://lore.kernel.org/git/20241022012701.8959-1-chizobajames21@gmail.com/
