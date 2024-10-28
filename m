Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848CE1DED4F
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 16:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730131907; cv=none; b=PntGhGDw9jCIeLqIZTlxYpFW8WCRfa/NpzcryIgIPB0NMmbbbPfDuvIBEUM3vDCb7jP9yhbn4lvG2SaDmSHbhcXxQOuh2brCNaJTjRKIPmmGM9mT39nSl2H8Ymlxt7qnqjTiC2+N7BqvFnmLbDSORg53k6avNvHhhfEbklfoCr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730131907; c=relaxed/simple;
	bh=/TyrWD912+UhU+Mu83mBGGVltwOG+rMGsvqH0Hs6Yx0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=VfxW1cq334LLYzDwRK0J96L9ScDEQAx0QcT6NOmXOJHqTZgvpOSrhmWoy8mxrm0YgY3eLEq7z7zyqZxBlMv7IswBtQizNUTvo/0nJRlmcoWRa7D5zOnLNV+bZScb5x0Wli3VvT4rQTL514SvIWTRtvm2XYbovetLrPlLdloqvwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CxOx26uX; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CxOx26uX"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9a0472306cso615974566b.3
        for <git@vger.kernel.org>; Mon, 28 Oct 2024 09:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730131904; x=1730736704; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LANu2EwAIkDHqd975j1WITyJa6ot46CylJ82+mM3riU=;
        b=CxOx26uX/8o6RxlvFb9YeuMRqJu1aiOrGAexPfmQz/6fAYIhFhtixLpCLtn5VGzCgi
         YnOV+Lpr4zi5xZAJ12ezyg2jwAQQUicta5hK31JTM4hJJdMc0AEHhTx6XDqflvoAw5u0
         Y6MS8nFtQH9+iYAs+WXYN2gI0xOyyTOM8WdkfZ82+37ssAe0DL+K3h1qSzMgldz7VWLV
         ZUVuQxzA++bqkKN+5hwLTzc+EWOYFj9lHSeVtv0HmOhQ+g5oIf2/3SvMmG0tHBGSOnLA
         QAxJjmkgh/jmw8JSiLR4Zb09Hd/S7NVo6Y9t9FK8dKZ1SFV1kWwEkH9uYNUV2v7AD2o+
         3q5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730131904; x=1730736704;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LANu2EwAIkDHqd975j1WITyJa6ot46CylJ82+mM3riU=;
        b=lHFJ0czBCm5pSyozRyZc0P9jiy/IhH0Ej55mMtcxcaK5trGh6Vt/Rx+QZ+OlWa15jq
         rJ+iO89psYjWauJS0MXAG1WUec668Vmov58dgolRMUbewrFVqTcYLrv+w5bK/Uso1JF1
         PMMC6kfs843hUPZ92bnp1EjCz3dMx3EB+r7ajp8UhTUy0l0/9rd+MlwlTZ8nxDIdDtkf
         LYqU0qp3LVKoG07YQLx+o7NM/qyFdelqWeDpRBY4jrxkBq+MtNCRFA+T+DxwWEI4bv/a
         zUwlOMahoSdtw9v2zckh0gCe7JnusgE6Y0xlsM3bunA47J80jXS653bXemvEYOUJHI5T
         vM5A==
X-Gm-Message-State: AOJu0YwYSVq96Yu+7ghCY/QnYje+6uLIl4cy/jUkCExz9pDsjFibGh9g
	KkENiv62EasEJoHDKBVxhlTfsXdI2o+zu9fO6/FllgHBgcMeeefMm6zWJmGTeRN27GAcNDpuyF7
	4pUyxzM4G0Ks+IKE5TJOtImF9Fcc7/szPG45tew==
X-Google-Smtp-Source: AGHT+IEEGqtB+ibdA8oWFGBsDP0os2vkCk0YZdTZSu2wgXClGMWaawADJ+YdEO67bA6u5+xW9uDxnb9IDMRoSF+1cUg=
X-Received: by 2002:a17:907:720e:b0:a9a:3cec:888c with SMTP id
 a640c23a62f3a-a9de6334642mr763882566b.64.1730131903209; Mon, 28 Oct 2024
 09:11:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Chizoba ODINAKA <chizobajames21@gmail.com>
Date: Mon, 28 Oct 2024 17:11:31 +0100
Message-ID: <CACwP9aokd-5gNEtgvHEOuFjHRCzvUEsFG4VNinP1p=GkEk0U8A@mail.gmail.com>
Subject: [Outreachy][v2] My Final Application
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, phillip.wood@dunelm.org.uk
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

I will continue to study the source code especially as it relates to the
task at hand, referring to previous works done by the two GSoC interns,
who have previously worked on this task.

## Timeline

Phase 1  (December 9 - December 30)
Community bonding. Talk with mentors. Read Documentation.
Investigate the next batch of unit tests to convert.

Phase 2  (December 31 - January 27)
Figure out whether these require functionality are not yet present
in either clar or Git's wrappers thereof.
Upstream potentially missing features.

Phase 3 (January 28 - March 7)
Migrate tests. Send patches for review and refine them
based on feedback.
Iterate Phase 3

## Availability

I will be available to make a time commit of 30 hours weekly for the
whole span of the internship, 13 weeks.

## Giving back to the community

I already love it here, and I will always come back to make contribution
here, and If given the opportunity, post-Outreachy I would stay back in
the community helping in grooming the next set of interns in the same
open spirit with which I have been groomed.

## Conclusion

In conclusion, I want to say a big thank you to everyone that made a
comment on my patch, your comment(s) had helped me to progress
this far in this journey. Thank you. And to every member of Git
community, thank you for sticking around and putting in the efforts,
offering this great opportunity to any, with no strings attached, who
might wish to build. Thank you.

## References

[1] https://lore.kernel.org/git/cover.1722415748.git.ps@pks.im/
[2] https://lore.kernel.org/git/20241022012701.8959-1-chizobajames21@gmail.com/
