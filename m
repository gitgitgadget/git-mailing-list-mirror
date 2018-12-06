Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2675F211B3
	for <e@80x24.org>; Thu,  6 Dec 2018 22:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726056AbeLFWl7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Dec 2018 17:41:59 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41565 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbeLFWl6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Dec 2018 17:41:58 -0500
Received: by mail-pl1-f194.google.com with SMTP id u6so834310plm.8
        for <git@vger.kernel.org>; Thu, 06 Dec 2018 14:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:user-agent:from:to:subject:organization:reply-to:address
         :date:message-id:mime-version:content-transfer-encoding;
        bh=dp2xq0K3PkYD68c7lXgVdGnsCtdPKAZX7wQAVD5wrKo=;
        b=RuA/1EO31vOzk3g3rkNqyAurVoZG1UaNFcWdkmzTfiPyb9hhSESuEO7M8hftY2QxFJ
         x0Pj+sXQYKvvJcRXlMNw826L+greoA6pDBmhCs8lYeV3BT56/4PjOG3bh7m8MVrwvRgA
         zLW8ErLn5dhf7+RDT1Wt9N4YkerxT8swCG4FS4gTp54625FGWKoVpTrpKNhjudrI3oPW
         3BxXxVTGgmkrEsN4fUvtAAcN89Wpj96s60ZL/jVIWGww1FasbpKJxOPvpuwCUXQIUthT
         +YjinF76km3VBI3jJk8BKPk/3Hmv7eQC0L+gIxnrx2rvJPYXp17At+coyZ/jL8d+TV0C
         PR2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:user-agent:from:to:subject:organization
         :reply-to:address:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dp2xq0K3PkYD68c7lXgVdGnsCtdPKAZX7wQAVD5wrKo=;
        b=ZMYZTVGiiIZdqgK821H59DyzFIIv4GPlivLNaV4XHXmW9uy2DfC6NdO+UxwfkQnxch
         rVTNAeoCheJw3bfpdz1LqKIZh8Yc9pcFoKAuMq0bNOF4Qr5H7sR77fRAZh8RGbCTkLUm
         YKpGhAM6VY9TbO+2aodMBpYzRLV5aItS/VGSMZO4uWlqdrTRgdxUxf1b7GpZnrm0fCLA
         tOMvQc9mb8DbTw6Z2XDjNMs9GJxw3fj7VSwD23cqltOWNrp/q8GweRasPFQWCdqfXoJK
         NrvyIZfy0Y0MFZ5OE99RD3g8lT9HkLdN/RN8Gxp/rIesX5+kTh1MI7P743BxeizEh14r
         h4AA==
X-Gm-Message-State: AA+aEWa/GGUbiyp4h30M7N/DjR5EE6kpwHkEgsufWR+MG8Q456cqzzk2
        ulUZEUSOVROxBQIzMquJpqJF5Dk6pf8=
X-Google-Smtp-Source: AFSGD/UpuhCEM+DI9xMBz0oRYVfIBi6jZ2zEMbZdbo1X28GXtI9heWPMFkJGyycOVFIwvJvk5Zt0pg==
X-Received: by 2002:a17:902:6bc4:: with SMTP id m4mr28629629plt.93.1544136116827;
        Thu, 06 Dec 2018 14:41:56 -0800 (PST)
Received: from mn.cs.uvic.ca ([24.244.23.12])
        by smtp.gmail.com with ESMTPSA id 184sm1789244pfe.106.2018.12.06.14.41.55
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 14:41:55 -0800 (PST)
Received: by mn.cs.uvic.ca (Postfix, from userid 1000)
        id 88B3950592B; Thu,  6 Dec 2018 14:41:54 -0800 (PST)
User-agent: mu4e 0.9.18; emacs 25.2.1
From:   dmg <dmg@turingmachine.org>
To:     git@vger.kernel.org
Subject: behaviour of git-blame -M -C (maybe a bug?)
Organization: turingMachine
Reply-To: dmg@turingmachine.org
Address: dmg@turingmachine.org
Date:   Thu, 06 Dec 2018 14:41:54 -0800
Message-ID: <87efau2s7h.fsf@mn.cs.uvic.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



hi everybody,

I am the maintainer of cregit. We are trying to improve blame 
traceability at the token level (see 
https://github.com/dmgerman/papers/blob/master/editorials/cregit/cregit.org)

We use git-blame heavilty in cregit. One of the features that I 
would like to add to cregit is the ability track movement of code.

I have been testing git-blame -M -C and I found some behaviour 
that  seems incorrect. I have created a very simple repository 
that I think showcases this problem:

https://github.com/dmgerman/testBlameMove

this repo have 4 commits (listed below in order of execution):

1. A file is created tpm-dev.c (authored by D German),
2. a refactoring (code is moved from tpm-dev.c to 
tpm-dev-common.c, a new file). Author is "refactor"
3. a commit that adds some few contiguous lines (the existence of 
this commit seems to matter). Author is "none"
4. a commit that changes few lines and alters the result of blame 
for lines not modified by this commit. Author is "problem"

See below. I am running blame at different commits, showing only 
the lines attributed to author "refactor" (author of commit #2).

dmg@iodine:/tmp/testRepo|master ⇒  git log --oneline
ded1aa1 (HEAD -> master, origin/master) problematic commit
3720e68 simple commit
391adba refactoring
33165cb file before refactoring

if we checkout 391adba and do blame -M -C we get this:

dmg@iodine:/tmp/testRepo|3720e68 ⇒  git checkout 3720e68 && git 
blame -M -C tpm-dev-common.c | grep refactor | head
HEAD is now at 3720e68 simple commit
391adba4 tpm-dev-common.c (refactor 2018-12-06 12:41:10 -0800  24) 
begin_include
391adba4 tpm-dev-common.c (refactor 2018-12-06 12:41:10 -0800  25) 
include|#
391adba4 tpm-dev-common.c (refactor 2018-12-06 12:41:10 -0800  26) 
directive|include
391adba4 tpm-dev-common.c (refactor 2018-12-06 12:41:10 -0800  27) 
file|"tpm-dev.h"
391adba4 tpm-dev-common.c (refactor 2018-12-06 12:41:10 -0800  28) 
end_include
391adba4 tpm-dev-common.c (refactor 2018-12-06 12:41:10 -0800 147) 
DECL|function|tpm_common_open (struct file * file,struct tpm_chip 
* chip,struct file_priv * priv)
391adba4 tpm-dev-common.c (refactor 2018-12-06 12:41:10 -0800 148) 
name|void
391adba4 tpm-dev-common.c (refactor 2018-12-06 12:41:10 -0800 149) 
name|tpm_common_open
391adba4 tpm-dev-common.c (refactor 2018-12-06 12:41:10 -0800 150) 
parameter_list|(
391adba4 tpm-dev-common.c (refactor 2018-12-06 12:41:10 -0800 151) 
name|struct

so far, so good. blame detects the movement. Note that the changes 
by refactor are adding 5 lines (24 to 28) and then adding some at 
147 and beyond.

now do it for the next commit: 3720e68


things continue to look good. The changes of this commit do not 
affect any of these lines.

now... the next commit, the problematic: ded1aa1 (author is not 
refactor)

dmg@iodine:/tmp/testRepo|3720e68 ⇒  git checkout ded1aa1 && git 
blame -M -C tpm-dev-common.c | grep refactor | head
Previous HEAD position was 3720e68 simple commit
HEAD is now at ded1aa1 problematic commit
391adba4 tpm-dev-common.c (refactor 2018-12-06 12:41:10 -0800  24) 
begin_include
391adba4 tpm-dev-common.c (refactor 2018-12-06 12:41:10 -0800  25) 
include|#
391adba4 tpm-dev-common.c (refactor 2018-12-06 12:41:10 -0800  26) 
directive|include
391adba4 tpm-dev-common.c (refactor 2018-12-06 12:41:10 -0800  27) 
file|"tpm-dev.h"
391adba4 tpm-dev-common.c (refactor 2018-12-06 12:41:10 -0800  28) 
end_include
391adba4 tpm-dev-common.c (refactor 2018-12-06 12:41:10 -0800  29)
391adba4 tpm-dev-common.c (refactor 2018-12-06 12:41:10 -0800  30) 
begin_function
391adba4 tpm-dev-common.c (refactor 2018-12-06 12:41:10 -0800  53) 
name|user_read_timer
391adba4 tpm-dev-common.c (refactor 2018-12-06 12:41:10 -0800  54) 
argument_list|)
391adba4 tpm-dev-common.c (refactor 2018-12-06 12:41:10 -0800 150) 
DECL|function|tpm_common_open (struct file * file,struct tpm_chip 
* chip,struct file_priv * priv)

now blame assigns the lines 29, 30, 53 and 54 to commit 391adba4 
refactor!!! This is what I think is a bug.
(by the way, the changes made in this last commit were between 28 
and 150)

thank you in advance for any clues on why git-blame is behaving 
like this.

--dmg

---
D M German
http://turingmachine.org
