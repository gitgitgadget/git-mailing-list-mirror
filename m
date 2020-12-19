Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D9EC4361B
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 11:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1991223602
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 11:45:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgLSLkW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Dec 2020 06:40:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbgLSLkW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Dec 2020 06:40:22 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B946C0617B0
        for <git@vger.kernel.org>; Sat, 19 Dec 2020 03:39:42 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id b24so4550005otj.0
        for <git@vger.kernel.org>; Sat, 19 Dec 2020 03:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=hXigBsS8ev3JE3tiDdTIFrPYS3xo31qP4QvWeH/8z9E=;
        b=a5OT5JkHLzsBeIcuaXLrERUJlcRXesvhirMw5GOEsi9QGTR6jsbmM2a7q26eamxlOv
         M71gUVRdGJibETffR+AX3FcvuzxkKbhQwU30N6izLJ7HwyoywmGW/H6Vn8gfy3BtnOqM
         lOurpOmwSiNtS9WoavzOQUjUqbig57u6eM4eBKLwZtndQWsSmh4rzSreIvVGF06Xa8u1
         raEoYz1qHwiP+FTUya99h+mrb1lE50zZFeAkxULUdsoBYnKM67TaurmfYVRSpkfg4xcj
         RzKyhmpmIt9A8CIlkggDoCLBWcRFJQ96p/EfnqCfVTUVZo8I2B3eFfxUDV91MtNhQcSW
         SUCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=hXigBsS8ev3JE3tiDdTIFrPYS3xo31qP4QvWeH/8z9E=;
        b=cw4uXuTwaiiFyifY1BYIuudlFb4dKbaNPSvgoVwRF38n6DUixJW1SWLtkmI7UUXb1C
         QKIjho31xYIq003N+tQrtXHCmGcBJgQJ/JxKTj2JU/pVO8t5zMkDARCvYwHonXliajA1
         Vzs3iWiwt+5pusaOH0ApSkomVKFu5/MoHbdkeOcIqgfp+QnGJjWfo8NUDupCl+7mpO6Z
         vPl3yGHlFdOjmnGMyrzFdcjJNXGybxJjt+p2ysaOuf5w91nmLfaBphVf4ret+8G+ZAw+
         Cio7DiBLLpXXhYw7Ckjqe1CtMrhn3GWrr8ARRBeQO3QjVHv8zrlE6wA7WTFqwJd2qWn0
         iAsA==
X-Gm-Message-State: AOAM530olcho7M24HDmLffnu6YuRnD0lOeY37fo5SoLabr54ZY1junZG
        VLa7h0/vS8TTqEqq8vDjBCA=
X-Google-Smtp-Source: ABdhPJxp8A3/VGWzE6JAVyD+4tWh0cxhIiAku0nuLgf72ASGlqgH9x6ubjEkeeF5OBTblTrNvb6BvQ==
X-Received: by 2002:a05:6830:1c62:: with SMTP id s2mr5996490otg.177.1608377980595;
        Sat, 19 Dec 2020 03:39:40 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id v207sm2371619oif.58.2020.12.19.03.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Dec 2020 03:39:39 -0800 (PST)
Date:   Sat, 19 Dec 2020 05:39:38 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Ed Avis <ed.avis@qmaw.com>, git <git@vger.kernel.org>,
        "Miriam R." <mirucam@gmail.com>
Message-ID: <5fdde67aa2e2e_1de0de208db@natae.notmuch>
In-Reply-To: <CAP8UFD3AHZppV2puere=zKyRjHhywCYQcO6q4yU7jJCfF0HZJg@mail.gmail.com>
References: <PH0PR11MB48875130A7DF30A7394DD3619DC30@PH0PR11MB4887.namprd11.prod.outlook.com>
 <5fdccc25255b7_1273af2086c@natae.notmuch>
 <CAP8UFD1XMA7y6qXXS8h2HZXTuC8nGVkxTiMG3ZA54XJJg=gAsQ@mail.gmail.com>
 <5fdce3a04a8b6_12eac7208b@natae.notmuch>
 <CAP8UFD3AHZppV2puere=zKyRjHhywCYQcO6q4yU7jJCfF0HZJg@mail.gmail.com>
Subject: Re: Feature request: 'git bisect run' option to redundantly check
 start and end commits
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder wrote:
> On Fri, Dec 18, 2020 at 6:15 PM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> >
> > Christian Couder wrote:
> > > On Fri, Dec 18, 2020 at 4:39 PM Felipe Contreras
> > > <felipe.contreras@gmail.com> wrote:
> > > > Here's a quick patch to implement such feature (it doesn't apply
> > > > directly, it's mostly for human eyes).
> > >
> > > There has been a lot of work over the years to port code from shell in
> > > git-bisect.sh to C in builtin/bisect--helper.c. So it would be nice,
> > > if you plan to implement this feature, if you could do it directly in
> > > builtin/bisect--helper.c.
> >
> > Yeah, I'm aware and I might be willing to do that--which probably would
> > require moving the whole of "bisect run" to C--if there was an
> > indication that such a patch would actually be merged.
> 
> I think it would likely be merged, as it would just be finishing the
> porting git bisect to C saga.

My experience tells me otherwise. We'll see.

-- 
Felipe Contreras
