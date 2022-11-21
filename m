Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E8DC433FE
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 01:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiKUBAJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Nov 2022 20:00:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiKUBAI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Nov 2022 20:00:08 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB88920BF5
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 17:00:07 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id l6so5043033ilq.3
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 17:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/VKwwl8sHoenqHfL97ReF80YghN+CAB/9+6MLq8R6VM=;
        b=Cx3HLhwPdtDSsOEG4oLWmuKVJI6TIHcK0sorAgrdnayS2sBcUnUZ59Vx595goyhs8Q
         swqwOn5FVwwzpy1W6tJWxV8zGfOW8pFyh+eMfLULGZLENHJfM6+gsAPsCtsrrG0OOCGa
         9ZLn9x/8J++Q2LxUAj1ZIeoNxzuRv/4r2aBgJwnfk9kyzUY1+a3G1Aa3Vg/tUgdnP4n1
         2SWOXwEl5O5+OMPQ80MF6wZ5IOhAjGG7tFZoCRFEVLvZCh4+C7LtqTMUT+AXY3gBbvjD
         C7G9fLZgyiWLJ0S6mzDDXBnZ1YtgC125S+qf2BjHyGdUe/QkNIIhp8MfRtRiQoMZsjmG
         PPoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/VKwwl8sHoenqHfL97ReF80YghN+CAB/9+6MLq8R6VM=;
        b=ggcXLj3KuFob6dFq4YahJatopmV9f3Ri5vQNMOW4EzqogwJ3SGJ5APcUMHB1ZWzG+C
         OgWMr4BHsptPGG6lakS3p3Xdn5Ro9zmEH7r4giF18v3ju0mumtwBEId4vbF+rnXWryOT
         IBtMBTeHDR/oJgKKrgCD7MPuNjPrYcJagj3FYBToa42GWWHBKaQVam7wul7qShsOAG9D
         JxGufxfzK6ENxrPMoCt0ioXLCcH7EMfO0fE51ECTnn8M0NavON8g73tLnSIj9BpVB70z
         NZ6ly4ExvQCQEjbtTaL0j/H48Rr9yQz6E2vqoxaDn5d9crLFLTsOfbuQH0coT0Ov+OaR
         2IRw==
X-Gm-Message-State: ANoB5pmsRSZn2Jlh1G/PoKy9mmYANJRBR8ZjOaXpInr2R9yZcIuJHSkN
        UDLIFYlinfaG9L7JCOfcm25afjId09tT6w==
X-Google-Smtp-Source: AA0mqf4qNMKjglsY4b4NEXGfHohf9gv/ZQMaM70kuROIzt3Om2E7qZi348gXy7XFGxgf073CuY6kwA==
X-Received: by 2002:a92:c80e:0:b0:300:e232:e0c3 with SMTP id v14-20020a92c80e000000b00300e232e0c3mr6708438iln.320.1668992407217;
        Sun, 20 Nov 2022 17:00:07 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a22-20020a027a16000000b00375664a365esm3688498jac.1.2022.11.20.17.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 17:00:06 -0800 (PST)
Date:   Sun, 20 Nov 2022 20:00:05 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2022, #04; Fri, 18)
Message-ID: <Y3rNlarjf8xcBUnA@nand.local>
References: <Y3g95OYdwzq2OP3z@nand.local>
 <35abf6a0-982c-42d3-78c8-0298b53e6faa@dunelm.org.uk>
 <on4s271q-21s5-onsp-ss70-863nr403760p@tzk.qr>
 <xmqq8rk5yvz8.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq8rk5yvz8.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 21, 2022 at 09:47:23AM +0900, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > Not only that. `ab/various-leak-fixes` still merges an older iteration:
> >
> > -- snip --
> > $ git range-diff ttaylorr/ab/various-leak-fixes~15^2...ttaylorr/pw/rebase-no-reflog-action
> > 1:  d6f756b0d66f ! 1:  d188a60d7228 sequencer: stop exporting GIT_REFLOG_ACTION
> >     @@ Commit message
> >          pass the reflog action around in a variable and use it to set
> >          GIT_REFLOG_ACTION in the child environment when running "git commit".
> >
> >     +    Within the sequencer GIT_REFLOG_ACTION is no longer set and is only read
> >     +    by sequencer_reflog_action(). It is still set by rebase before calling
> >     +    the sequencer, that will be addressed in the next commit. cherry-pick
> >     +    and revert are unaffected as they do not set GIT_REFLOG_ACTION before
> >     +    calling the sequencer.
> >     +
> >          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> >     +    Reviewed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> >          Signed-off-by: Taylor Blau <me@ttaylorr.com>
> >
> >       ## sequencer.c ##
> > 2:  be0a662f863c ! 2:  0e34efb31d89 rebase: stop exporting GIT_REFLOG_ACTION
> >     @@ Commit message
> >          reflog_action.
> >
> >          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> >     +    Reviewed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> >          Signed-off-by: Taylor Blau <me@ttaylorr.com>
> >
> >       ## builtin/rebase.c ##
> > -- snap --
> >
> > And that superseded iteration of `pw/rebase-no-reflog-action` _did_ hit
> > `next`.

> Thanks, all.

Indeed, thanks for catching, Johannes -- I could have sworn that I
rebuilt Ævar's topic when I got a new version of
pw/rebase-no-reflog-action, but apparently not. Sorry about that.

> So in short, we should
>
>  * revert the merge of ab/various-leak-fixes to 'next'
>
>  * rebuild ab/various-leak-fixes using the updated iteration of the
>    other topic
>
>  * merge rebuilt ab/various-leak-fixes to 'next'.

Yep, that will do the trick. Sorry for the extra juggling.

Thanks,
Taylor
