Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E032BEB8FAD
	for <git@archiver.kernel.org>; Wed,  6 Sep 2023 06:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233907AbjIFGsA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Sep 2023 02:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjIFGr7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2023 02:47:59 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3658BCFC
        for <git@vger.kernel.org>; Tue,  5 Sep 2023 23:47:56 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-500c63c9625so5592300e87.2
        for <git@vger.kernel.org>; Tue, 05 Sep 2023 23:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693982874; x=1694587674; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nUtrbcgHauDLLnn2YxEozcBNap9tE8UQqqSgSBugjZ8=;
        b=jPMgxMb6tTfEb5Ywn4kzoHCHLNU3cPrav0ST6oYL6J28mS48Deil22TSn4KKY+dw/p
         Q/XeNhQyqsFZ11lYtKghIPx90y2RbJZ7cUOY0eEdHgh+fQwDZ1EtVseP+nFRIYS7Z/w8
         L4/pilU8bcriiACEFRyiOhAjWatp4RQrdycSbSdzlVH+pmxXyKh7iIj7W/QgFD2YeCSF
         +jOnzoTjfWoWtv7d7ygwFCGEnVFbHArlAX19F7PJMcIYw58fO5Xejp2H5KqCttmmdTjI
         sbjDObokQ84uSFQlT0U/pii0mzdGfryRxz1amTSm/m3ri8IEm6AIeeiA4p68XmpMmLRT
         6B6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693982874; x=1694587674;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nUtrbcgHauDLLnn2YxEozcBNap9tE8UQqqSgSBugjZ8=;
        b=DUsHYQC86Gp6JzGIaXnaaPEpnMV68mwFD+kzSk8GEydhwwaW3ETmrRglTgE94MQ1/2
         vIwicgkuQuqtD0gXtLpVG1rDAVak4rrsaCZA4EKgVttKkDr+64W9lLgKGwhXCOG6cZlx
         VQAkrzQ29I4RZLv3M/RbeD/Jzg9Rq01WeNA/dW50LkeE85KlpaxRGxDh1mVQt//oGkiF
         tI1DsLQi3WQBeQZ/mO7IrmB0dFfLw4+Hh5cpBmk4duTnivNRNY6Bmb5KX1Rd/rYj/461
         +NMwnPnLwnlCyc+ZpJPW2tgP6MCbgwcVuUvVOuz8y+sABGl5A8znBEYPYUl/A59rCsK+
         DYAg==
X-Gm-Message-State: AOJu0YzY+YOCpGjl+K3bo1dOIlSxkh7mPu3/KeCbcUmcGANB/Uh9iFg6
        tGYAGkWxlop9LEF8Std9WZo=
X-Google-Smtp-Source: AGHT+IFRx5rhbttvTVP9q9NdY0qHzkIhNix6rt4o4rN1A8RHcTcno+H8jAcbpNE0kQ4iaX1q1gf2qg==
X-Received: by 2002:ac2:530b:0:b0:4fe:711:2931 with SMTP id c11-20020ac2530b000000b004fe07112931mr1466322lfh.22.1693982874165;
        Tue, 05 Sep 2023 23:47:54 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id x7-20020a19f607000000b004fe4833ca5csm2626299lfe.237.2023.09.05.23.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 23:47:53 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 1/1] doc/diff-options: fix link to generating patch section
References: <87zg20qzhg.fsf@osv.gnss.ru> <xmqq34zsqlr3.fsf@gitster.g>
Date:   Wed, 06 Sep 2023 09:47:53 +0300
In-Reply-To: <xmqq34zsqlr3.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        05 Sep 2023 15:49:04 -0700")
Message-ID: <87tts7pzl2.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> First, there is no need for conditional referencing, as all the files
>> that include "diff-options.txt" eventually include
>> "diff-generate-patch.txt" as well.
>
> Except for git-format-patch.txt which includes the former but not
> the latter.  But this is inside ifndef::git-format-patch[], so the
> above description being a bit imprecise does not cause any actual
> damage.
>
>     Documentation for all commands that want to describe the `-p`
>     option by including the "diff-options.txt" file also include the
>     "diff-generate-patch.txt" file, so an internal link would work
>     for all of them.
>
> or something like that, perhaps.

In fact I just realized that removing conditionals in fact *fixes* those
documents by providing proper link in them as well, so I'll think of
better description taking into account your observation as well, and
then will re-roll.

Thanks,
-- Sergey Organov
