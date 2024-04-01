Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95657481BF
	for <git@vger.kernel.org>; Mon,  1 Apr 2024 17:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711992564; cv=none; b=LX6qYPRa2pz37RRdBWFE63XKXTHSdxD+WkFIqGsKNxUeVHuNJ7H+WYh+TFyZ3JfVxPJ5WgUp4prKtYNtSrsT3EDttNsXGuWBDk01EDjFHhubf/q5VQUSpuFKzYjtaJyZWQV719wS3aKq0uukn/xjm3YT2WVzM2/NSzo1zQ1Vo70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711992564; c=relaxed/simple;
	bh=hXsjoSW+6rK+LQiHeE/BvFkzS3YeK74yXi0rDU3lgBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s5MBc7PgVYMNvBDSe4EslxjMI+vsPwN3SLevK796x5ymXTWVkgI3OQaN0gEDh+6HED8JndxpDUfHi4/xmYFkTfWX7J1ClvyDOk27GJPBp9UehPUX5kjjQ88IHgackjKb1XBMt284R6ggy51b+DkuoqzNlEhM+t0D7fj1eOYo8ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GZFV+Z2a; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZFV+Z2a"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-513e134f73aso5462707e87.2
        for <git@vger.kernel.org>; Mon, 01 Apr 2024 10:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711992561; x=1712597361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwb8ygan+gE8cPXJbVQ4CsiCfrW/we3kmdSuj31VU3Q=;
        b=GZFV+Z2a+lREcz81J+PJ1fisFV79yLSApH94dIIyfzTaHC+UugqbyHSVOH0xfYmer6
         NuCTmuNMX2dofkgYf2SE+pNdqSLG523CFYt1OjfoUa1BVm6V3sylST25susEAH/x2hIq
         hVl9fq1obW0IUcuE/W47sFKZSmKxq+kpovyyhrLURJNMqvWu1VkfAWgawp2p+r23mY/U
         EprxUVedfHKrwUTP7tVlKYVBUqROOg0dqS7xGjzJIYocbbEcSusDnFnR1NZRCnCzZVjI
         /fKCmXtMh+oNaIz0RuR8tjnpkM6EfJSa/ySvs0IpY3qKivku7oPWpOoXmFfB9ZtmFUT5
         mxFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711992561; x=1712597361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cwb8ygan+gE8cPXJbVQ4CsiCfrW/we3kmdSuj31VU3Q=;
        b=r8zXg0dOPORk1CBT5+0AuiusGNpT6wD0e+pN+3yjf4N45orhJBgqxxGG/QL1ygtOA3
         imHNXnTeuVTIoKoAGIXN3pbv/JKE0Yl5RluV0pdS8aUP30FxC+sRdBldTfs+IGwQ4D7A
         umd2/YOqErhfpIR7S9yBPtjHoDYA0EgPxveDwd2gkEXv4HCeAM/Oi2BaX+vekOYEfRg4
         AEKYpzvZ0KdNOU7O+jQ+jeCFX+yS9mbF8z0w1XqjGrt0Y/49a4zSn+RK8EOeDD0nBcCx
         l+aT1sfBI+lY/KL6ihPo1o/YpVa4ZHy7tSgybMGl3EstzAQCioc7FSyDPvRj0CResGW3
         1v+w==
X-Gm-Message-State: AOJu0Yx3PAOr8X28jfAEmw6+fz3JSo68V37PWnzVXN6nI4XK3rfg/6ji
	AyxpzmX7uCjcK4wbI3qMXzY8Q9tZfTaDqKALbNfotiGB2kuOfTRzLISxfZdLhuandBLs+HORQ+v
	z5k2Q4mP/xzvJgfidtQ7pCQ9JYwJS8/CCl2I=
X-Google-Smtp-Source: AGHT+IGfX+iK8lSefHpj9LBbGjCcikccRh4VbmHlt2G8k5ftDqNrEz89Xm8jU9j7JRbLBSya20bH8VrMx9JVznvE/60=
X-Received: by 2002:a05:6512:2145:b0:515:9dcd:22ae with SMTP id
 s5-20020a056512214500b005159dcd22aemr6923350lfr.66.1711992560376; Mon, 01 Apr
 2024 10:29:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN7Jk_2mMiVjXuF02S14OX6Rjq2jVjNxcUbZvTqhcz_YMnD=gg@mail.gmail.com>
 <CAN7Jk_0hyjx39rrO1PKbEcJQXLtCYkWP7A4mCv01DZu2ffGHyw@mail.gmail.com> <ZgUdKU5uynGrJ33f@tanuki>
In-Reply-To: <ZgUdKU5uynGrJ33f@tanuki>
From: Sanchit Jindal <sanchit1053@gmail.com>
Date: Mon, 1 Apr 2024 22:59:16 +0530
Message-ID: <CAN7Jk_3Y+Ls2VjhQqzA3Ymy-WDv8nT+v5bzU2a1YGz+j89vPgw@mail.gmail.com>
Subject: Re: Fwd: [GSOC][Proposal] Move existing tests to a unit testing framework
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, christian.couder@gmail.com, 
	kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

Thank you for the review and sorry for the late reply.
I have made the required changes in the document and uploaded the pdf
to GSOC webpage

Thank You,
Sanchit Jindal

---------------------------------------------------------------------------=
-------------------------
Google Summer Of Code Proposal
Git (Move existing tests to a unit testing framework)

Personal Information
Name:          Sanchit Jindal
Email:           sanchit1053@gmail.com
Qualification: B.Tech in Computer Science and Engineering

Greetings,

My name is Sanchit Jindal, currently pursuing my B.E. in Computer
Science at the Indian Institute of Technology, Bombay, I will complete
my degree in May 2024. I am writing to put forward my proposal for the
Git Project to transition the unit tests to the new Unit Testing
Framework.


Throughout my academic journey and internships, I've gained valuable
experience across diverse domains, ranging from machine learning to
fundamental system components like compilers and operating systems.
This breadth of exposure has honed my ability to swiftly grasp new
concepts and adapt to different codebases. Proficient in both C, C++
and shell scripting, I am well-equipped to contribute effectively to
the project.


In my internship at Quadeye last summer I worked on building an
efficient and user-friendly library for creating and maintaining
network connections. The project included building a layered
architecture with a modular approach, and C++ meta programming for
easy transfer of any structure between nodes.

I have also worked on an gdb extension to provide a front end to
display graphical structures in the program via a web application. The
program aids in debugging pointer structures and to visualise the
run-time of the code.

For this GSOC project, I aspire to make meaningful contributions to
the open-source community. My interest in software development drives
me to create solutions that will offer utility to others.

## Overview

### Proposed Abstract

Git has a lot of test cases that need to be migrated to use a new unit
testing framework. This typically involves moving code from both:
- a =E2=80=9Ct/helper/test-*.c=E2=80=9D test helper in C, and
- a =E2=80=9Ct/*.sh=E2=80=9D test script in shell that invokes the test hel=
per

over to a single =E2=80=9Ct/unit-tests/t-*.c=E2=80=9D in C using the unit t=
esting framework.

### Details

The Project entails porting the current testing framework (which is a
collection of helper files written in c that provide various
utilities, and various shell scripts) to using a new Unit-Testing
Library. The shell scripts in the original code base setup the
environment and , using the helper functions, test the functionalities
provided by Git. The new framework utilises the test-lib library that
will combine the functionality of both the helper functions and the
shell scripts into one unit-test.
Advantages of this approach
- Unit Tests are a great way to check any program and to test all
possible corner cases and functions
- Using this new testing framework will provide a more modular
approach to unit testing, allowing to create more extensive tests, and
to provide more fine-grained tests when required.
- Having a testing library also provides various other features such
as better debug messages or a better CLI to choose and run tests.
- The tests will also improve the runtime as instead of running
multiple process (with each use of shell commands), the program can
compile and run a single process
- The approach will also future proof the unit testing as having a c
library will provide a better base than shell scripts to test
libraries and other internal features


### Basic Structure of the Changes

For each file in the helper directory I will create a corresponding
unit-test file. (Some files which are being used by multiple tests and
implement more general functionality may not be ported to the new
library)
Each test in the script will be corresponding to a function that will
be called in the format

`TEST(funtion_name(), =E2=80=9CSUCCESS MESSAGE=E2=80=9D);`

The function body will contain the main implementation of the test
corresponding to the c file ( The helper function will ideally be the
same with no or minimal changes just to allow it to be called as
required )
Where the assert usually given at the end of the test will be made
using the utility functions such as check_int, check_str and others,
(or creating more function as they are required)
The Make files will be updated to remove the use of shell script with
compiling and running the new c programs



### Previous Contributions

I have worked on the micro-project
Use test_path_is_* functions in test scripts
Thread Link: https://lore.kernel.org/git/b8d0620d4104106210ecf6a34ada591adf=
01cff8.1711049963.git.gitgitgadget@gmail.com/

Status: Open
I had some difficulties in understanding the usage of gitgitGadget and
git send-email which are being employed as the Pull request
alternatives. Having tried gitgitGadget I am confident that I will be
able to utilise it hereafter. I am having some trouble using git
send-email with the network at my institute but I am optimistic that I
will be able to use it after the completion of my degree.

With the guidance of Eric Sunshine and Junio C Hamano, I have iterated
through different versions of the pull request, and familiarised
myself with the git commit pattern and formalities


### Deliverables

The plan is to port the helper functions from helper directory to the
unit-test directory along with the test defined in the shell scripts.
Some of the helper tools which have a more basic functionality and are
being used by multiple test scripts can be left untouched.
As a stretch goal I will try to port the shell scripts to the new
testing interface creating new functions for the library as required
I also plan to keep documenting all the changes made and to keep in
constant contact with the mentors regarding any bugs or reviews
regarding the code.


### Availability

I am expecting to be free from my academic responsibilities by 4th
May. I have no further commitments for the summer and will be able to
provide about 40-50 hours of work per week. I will try porting at
least one file per week, depending on the community feedback and the
pace of the development process.

### Related Work

The project has been worked on by Achu Luma for the Outreachy Internship
Test-ctype:
https://lore.kernel.org/git/20240112102743.1440-1-ach.lumap@gmail.com/#t
Test-advise:
https://lore.kernel.org/git/20240112102122.1422-1-ach.lumap@gmail.com/
Test-data:
https://lore.kernel.org/git/20240205162506.1835-2-ach.lumap@gmail.com/
Test-hash:
https://lore.kernel.org/git/20240229054004.3807-2-ach.lumap@gmail.com/
Test-strcmp-offset:
https://lore.kernel.org/git/20240310144819.4379-1-ach.lumap@gmail.com/

Another testcase has also been handled by Ghanshyam Thakkar
Test=E2=80=93oid-array:
https://lore.kernel.org/git/20240223193257.9222-1-shyamthakkar001@gmail.com=
/


### Timeline (Tentative)

Community Bonding
(1 May- 26 May)
Be in contact with mentors and figure out the best way to migrate the
test-cases, Familiarise myself with the library and previous work done
during the outreachy program.

Phase I
(27 May - 11 July)
Begin tackling the harder or longer testcases that will require more
knowledge of the implementation

Phase II
(12 July - 18 Aug)
Keep working on the testcases following the mentors and community feedback

Final Week
(19 Aug - 26 Aug)
Finish up the remaining testcases, fixing any bugs that may be
discovered in the earlier implementations


### Acknowledgement

I would like to thank Eric Sunshine and Junio C Hamano for helping me
with the microproject and for the guidance on the gitgitGadget and git
send-email features, And also helping me get acquainted with the git
PR guidelines.

Regards
Sanchit Jindal
