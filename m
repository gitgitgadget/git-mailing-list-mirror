Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD45DC433F5
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 16:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346152AbiDRQbM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 12:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346173AbiDRQbC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 12:31:02 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F332FFEE
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 09:28:08 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id y20so7618403eju.7
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 09:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bGx3fV/vc699HEHWcqd/iNcz7DEpuqpwEMFdDUIAVi8=;
        b=ZKAjTxbP9F/pXLmPN10NEiHcO6eTeX+5DV7tGzZrA8JTI7wu7StM0WwUnoDSMNoEOu
         bJ4fVrrPOFR+1AyvlPN9ktAXxdVNpsG/gpONCS7w2DvYB9aU4UfwhfKmALjfS5iGgEF9
         nnGvAWatQpy8xbpFLyH0dW37L4CX9vm83u3mn9wjYm1B6zjRLaVg8X4Y+8282I1tEjCt
         yMLuXYJWPYcPAsTQgvEHWGFf8soIYcic/Pu/ofSFnGOxF87fJlWszu8ONvn2EZz/K21S
         wUqSPXnRjSCdF3Y3INAAhLEllROOQgBPfvhtJsM/qId8quaRHqQD9VW1hY/VyxzkQCGD
         LkJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bGx3fV/vc699HEHWcqd/iNcz7DEpuqpwEMFdDUIAVi8=;
        b=zIaMU/PP8fQx+c/7MR0TiwmXx40qaOf25aWgi2JnxQKX44bvlTelAI8m3UkJHd3MUB
         1CI2FpQ0pGPyhKcrSOliJP7udfkNZ4XQqXPKL4OzdfRvmoV5qtokUim4i3Kl0fKjo+jC
         WtNJmscPX7R3BDWYM18GyQA+Dod/+sxNwc1+nNsHKn+7JYpwklpGhqKoI/lO2cUnIQcn
         8Ccwjwpt+nJa01my0rM88bDo7WMltDrOQ3KbwgDJeVgv1njsIZyeXMoOJS/i7uQspjCA
         jRllo6sFVs5ath1iNMTipzX5XT+oDidApsaz5GA24tfvQOKnbEyGLKE5651bgwVVCTO7
         6xYw==
X-Gm-Message-State: AOAM5322VfwE1ax2FS/CvxYwl7lyReqgXu4cy+Ux5+h/7Ki6kM1HVcd1
        3M0vq+iG5umN+PBRuT24TSRY827j4eL5a75/icBvkME1ec8=
X-Google-Smtp-Source: ABdhPJybk+vPYjQfi28HGjdEgGyDraQkfECjSC+NdR5U8WjxdWrZidDnEW2aeuqpfSvAInTGlwYb+QkVdP2BFxk/MBQ=
X-Received: by 2002:a17:906:7714:b0:6ba:8a6a:b464 with SMTP id
 q20-20020a170906771400b006ba8a6ab464mr9619424ejm.613.1650299286460; Mon, 18
 Apr 2022 09:28:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220413164336.101390-1-eantoranz@gmail.com> <xmqq4k2wap8g.fsf@gitster.g>
 <CAOc6etYvOhqQn3icWj3Ny1m+J_60h7aiqW-gvm=dQyDLgG=6NA@mail.gmail.com>
 <xmqqbkx2ccj4.fsf@gitster.g> <CAOc6etYwMtfytbw6iRfnJnsexJhe7UydVu0OFUbWP0byS9i=MQ@mail.gmail.com>
 <CABPp-BE=H-OcvGNJKm2zTvV3jEcUV0L=6W76ctpwOewZg56FKg@mail.gmail.com> <87lew226iw.fsf@osv.gnss.ru>
In-Reply-To: <87lew226iw.fsf@osv.gnss.ru>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 18 Apr 2022 09:27:54 -0700
Message-ID: <CABPp-BGQSN2iRWco4pQCVKA3AM6J0L0vyFMnYdrOgK0Pa26tWw@mail.gmail.com>
Subject: Re: [RFC] introducing git replay
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Edmundo Carmona Antoranz <eantoranz@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sergey,

On Mon, Apr 18, 2022 at 12:30 AM Sergey Organov <sorganov@gmail.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
[...]
> > Replaying merges is something I've put a little thought into, so allow
> > me to provide some pointers that may help.  Merges need special
> > handling for replaying, and in my opinion, doing either just a new
> > merge of the new trees (what rebase --rebase-merges does), or just
> > reusing existing trees (what you proposed to start this thread) are
> > both suboptimal, though the former is likely to just be annoying and
> > require potentially unnecessary user refixing,
>
> It silently drops user changes as well, and that's the worst thing about
> it, not annoyance.

Yes, I mentioned that later in the email, but omitted it in the
summary you highlight here just because the fixed-tree case was so
much more likely to do it.  Anyway, sorry for the inaccuracy in the
summarized version.

> > whereas the latter can silently discard changes or reintroduce
> > discarded changes and could be dangerous. More details on both of
> > these...
>
> Please consider yet another option:

I linked to where I had given another option.

> https://public-inbox.org/git/87r2oxe3o1.fsf@javad.com/
>
> that at least is safe with respect to user changes.

If you read the suggestion I made (which I'll reinclude here at [1]),
you'll note that I read the old thread you link to with both your and
Phillips' suggestions.  I dug into them with some examples, and came
to the conclusion that we needed something better, as I briefly
commented when proposing my suggested alternative (at [1]).  I
appreciate your suggestion and the time you put into it, but based on
my earlier investigation, I believe my suggestion would be a better
way of preserving user changes in merges and I'll be implementing it.
The fact that Martin (in this thread) independently came up with the
same basic idea and implemented it in jj (though he apparently has
some further tweaks around the object model) and it works well
suggests to me that the idea has some real world testing too that
gives me further confidence in the idea.

[1] https://lore.kernel.org/git/CABPp-BGW39_5r8Lbt3ymR+F_=hWJcf=2e7O75vFNJ=3CEL5s=g@mail.gmail.com/
