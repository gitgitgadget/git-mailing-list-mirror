Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62AD4C433DF
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 05:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB81F22282
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 05:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RN0AH/uU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391703AbgJTFjI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Oct 2020 01:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730259AbgJTFjI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Oct 2020 01:39:08 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39197C0613CE
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 22:39:07 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id v123so174191ooa.5
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 22:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hFirvvto5D/0h3aeYO5/1wszmJe7+vxB2ru/94va2zw=;
        b=RN0AH/uUJ3bbZNNNXfb2l9eVoN/8k2jgz3A7fVLfKNYoBxeW9TLJRAgkGWq06vWPG+
         E/BRusnE+9NFgSO4+WzFZyn+FFh8WJNKw2oEE98PdWcns+/kK35jIhqeYNGtGG3gDjzN
         9Rig7Vyx79UOSpKaguS/cKEpYCPMyxn4pQipsfelUDyLNwyAnrNSVLFFOiW4o6UV+QqY
         4k5ZNGZgJ67j6t4+amrw5qluu67pJ24LXmv9qTf6IWi+a5VP57Sb1MDWHK24WTKLvbCT
         6ZLizApM4z0lmL0jczxUjoQbyzHXe+HLV5Wr8c9r9oXLBIZVBfwYcn+ccTL33VpcIHcy
         I+Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hFirvvto5D/0h3aeYO5/1wszmJe7+vxB2ru/94va2zw=;
        b=tRGljMJD7c09kvO07OA6Ggfs9hPM5ww8rIvmms22PkMYFGD01gEw3DZGCDvo2jcSRJ
         LnG+7p0c6qQgniozXlPNrk7lGBWM+OIKmpR54FrYb+p7SN04g+dFMBU4DQ1YNNaiO3WJ
         /xXiSqczoDuOKsYPGOmhK0nvNr2NqFyCuVL7f063MLLsJk+w1DmH1s92Z9i3E16XfQuk
         LpcVOR9FWeRZz7sA/2jNKqE+tts8oaGL3E4prUYcpgdZx2fzd+H13A1n1YWtDwDXBVTn
         aAyXdHO27HPcB1Ytxzrsrz3JNew2Tl3gGFxj+2vSwwJfiFwZQxrBHHSMPwLSduoGhIpe
         Q4xg==
X-Gm-Message-State: AOAM530U6NSfd8cOOKx2OJzdq2ME1B9RxtY5Sd2OdVk7ytuoyRMw/YTE
        l8zkx+ildGDRgrKTtvCY4I8ASir27BULmSEzwJBTEWnOBLY=
X-Google-Smtp-Source: ABdhPJwJlxIMoYID+C3O9AYrO/Gz0fvUs+YqPxmrisUHFTgF4wnHY1untALTZ1T5Ydl2wMsqWWN5P1wmOiAPsOGonHs=
X-Received: by 2002:a4a:e09a:: with SMTP id w26mr689249oos.18.1603172346597;
 Mon, 19 Oct 2020 22:39:06 -0700 (PDT)
MIME-Version: 1.0
References: <20201015175709.20121-1-charvi077@gmail.com> <20201017075455.9660-1-charvi077@gmail.com>
 <20201017075455.9660-5-charvi077@gmail.com> <cf26c039-0870-ced6-5347-ab3f24343105@gmail.com>
 <CAPSFM5ejRWUc2mCtqTPH4a6Q-WWUC4mQHU=bsHkjJOdG4kwW0g@mail.gmail.com>
 <3b501a3a-b675-3eb7-975a-cc9206f15057@gmail.com> <CAPSFM5fvBt+x840XOwzwPBvXK7_1qB-sb+_M3LoPuKv_P=VvDA@mail.gmail.com>
 <20201019202456.GC42778@nand.local>
In-Reply-To: <20201019202456.GC42778@nand.local>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Tue, 20 Oct 2020 11:08:55 +0530
Message-ID: <CAPSFM5fr4dY0tNdUrxdjhBQohX_sH0X-5m1VGHF-GAtpx0rQXA@mail.gmail.com>
Subject: Re: [PATCH v2 4/5][Outreachy] t7201: avoid using cd outside of subshells
To:     Taylor Blau <me@ttaylorr.com>
Cc:     phillip.wood@dunelm.org.uk, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 20 Oct 2020 at 01:55, Taylor Blau <me@ttaylorr.com> wrote:
>
> Hi Charvi,
>
> On Mon, Oct 19, 2020 at 10:54:57PM +0530, Charvi Mendiratta wrote:
> > Yes, thanks a lot Philip I understood the reason. I will do the corrections in
> > commit message and commit body as below :
> > t7201: using 'git -C' to avoid subshell
> >
> > Using 'git-C' instead of 'cd' inside of subshell, to avoid the extra process
> > of starting a new subshell
> >
> > Please confirm, if any other changes are required .
>
> Usually it never hurts to just send the patch, since any feedback that a
> reviewer has now is equally good even after you have sent a patch. Plus,
> it's easier to review the concrete patch you want applied, instead of a
> hypothetical of what you might send.
>

Yes, I completely agree with you . Its my fault, I will send it in the
patch and will
take care of not repeating this again .

> That said, a couple of notes:
>
>   - Your subject message is good. It is concise, to-the-point, and
>     accurately describes the change. Good.
>
>   - The body is similarly short, but could be rewritten to use the
>     imperative mood. But, it is redundant with the subject. The subject
>     says "we are using 'git -C' to avoid creating a subshell", and the
>     patch says exactly the same.
>
> ...So, you can do one of two things. Either you can abbreviate the
> subject, adding the additional detail in the patch message, or you could
> leave the subject as-is and delete the patch message entirely.
>
Thanks Taylor, I will do the changes as you mentioned and send it in the
next patch .

> Either would be fine with me, but certainly Phillip or others could
> chime in, too.
>
> Thanks,
> Taylor

Thanks and Regards,
Charvi
