Return-Path: <SRS0=XbPV=A4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12826C433DF
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 01:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E17162070E
	for <git@archiver.kernel.org>; Fri, 17 Jul 2020 01:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJyGA/SW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgGQBpi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jul 2020 21:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgGQBpi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jul 2020 21:45:38 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4ADAC061755
        for <git@vger.kernel.org>; Thu, 16 Jul 2020 18:45:37 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id b4so7461431qkn.11
        for <git@vger.kernel.org>; Thu, 16 Jul 2020 18:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GPZGi7Rzu4P26gxTuWaMswOxBiYUAyWQhGRG1W5P6rg=;
        b=SJyGA/SW/HFtap62FlxghLsoL/8JTtENqRTkdEdkPpCvdlO0hzDX/GphlitVkcTcmG
         jD2sS+/YuKikX8h2huzgwqYSDkv00gXZbUPOvsDPgaAWLyrO9cQRYPt8Q3bB9SwFFcnj
         gmEa3fPBU0lQxICnHJ+Xg8gyPWh92DvLa34MwrtP/YnUhW42Gm0jmY5zBZ5me/qvebND
         e5V9BglHUDFvhAiTEto70j2S8zh9unI7iAdYrvydLIJdecJ5JFTz3uyCKNBIKGF4KTvc
         WqN2nwg/5Dy9JKcaWO+FksOui8ISWse4MqJXHAyFeIukYOKFLm4WfZrCSzj9RDPDvC9k
         +iEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GPZGi7Rzu4P26gxTuWaMswOxBiYUAyWQhGRG1W5P6rg=;
        b=LqDj2cztHVRJ4dSWvH5oKSw0b3cKcOy1eqUeBEe320TCNwyZ3v0PYIhhbmcWq8u44y
         1CX8vBbYKlYspnBUssX/h1dqM+kzz42WC39Iwf3LzVtciw6CyV+vPh6y7iMUe97XPHOW
         aPfmCsICwLehcGlBbJ0QGWXWzL0LlbcjW7Gvke+BMkrtYyRDBWX7iUKZONByqO+ed3D+
         eQ0DupcmQUBRNV7SNGgPl0FGMpx1WixBRKhigYBA3oXGrxVJ52wqr5+ZeC/WCK9pT0NL
         hiyr7MeJCVRWGvCTJebfjuFoRcj8Q4oC7DJDzmEB9aekNnrpVxx09j6KzMNjdPX34DyO
         DWUg==
X-Gm-Message-State: AOAM5322EM+t3xif8fyckVGbARz0iOlZesSAcsidgFpkNzav6FdvEQxz
        daq9o+KSL14nnWuj3jF30lNTCtTmXA23RF5ZJMB9p07DnB2v4w==
X-Google-Smtp-Source: ABdhPJwGwUAtmosBphhVTFh67OF5CX8lY0F1tWqTohXhFz93NNMvpkf5uTDiDoJOw1RNik7oUML4X+gBqqEnvYyW/h8=
X-Received: by 2002:a37:cd4:: with SMTP id 203mr6915117qkm.490.1594950337124;
 Thu, 16 Jul 2020 18:45:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAAvDm6Z2HcQkyinCD4hKTnqGR3gcXodhoo0YKSnbB-vDJcn3MQ@mail.gmail.com>
 <CAPUEspg=4HJL8iiNrNp9Wr9sVj5Gw_PciSezHV5iJ1w-ymdzdw@mail.gmail.com>
 <CAAvDm6avvkXrU-Q8zu7C5WFqfCbf0DN=6cPMU-rOxgmdAh1Ebw@mail.gmail.com> <20200716153159.GA1061124@coredump.intra.peff.net>
In-Reply-To: <20200716153159.GA1061124@coredump.intra.peff.net>
From:   =?UTF-8?B?5a2Z5LiW6b6ZIHN1bnNoaWxvbmc=?= <sunshilong369@gmail.com>
Date:   Fri, 17 Jul 2020 09:45:26 +0800
Message-ID: <CAAvDm6Z6SA8rYYHaFT=APBSx0tM+5rHseP+fRLufgDxvEthsww@mail.gmail.com>
Subject: Re: How can I search git log with ceratin keyword but without the
 other keyword?
To:     Jeff King <peff@peff.net>
Cc:     Carlo Arenas <carenas@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you for your detailed explanation.
My understanding of this matter is at a different level with your help.

I wonder why this command doesn't work well.
I intend to find the comment with the keyword "12" but without "comments"
whereas the output is something like this:

git log --perl-regexp --all-match --grep=3D12 --grep '\b(?!comments\b)\w+'
commit f5b6c3e33bd2559d6976b1d589071a5928992601
Author: sunshilong <sunshilong369@gmail.com>
Date:   2020-04-12 23:00:29 +0800

    comments 2020.04.12 ng

Thank you for your attention to this matter.

On Thu, Jul 16, 2020 at 11:32 PM Jeff King <peff@peff.net> wrote:
>
> On Sat, Jul 11, 2020 at 01:48:04PM +0800, =E5=AD=99=E4=B8=96=E9=BE=99 sun=
shilong wrote:
>
> > Thank you for taking the time to respond to me.
> >
> > When I run the said shell command, this error reported:
> > # git log -P --all-match --grep '12' --grep '\b(?!t123\b)\w+'
> > fatal: unrecognized argument: -P
> >
> > The version of git which I am currently using is 2.7.4.
>
> Try replacing "-P" with "--perl-regexp"; the shorter name was added in
> v2.14.0. You'll also need a version of Git built with libpcre support.
> If it's not, you'll get a message like:
>
>   $ git log --perl-regexp --all-match --grep=3D12 --grep '\b(?!t123\b)\w+=
'
>   fatal: cannot use Perl-compatible regexes when not compiled with USE_LI=
BPCRE
>
> > One more question, could you please explain '\b(?!t123\b)\w+' in
> > more detail for me?
> > Or suggest some related documents for me to go through?
>
> The (?!...) block is a negative lookahead assertion in perl-compatible
> regular expressions. So it's looking for a word boundary (\b) _not_
> followed by t123.
>
> I'm not sure if that solves your original problem, though. It won't
> match "t123", but presumably there are other words in that commit
> message.
>
> A negative lookbehind like:
>
>   git log --perl-regexp --grep=3D'(?<!t)12'
>
> might work, if the distinction between "b12" and "t123" is important. Or
> if you care about "12" but not "123", then maybe just asking for a word
> boundary at the end would work:
>
>   --grep=3D'12\b'
>
> -Peff
