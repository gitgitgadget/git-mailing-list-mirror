Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 934F0C54EBE
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 09:11:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234626AbjAIJLI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Jan 2023 04:11:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237080AbjAIJJd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2023 04:09:33 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76B61C93F
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 01:04:25 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id c7so7273105qtw.8
        for <git@vger.kernel.org>; Mon, 09 Jan 2023 01:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uyTIhOmsor0dBIWc29ws4f9HTiqwXbtcOHmoLvHFFtI=;
        b=LFaLcVsw0aWVQ/mWGgLZzytXthi0gS+cGWR9F6DZv11gZV2vioaREBUrUPdQclwJlt
         myzcGTLFJZBEdFGXfdbZ0Y1zoVNED32Ki6N8i+ReNEQTTKKVr2r42x2AMpna0jDvmCqy
         rFGEjt4OCtZPuMC1dxQQ7OBEBObfzRRdDP/imus1U9uxsfG5rRlPmhyhYhLZmGCZ//Y2
         OUWX9Fr9m/cEoC31ohgfo5aPaC7y20L83/h0qb3quZNzZfnUL0sM/mq9LNakZLYeJNwU
         v7W0vK5dcpZ5RVEHmq4sQC70+v7UwKN22M7J+XrZ+X10viXRbdQZ7uuqdhi8ap1nWDCf
         rAEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uyTIhOmsor0dBIWc29ws4f9HTiqwXbtcOHmoLvHFFtI=;
        b=wd/YeT6FqB9tLXcrpuGnkEURh+cENUBH6JGqul5aH39T87EeuI5w5skJPP+R+cp1YN
         PKx8FQwHLUeRvYjeOXfWZU/xwEITUaJM9samWxvu/CBDixPPm0kjXh5yrEBWFMtwekIU
         qDpxCWIMYNPSvnHm9JKCSzjSWbRQzVeBPRhvy4mDrd2peltrYsmRyhYPd9xDVn/w7n9M
         9dEZlIgKYw0HZIyj+PbTHm8wpNkbhL1y94JvOicBMEhkekrkf2/H7mzTVXvm8rBUMpa4
         ecBe9Z5UH+AXJ6oFaCZOdCM+4g/4E/9+EPlFKnMPyeEjyNRH5DUVvSkoEDSUughpW84V
         Fi6Q==
X-Gm-Message-State: AFqh2koFldOrCZga4kXaW+SOB+cb1Vhcwp5KNbs3xOCZjhtQjrag8D19
        LLOVF5Av4usVnjeu/M3vPlc1XcDgqr+TKt6KDK1VOujMRRo=
X-Google-Smtp-Source: AMrXdXsLGh254ONSROrH/jNLwCPwxdcQvbEqs+UUttN940oy8Z9ueggUtn6xf6nSxHyHGpv91GAAoe2bAKxyDwyZgzI=
X-Received: by 2002:ac8:7745:0:b0:3a7:e4d1:c76e with SMTP id
 g5-20020ac87745000000b003a7e4d1c76emr2236086qtu.505.1673255064639; Mon, 09
 Jan 2023 01:04:24 -0800 (PST)
MIME-Version: 1.0
References: <CANgJU+Vo3B=YuqgWVgiRMMiBwTFEh98O0LSJJ+ES6EM=MP4Cew@mail.gmail.com>
 <xmqqmt6tzrcx.fsf@gitster.g> <CANgJU+UeZJP=tBx7ALd8_X=b25RkAdQ1NkQpueSL-p+kpCO17Q@mail.gmail.com>
 <xmqqpmbowek7.fsf@gitster.g>
In-Reply-To: <xmqqpmbowek7.fsf@gitster.g>
From:   demerphq <demerphq@gmail.com>
Date:   Mon, 9 Jan 2023 10:04:13 +0100
Message-ID: <CANgJU+VsAZ6Dz05ZFRQfGLgti7WssdYqGaEYEQuACoCdN+nvew@mail.gmail.com>
Subject: Re: should git rev-parse -q --verify on a range produce output?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 9 Jan 2023 at 04:51, Junio C Hamano <gitster@pobox.com> wrote:
>
> demerphq <demerphq@gmail.com> writes:
>
> > Is this something you think should be fixed? I would give it a go if
> > there was some direction on what it should do in this case. Just error
> > early and produce no output?
>
> I do not mind if the error case gets changed to behave differently,
> as long as the updated behaviour is something everybody thinks an
> improvement over the current behaviour.  I do not offhand know what
> the "fixed" behaviour should be.
>
> I do not mind if nothing changed and documentation gets updated to
> reduce end-user confusion, either.

Ok, I'll wait a bit to see if someone can suggest a good alternative
behavior, and if nobody does ill write a doc patch.

Cheers!
Yves

-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
