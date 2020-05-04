Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805BAC3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 18:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CF2320752
	for <git@archiver.kernel.org>; Mon,  4 May 2020 18:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="guKs7ons"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgEDSjX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 14:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726404AbgEDSjW (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 May 2020 14:39:22 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CECAC061A0F
        for <git@vger.kernel.org>; Mon,  4 May 2020 11:39:22 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id s10so12235186iln.11
        for <git@vger.kernel.org>; Mon, 04 May 2020 11:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ySgovYACOPA4DuvGLXFlguB34hCroMkEmEwDtjRUMPk=;
        b=guKs7onsLVbNcMXab6B3cH/IhlfiK5Y5l+wEdbGNh+7aTLworZGlnDjkLy6hukq+cd
         8MG6983eYkXx+LH7Vx7QgPQa46z/s3b9ItX366KUn2Cvs1gVPQGhtWm52Z1X36oN3d2V
         JUuD4vnptUWBuhlm/vR2YyzgDy6w0WUcWq3pu+2NVHWTE09nfAIB1p9t729K85JS+9Le
         W4mU8dlj9dXRjXWlMF+Z+Ic3zVYrg+09e1O1AVta18Q8GWb+v+qybI4PTIy838lGeOkI
         q7105cH4VYcKIdRgP0Mwn7L62SdIKgH343xXnrBmHLLog76kCiJ9o+jlXUg5qoaxMI7h
         67Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ySgovYACOPA4DuvGLXFlguB34hCroMkEmEwDtjRUMPk=;
        b=r/jG4JSCt9JWyLSe/tBwJP0N8L3LW0jU/IlxAdfU7mfMATix08rg8FmPp8g/IpuFLN
         /Y/pFPptj951cAkJfxVNFOmxrqohnMF7csiYRpXllfPvdtP/jD+WwkBOZ/XT38W7T1oO
         YLDbCWreSe8f5vmBlpoh4k4M/XBUq7RlCTdo4eylqOCNlG52/B2ffZHpGO2ry6OtRFei
         v4FrMhfLgLpp33yTq364YxFpd51KJONMWolkY7BR4X0FUs7M1gA8gI1Tw6NKEJYaltWQ
         6cJ3Ku40r3cLB1ZDsF3je0eUFVQh41vm09fPqA5I6grh51qMO3bCIfmZ6LpwG7r2i0zw
         ZLlg==
X-Gm-Message-State: AGi0Pub2FtxRd3MMdYFMGiDnR6iX5/yXCMTSD9iT+nz4UfdXftjQCS+4
        yvU3v8oSpKlJkNqpss/rKbUhCUY6HAakYPSAIMzs2m+wsA==
X-Google-Smtp-Source: APiQypJVH1Gg2Srd1BPMvxXuNDvjoUiPaVg4qJAI2tSN2tw9VPr8lAU7wf9ap2zW+HQjjRvtQn7AECPgE23CchQJZMY=
X-Received: by 2002:a92:9c0a:: with SMTP id h10mr15634271ili.12.1588617561642;
 Mon, 04 May 2020 11:39:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAEoQP9iY-0+=ETA0vrHL0HngccwtNA_3KX4WSSokJpOgJDGUeA@mail.gmail.com>
 <20200504055530.GA13290@konoha> <CAEoQP9hyMi=oj18atTJo+dR3ve_zzrLQoOja0CKAAVHei6rA0g@mail.gmail.com>
 <20200504120024.GA3372@konoha> <CAEoQP9gs-a1NanNpYiFQgTs0C+CeYhbD8rMjoFVat1ZSijNA2A@mail.gmail.com>
 <874ksvei1r.fsf@osv.gnss.ru>
In-Reply-To: <874ksvei1r.fsf@osv.gnss.ru>
From:   =?UTF-8?B?RXdhIMWabGl3acWEc2th?= <kreska07@gmail.com>
Date:   Mon, 4 May 2020 20:39:10 +0200
Message-ID: <CAEoQP9guAWg8E95Pi4MOih7z5rPg7OCB+_jZ6EMhJxpFsM3A1A@mail.gmail.com>
Subject: Re: file is showing as modified even that it was never commited
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Shourya Shukla <shouryashukla.oo@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sergey,

Thanks for engaging here.

Actually, I gave some details in the first email, I'm not sure if they
were even noticed.

About asking second time: I emphasized this because I felt this part
was ignored and I didn't like it.

I wanted to describe problem more generally and gave you the commands.
But now I will paste the console full output as you demanded:

mac:lp3rater noelo$ git status

On branch master

Your branch is based on 'origin/master', but the upstream is gone.

  (use "git branch --unset-upstream" to fixup)


Changes to be committed:

  (use "git reset HEAD <file>..." to unstage)


new file:   .idea/.gitignore

new file:   .idea/compiler.xml

new file:   .idea/encodings.xml

new file:   .idea/jarRepositories.xml

new file:   .idea/libraries/Maven__commons_codec_commons_codec_1_11.xml

new file:   .idea/libraries/Maven__commons_io_commons_io_2_6.xml

new file:   .idea/libraries/Maven__commons_logging_commons_logging_1_2.xml

new file:   .idea/libraries/Maven__commons_net_commons_net_3_6.xml

new file:   .idea/libraries/Maven__net_sourceforge_htmlunit_htmlunit_2_39_1=
.xml

new file:   .idea/libraries/Maven__net_sourceforge_htmlunit_htmlunit_core_j=
s_2_39_0.xml

new file:   .idea/libraries/Maven__net_sourceforge_htmlunit_htmlunit_csspar=
ser_1_5_0.xml

new file:   .idea/libraries/Maven__net_sourceforge_htmlunit_neko_htmlunit_2=
_39_0.xml

new file:   .idea/libraries/Maven__org_apache_commons_commons_lang3_3_10.xm=
l

new file:   .idea/libraries/Maven__org_apache_commons_commons_text_1_8.xml

new file:   .idea/libraries/Maven__org_apache_httpcomponents_httpclient_4_5=
_12.xml

new file:   .idea/libraries/Maven__org_apache_httpcomponents_httpcore_4_4_1=
3.xml

new file:   .idea/libraries/Maven__org_apache_httpcomponents_httpmime_4_5_1=
2.xml

new file:   .idea/libraries/Maven__org_brotli_dec_0_1_2.xml

new file:   .idea/libraries/Maven__org_eclipse_jetty_jetty_client_9_4_27_v2=
0200227.xml

new file:   .idea/libraries/Maven__org_eclipse_jetty_jetty_http_9_4_27_v202=
00227.xml

new file:   .idea/libraries/Maven__org_eclipse_jetty_jetty_io_9_4_27_v20200=
227.xml

new file:   .idea/libraries/Maven__org_eclipse_jetty_jetty_util_9_4_27_v202=
00227.xml

new file:   .idea/libraries/Maven__org_eclipse_jetty_jetty_xml_9_4_27_v2020=
0227.xml

new file:   .idea/libraries/Maven__org_eclipse_jetty_websocket_websocket_ap=
i_9_4_27_v20200227.xml

new file:   .idea/libraries/Maven__org_eclipse_jetty_websocket_websocket_cl=
ient_9_4_27_v20200227.xml

new file:   .idea/libraries/Maven__org_eclipse_jetty_websocket_websocket_co=
mmon_9_4_27_v20200227.xml

new file:   .idea/libraries/Maven__xalan_serializer_2_7_2.xml

new file:   .idea/libraries/Maven__xalan_xalan_2_7_2.xml

new file:   .idea/libraries/Maven__xerces_xercesImpl_2_12_0.xml

new file:   .idea/libraries/Maven__xml_apis_xml_apis_1_4_01.xml

new file:   .idea/misc.xml

new file:   .idea/modules.xml

new file:   .idea/sonarlint/issuestore/2/2/22a598feccb13c958ecc8eff5c53a9a7=
f9470a72

new file:   .idea/sonarlint/issuestore/4/4/442292b8a7efeabbe4cc176709b833b1=
792140ec

new file:   .idea/sonarlint/issuestore/c/0/c02b58f69e810278d2d423bdee557628=
145ed943

new file:   .idea/sonarlint/issuestore/f/b/fb31951790c271e26d568f9ac5b7681e=
7f0804ec

new file:   .idea/sonarlint/issuestore/index.pb

new file:   .idea/vcs.xml


Changes not staged for commit:

  (use "git add <file>..." to update what will be committed)

  (use "git checkout -- <file>..." to discard changes in working directory)


modified:   .idea/sonarlint/issuestore/c/0/c02b58f69e810278d2d423bdee557628=
145ed943

modified:   .idea/sonarlint/issuestore/f/b/fb31951790c271e26d568f9ac5b7681e=
7f0804ec

modified:   .idea/sonarlint/issuestore/index.pb

modified:   src/main/java/Downloader.java

mac:lp3rater noelo$ git log

commit 50001426b28ed80433484f24831c160fcf15eec1 (HEAD -> master)

Author: Ewa =C5=9Aliwiska <kreska07@gmail.com>

Date:   Fri May 1 22:02:10 2020 +0200


    content of the main page displayed

mac:lp3rater noelo$ git show --pretty=3D"" --name-only 5000142

.gitignore

pom.xml

src/main/java/Application.java

src/main/java/Downloader.java

mac:lp3rater noelo$ git log -p
.idea/sonarlint/issuestore/c/0/c02b58f69e810278d2d423bdee557628145ed943

mac:lp3rater noelo$

Best regards
Ewa

On Mon, 4 May 2020 at 19:17, Sergey Organov <sorganov@gmail.com> wrote:
>
> Dear Ewa,
>
> Please see below.
>
> Ewa =C5=9Aliwi=C5=84ska <kreska07@gmail.com> writes:
>
> >> That actually was a solution to your problem, not a workaround.
>
> > Not really, because I would like to investigate what happened, not
> > just fix it. In that case I could as well recreate repository I
> > guess...
> >
> > I agree that I could add those files accidentally. But I'm really
> > disappointed in fact that you seem to ignore all the part where I
> > described in details how I checked this and why I think this is not
> > the case.
>
> Except you didn't give actual details. Please give exact commands you
> issued and exact answers you've got.
>
> For example:
>
> $ ls .test
> a  x
> $ git status
> On branch v4.0
> Your branch and 'origin/v4.0' have diverged,
> and have 2 and 29 different commits each, respectively.
>   (use "git pull" to merge the remote branch into yours)
>
> Changes not staged for commit:
>   (use "git add <file>..." to update what will be committed)
>   (use "git checkout -- <file>..." to discard changes in working director=
y)
>
>         modified:   .test/a
>
> no changes added to commit (use "git add" and/or "git commit -a")
> $ git log -- .test
> commit e1e7818f4120b5ebc622c8dbf1b257ea8a03530c
> Author: Sergey Organov <sorganov@gmail.com>
> Date:   Mon May 4 18:55:58 2020 +0300
>
>     Test
>
> $ git log -- .test/a
> commit e1e7818f4120b5ebc622c8dbf1b257ea8a03530c
> Author: Sergey Organov <sorganov@gmail.com>
> Date:   Mon May 4 18:55:58 2020 +0300
>
>     Test
> $ git log -- .test/x
> $
>
> > Could you please answer if there was something wrong with my checking?
>
> Nobody could tell unless you actually show us your checkings.
>
> > I'm asking second time.
>
> Thanks, we've noticed.
>
> -- Sergey
