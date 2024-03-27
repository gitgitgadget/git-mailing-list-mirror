Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E37F12F5A1
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 14:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711550176; cv=none; b=B3mHXIP9tVtMSBfV+HYSju1S9fK41yNxe7baq/eOHhTBFlDtQfPJEPMq6GhNfsVLKvkZTbFReN8gpI3GCaL1XKxwCTKSPd4vti6fxhYVLV7PDBp+SukgJYmNBHi7bSr45YgasU61duWBBede/EjJPfsFIGNpzA58Y9XrZ+YNc+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711550176; c=relaxed/simple;
	bh=MQnOy7fZKrGaoHTjk6KFOLFSEnGIPSiTBkx8zCrvaZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=iP6flxDDQoA4hugE6hVbjM9F3bat3lroXLco3EsSwAOqyk2x2Y89zV58tBgZhpTW3TikANGJn3FxSWhmnDMy/bSGltUQf/DNuTU7iaEX75XxG8bwp/ghiJyqCHHTmWyH5lwt2KiEsnuN1tNY/XUiuQwxlySx1HQAAFkO+o/MbHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WSVS2vCm; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSVS2vCm"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d6fd3cfaa6so8664321fa.2
        for <git@vger.kernel.org>; Wed, 27 Mar 2024 07:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711550172; x=1712154972; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d2wFDJoki31O9cZmZo0FBWbayI6Xv5vMqrRPkhlCgPc=;
        b=WSVS2vCm6zqN147WQ8k4g+WC+wxLwsFcsSDQt2GJLM6YDPJQhrrjYskvH0D7pcbQny
         4tiDMyomDeeGM1ZHke8ICet1T1qQg8a8npUJAl1LNK79N2ZeOw6hgC5jBYBFtCadvYFS
         P2qzOQbx79SBlYNvthgUf9Y0ayR4+XU5QbofFM9iKDsK5DSVviHBzjip1N6DsznqhmlU
         pcbyXJFAolhLiR5vtdUHD66t0Ao8r9ABDFmqJnVXH7lVZrAr67EjRDj1Dfd+nZ3OEZkI
         T2vOQIauN972tVqSZc37xUdDLF3WkuXxQh6pYqqYtWrl+t0BrbIz8WKhnoKkiOEkEvZm
         xUrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711550172; x=1712154972;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d2wFDJoki31O9cZmZo0FBWbayI6Xv5vMqrRPkhlCgPc=;
        b=RAQVB9vsErk6WU3P6BDsDQbaADop0B0RvUr0ryqoicUBYLhWIaoVLCB/lesfzMaocc
         2CsnjAIfW8zMeB8tscCa+RIcnw4jr8MgWqCo3NGoVY5hAu1aXfMGYGXYbTtRteDdMU6g
         CBOgOW/qbBSrfnMfUelSlCbbWDQ7ules/m2z0LROMjaYdVEQxA6Mrfv78j9BWZDn+q8l
         j8CxBRQY6oCUsPcN95LlWStrWc6o2+nbUz26aSypTF9NqxrlXVAu/HJwI6NDG100qJHX
         FJkaJYzLGRo/KV1w1rua1teKvAsJ7Q8u3IBkau+Ff0CvUl3MryxelQ2t9fitIQOSPwM3
         pjDg==
X-Gm-Message-State: AOJu0Yw8MBLI9hAnt2ivtP8TBagpkidif6dT5liMw40w/MQGSlLf7VQ4
	/lZFLcEni/l7ze41um0ZcWcJF10+HicesSO99HOBMjAuZMlimofCC+/UiI+mZZ9/r69+SopYDL2
	r1aicQFHiTOxjt/h4pvM8w04nBcwrzcqZ
X-Google-Smtp-Source: AGHT+IFaah1c+pZp6JY64b4yEzDB5XZTdbBXpfK7YsglQeqQ0h6apSVdaUMOkFZTXkNysBeqyCuoXOQ/Iad/1RTN7II=
X-Received: by 2002:a2e:a7d0:0:b0:2d4:908e:4cc4 with SMTP id
 x16-20020a2ea7d0000000b002d4908e4cc4mr211306ljp.4.1711550171670; Wed, 27 Mar
 2024 07:36:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN7Jk_2mMiVjXuF02S14OX6Rjq2jVjNxcUbZvTqhcz_YMnD=gg@mail.gmail.com>
In-Reply-To: <CAN7Jk_2mMiVjXuF02S14OX6Rjq2jVjNxcUbZvTqhcz_YMnD=gg@mail.gmail.com>
From: Sanchit Jindal <sanchit1053@gmail.com>
Date: Wed, 27 Mar 2024 20:06:06 +0530
Message-ID: <CAN7Jk_0hyjx39rrO1PKbEcJQXLtCYkWP7A4mCv01DZu2ffGHyw@mail.gmail.com>
Subject: Fwd: [GSOC][Proposal] Move existing tests to a unit testing framework
To: git@vger.kernel.org, christian.couder@gmail.com, 
	kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

Please find my proposal for GSOC 2024 for the project "Move existing
tests to a unit testing framework" at
https://docs.google.com/document/d/1yWP5GFRksdQEOKtYIEXbNSVb1qlJ2szRvpTcXXV=
vgTk/edit?usp=3Dsharing.
I am also adding the text version for convenience.

Thank You,
Sanchit Jindal
--------------------

Google Summer Of Code Proposal

GIT (Move existing tests to a unit testing framework)

### Personal Information

Name:          Sanchit Jindal
Email:         sanchit1053@gmail.com
Qualification: B.Tech in Computer Science and Engineering


Greetings,

My name is Sanchit Jindal, currently pursuing my B.E. in Computer
Science at the Indian Institute of Technology, Bombay, I will complete
my degree in May 2024. I am writing to put forward my proposal for the
Git Project to transition the unit tests to the new Unit Testing
Framework.

You can find my Resume at
https://www.linkedin.com/in/sanchit-jindal-0a953621a/ in the featured
section


Throughout my academic journey and internships, I've gained valuable
experience across diverse domains, ranging from machine learning to
fundamental system components like compilers and operating systems.
This breadth of exposure has honed my ability to swiftly grasp new
concepts and adapt to different codebases. Proficient in both C and
C++, I am well-equipped to contribute effectively to the project.

For this GSOC project, I aspire to make meaningful contributions to
the open-source community. My interest in software development drives
me to create solutions that will offer utility to others.


### Overview

Proposed Abstract
Git has a lot of test cases that need to be migrated to use a new unit
testing framework. This typically involves moving code from both:
* a =E2=80=9Ct/helper/test-*.c=E2=80=9D test helper in C, and
* a =E2=80=9Ct/*.sh=E2=80=9D test script in shell that invokes the test hel=
per


over to a single =E2=80=9Ct/unit-tests/t-*.c=E2=80=9D in C using the unit t=
esting framework.


### Details

The Project entails porting the current testing framework (which is a
collection of helper files written in c that provide various
utilities, and various shell scripts) to using a new Unit-Testing
Library. The shell scripts in the original code base setup the
environment and , using the helper functions, test the functionalities
provided by git. The new framework utilises the test-lib library that
will combine the functionality of both the helper functions and the
shell scripts into one unit-test.
Advantages of this approach
* Unit Tests are a great way to check any program and to test all
possible corner cases and functions
* Using this new testing framework will provide a more modular
approach to unit testing, allowing to create more extensive tests, and
to provide better debugging features. Such as better debug Messages or
a better CLI to choose and run tests.
* The tests will also improve the runtime as instead of running
multiple process (with each use of shell commands), the program can
compile and run a single process
* The approach will also future proof the unit testing as having a c
library will provide a better base than shell scripts to test
libraries and other internal features


### Basic Structure of the Changes

* For each file in the helper directory I will create a corresponding
unit-test file. (Some files which are being used by multiple test can
be ported later)
* Each test in the script will be corresponding to a function that
will be called in the format

'''
TEST(funtion_name(), =E2=80=9CSUCCESS MESSAGE=E2=80=9D);
'''

* The function body will contain the main implementation of the test
corresponding to the c file ( The helper function will ideally be the
same with no or minimal changes just to allow it to be called as
required )
* Where the assert usually given at the end of the test will be made
using the utility functions such as check_int, check_str and others,
(or creating more function as they are required)
* The Make files will be updated to remove the use of shell script
with compiling and running the new c programs

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
provide about 40-50 hours of work per week. I am confident that I
should be able to complete about 2-3 files each week depending on the
files.


Related Work
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




Timeline (Tentative)

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
Keep working on the testcases following the mentors feedback

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
