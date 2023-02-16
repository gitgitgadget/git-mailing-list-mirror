Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92204C636CC
	for <git@archiver.kernel.org>; Thu, 16 Feb 2023 06:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjBPGIn convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 16 Feb 2023 01:08:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjBPGIj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2023 01:08:39 -0500
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFF546096
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 22:08:38 -0800 (PST)
Received: by mail-pg1-f173.google.com with SMTP id 24so615386pgt.7
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 22:08:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676527718;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cwWiM1Za235L7ISQIq4RbAVruOBon7BfIswVq6Rii0k=;
        b=MvUEV3r/WJ+n7Cbu1SYDJ9QgE9cKYPWDXEP9uzWc/J3wRZKZDRh1007fv5JSasUyUW
         m9w+SmlJgG/pWGWtmmhwith6oEc2gMLBgPx329vggC6dcblHHIbNp/UqNAvyrj/7zbRj
         pBj31pOLeQfuxxeR4EZ+keZ0c9rSz9/Lj3Ljr6vbOtrMen4yVk2VogdeJNK91AC4TfS1
         lDintsV+ahqaP/BVaIWdvp22xjiEUlgzHfYSPYOb4NsoE5+9/FkqKK3/v1dFpdpGGWgw
         FkWURzw89ACE6qvYcTyCYWGFa3WD6jZfD+8d0GuCSCp/CyKUYYBJ7fOnVAOfqENKhWYs
         4psg==
X-Gm-Message-State: AO0yUKVwEMS3c8n04sgZJ+6KVwQlkWrAMPt5PFeMgGEKd5Gt8CNOCRXe
        aPfG3gJDIZWYPpuhbJ338o9htfeFFOJmO/Pt+q+nB5vex7k=
X-Google-Smtp-Source: AK7set9HU3dnsHLYcArlogn7r23Pts+P2ejlv2ReL8O6wvhI3vwyL+73a502sFvolr2KYJyJSEsU5OtFyvr9ejxLv40=
X-Received: by 2002:aa7:8eca:0:b0:5a8:c0e0:3b2 with SMTP id
 b10-20020aa78eca000000b005a8c0e003b2mr778377pfr.45.1676527717702; Wed, 15 Feb
 2023 22:08:37 -0800 (PST)
MIME-Version: 1.0
References: <CAGF3oAcCi+fG12j-1U0hcrWwkF5K_9WhOi6ZPHBzUUzfkrZDxA@mail.gmail.com>
 <Y+qbFN+PhHVuWT2T@coredump.intra.peff.net> <20230215162648.py7diaasrymezntl@tb-raspi4>
 <CAPig+cRmgGssbN=dDmeDeNeBJhcjvtzxg6O_ZNX5U9kWY0jfZg@mail.gmail.com> <20230215171924.6dutxlsi64h4upkg@tb-raspi4>
In-Reply-To: <20230215171924.6dutxlsi64h4upkg@tb-raspi4>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 16 Feb 2023 01:08:26 -0500
Message-ID: <CAPig+cSvP4cd0qqKpu2+-3rwPTgPu=o=Y7yPJdoz374usdEEJQ@mail.gmail.com>
Subject: Re: bug report: symbolic-ref --short command echos the wrong text
 while use Chinese language
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?B?5a2f5a2Q5piT?= <mengziyi540841@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 15, 2023 at 12:19 PM Torsten Bögershausen <tboegi@web.de> wrote:
> On Wed, Feb 15, 2023 at 11:37:11AM -0500, Eric Sunshine wrote:
> > On Wed, Feb 15, 2023 at 11:33 AM Torsten Bögershausen <tboegi@web.de> wrote:
> > > It would be helpful, to pipe the result into xxd:
> > > git symbolic-ref --short HEAD | xxd
> >
> >   $ git symbolic-ref --short HEAD | xxd
> >   00000000: e6b5 8be8 af95 2de5 8a0a                 ......-...
> >   $ LANG=C git symbolic-ref --short HEAD | xxd
> >   00000000: e6b5 8be8 af95 2de5 8aa0 2de5 a29e e58a  ......-...-.....
> >   00000010: a02d e58a a02d e5a2 9ee5 8aa0 0a         .-...-.......
>
> Interesting.
> I just saw that there are already fixes going on:
> Is the fix from Peff helping here ?

Peff's fix successfully sidesteps the problem on my machine.

(main) % git symbolic-ref --short HEAD
测试-?
(peff) % $(GIT)/bin-wrappers/git symbolic-ref --short HEAD
测试-加-增加-加-增加

> And what do you see on disk ?

I'm not sure what you mean by "on disk". Do you mean the output of `ls
.git/refs/heads/ | xxd` which I posted in [1]?

FWIW: I'm on High Sierra (10.13) using HFS+.

[1]: https://lore.kernel.org/git/CAPig+cQ9f0aW0TcP9A5WrKmYcQsEZvPOiPrgmzsy1frWkHd34w@mail.gmail.com/
