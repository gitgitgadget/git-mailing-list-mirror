Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745E8C47247
	for <git@archiver.kernel.org>; Tue,  5 May 2020 08:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EB7D20675
	for <git@archiver.kernel.org>; Tue,  5 May 2020 08:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKkV9laf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbgEEILL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 04:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725833AbgEEILL (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 5 May 2020 04:11:11 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8F7C061A0F
        for <git@vger.kernel.org>; Tue,  5 May 2020 01:11:09 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id q10so68488ile.0
        for <git@vger.kernel.org>; Tue, 05 May 2020 01:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IwdJxaVcrDS6vs2x2qh4sRkcxlyipOoxb7kTai58FVY=;
        b=LKkV9lafy7rpFt0FmzXNPoJGFUlzK1ZRm684SIdpu7eIHnhXarPxBMD7HnD3rWRM2K
         /PPt0R7ZMOEbXsYcES8HrjHUIylfVuJlnt4kxvrcHdD7AApcvDo09G6lx7busNfQWjAn
         NC9mbCU3ZtHPxSCcCqj/h9U9GBoPB6vjioqy1it1dm+dSBVDTw8qNFyJhMRnQiMOeFeW
         AOPqscVCVbOVq9G+XA2ho2suR6WwQZ1Z8+gtpRMjcvU1arseXUcqGxDAFMOZNgmtMdFU
         gPjSSD899y3f8k5RY/B75JqCrP07CL6Za6aC1XoCI8Vyoxin8qNpnUVKYDsCnNp8ZWLA
         afvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IwdJxaVcrDS6vs2x2qh4sRkcxlyipOoxb7kTai58FVY=;
        b=WhP4A255toQwIrUqB4821yGrydOWYF3dqSFKJy+OmBmNzkmA4j5hAlB3rAyOdHtdmN
         UXE6MgKJxkL55xlQplmWxzope206ZziBzumXAFrxcmnAwc2hX6zVtdglbEgHTy0SXxjI
         xLq7so1iTdFVq5lzwFQjDBWLAnKDns3Dn/579v4mrm8//fJEEQsI8RRdp0tpnXHwXeRX
         a7qAeXf5s4o1bt4wHfxwr4oTHRNPpI0xBxvU5Y/KwpcBE/hMPYfteryiCpUcqSBZqqGw
         iki5HMpVwSmHANRJit5QFx2EOYZUyGKg4OuCFD2aODEE0/IcN+qHcOvKh5G5hSsmVLhU
         Bh0g==
X-Gm-Message-State: AGi0PubexMM7Z+rGN+Xy8+8HBUqZJMHf6qmwrYjyNufL8GNRcHwpvA+D
        gQZcWJO1ilwbmVxcTN+Hc1SZ1G541yIKBh3udg==
X-Google-Smtp-Source: APiQypI3KA8Y3iv0mT6CJZka9imjY8tbR6UjH3uuIeIMlnudJPLnO3xj4/c+e+RbkraPtRBJRZwzrEnw2msNxgCtENo=
X-Received: by 2002:a92:ad09:: with SMTP id w9mr2536628ilh.177.1588666269001;
 Tue, 05 May 2020 01:11:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAEoQP9iY-0+=ETA0vrHL0HngccwtNA_3KX4WSSokJpOgJDGUeA@mail.gmail.com>
 <20200504055530.GA13290@konoha> <CAEoQP9hyMi=oj18atTJo+dR3ve_zzrLQoOja0CKAAVHei6rA0g@mail.gmail.com>
 <20200504120024.GA3372@konoha> <CAEoQP9gs-a1NanNpYiFQgTs0C+CeYhbD8rMjoFVat1ZSijNA2A@mail.gmail.com>
 <874ksvei1r.fsf@osv.gnss.ru> <CAEoQP9guAWg8E95Pi4MOih7z5rPg7OCB+_jZ6EMhJxpFsM3A1A@mail.gmail.com>
 <871rnz4eln.fsf@igel.home> <CAEoQP9jkP6KinqOM41zbJhV7+MbA742Xgit2ztK1OcJ78+YbdQ@mail.gmail.com>
 <87zhamiz3r.fsf@igel.home>
In-Reply-To: <87zhamiz3r.fsf@igel.home>
From:   =?UTF-8?B?RXdhIMWabGl3acWEc2th?= <kreska07@gmail.com>
Date:   Tue, 5 May 2020 10:10:58 +0200
Message-ID: <CAEoQP9jvpCnC0Ag=xZVSpCE_CgyddLooSGi35NcMQf=0se3BEw@mail.gmail.com>
Subject: Re: file is showing as modified even that it was never commited
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Sergey Organov <sorganov@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We probably don't understand each other. At least I don't get you.

I don't know what you think I want with them, but it's definitely not addin=
g.
And the problem is I would like to know what HAPPENED or why they are
displaying as they were added when at the same time it seems they
weren't (that was never my intention).

On Tue, 5 May 2020 at 10:07, Andreas Schwab <schwab@linux-m68k.org> wrote:
>
> On Mai 05 2020, Ewa =C5=9Aliwi=C5=84ska wrote:
>
> > That is not the problem now, I worry only about those "modified" files.
>
> Just git add them again.  Each time you git add a file, only the current
> content is staged.  If you modify it further, you need to git add it
> again if you want to commit the new contents.
>
> Andreas.
>
> --
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint =3D 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC=
1
> "And now for something completely different."
