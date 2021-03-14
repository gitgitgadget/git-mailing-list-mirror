Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC3EC433E6
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 16:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBBCF64E33
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 16:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233779AbhCNQzi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Mar 2021 12:55:38 -0400
Received: from mx.kolabnow.com ([95.128.36.40]:35398 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233966AbhCNQzU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Mar 2021 12:55:20 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTP id 12C8D4049B;
        Sun, 14 Mar 2021 17:55:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:date:date:message-id:from
        :from:references:subject:subject:received:received:received; s=
        dkim20160331; t=1615740900; x=1617555301; bh=5bq90ixzlRxBq7eEfUo
        0C3XYnz0sPMb/SHsG1u1ycV8=; b=5v9NOLo/SAOCanljHRvwvVIfbB5mMy1yzWR
        WSAi0eJc4DtcWznh1OeCLoHL7bb+dP/lTSCCphv1cVkwe5WcLa+np8TrnRtR0GoT
        mRWO9dqtYp6thPTzzF8WoASX986zN5yD/yAwC+gdh2mhhgKV2NfKl3c3LANBm233
        XO0oy13gp5OS54fVf1pYfQ5+P1fEhAEMrC7c5/nk8TMcGbgePKgV0mvRU7o/xdsR
        GV5YUm1FM711G6zSvKp1Z0jz1M/vO1qFLkByt8pQOOCwiiy5+r5Q1utjxbSYhbOz
        56oZATMzx60RsD0UKD9DCDmJqQgCwCXTHCUt7ZGpWxoWctzqmKlotoXfhgZfN55U
        T0wEuqIIXyN5YZtOLcECD2vkCmYX6mh0p1i9ZST4Y3PlkIHDNDQkYchiK+OnvnJO
        DnH3v4w4NCiwJOY/dENtnPuOKEJNRCZ286VFWgHl4lHxBmtS0YyaqPzXoZDQHv2N
        72Lb3DJHInindS443dumwl5X1cnQQtDn2t1Vs/5Tk4cuYMkeI2IQSS/zIT5VDKkD
        e9qIWv0KQ+DniUk9Vtnk+cyaAoK/WdFkO3IvsRmTgsHDhH1nDFPItJSz/Xdliv4j
        5bSp/sqAMhdCqRrQb6ouoZdw1VibP6haD+d2P4ZyYyO2v8zZtvxaiindoV3G/wOh
        m4yfxpzY=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id cnDq0ubCDL7T; Sun, 14 Mar 2021 17:55:00 +0100 (CET)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id 3D4FA403B1;
        Sun, 14 Mar 2021 17:55:00 +0100 (CET)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id 0A8B2B1D;
        Sun, 14 Mar 2021 17:54:57 +0100 (CET)
Subject: Re: [PATCH 0/7] Fix all leaks in t0001
To:     Jeff King <peff@peff.net>,
        Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.899.git.1615228580.gitgitgadget@gmail.com>
 <YEZzGjNMSj+MkDUH@coredump.intra.peff.net>
From:   Andrzej Hunt <andrzej@ahunt.org>
Message-ID: <d22dc5e6-415e-e265-e894-67b28fe9fe54@ahunt.org>
Date:   Sun, 14 Mar 2021 17:54:54 +0100
MIME-Version: 1.0
In-Reply-To: <YEZzGjNMSj+MkDUH@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/03/2021 19:55, Jeff King wrote:
> I think it's worth doing. The reason t0000 passes is because it was my
> reference script when adding UNLEAK() back in:
> 
>    https://lore.kernel.org/git/20170905130149.agc3zp3s6i6e5aki@sigill.intra.peff.net/
> 
> (which might be of historical interest if you haven't read it). I knew
> that the next step would be tediously going through the test suite
> looking at the tool results, and I somehow stalled on that part. ;)
> 
> But I think it's nice to move the goal forward incrementally. I agree
> that a lot of these leaks aren't that important, but it's generally as
> easy to fix or annotate them as it is to argue that they shouldn't be > dealt with.

Thanks for the confirmation! I'd seen your post, but wasn't sure if 
there'd been a change of plan or just lack of time :).

>> Note: this series does not guarantee that there are no leaks within
>> t0000-t0001, it only fixes those leaks which cause test failures. There is
>> at least one test case in t0000 where git is invoked in a subshell, and the
>> return value is ignored - meaning that a memory leak that is occuring during
>> that invocation does not cause tests to fail (I'm still trying to figure out
>> if that's something that's worth fixing - but that's probably a topic for a
>> separate thread):
>> https://git.kernel.org/pub/scm/git/git.git/tree/t/t0000-basic.sh#n1285
> 
> It's not the subshell there, but rather that git is on the left-hand
> side of a pipe (and so its exit code is discarded). We've been slowly
> fixing such cases (the usual technique is to use a tempfile).

Thanks for the tip! I've started on another series to fix t0000-basic 
along with the leaks that that uncovers. In future I suspect it's best 
to start by removing pipes _before_ running leak-checking against a 
given test. (Fortunately t0001 doesn't contain any such cases, so this 
series is valid as is.)

>> In case anyone is interested: I have been using the following workflow to
>> find leaks and verify fixes - I'm running into crashes when using LSAN
>> standalone, therefore I'm using full ASAN instead (I'm not particularly
>> concerned about this: LSAN standalone mode is known to be less-well tested
>> than leak-checking within ASAN [1], and the crashes are occurring within the
>> leak-checker itself):
> 
> Yeah, I think using ASAN is just fine. I found that LSAN is faster, but
> if you are running a single script the difference probably doesn't
> matter. I also found that clang's support was much more mature than
> gcc's (I don't know how different the state is these days, though).
> 
> Regardless, if you can get it to run cleanly with _any_ leak checker,
> I'll be quite happy. :)

I was wrong when it comes to LSAN being broken. What was actually 
happening is: we default to running ASAN and LSAN with abort_on_error=1, 
and I had overridden that setting when running with ASAN. When I 
switched to LSAN, abort_on_error was enabled again - and I was just 
misinterpreting the intentional abortion as opposed to seeing an 
unexplained crashes. [As far as I can tell, abort_on_error is needed to 
detect leaks during a test_must_fail and similar scenarios.]

I've briefly tested all the various combinations of gcc or clang, with 
LSAN or ASAN or both - and they all seem to work as expected, with one 
exception: gcc with LSAN-only finds what seems to be a false positive, 
in a method which mallocs, followed by a die().

To make it trickier, that new "leak" happens inside a test_must_fail - 
the LSAN output is swallowed, making it hard to diagnose. I'll try to 
prepare a separate patch to not discard stderr in that scenario.

Regardless of the LSAN/ASAN differences - I'm wondering whether 
piggybacking on the existing ASAN validation might be the best way to 
get leak checking run more often (limited to a subset of leak-free tests 
of course). I'll expand on these thoughts in my reply to Junio.

>> make GIT_TEST_OPTS="-i -v" DEFAULT_TEST_TARGET="t0000-basic.sh"
>> ASAN_OPTIONS="detect_leaks=1:abort_on_error=1" SANITIZE=address DEVELOPER=1
>> CFLAGS="-DSUPPRESS_ANNOTATED_LEAKS -g -fno-optimize-sibling-calls -O1
>> -fno-omit-frame-pointer" test
> 
> There's some magic in the Makefile for detecting SANITIZE=leak and
> setting -DSUPPRESS_ANNOTATED_LEAKS. It might be worth that extending
> that to SANITIZE=address, but I guess we wouldn't want to do so for most
> builds (which also are setting detect_leaks=0 in the test suite). Maybe
> we should have some other name to trigger asan-as-a-leak-detector. Or
> maybe that just gets complicated, because we pass the results of
> SANITIZE on to the compiler directly.

I've realised it's enough to set SANITIZE=leak,address. That gives us 
the benefits of ASAN, but still adds -DSUPPRESS_ANNOTATED_LEAKS. Given 
that LSAN seems stable enough with clang, I suppose this is only really 
useful for gcc users.

> I haven't looked at the individual patches yet. I'll respond to them
> individually.
> 
> -Peff

Thank you for the reviews! I'm still a bit new to the git codebase, 
thank you for being patient with my (deficits of) style :).
