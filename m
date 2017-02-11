Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3FA01FAF4
	for <e@80x24.org>; Sat, 11 Feb 2017 21:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750940AbdBKVIN (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Feb 2017 16:08:13 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35616 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750778AbdBKVIM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Feb 2017 16:08:12 -0500
Received: by mail-pg0-f67.google.com with SMTP id 204so5773787pge.2
        for <git@vger.kernel.org>; Sat, 11 Feb 2017 13:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=JqTDZj6aF88hQR3eW5ZDBF72muf3M+dBxhi5tPDap4s=;
        b=WR0HEChIWsvvlpXF7ApEUv11NwfHAn3TDsYnKmsylKGUm4WBaNSCzk9wzv1KJf75KH
         CND7WivpX9q5Tt9x1n4OQevsgKnhDLmqYYs88K26cLUTkEO4bc7MRLz7bBHeUq7bLzrb
         hamYGTq3HEtbr1VenzbEcIvj4A6jQLKU1FTk5FY34GqZkYggeTKhNq0jOdeNoqqLhi3u
         XKCQrqKhTTCZiw23m2is0o0RYDrH0nPxMKa3tLb/v0ExcJ86vVgrTaiarD5zOuemYCgq
         VCkgy8xNLLwmJCvHsXz7UJhIqOZ3uoQfhjYtcsGaXkGrXULBOTi1DAgFgbkgGkjb1Sjk
         c8GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=JqTDZj6aF88hQR3eW5ZDBF72muf3M+dBxhi5tPDap4s=;
        b=pR8IUaUYiFJByOCr4/8w45ykDgTVLOpKb/638tmYuPBHS0NruwLq9HTyuREMxUd+Uj
         F1sM7vbnJfga0ExdZbo1CONHTf/Uqs9FPxY5pJfow7O8yc7BfEAT7b+CBWA/IYd8oPQO
         1h88SSUqTs3eObvvZg3UWu8v2pWYC3Mm6Pw3jM/Bu4om7tA+/1s3ECOCeyFa5XIZaoLI
         d9EqCy9tqLwtB/OaOLNAWeU3wiOfBNmz/Oh9TdycJ8Q6tObTm6JM4ll8lpRDP09RQ5oF
         rI1dEG2gwGkss1WquAQoyBowTcv6VE3CL+N0pw7LkyDa+0GscMkn9+itmhgvpN7EHX6n
         ZuiQ==
X-Gm-Message-State: AMke39lRg3dWxmW4bnrEqLvwHvpvtCDEyVqDstOS0n7Jz+ihns9vXZPFPIPMAHQC+vg7Xw==
X-Received: by 10.98.92.4 with SMTP id q4mr17421202pfb.151.1486847291992;
        Sat, 11 Feb 2017 13:08:11 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:d4bf:82d:ab5d:5a31])
        by smtp.gmail.com with ESMTPSA id 64sm6256977pfq.112.2017.02.11.13.08.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 11 Feb 2017 13:08:10 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Siddharth Kannan <kannan.siddharth12@gmail.com>
Cc:     git@vger.kernel.org, Matthieu.Moy@imag.fr, pranit.bauva@gmail.com,
        peff@peff.net, pclouds@gmail.com, sandals@crustytoothpaste.ath.cx
Subject: Re: [PATCH 1/2 v3] revision.c: args starting with "-" might be a revision
References: <1486752926-12020-1-git-send-email-kannan.siddharth12@gmail.com>
        <1486752926-12020-2-git-send-email-kannan.siddharth12@gmail.com>
        <xmqqh941ippo.fsf@gitster.mtv.corp.google.com>
        <20170211075254.GA16053@ubuntu-512mb-blr1-01.localdomain>
Date:   Sat, 11 Feb 2017 13:08:09 -0800
In-Reply-To: <20170211075254.GA16053@ubuntu-512mb-blr1-01.localdomain>
        (Siddharth Kannan's message of "Sat, 11 Feb 2017 07:52:54 +0000")
Message-ID: <xmqqefz4h1vq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Siddharth Kannan <kannan.siddharth12@gmail.com> writes:

> On Fri, Feb 10, 2017 at 03:35:47PM -0800, Junio C Hamano wrote:
>
>> I am wondering if writing it like the following is easier to
>> understand.  I had a hard time figuring out what you are trying to
>> do, partly because "args" is quite a misnomer---implying "how many
>> arguments did we see" that is similar to opts that does mean "how
>> many options did handle_revision_opts() see?"
>
> Um, okay, I see that "args" is very confusing. Would it help if this variable
> was called "arg_not_rev"?

Not really.  If we absolutely need to have one variable that is
meant to escape the "if it begins with a dash" block and to affect
what comes next, I think the variable should mean "we know we saw a
revision and you do not have to call it again".  IOW the code that
needs to do "handle_rev_arg_called && arg_not_rev" is just being
silly.  At that point in the codeflow, I do not see why the code
needs to take two bits of information and combine them; the one that
sets these two variables should have done the work for it.

And that would make the if statement slightly easier to read
compared to the original.  I am however not suggesting to do that;
read on.

> Because the value that is returned from
> handle_revision_arg is 1 when it is not a revision, and 0 when it is a
> revision.

The function follows the convention to return 0 for success, -1 for
error/unexpected, by the way.

> Um, I am sorry, but I feel that decrementing left, and incrementing it again is
> also confusing.

Yes, but it is no more confusing than your original "left--".

If we want to make the flow of logic easier to follow, we need to
step back and view what the codepath _wants_ to do at the higher
level, which is:

 * If it is an option known to us, handle it and go to the next arg.

 * If it is an option that we do not understand, stuff it in
   argv[left++] and go to the next arg.

 * If it is a rev, handle it, and note that fact in got_rev_arg.

 * If it is not a rev and we haven't seen dashdash, verify that it
   and everything that follows it are pathnames (which is an inexact
   but a cheap way to avoid ambiguity), make all them the prune_data
   and conclude.

Because the second step currently is implemented by calling
handle_opt(), which not just tells if it is an option we understand
or not, but also mucks with argv[left++], you need to undo it once
you start making it possible for a valid "rev" to begin with a dash.
That is what your left-- was, and that is what "decrement and then
increment when it turns out it was an unknown option after all" is.

The first step to a saner flow _could_ be to stop passing the unkv
and unkc to handle_revision_opt() and instead make the caller
responsible for doing that.  That would express what your patch
wanted to do in the most natural way, i.e.

 * If it is an option known to us, handle it and go to the next arg.

 * If it is a rev, handle it, and note that fact in got_rev_arg
   (this change of order enables you to allow a rev that begins with
   a dash, which would have been misrecognised as a possible unknown
   option).

 * If it looks like an option (i.e. "begins with a dash"), then we
   already know that it is not something we understand, because the
   first step would have caught it already.  Stuff it in
   argv[left++] and go to the next arg.

 * If it is not a rev and we haven't seen dashdash, verify that it
   and everything that follows it are pathnames (which is an inexact
   but a cheap way to avoid ambiguity), make all them the prune_data
   and conclude.

Such a change to handle_revision_opt() unfortunately affects other
callers of the function, so it may not be worth it, but I think
"decrement and then increment, because this codepath wants to check
to see something that may ordinarily be clasified as an unknown
option if it is a rev" is an ugly workaround, just like your left--
was.  But I think the resulting code flow is much closer to the
above ideal.

