Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3B5C4332B
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 05:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A1A964E67
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 05:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbhCOFPA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 01:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbhCOFOp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 01:14:45 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9068BC061574
        for <git@vger.kernel.org>; Sun, 14 Mar 2021 22:14:44 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id u6so25993550oic.2
        for <git@vger.kernel.org>; Sun, 14 Mar 2021 22:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=it1Q0O7q4+UfiqqLjUivdWCzPz3ZDf5XMXfoUOZ1WHI=;
        b=j1HsfGR2HJgQmB/OOyTqtFemylt2W2ByiBcoTVT4jxE2Wjr5qZ5FgOUocE+tavgBIC
         bdlycfG9zX7M99byse17TRZvYgT76N4CIJ5Huq6vEXNBG6kbKZaiZsaVLx+X82JxXNPl
         45bXcJgg69q0ZDqz70UatxLVL1jGE5/FnVh/Iml2sPYBU14CxTVVInrGl8OxHfmvel9z
         5JDW3p55RMX3YveUU6zlJZe4OewOk49EHcMJyfMC/OHVkmUin6WNiPrCXqQNrTtpr5MM
         pHeukczo3f0hpZoYzIdnfhJUYYhCyb5dGfZGmsM6a3Tq5sJH/GOj0QhjFKEXEwy3wl9S
         FJkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=it1Q0O7q4+UfiqqLjUivdWCzPz3ZDf5XMXfoUOZ1WHI=;
        b=cStkZOl9ZI4lDFvHfFXGtQgkWI7knPg+w8H/eoY4S7s5zh/wxhsgzbP3pO7AUcSH09
         KzbgFyKML/rK4S6AMHcdL/M/F3DBoC4VFFFGaNDpvdVeAbpY7Q5mQPXrSW6TUnfO922s
         HxLeOYq1ZRsHd/nveESsR1dXI1c3PlJf45eLc9tifjS7xe7E9sF0tX73yEdKV28V5Gab
         Slt2qUTN+LIGvgrgE6VOxdPcwfsYS/z8svIukBK/KfvX5//FAxwYALAbDI3MH5cJ6Hcq
         6xSTtor0/rA6vjQLEK6RGyDUflJa/h2uuMvp6Xbz169ON65l9tiqM3AUz6IMyxxEP2dt
         O9pw==
X-Gm-Message-State: AOAM532HUEPMPulRvRG8DYJDTi7J8IbP5514FGV84N55skYoflVpOBj/
        FONjEN/7vUbno0iCcfXrxecSe++4tfp2T+QahAE=
X-Google-Smtp-Source: ABdhPJy++oYAPKn/Pkb7zsaqnnqtbezGhEKDJ8RfpaCsY82TVWoRtKjeIoL9FRWq+88rBtl36YrIE62wj4svZW9VXo4=
X-Received: by 2002:aca:af10:: with SMTP id y16mr17536975oie.120.1615785284064;
 Sun, 14 Mar 2021 22:14:44 -0700 (PDT)
MIME-Version: 1.0
References: <pull.901.v3.git.1615726978059.gitgitgadget@gmail.com>
 <pull.901.v4.git.1615737505834.gitgitgadget@gmail.com> <xmqqh7ld2syx.fsf@gitster.g>
 <CAOLTT8RNKFC_NzZXGvE4Zz+NmVHCUAn-jZFu-0Nm=7JAS0jBjA@mail.gmail.com> <xmqq8s6p2fkn.fsf@gitster.g>
In-Reply-To: <xmqq8s6p2fkn.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Mon, 15 Mar 2021 13:14:32 +0800
Message-ID: <CAOLTT8TFYZ1fTFv1LzbQgNs_hnV3jmYCEU5oL_GRUQRR=Q7UUg@mail.gmail.com>
Subject: Re: [PATCH v4] [GSOC] commit: add --trailer option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=8815=E6=97=
=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=8812:42=E5=86=99=E9=81=93=EF=BC=9A
>
> ZheNing Hu <adlternative@gmail.com> writes:
>
> > Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=8815=
=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8A=E5=8D=887:52=E5=86=99=E9=81=93=EF=BC=
=9A
> >> IOW this part would become ...
> >>
> >>         if (trailer_args.nr) {
> >>                 strvec_pushl(&run_trailer.args, "interpret-trailers",
> >>                              "--in-place", ...);
> >>                 strvec_pushv(&run_trailer.args, trailer_args.v);
> >>                 run_trailer.git_cmd =3D 1;
> >>                 run_command(&run_trailer);
> >>         }
> >>
> >> > +     } else
> >> > +             strvec_clear(&run_trailer.args);
> >>
> >> ... and there is no need to have "else" that won't need to do
> >> anything.
> >
> > Yes, but we also should clear "trailer_args" in "else" here, and check =
the
> > return value of the "run_command()" for clear "run_trailer.args".
>
> No.  If you introduce the separate strvec, the "else" clause runs
> only when trailer_args haven't got anything, so there is nothing to
> clear.
>
I admit I was wrong before. But this may be the right thing to do.
+       if (trailer_args.nr) {
+               strvec_pushl(&run_trailer.args, "interpret-trailers",
+                            "--in-place", "--where=3Dend",
git_path_commit_editmsg(), NULL);
+               strvec_pushv(&run_trailer.args, trailer_args.v);
+               run_trailer.git_cmd =3D 1;
+               if (run_command(&run_trailer))
+                       strvec_clear(&run_trailer.args);
+               strvec_clear(&trailer_args);
+       }
