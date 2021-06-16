Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4AEBC48BE6
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 11:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94C5D610CD
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 11:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbhFPL3O (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Jun 2021 07:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhFPL3N (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jun 2021 07:29:13 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A3BC061574
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 04:27:07 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id k7so3272271ejv.12
        for <git@vger.kernel.org>; Wed, 16 Jun 2021 04:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=oPy439WCoCwTFQwoKNlVIVNO9OTaW1Bkpl+D1Fq305o=;
        b=L+j9D5X++XQLdcZ8lErMVTekWkjUjDLMPpdTJnq+lFX16ecwoZs/ybpyT99Dym7hSJ
         eD8ZV/hcz2Wl63wEreAQ+8z9MRkgGH+G9VPIrsuDq9egkuRIcxYTb61tPOSnjao4Xdjt
         LLJQkt29qlt6yuibwM3oCUajgnbtpDpH35gUk4zKVYEWAyGoclkPXDee9+Rbg2uAhxIj
         PYVO9BuOuu1Q0fu+ksSMsh5q7m/3rDVMRgRhC8x2t5sneajx27m8uLZg3XvA9Po+JTfp
         /vTuTWacDZkbN3vtFxreKZKiEgtzr1/q+Aup7X81cRbhqaAWLpKag1ND3vCGb1auoYDO
         NxAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=oPy439WCoCwTFQwoKNlVIVNO9OTaW1Bkpl+D1Fq305o=;
        b=tzcPPZyuWZWiKByudWermmqcw0qxoYH+DCoVQuJhOULAeGvaNvfqVcGlLJIzjhCb6+
         NEJuELQGvaN5UN3XGT5HKMKmWYm9Rw+zSGxf+JIOVCBCZsFE9QYlUWEaiF/ONwa2gfWm
         eyTflhcQxlxnZgi14FtRg2jbh2qPdimg+BuHE1WS3SN/0elrxZhMRMf1OeCP2hT6f0BC
         i8bbGzPpOW7VRvKpKQwqss9u5CupNZAJ98MW8hqn45+YFKxyB1IH39S4zvKFrXE7ej4g
         crkieBl8sC6V826a/7gpDv4s6I3wmnKLnhMKhncELdsMkoIZbEhRs5KY36rsCvrwRHG+
         03nQ==
X-Gm-Message-State: AOAM531PY+sjFgoYr1vbVoTla6teJ8pmtle0CiAJRfiblT3P9NYvLjm4
        ezdjROSvc0wGom7mpxETDgU=
X-Google-Smtp-Source: ABdhPJyjKRzhzSI5hGYDZwk2mQXVs58Y/IrDvLX9nCePD93CuBCoxv2oQbyw7ZdldNu8zvtMAPtquQ==
X-Received: by 2002:a17:906:546:: with SMTP id k6mr4722113eja.53.1623842826133;
        Wed, 16 Jun 2021 04:27:06 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id p23sm1568010edt.71.2021.06.16.04.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 04:27:05 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Subject: Re: [PATCH] test-lib: fix "$remove_trash" regression and
 match_pattern_list() bugs
Date:   Wed, 16 Jun 2021 11:49:20 +0200
References: <xmqqa6nqsd2i.fsf@gitster.g>
 <patch-1.1-436c723f4f8-20210616T082030Z-avarab@gmail.com>
 <YMm4F2uKZ4Dv3C4p@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <YMm4F2uKZ4Dv3C4p@coredump.intra.peff.net>
Message-ID: <87pmwmxd6f.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 16 2021, Jeff King wrote:

> On Wed, Jun 16, 2021 at 10:24:13AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> Those options will try to match an argument like --verbose-only=3D1*
>> against a test number like "10", but since we run the match in our own
>> trash directory an earlier test creating a file like "1one.txt" will
>> break that option.
>>=20
>> We cannot simply quote the $GIT_SKIP_TESTS" being passed to
>> match_pattern_list(), since we are relying on the $IFS semantics.
>>=20
>> Let's instead setup a .test-lib-trash subdirectory under the trash
>> directory, and an "empty-dir" directory under that. Then let's run the
>> match_pattern_list() in a sub-shell in that directory.
>
> Looks like my email just crossed with this one. Your "cd to an empty
> directory" is a fun version of my "maybe somebody can think of something
> clever" statement. :)

Yeah, I sent it before seeing yours.

> As a general solution, it does fail if the globs may contain things that
> look like absolute paths, but that is quite unlikely for our use case
> here.[...]

Not just unlikely, impossible. Yes it's possible in the general case,
but in the match_pattern_list we are always normalizing
e.g. ./t1234-some-test.sh t t1234, and the other match cases are test
numbers etc. It doesn't need to deal with the general case.

> [...] Still, I kind of like the "set -f" version because it doesn't need
> the extra directory which could cause problems with "ls-files -o", etc,
> as you mentioned. You could also create the empty directory on the fly,
> though if "set -f" works portably, that seems less complicated to me.

Yeah, in isolation I'd agree, but given the desire (with existing code
and other in-flight code) to have a scratch are for the test library
code itself simply creating such a directory seems like a good thing to
have in general, and once we have it we can use the subshell trick, or
just "set -f" I suppose and use the scratch dir for other stuff.

I am a bit wary of this being our first ever use of "set -f", but maybe
it's sufficiently portable.

> Whatever the expansion mechanism, I do think it's worth having callers
> quote "$GIT_SKIP_TESTS" and then performing the expansion within
> match_pattern_list. Then the nasty mechanics are all in that one place.

I think it's rather clean to not quote it, i.e. to have the loop get a
list of item and then things to match, it would also make it easier to
e.g. port it to a native C program.
