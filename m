Return-Path: <SRS0=39iz=ZR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A09B4C432C0
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 06:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 707D420722
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 06:32:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyrl5M0S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbfKYGcl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 01:32:41 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33683 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbfKYGcl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 01:32:41 -0500
Received: by mail-qk1-f196.google.com with SMTP id c124so7318869qkg.0
        for <git@vger.kernel.org>; Sun, 24 Nov 2019 22:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZtyihdT8W88h3hcJi0sFl4EzIOpbIrGuZ98iBupv1XE=;
        b=kyrl5M0S2yQq/tfwwOFWk36KJ8O2r2dlLvU/OI7FnNe9uyNpf7z+b+tpDk+owdp2iZ
         4tl82yfeaQKYvaWCaXx15SbeA0k9e+NIxckEuTr1ICGEaoGfD8xru4gEgK2dMB/QaFLE
         aMgAOoFpfroM7gk2NwmerWEx/9Jz12f6BJr+kWeMnb3uokX2sVVopnRV+CqU4RhAZQUZ
         So4OtQ0nzlmByd81AqU1Iq+WvG9jSS88d52pI53u56IdXYqcd7HjFx26/3Op5jxNdV4y
         AcMtKuHmxR1ND55fmvkE3XmRRl6dT/7JJb2NOI2YcENLc3BqbIC6sS6gesILJwi5S2i6
         oGKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZtyihdT8W88h3hcJi0sFl4EzIOpbIrGuZ98iBupv1XE=;
        b=PiEpDVAvxJQImDVpCp52+DPm5W+jeFNcF9rdhKEgPagjfY0yBjkihRsoQ12Iz12yyh
         ZTTYIgX7yL+1TLiO0rW9dJfVi71fnQbU2+G6XrM/Qk+8WAuEZD75xZWp4NXCwk0faVbx
         DR0TKUFHshKxz5qvz2+b48guLbvnrwXNQOSqAaBOxy4wItXGmOvzF4inyxCYX0ILzmDp
         OLAglPa72bXreHvO5LAnvnJHNE9Ienu89esPuZyo2WJ6KHI9qXwuw8qmkHHTBGTMBTve
         jY1wo/dWvUEG1qoIUfOCBPsyRgu9BQqEDAyjjLQE51+FsJziUSalD8C6t64OKx96JmxM
         ga1g==
X-Gm-Message-State: APjAAAVp6ZmIKe7zzSghiuGXyMH97iPBlCqcs+hSH1xRdTwCazq5+oJw
        nOzYpnJI2F5u1joawOZ/Efb4c9+CxIiybMXH2qI=
X-Google-Smtp-Source: APXvYqxEz2lwgmsrfmUPz2vW/fbo0jvAZHV72I51eXRPipO5NwFDtf8ijIhftteJegE0k8S4z2EaXvqMS27Q+MLD6U0=
X-Received: by 2002:a37:67c5:: with SMTP id b188mr24121700qkc.199.1574663558473;
 Sun, 24 Nov 2019 22:32:38 -0800 (PST)
MIME-Version: 1.0
References: <pull.472.v2.git.1574582473.gitgitgadget@gmail.com>
 <pull.472.v3.git.1574655344.gitgitgadget@gmail.com> <8dcea6b399923e931625ef09d66661e93975b93a.1574655344.git.gitgitgadget@gmail.com>
 <xmqqmucky2wj.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqmucky2wj.fsf@gitster-ct.c.googlers.com>
From:   Manish Goregaokar <manishsmail@gmail.com>
Date:   Sun, 24 Nov 2019 22:32:20 -0800
Message-ID: <CACpkpxmFK61CgOS0M_2RV7BMT1Pk6Q2XdWYzdf5LVbAvd1rnXQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] submodule: fix 'submodule status' when called from
 a subdirectory
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Manish Goregaokar via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you!
-Manish Goregaokar

On Sun, Nov 24, 2019 at 8:51 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Manish Goregaokar via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > +             test_cmp ../expect ../actual &&
>
> Note that "test_cmp expect actual" highlights a breakage, when it
> finds one, by showing a diff that shows "what we saw is different
> from what we expected to see in this way".  So this invocation is
> good.
>
> > +             git -C ../submod checkout HEAD^ &&
> > +             git submodule status >../output &&
> > +             awk "{print \$1}" <../output >../actual2 &&
> > +             cd .. &&
> > +             git submodule status >output &&
> > +             awk "{print \$1}" <output >expect2 &&
> > +             test_cmp actual2 expect2 &&
>
> But this one is probably the other way around.  I'll fix this up
> while queuing, so if there is no other changes necessary, there is
> no need to resend the patch.
>
> > +             ! test_cmp actual actual2
>
> And the order of this one actually does not matter ;-)
>
> > +     )
> > +'
>
> Thanks.
