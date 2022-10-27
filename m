Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8D4FA3740
	for <git@archiver.kernel.org>; Thu, 27 Oct 2022 17:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235213AbiJ0Rrm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Oct 2022 13:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234721AbiJ0Rrk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2022 13:47:40 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2883010042F
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 10:47:40 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id w189so2339157pfw.4
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 10:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dxuxekKrhCPgNdbPKMcCoA4og2ZUVmHcpAn6f84eQzs=;
        b=XgWNYzD4kpl0znDPSL1M9R6bfoBFlBsN8JHILma6czZ6vcU5XXlP88j0BuRefF/Itq
         oavsMaw+FEDcX113uQTBjgjoPQqaphd3C+l6b2HE36+90qLMHQ48HB16tOaymIlbO91p
         SMY/jF/EGjWdMdueyzjmzKsFBq4vMEDtV7UMBQUFjp3ONkxvsn352gtHzZ0pUbMY+Xjk
         e9v9dqjz9Wer3y2xQ0vx4qtFzk1SiCN/r6Lo1sxi40V4zLa1sAYgX/xc5p+681AVuDgf
         VNzRJumcpP2X/xjyLOb+Vjlhe+rb1y+e2MOyFXtIxcd26UTIelo5utTkhivGD61kq1dI
         R59Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dxuxekKrhCPgNdbPKMcCoA4og2ZUVmHcpAn6f84eQzs=;
        b=nMvaNOcvt9TMUUjqgsdHHfO+dfesvv1kksDaYvXFBeOBceTdXMinerVfSNH/NgLeaI
         ceQ/cFODFhT6fGJRu2ue/SXocQ7QqvGORXRjYfXbH3R1EAYvz7od8tuvrU4sQZF6wgUM
         bPawleoaLUuY739UvAfKwkH8aSfVNOu75NxiMNKT3eGaBFMwpokiMe2IBNSXlIpooSlb
         9CmNqHo22LiimLAiLboXInSJ2HrS696RQmDsi/UTJVsZzKgvkszeiU3LE02onXrbb/UC
         hd0wfHUrjfHXvWav/CiWjQaV3x/auBZoqG4OWMVLx4hxd+zhsraXR3fVtslZGZlFsUXK
         cHBQ==
X-Gm-Message-State: ACrzQf3wuYsgfTum7wHMIEUENhDarM4dxmgOPTL32DXmqGtyYflt46Tj
        BmTdy3hesSQALcxeEtnj6SvGG0m6F1DMBdsONYUlz3cEjCg=
X-Google-Smtp-Source: AMsMyM7lo/8Y5F/1bgajkIDTxVzcFAM+krqsu5VBsyMwpRzdkAcBWL+clNzxRYudsx4Z0q55dwIMvs1SW6UhCuhqwtI=
X-Received: by 2002:a63:d0:0:b0:45b:b321:46d2 with SMTP id 199-20020a6300d0000000b0045bb32146d2mr43696543pga.250.1666892859590;
 Thu, 27 Oct 2022 10:47:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAB9Jk9Ay2PPEYKve3DXVmG__yZjO1mgh1MxaKA+wfsF0ZvKRqA@mail.gmail.com>
 <b0008377-2cb5-72ff-e94b-8182065b3436@iee.email> <CAB9Jk9BBddd5d0wKFB0eJw1OMMAQj88J9Bn1Yn1rbK_F1mEs1A@mail.gmail.com>
 <2ed22fa1-4d9d-e50a-18cf-048007272729@iee.email> <CAB9Jk9DPdVmmb2DPDKPm5FLGr-XJa5kNouCYmcjh534Y2z1rVQ@mail.gmail.com>
 <xmqqo7txmazv.fsf@gitster.g>
In-Reply-To: <xmqqo7txmazv.fsf@gitster.g>
From:   Angelo Borsotti <angelo.borsotti@gmail.com>
Date:   Thu, 27 Oct 2022 19:46:52 +0200
Message-ID: <CAB9Jk9BC1PVxuuNggZuDh1OMe3kdTvCzwkoo7Bkm35nRqAaL4g@mail.gmail.com>
Subject: Re: Git add documentation error
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Philip Oakley <philipoakley@iee.email>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

I have displayed the contents of the commits with the command you indicate,
but they still look much the same:

D:\gittest>git ls-tree -r --name-only 91ef45d
C1.java
C2.java
C3.java
C4.java
C5.java


D:\gittest>git ls-tree -r --name-only 8ec0c2f
C1.java
C2.java
C3.java
C4.java
C5.java

I thought that in the second one I would see only the changed file.

-Angelo

On Thu, 27 Oct 2022 at 19:28, Junio C Hamano <gitster@pobox.com> wrote:
>
> Angelo Borsotti <angelo.borsotti@gmail.com> writes:
>
> > Then I displayed the contents of both commits, and seen that it is pretty much
> > the same:
> >
> > D:\gittest>git show --pretty="" --name-only 91ef45d
> > C2.java
> >
> > D:\gittest>git show --pretty="" --name-only 8ec0c2f
> > C2.java
>
> You did not display the contents of these commits, though.  For each
> of these commits, you checked the _difference_ between it and its
> parent.
>
> In the previous sequence
>
> >> > I have tested this in the following way: I have two files: C1.java and C2.java
> >> >
> >> >     > git status
> >> >     On branch master
> >> >     nothing added to commit
> >> >     > ... edit C2.java
> >> >     > git status
> >> >     On branch master
> >> >     Changes not staged for commit:
> >> >     (use "git add <file>..." to update what will be committed)
> >> >     (use "git restore <file>..." to discard changes in working directory)
> >> >         modified:   C2.java
> >> >      > git add C1.java
> >> >      > git add C2.java
> >> >      > git commit -m "commit2"
> >> >      D:\gittest>git commit -m "commit1"
> >> >      [master 91ef45d] commit1
> >> >      1 file changed, 1 insertion(+), 1 deletion(-)
>
> 91ef45d, relative to its parent (i.e. the previous state before the
> commit was made), C2.java was modified.  C1.java was not.
>
> So, what you saw
>
> > D:\gittest>git show --pretty="" --name-only 91ef45d
> > C2.java
>
> is very much consistent with what you did.  And the above does not
> mean 91ef45d does not have C1.java.  If you want to "display" the
> contents of commit 91ef45d, you could
>
>         $ git ls-tree -r --name-only 91ef45d
>
> which lists all the contents in commit 91ef45d
>
> or
>
>         $ git diff --name-only $(git hash-object --stdin -t tree </dev/null) 91ef45d
>
> which compares all the contents in commit 91ef45d with a completely
> empty tree.
>
> In them, you'd see both C1 and C2, among other things that you did
> not modify in 91ef45d.
