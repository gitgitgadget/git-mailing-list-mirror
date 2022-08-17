Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB4FC2BB41
	for <git@archiver.kernel.org>; Wed, 17 Aug 2022 19:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241452AbiHQTZM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Aug 2022 15:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241196AbiHQTZJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Aug 2022 15:25:09 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052FA5F55
        for <git@vger.kernel.org>; Wed, 17 Aug 2022 12:25:09 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id a15so10698167qko.4
        for <git@vger.kernel.org>; Wed, 17 Aug 2022 12:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=s/fLeppeRrNl0jBATLK1FUP5ZeILiHfVvWqbvH74h3o=;
        b=oI9bYAysv+Xy/531zTqdE+kERRJEa6eCgCgR8w/q6gbVqQe72W0Y3SJpbPH+gQl1yF
         qSPUhkUgAR7PGK7VJ+gS2iu8RZfWSiBFPPcuurzmsLSBp3RwSg2vdbVOR2rZzRiRvReA
         rkWNjoyInJK5MqybI2xi2fZYW9MwaXd+sLaMwzJqN/DV9W+I/ktRif/Bj8a4/ZPCNo5i
         Au9GCU5ql9gGgr6F2Ha4UzAj2jY+sXpji5qRvaqBp8v7td/wiqLCWlihvRq8IUAl1S5f
         7//iX47nebLng/GKchyVkWECiyC2oCSk0LWe40/pbdUe1SfK4FPWAww/xyG/C6GNAhIB
         qNGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=s/fLeppeRrNl0jBATLK1FUP5ZeILiHfVvWqbvH74h3o=;
        b=KpGIJIDyOOB8/3Dzt45WlBAIl9IJQNJKbU9w4A/S5GoOb1juM5UOjTOqgHufv/C6gs
         kSazmgqRLDF7eXDTngFFxToZLQiGngOURCKhSHir22zQohKJ74o3b7PryBF/vfhNlqKq
         tcEcXoOfyJ6epTqMh6/W2Ikz44JSyXZ+B6f0QwiwX+P70R5uGgHNJG/jn7KyrrJRq4/I
         h+vhAcLxcnmv9OqlzTu3fee2ba+jNHOuQby/EBTHxzt+lu6ecafjJ4fgqzWreZz0qVuM
         GIcj6YG77MvVjkkt3rMA+KskbRQ3hY3ZRITXt0Q3Um5Adcio5SW9IfxK+y4pQfV5YHX1
         BXow==
X-Gm-Message-State: ACgBeo0BdTRxzd8DELq3VuiRm6uvgYrkzinybwx/fyax6x+DAhq88Hya
        RO7xpJ6jhDTDa/AM9Yga8rCdB/TXfAVol9oLszM=
X-Google-Smtp-Source: AA6agR6KmVxUUdt09TNBU9zsPYgBWNt89L6Tu064+k1Eig1TlgaWbegt+y0M/5z1RO+SJxoZ2/sGgZYBMp6LNiuKntA=
X-Received: by 2002:a37:638c:0:b0:6ba:fcfa:3690 with SMTP id
 x134-20020a37638c000000b006bafcfa3690mr14631446qkb.227.1660764308072; Wed, 17
 Aug 2022 12:25:08 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq5yityzcu.fsf@gitster.g> <p053rrpq-17q7-pnrs-3794-o04ro1445s5s@tzk.qr>
 <CABPp-BFAERLt_z-D=7gbXWVA9JgsqTP_2iW9BLe5S=YbsQ1V6w@mail.gmail.com> <xmqqtu6avgub.fsf@gitster.g>
In-Reply-To: <xmqqtu6avgub.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 17 Aug 2022 12:24:57 -0700
Message-ID: <CABPp-BHBOqnU7DSLkYPig=c6+emWGaE1vdzaPk0D90yQdof+6A@mail.gmail.com>
Subject: Re: js/bisect-in-c, was Re: What's cooking in git.git (Aug 2022, #05;
 Mon, 15)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 17, 2022 at 11:57 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> >> >  Expecting a (hopefully final) reroll.
> >> ...
> >
> > Could I vote for just merging it down, as-is?  As far as I can tell,
> > ... Further, such changes, while likely
> > desirable for consistency among Git commands, would likely move us
> > away from "faithful conversion from shell to C", and thus is likely
> > better to be done as a separate step on top of the existing series
> > anyway[4].
>
> If this were a faithful conversion, yes, merging it right now can be
> one good approach; add a faithful but not very C-like convesion
> first and then make it "more like C code" later.
>
> I however got an impression from the review discussion that it
> subtly changes behaviour (IIRC, one thing pointed out was that exit
> codes are now different from the original---there may or may not be
> others, but my impression was they were all minor like the "exit
> code" one).
>
> My "hopefully final" comment was not about a big rearchitecting
> change like use of parse-options API but about adjusting such minor
> behaviour diversion so that we can say "This may not be very C-like,
> and does not use much of our established API, but it is a fairly
> faithful bug-to-bug compatible translation.  Let's take it and make
> it more like C incrementally".  And of course, what was implied in
> "hopefully final" was that such adjustments would be tiny, trivial
> and can be done without much controversy.  After all, I was aware
> that the series was otherwise reviewed and received extensive
> comments (sorry, I forgot that it was by you).
>
> Thanks.

Ah, gotcha.  My impression was that the exit codes did match what the
previous shell code had done, but didn't match what other builtins
usually return.  Perhaps I misread those discussion comments.

Thanks for the clarification.
