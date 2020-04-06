Return-Path: <SRS0=cWmm=5W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537CFC2BA19
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 09:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 211D0206F5
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 09:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Li3yr9uD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgDFJqj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Apr 2020 05:46:39 -0400
Received: from mail-pj1-f47.google.com ([209.85.216.47]:36815 "EHLO
        mail-pj1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgDFJqj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Apr 2020 05:46:39 -0400
Received: by mail-pj1-f47.google.com with SMTP id nu11so6222494pjb.1
        for <git@vger.kernel.org>; Mon, 06 Apr 2020 02:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7navwiBHhGxRR/KUTojrJm0UqZ/MBb19p9C5J+upI9w=;
        b=Li3yr9uDYV70LM9vrulF28bAt4tITNsVf3kMn5C/5ijUqvnorLMmJAnyT6rpdrzZ2k
         hgUmbZSkDraLqaPKUr8PqsJQCDyJX/7n2GAFa75b/DfZUTrdemWyEKbFtLbN9myeJD7k
         W8xb73JeyZgNmSoJfwPA2GWdIQ8h8EJxE2ixfRy6Grt3yu//6lF27Z7Vi+/Qb1trXRfU
         ZLT7k1wm+Nn5Hei5vxtjW5uPzwMLMUpoT3ZPf6dnqDdC+vadLAHWE+2N1GBEbZy+cn2W
         5jzvcyeLnOpXubcMwVDq/G3lWTl2TBQ13ipYtjrbcGrm2wM+TWx+CcKAsugTQWjOXQ3A
         RpvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7navwiBHhGxRR/KUTojrJm0UqZ/MBb19p9C5J+upI9w=;
        b=HbtlAk5+snVw5i+sekqthpegljcuvnrCKQuEn/k8bcAwhbro3011qAuMu+kghj/S31
         4FJ/F/lwOnWN2ULdgRKpUxEIG2b2V/r8cMkFaxGW34LH/WDtIM/3trc5jWoaZTbWBvF/
         lKHq2tvaSiwotgb5CoXmliPlUJnNj9Xs5UaXUPgyDqna8Wqn+7qx4Z2D3dAkiJtx/pGW
         JuwW5duYcfp2Lg2z/UrjW3FVfMNLD6jxztghVvdflMC15ghF5p3ZyDfk3eJ8R39fuUSv
         yuNOa74EXtFG+xq0hZIzeI0I+tYa09ioAus0mF8pBJWTUEDDBEeepzIfAbeVjVUgBeSq
         8VsQ==
X-Gm-Message-State: AGi0PuYjR05PY4og0W6rd+DwQzbvLmdeSP8H3HLfb29YWE3tJ54P36KJ
        +vAIP3S1bEmx4jiZbbuz2UkMtP+pNbyPNKXZ7fw=
X-Google-Smtp-Source: APiQypIA90JrJIZue4HDjJ1DKD5urAJmn0HZZwcNU36Z9O96J1LfFQIdTOZCNxwtZyS1JFud1vMUt445Zy6AERz7hJg=
X-Received: by 2002:a17:90a:343:: with SMTP id 3mr21546691pjf.115.1586166396163;
 Mon, 06 Apr 2020 02:46:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200320223015.GA19579@SDF.ORG> <xmqq36a2bpxz.fsf@gitster.c.googlers.com>
 <20200320233528.GB19579@SDF.ORG> <nycvar.QRO.7.76.6.2003211135380.46@tvgsbejvaqbjf.bet>
 <20200321175612.GC19579@SDF.ORG> <nycvar.QRO.7.76.6.2003252008490.46@tvgsbejvaqbjf.bet>
 <20200326001821.GB8865@SDF.ORG> <nycvar.QRO.7.76.6.2003281510260.46@tvgsbejvaqbjf.bet>
 <20200328163024.GA26885@SDF.ORG> <nycvar.QRO.7.76.6.2004041417420.46@tvgsbejvaqbjf.bet>
 <20200404174116.GB11944@SDF.ORG>
In-Reply-To: <20200404174116.GB11944@SDF.ORG>
From:   Sebastien Bruckert <sbruckert.dev@gmail.com>
Date:   Mon, 6 Apr 2020 06:40:07 -0400
Message-ID: <CA+KXf2C0XytyNEAAdTOZAzw5YTQuv3PSjJ7RgyWqTj9MPp6BDQ@mail.gmail.com>
Subject: Re: Feature request: rebase -i inside of rebase -i
To:     George Spelvin <lkml@sdf.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

What is your problem actually ? You want to edit a commit before where
you are in a rebase ?

O --- A --- B --- C --- D
* You are in a middle of a rebase at commit C.
* You want to edit A without finishing all your actual rebase.

Is that right ?

Then, why making a whole new rebase for that operation ?

In this example, you are finally editing A with some sort of new
nested operation. This operation should not do anything else than
this. Like something atomical, you edit the commit / add a commit /
remove one, and that's all. End of the story. Back to the original
rebase, and back to commit C. If that "nested" operation  made
conflict with B, we can move the actual rebase to B to clean the mess
you made with the "nested" operation. But you are still in only one
rebase. If you abort, everything gets cleaned up.

I don't know if any of this is pertinent / understandable, but I hope
it gave a fresh view on that. You guys are maybe a bit too focused on
what to do in case of an abort of a nested rebase. However, we don't
actually know if a nested rebase is the best solution for this job.

My two cents
