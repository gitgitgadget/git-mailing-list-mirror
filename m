Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 178D71FAA8
	for <e@80x24.org>; Tue, 16 May 2017 16:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753137AbdEPQpk (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 12:45:40 -0400
Received: from mail-oi0-f49.google.com ([209.85.218.49]:35225 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752120AbdEPQpj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 12:45:39 -0400
Received: by mail-oi0-f49.google.com with SMTP id l18so32775108oig.2
        for <git@vger.kernel.org>; Tue, 16 May 2017 09:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=F9BItoQRka+yJHKCfeneZKUwHhL6KmWHrMonIPd07is=;
        b=BM8SGPqzhO5H5QMpGGo5B3rl0KGSs7s2pCNlkBdlLXcBjsnb9sz8qitdVn1jF6hM4C
         ssMCf2T8VlwbpSfZAJqWgX3oW/5toptmQ+B+/567Rxolg9qdT8Y0BFCfc8zEs7Kwi55D
         P2uCpFEu1/Oly6dSAdGRh9dCw6JeGxUfgGBzrmKrgojTJqyAyzigzHFbnFKEvrs2HjVH
         zOdNgUe6MCuCk7+iToyVvY8rkcu+2gTKR8uzaaJPG+77kFsJzodz+eyAcTI91klL6Y0c
         8QOXeRwfAqNTrlWrFpKukLD09YurbNNf3gtVBwnB7uFIg3lwgdxFa114uofmMr660Fq2
         wekA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=F9BItoQRka+yJHKCfeneZKUwHhL6KmWHrMonIPd07is=;
        b=oQ2QcUsKslBmwE8/lQDSz+jcrjxsZ1up7uXFuBj4Q/C+3R/JEMuTlXBUbBgYC+DCxu
         j33GtETRpkjv02i1OIwvlYwWhzKkhk3cw/cM0gy6J1F6783taGbNDK1RSgptY4FZ0Kfj
         j5Xxc445o7osUXmi1em9UnlMvhZ0BtMc1FQtEga+2m7BbyckrZiF+SKDQQnbM9wEpHMW
         E/4NHXIMzx3w7VKjQk7rbgNoNaznAjS28mu0T6eSUbMuJ18VWxpm63qWuxs9JQkAJxHj
         hU/KZIKmtx938AWNHiMhvlzC8MjmIlYEGGPTVdgMHHjN9V+8K/DbyHtpVmNLJQDswCmM
         kp5A==
X-Gm-Message-State: AODbwcAtRKHllp+5U8AajBeK6GTnG+zBC9JOjSxqk65UQj4tj5TZp700
        e9gTVATT6c73Gfl3szPyMbbjnkIDsg==
X-Received: by 10.202.56.137 with SMTP id f131mr2662369oia.42.1494953138510;
 Tue, 16 May 2017 09:45:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.54.53 with HTTP; Tue, 16 May 2017 09:45:38 -0700 (PDT)
In-Reply-To: <20170516035357.2wutcd2tyax4tjyn@sigill.intra.peff.net>
References: <CA+zRj8X3OoejQVhUHD9wvv60jpTEZy06qa0y7TtodfBa1q5bnA@mail.gmail.com>
 <20170516032503.bzkxmtqpmppxgi75@sigill.intra.peff.net> <xmqqr2zp31vg.fsf@gitster.mtv.corp.google.com>
 <20170516035357.2wutcd2tyax4tjyn@sigill.intra.peff.net>
From:   Eric Rannaud <eric.rannaud@gmail.com>
Date:   Tue, 16 May 2017 09:45:38 -0700
Message-ID: <CA+zRj8V94H4E1DPage1-YAVGAxHC_8oYiSoFrwHkg0QbUsJu0Q@mail.gmail.com>
Subject: Re: git rebase regression: cannot pass a shell expression directly to --exec
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeremy Serror <jeremy.serror@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 15, 2017 at 8:53 PM, Jeff King <peff@peff.net> wrote:
>> > So I suspect if you added an extraneous semi-colon, your case would work
>> > again (and that would confirm for us that this is indeed the problem).
>>
>> Wow, that's a brilliant analysis.
>
> If it's right. :) It's all theory at this point.
>
> My /bin/sh isn't bash, but I should be able to build with
> SHELL_PATH=/bin/bash to reproduce. But I can't:

Just to clarify if there was any doubt, the semicolon trick does
indeed work fine when bash is your shell.

It would be nice if it were consistent for all git commands that take
a <cmd> argument:

  foo() { echo foo; }
  export -f foo
  git bisect start master master^^
  git bisect run foo  # works
  git bisect run 'foo;'  # doesn't work
running foo;
/usr/lib/git-core/git-bisect: line 493: foo;: command not found

Also, what's a "simple command", exactly?

  foo() { echo foo; }
  export -f foo
  git rebase --exec foo master^^  # fails
  git rebase --exec 'foo;' master^^  # OK
  git rebase --exec 'foo 1' master^^  # OK

Not sure if this can be made easy to understand in the manpage.

Thanks,
Eric
