Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B27C4361B
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 07:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC55823BDC
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 07:48:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbgLSHrY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Dec 2020 02:47:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbgLSHrY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Dec 2020 02:47:24 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DB9C0617B0
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 23:46:43 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id w1so6450577ejf.11
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 23:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fqi2Zi1jSYI1csHGArs4pM0gQDK/sAVj+dGbkFiYezc=;
        b=luefat+BZDyvKYSbeXnNhi0VLXeZG+bhIuAB2X+6vcoE0IMsIYTrTgmr3NcBCPkWda
         MtwFvLFNcxItXJY/YJceta27UCixLgEMll+/4DA/yLXE0kxxwYjIckzKWBy7NAI8b5wN
         z3aeH/UbdTEtqiCZWdJ1MlyaigeuOU5xLfHD+lPFRh2diWHNF5Nq9+9TiHlGK/WkBtrv
         WU2n56VUZgczb2Di5JmwYxsLZhb5aJKwSlZQun4lDrjVmyaeQGnPENETxyIBLtmIE4M3
         FSeNdhmrJjjeitfHdelPRK0JpWS6gc6GdpHZA2rIJuD1145BKmOZJ6T1Z6m8zTRxjzpM
         C4Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fqi2Zi1jSYI1csHGArs4pM0gQDK/sAVj+dGbkFiYezc=;
        b=rb21WHabIE3RnFH0nCHzuyeF2HUoX8R0NTDlGRcajFYA21TRNtiV6XOjgQrsipT5Xc
         3s+hy6Qnqw3IjCg+pcdDiy3SAmiAJFLEikKrS3QBHrp/3Ml09wpsj8xmeQqvkQvRGdya
         uFOy5mVpN5BQtR+PAv3rBfROENZZTluseUVjn2xw4CAeNZWW+uu/DSaS3lt6611dTzK1
         zluz+ydCR9ZNhSDRVaOhyQAYZLfDFiFwZDlRxCREemp6a9Z4LLrHkgzWnAT+NQhumI0V
         tr7I+KF3f7O0GUNLVrB2LrYkwOZlrGOhOJb2rIRPdYkyp4zO4JbAnleeORmnijrmKvPY
         mgFg==
X-Gm-Message-State: AOAM531+uN7QYFulcMucSum+mQqE2LfUIpRr1N0twpZO0OVEM9xHb6mf
        CQ+NWmR9+P4pETzjDtc7ldse9ahsqhlDpGbB+E8gjlacwoY0fg==
X-Google-Smtp-Source: ABdhPJxfovGPC4q8DTayYZbXOYyqJ/p5XGZetbOywQAFTnN8tbkS0awTkKiNzzzEtm8KlRAg3+GOUmNEx2kJtpXR4nA=
X-Received: by 2002:a17:906:d209:: with SMTP id w9mr6878131ejz.211.1608364002686;
 Fri, 18 Dec 2020 23:46:42 -0800 (PST)
MIME-Version: 1.0
References: <PH0PR11MB48875130A7DF30A7394DD3619DC30@PH0PR11MB4887.namprd11.prod.outlook.com>
 <5fdccc25255b7_1273af2086c@natae.notmuch> <CAP8UFD1XMA7y6qXXS8h2HZXTuC8nGVkxTiMG3ZA54XJJg=gAsQ@mail.gmail.com>
 <5fdce3a04a8b6_12eac7208b@natae.notmuch>
In-Reply-To: <5fdce3a04a8b6_12eac7208b@natae.notmuch>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 19 Dec 2020 08:46:31 +0100
Message-ID: <CAP8UFD3AHZppV2puere=zKyRjHhywCYQcO6q4yU7jJCfF0HZJg@mail.gmail.com>
Subject: Re: Feature request: 'git bisect run' option to redundantly check
 start and end commits
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Ed Avis <ed.avis@qmaw.com>, git <git@vger.kernel.org>,
        "Miriam R." <mirucam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 18, 2020 at 6:15 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> Christian Couder wrote:
> > On Fri, Dec 18, 2020 at 4:39 PM Felipe Contreras
> > <felipe.contreras@gmail.com> wrote:
> > > Here's a quick patch to implement such feature (it doesn't apply
> > > directly, it's mostly for human eyes).
> >
> > There has been a lot of work over the years to port code from shell in
> > git-bisect.sh to C in builtin/bisect--helper.c. So it would be nice,
> > if you plan to implement this feature, if you could do it directly in
> > builtin/bisect--helper.c.
>
> Yeah, I'm aware and I might be willing to do that--which probably would
> require moving the whole of "bisect run" to C--if there was an
> indication that such a patch would actually be merged.

I think it would likely be merged, as it would just be finishing the
porting git bisect to C saga.

There has been work on this by a number of GSoC students and Outreachy
interns. I am adding Miriam in Cc who is the last one to have been
working on this. I think her most current work is:

https://gitlab.com/mirucam/git/-/commits/git-bisect-work4.3.1/

which contains a commit to port bisect_run to C.

I am not sure if she was planning on continuing the port by sending
this to the mailing list. Hopefully she will reply to this thread.

Best,
Christian.
