Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A92EC61DA4
	for <git@archiver.kernel.org>; Thu,  9 Feb 2023 22:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjBIWzD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Feb 2023 17:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjBIWyw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2023 17:54:52 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948BC5B76B
        for <git@vger.kernel.org>; Thu,  9 Feb 2023 14:54:47 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id b5so4619554plz.5
        for <git@vger.kernel.org>; Thu, 09 Feb 2023 14:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tYHsRYRRHn6noN538WC1RHGgsWBB6Xd+u+lYGCILxRs=;
        b=gvxjvvg3NvCjOCSGTv93xIx+SvrZN3PcFs9booCqt9L7we6lJrOjLs5CxpNUgVJX0F
         SmvCwz5Qq8VtzZ1uRSwomPvYfhzoo+pf/eHQFLfbjlAyugsJBeHJicSb/IzgG2n1z9AS
         qaj1qnwktr51IeJWEFCdJbQaT8sAMTART9vu8cZ2a6x6Go5cZybjeQ86PHCkPzsKdpKo
         ovdgvcCs9RDEfaNUVfobG2WycbwVMiZuT2ODhy2j0Bb9eINHVM7h7mYELes0HphI2UjY
         wji+ViQeLz2Je1IenOx3NFHRuAeZohsNWTJRfSlwIVOawLg91oBci1RSsXep8tZg674C
         Afaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tYHsRYRRHn6noN538WC1RHGgsWBB6Xd+u+lYGCILxRs=;
        b=AigwWILR4aePgqXaKQFXdZyCkhOt2uqZQHQO60Uovtp3LkOzPQfDZ2zHGnNO2Em/YH
         lUb0NwEdbprNB+6q+WEESo34XGRmTLW36i65jGEDOUT14xctT8hOo/dYIgFanpSEazzk
         A7jKVJxdNfWxzzlyG09YWcqCXmfdya2BPmQm4AoCzVE6r9Kw1w0TumvmlPSXv80afbas
         N8jjyhxpxB89zlBc01pYNth+08XF+mNwxdRbr+vPCSN3F5vkRq0AnWD3VgePXhxJZ8qL
         ss7VhmPhV7k0Oh35+m8IpKEa8tf1a4YAHX2m9r+UNWmq6z5wjuf3QBjuU6WhBth3p5k1
         MlgQ==
X-Gm-Message-State: AO0yUKXla4bbOUNCuGje75XM0tYFZ8AcvSMcJZ1Cl+N+w42W6SQSBVlP
        pCqF/Y6mLXN4Gj9q6aUAZtY=
X-Google-Smtp-Source: AK7set/LaX+b6qX1Y2j3OhpRY1FCsileYnF2UPiI85V61ueIQB/e7Vln0RrgwXFr0KSGj53d+90noQ==
X-Received: by 2002:a17:90a:199:b0:230:ac58:4fa2 with SMTP id 25-20020a17090a019900b00230ac584fa2mr41492pjc.12.1675983286931;
        Thu, 09 Feb 2023 14:54:46 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id s89-20020a17090a2f6200b0022bfcf5d297sm3931065pjd.9.2023.02.09.14.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 14:54:46 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] test: make SYMLINKS prerequisite more robust
References: <xmqqwn4sq73f.fsf@gitster.g>
        <230209.86k00rzqsz.gmgdl@evledraar.gmail.com>
        <xmqqbkm3ppn8.fsf@gitster.g>
        <230209.86ttzvy405.gmgdl@evledraar.gmail.com>
Date:   Thu, 09 Feb 2023 14:54:46 -0800
In-Reply-To: <230209.86ttzvy405.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 09 Feb 2023 03:15:07 +0100")
Message-ID: <xmqqlel6laa1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>> We
>> are testing "git" with the test suite, so even if with some magic
>> that is still unknown to compat/mingw.h it knows how to read what
>> "ln -s x y" left in "y", until compat/mingw.h::readlink() learns the
>> same trick, asking Perl to decide SYMLINKS prerequisite would not
>> help our test scripts at all.
>
> We could always see if they return the same answer :) But not worth
> pursuing in this case.

Actually we probably should test if "git" can create a symbolic
link, because that is what matters more than what "ln -s" can or
cannot do.  We also are interested in the "symbolic link" does
behave as a symbolic link, i.e. writing into it should modify the
contents of the target of the link.

In any case, here is what I have in mind.  There is only a symbolic
link 'y' without 'x' (because this happens in a new and empty
directory for evaluating the lazy prerequisite), redirecting output
from the command, which should be 'x', into 'y' will vivify file 'x'
with contents also 'x', and reading 'y' should yield 'x' because it
points at 'x'.

diff --git c/t/test-lib.sh w/t/test-lib.sh
index 6db377f68b..3fb5957bd2 100644
--- c/t/test-lib.sh
+++ w/t/test-lib.sh
@@ -1773,7 +1773,9 @@ test_lazy_prereq PIPE '
 
 test_lazy_prereq SYMLINKS '
 	# test whether the filesystem supports symbolic links
-	ln -s x y && test -h y
+	ln -s x y && test -h y && test-tool readlink y >y &&
+	test "$(cat y)" = x &&
+	test "$(cat x)" = x
 '
 
 test_lazy_prereq SYMLINKS_WINDOWS '
