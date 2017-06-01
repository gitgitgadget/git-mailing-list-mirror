Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E83D120D0A
	for <e@80x24.org>; Thu,  1 Jun 2017 21:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751290AbdFAVNA (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 17:13:00 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:36456 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751105AbdFAVM7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 17:12:59 -0400
Received: by mail-io0-f173.google.com with SMTP id o12so44309811iod.3
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 14:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VfjXB+TREd+6+oDR0AjbAa48sZjlWzrnl9Sitoi3HxU=;
        b=GpDy52CdSLvbCLHcVpFCIg/EzFNbv/WagNFDE6t6iA/+b58HXlow/SlIfZ9NUlemAM
         Bgv7qxm248ba9cbEjR5D1daPUbX4gV0Tv4tgc2AZAHskb5Ov7zFHnW7QnCvJLAX8pvQp
         EPcsjiu9XL530hVE314O35ABr5qTPAeOhq/rT1Sqr8lcOL3G+0Q8h19xC7uOE9eoS+Er
         CDDKJZZ6d5RD0Za6Dd6Tj8+V364vvI+LLEP00DbZGxhNZd1usSj6SIlx8nAm5j3teGrV
         nNqAbe2vKK/v9f1e7Cg6twbNPwNdZpCJYDuY8NdylZN3Ae4XXqBS2L+AFyKv/iHpUuVW
         m4yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VfjXB+TREd+6+oDR0AjbAa48sZjlWzrnl9Sitoi3HxU=;
        b=G2VesXec59d7/72MNgKCyw2nQM9hd3KBwS/MS6NQBVKCmIVG4AvIkN29QFCM0NCr0k
         cpYMyaHHuUxMLliKAQs2L9OOe/mXgceYYj/6v13h4Dmb1c910nyeGcXcgWFvCEzY0rKY
         Y7A9fxPnoW6PccUOo/E1rVKio+nziaYEl78fkMs1X3U57ryjXGXXrtWmRTeARtYVpGc8
         oaQfl+SibTVZNHeWIadF4TVAnSOO1p247phkhY5TB/A2GF2aVteQvEwVcUuQeRe6nFFH
         wBgXX4OpVnVb/5sMzvjQopcgPwO0keBksGuJSgvcs6Kzdh9nPqDRggu7TSwLw6MgQdSq
         KjbA==
X-Gm-Message-State: AODbwcDops45xj/KEpxG7XpLEvCZSLchA8wP5AkXsvA5oRp4PYbuAoFZ
        jedMmV+GBqB5gwg3zEjJWVisHAnwyg==
X-Received: by 10.107.201.131 with SMTP id z125mr4252151iof.160.1496351578699;
 Thu, 01 Jun 2017 14:12:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Thu, 1 Jun 2017 14:12:37 -0700 (PDT)
In-Reply-To: <020b09ef-6035-285d-c033-8831564d8752@gmail.com>
References: <20170601155105.28356-1-benpeart@microsoft.com>
 <CACBZZX6+V6=gSs0pdN9WU+LPZv5qSAmE5u_f=NFYht2dT-hxEQ@mail.gmail.com> <020b09ef-6035-285d-c033-8831564d8752@gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Thu, 1 Jun 2017 23:12:37 +0200
Message-ID: <CACBZZX5g+t_7ViCggB32WBaARV1cz_dj3gCGEqjvjN3A-QJhiA@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] Fast git status via a file system watcher
To:     Ben Peart <peartben@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        David Turner <David.Turner@twosigma.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 1, 2017 at 11:06 PM, Ben Peart <peartben@gmail.com> wrote:
> On 6/1/2017 3:57 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>
>> On Thu, Jun 1, 2017 at 5:50 PM, Ben Peart <peartben@gmail.com> wrote:
>>>
>>> Changes from V3 include:
>>>   - update test script based on feedback
>>>   - update template hook proc with better post-processing code and make
>>>     it executable
>>
>>
>> Thanks, exciting stuff, do you have this pushed somewhere? I didn't
>> spot it it in your github repo. I had some issues applying this on top
>> of master @ 0339965c70, on 5/6 I got
>>
>
> I just pushed this to github at
> https://github.com/benpeart/git-for-windows/tree/fsmonitor
>
>>      $ git am /tmp/original_msg.txt
>>      Applying: fsmonitor: add documentation for the fsmonitor extension.
>>      error: patch failed: Documentation/githooks.txt:448
>>      error: Documentation/githooks.txt: patch does not apply
>>      Patch failed at 0001 fsmonitor: add documentation for the
>> fsmonitor extension.
>>      The copy of the patch that failed is found in:
>> .git/rebase-apply/patch
>>      When you have resolved this problem, run "git am --continue".
>>      If you prefer to skip this patch, run "git am --skip" instead.
>>      To restore the original branch and stop patching, run "git am
>> --abort".
>>
>
> Sorry, no idea on why this didn't work.  The patch was formatted with git
> format-patch but it's possible I've got something wrong.
No idea what's going on there, anyway I can grab it from your github
url, thanks!
>> But it worked with patch, weirdly enough:
>>
>>      $ patch -p1 </tmp/original_msg.txt
>>      (Stripping trailing CRs from patch; use --binary to disable.)
>>      patching file Documentation/config.txt
>>      Hunk #1 succeeded at 410 (offset 21 lines).
>>      (Stripping trailing CRs from patch; use --binary to disable.)
>>      patching file Documentation/githooks.txt
>>      Hunk #1 succeeded at 456 with fuzz 1 (offset 8 lines).
>>      (Stripping trailing CRs from patch; use --binary to disable.)
>>      patching file Documentation/technical/index-format.txt
>>
>> The 6/6 patch failed due to an unknown charset y, you have
>> "Content-Type: text/plain; charset=3Dy" in the header, worked after
>> manually munging it to "UTF-8", although it gave a warning...
>>
>
> The only thing I see different about this patch is the special characters=
 of
> your name in the sign-off line.  The call to git send-email prompted me
> about encoding - I wonder if my answer was incorrect?  Given you've proba=
bly
> dealt with your name in git patches before :), what should my answer be?

Hah! I didn't think that the "y" could be the result of "yes" in some
interactive dialog. It never prompts me when I send patches, it just
works, and with UTF-8 it seems to have been applied correctly.
