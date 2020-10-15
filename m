Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C473CC433E7
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 08:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6763920BED
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 08:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N95EILtD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730431AbgJOIxf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 04:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgJOIxf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 04:53:35 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9090C061755
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 01:53:34 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id i1so2448875wro.1
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 01:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=H+RYlw/HHgTSF3MAj6s5rhIJYETCoBUjqoyaCQPYzgc=;
        b=N95EILtDdzIrAHSVB45zkSynrboF5nSvWf5kVL3lvkAZ52vpqOAnWWQKZoYjNBT5m/
         wpnarEey0ewPhic4M0kkN5/phDr2eWQtfcGUtjcSL00trenmt/KHvI9f5F9MSJ0saZqf
         R6R5qvF6fiiVxBSvrkoVFqn3BuC5tN65rLV+VbpfUz4jGI1Tv1zxbTqVH0ktKDQfDewI
         wLmIUJaQhCUV4cixlfYKefStDpglhTL+ciO6lHTcFoUVYFXS75TCDjDBNZ1RJ9taRANV
         fnt9HbGISz963jQwu7bdgopcbuZZoDO1g4xVB24H9gowe+ZbzFcwt9Al9peNdRT7DaW9
         w4xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=H+RYlw/HHgTSF3MAj6s5rhIJYETCoBUjqoyaCQPYzgc=;
        b=Tfp3HId3lPg+V4FSMCpz+UcY7H3yB6O7lw/B9F104+qMULlvQW1yyVD14Rbv7hEQGK
         3LwgnfD3loX2zmFAmgUwvu+ViKDlTyHb9r4SYTlr47nntPQqlcqW5f3SIXHtmUZG/cTS
         Pl9SMmh15nqIa7qFsdUJzLyGCqe7geLAwJM9IeTnXGrjcdS9ZvknM0s3R5YXrA8dhJHv
         uE1NZg/8jGTyQwxxEbCy4hNz7Xldna/PFFYZzf2rTO2poxzlYXEyMaGmm5W1auaMKfAL
         SLWVRqJ0sWNxTYstGN0I+9Q8i/FgkCzirECney3xEl3LJbpiMaWIaFtYxOje8yoLVUNv
         fTOg==
X-Gm-Message-State: AOAM531TfZMxurONWXFNzn+8jQOYT2l/D8bhmzZ2IDzzqDzfaaN1fJFP
        uyyZy/57TCEQuRTSS823HuV86fHFBeabes30A3E=
X-Google-Smtp-Source: ABdhPJxni/6H3mspyTdxy8pxnr/81t6x4rKuN6tVCkBGUlidxLDSpt/IGPgFjCMAPi70nXuOVuk7uaRdoFAtsZz6KNo=
X-Received: by 2002:adf:ff8e:: with SMTP id j14mr3206388wrr.255.1602752013563;
 Thu, 15 Oct 2020 01:53:33 -0700 (PDT)
MIME-Version: 1.0
References: <mailman.1.1602590401.25101.wireshark-dev@wireshark.org>
In-Reply-To: <mailman.1.1602590401.25101.wireshark-dev@wireshark.org>
From:   Amanda Shafack <shafack.likhene@gmail.com>
Date:   Thu, 15 Oct 2020 09:52:57 +0100
Message-ID: <CAGxm6oUcxLCqhN0+tSA37xsNUJbjcyj3ahraVdiwxnQn-7qC4g@mail.gmail.com>
Subject: Re: Wireshark-dev Digest, Vol 173, Issue 14
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org,
        Developer support list for Wireshark 
        <wireshark-dev@wireshark.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

I have completed the MyFirstContribution tutorial
(https://git-scm.com/docs/MyFirstContribution). You can find my work
in this repo (https://github.com/lkmandy/git/tree/psuh).

Also, regarding my initial starter contribution, I chose the
"micro-project" titled "Avoid pipes in git related commands in test
scripts" (source https://bit.ly/3iZQcT2).
Emily has approved the micro-project.

I plan to complete the micro-project and then move on to more research
on Git's HTTP protocol and other resources you've pointed out.

Let me know your thoughts on this, thanks.


On Tue, Oct 13, 2020 at 1:00 PM <wireshark-dev-request@wireshark.org> wrote=
:
>
> Send Wireshark-dev mailing list submissions to
>         wireshark-dev@wireshark.org
>
> To subscribe or unsubscribe via the World Wide Web, visit
>         https://www.wireshark.org/mailman/listinfo/wireshark-dev
> or, via email, send a message with subject or body 'help' to
>         wireshark-dev-request@wireshark.org
>
> You can reach the person managing the list at
>         wireshark-dev-owner@wireshark.org
>
> When replying, please edit your Subject line so it is more specific
> than "Re: Contents of Wireshark-dev digest..."
>
>
> Today's Topics:
>
>    1. lua decoder accessing info from layers above (Fulko Hew)
>    2. Re: lua decoder accessing info from layers above (John Thacker)
>    3. Re: lua decoder accessing info from layers above (Guy Harris)
>    4. Re: Introduction - An Outreachy 2020 Applicant (Jonathan Nieder)
>
>
> ----------------------------------------------------------------------
>
> Message: 1
> Date: Mon, 12 Oct 2020 19:59:46 -0400
> From: Fulko Hew <fulko.hew@gmail.com>
> To: Developer support list for Wireshark <wireshark-dev@wireshark.org>
> Subject: [Wireshark-dev] lua decoder accessing info from layers above
> Message-ID:
>         <CAGuV3hNXvRDUL02bmLxbkOLEgbOWQSPwj7sSne8CYCcgrNhPQg@mail.gmail.c=
om>
> Content-Type: text/plain; charset=3D"utf-8"
>
> I'm trying to update/improve someone else's decoder written in Lua.
> It's for a simple UDP (and TCP) based protocol.
> But I need to be able to get access to the upper layer
> to be able to decode it easily.
>
> Can someone provide an example of how to determine if the higher layer wa=
s
> UDP or TCP?
>
> Thanks
> Fulko
> -------------- next part --------------
> An HTML attachment was scrubbed...
> URL: <https://www.wireshark.org/lists/wireshark-dev/attachments/20201012/=
d1eaa52a/attachment.html>
>
> ------------------------------
>
> Message: 2
> Date: Mon, 12 Oct 2020 20:33:37 -0400
> From: John Thacker <johnthacker@gmail.com>
> To: Developer support list for Wireshark <wireshark-dev@wireshark.org>
> Subject: Re: [Wireshark-dev] lua decoder accessing info from layers
>         above
> Message-ID:
>         <CAP_QLgo5PYz79BXQvoQyiQGjZ-FqBVq__ybRg10xQ3DYd3KUQQ@mail.gmail.c=
om>
> Content-Type: text/plain; charset=3D"utf-8"
>
> On Mon, Oct 12, 2020, 8:00 PM Fulko Hew <fulko.hew@gmail.com> wrote:
>
> >
> > I'm trying to update/improve someone else's decoder written in Lua.
> > It's for a simple UDP (and TCP) based protocol.
> > But I need to be able to get access to the upper layer
> > to be able to decode it easily.
> >
> > Can someone provide an example of how to determine if the higher layer =
was
> > UDP or TCP?
> >
>
> If all you need to know is whether it was called from TCP or UDP, then a
> typical approach is to create slightly different dissector functions, one
> for TCP and one for UDP (they can then call a common function, setting a
> parameter) and register the TCP dissector with TCP and the UDP dissector
> with UDP. That approach for C dissectors is demonstrated, for example, he=
re:
>
> https://gitlab.com/wireshark/wireshark/-/blob/master/doc/README.heuristic
>
> And it's pretty similar for Lua dissectors using some of the examples
> linked from here:
>
> https://gitlab.com/wireshark/wireshark/-/wikis/Lua
>
> John Thacker
> -------------- next part --------------
> An HTML attachment was scrubbed...
> URL: <https://www.wireshark.org/lists/wireshark-dev/attachments/20201012/=
67707084/attachment.html>
>
> ------------------------------
>
> Message: 3
> Date: Mon, 12 Oct 2020 17:55:06 -0700
> From: Guy Harris <gharris@sonic.net>
> To: Developer support list for Wireshark <wireshark-dev@wireshark.org>
> Subject: Re: [Wireshark-dev] lua decoder accessing info from layers
>         above
> Message-ID: <93FB74E3-88D0-408F-883D-F0385A916EA0@sonic.net>
> Content-Type: text/plain;       charset=3Dus-ascii
>
> On Oct 12, 2020, at 5:33 PM, John Thacker <johnthacker@gmail.com> wrote:
>
> > If all you need to know is whether it was called from TCP or UDP, then =
a typical approach is to create slightly different dissector functions,
>
> ...or, in that particular case, slightly *less* different functions, give=
n that UDP provides a packet-based service (so that packet boundaries are p=
rovided for you, unless you have to send packets that don't fit in a UDP da=
tagram and add your own reassembly - but, even there, *fragment* boundaries=
 would probably be provided by UDP), while TCP provides a byte-stream servi=
ce (with *no* packet boundary information).
>
>
>
> ------------------------------
>
> Message: 4
> Date: Mon, 12 Oct 2020 20:10:56 -0700
> From: Jonathan Nieder <jrnieder@gmail.com>
> To: Developer support list for Wireshark <wireshark-dev@wireshark.org>
> Cc: Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.com
> Subject: Re: [Wireshark-dev] Introduction - An Outreachy 2020
>         Applicant
> Message-ID: <20201013031056.GC3814681@google.com>
> Content-Type: text/plain; charset=3Dus-ascii
>
> Richard Sharpe wrote:
> > Amanda Shafack wrote:
>
> >> Good day.
> >>
> >> I'm Amanda Shafack, an Outreachy 2020 applicant who wishes to
> >> contribute to the "Add Git protocol support to Wireshark" project.
> >>
> >> I have some experience coding in C and I hope to enhance
> >> my skill set by contributing to this project.
> >>
> >> In addition, I'm fascinated by network protocols and it's really
> >> exciting to get my hands around these concepts in a real-world
> >> project.
> >>
> >> I'm currently going through the project description and contribution
> >> guidelines.
> >
> > Welcome. There are many helpful people on the list.
> >
> > It would be useful if you can point us to a protocol description
> > document but that can wait until help is needed. It may be that all
> > the online resources are sufficient, but if not, do not hesitate to
> > use this list to ask questions.
>
> There's an overview of Git's HTTP protocol in the Pro Git book:
>
>   https://git-scm.com/book/en/v2/Git-Internals-Transfer-Protocols
>
> The official protocol spec in git.git (https://git.kernel.org/pub/scm/git=
/git.git)
> is split between a few files:
>
>   Documentation/technical/protocol-common.txt:
>     conventions for protocol docs
>
>   Documentation/technical/pack-protocol.txt:
>     overview of Git protocol
>
>   Documentation/technical/protocol-capabilities.txt:
>     optional capabilities
>
>   Documentation/technical/protocol-v2:
>     protocol v2, the new default (more about this is at
>     https://opensource.googleblog.com/2018/05/introducing-git-protocol-ve=
rsion-2.html)
>
>   Documentation/technical/http-protocol.txt:
>     how this works with http
>
>   Documentation/technical/pack-format.txt:
>     packed representation of Git objects (used both on disk and over
>     the wire)
>
> Amanda, if you have any questions, please don't hesitate to ask
> (#git-devel on IRC is the best place for that, and email works as
> well).  I am there around 15:00-24:00 UTC most days.  In addition to
> working on your initial starter contributions, we can start to put
> together a plan for the project.
>
> Richard, to set expectations: the internship period for accepted
> interns starts in December: https://www.outreachy.org/apply/project-selec=
tion/.
> Until then, potential interns are often not free full time, so we
> focus on smaller contributions that help get their feet wet in the
> codebase.
>
> Excited,
> Jonathan
>
>
> ------------------------------
>
> Subject: Digest Footer
>
> _______________________________________________
> Wireshark-dev mailing list
> Wireshark-dev@wireshark.org
> https://www.wireshark.org/mailman/listinfo/wireshark-dev
>
>
> ------------------------------
>
> End of Wireshark-dev Digest, Vol 173, Issue 14
> **********************************************



--=20

Cheers!

Amanda  Shafack
