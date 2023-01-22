Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0F6C25B4E
	for <git@archiver.kernel.org>; Sun, 22 Jan 2023 19:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjAVT6J (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Jan 2023 14:58:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjAVT6I (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2023 14:58:08 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6A7C647
        for <git@vger.kernel.org>; Sun, 22 Jan 2023 11:58:07 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id k10-20020a17090a590a00b0022ba875a1a4so6560123pji.3
        for <git@vger.kernel.org>; Sun, 22 Jan 2023 11:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kDlyNPiBokcZarDVqnFoqP9tWRX3G2wgxdcLQuT/USk=;
        b=Qy0mU4eSbmvQwlbBiMLANk7WPIKhA6tDW8NSY/oZMrj/754sU1Hm8TaesNxLB/aBsc
         Vh6VavBEC59LmrS2+AUkouJUktLsPh1Ah07ydbVEyYMS6X8WaOs3Jd1NBAFPnLsVEBxs
         ZCAwksk3/scpn8YEbNOg/67XZBvi2kKexKJhV/uKY+zOinBUz1JWLXobfI+bb+J5yG92
         sAWHAimgdIdwXcCWsiD8WSzHA2w2iOmlPOkvoYKmuM5zM+vKM/X/Y0WQlA1I6rhZfPgl
         FWLF7w+J97fHKTLB/2lgQWzpldxymXZDCYAdnK9bkwcYGble1hVDuyZLS6Jpz3TTIVC2
         nGMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kDlyNPiBokcZarDVqnFoqP9tWRX3G2wgxdcLQuT/USk=;
        b=PxdHIQda7H3qz5Kf9JdM59FRzGRPFs11HMiPd0ll9VjhEOY+Ab5mHqsAvE3mjK8pfN
         gj/zUa/8EOeGVtbzxGhUnxcaO15v5gVL5ZyUCu8hNdm4VXlwYXYJly2F71uksKbJ4WX5
         ZvVw7mkoF/EBy1lbE8blMdB1vtwWRhUdKFjVqt2JTed0LBfpNs+ctWudpZ1ZdjrifSPh
         n2NU5QsG4EtZKuogmzQ305uLNdcfDA9lX7I/U+gpxwfnfn9EwRwN7cEi9b3rvSD16kmp
         6A/blL8Tg/ec1+y1hL8LvPdbD0zxQgZn0J7ZrwkHdY2eSD2tTQsObjgrGLXST3zzFzyP
         56ng==
X-Gm-Message-State: AFqh2kofjHF23tL9eQicJeBBp5Ys6joxSvqyafNydfFII5Vkqi1r7Cq6
        GI9MVYRfp6RwuitlLQmjxdrKxYVZuIs=
X-Google-Smtp-Source: AMrXdXu0fIBTsPFj91B8zjs80fnNvP1BqxsoXK4+/gyi9S0A8+QQ2bfdOmWj6vCh6/qlqaSzHKitCw==
X-Received: by 2002:a17:902:e5cd:b0:192:efc2:6578 with SMTP id u13-20020a170902e5cd00b00192efc26578mr33048223plf.41.1674417486604;
        Sun, 22 Jan 2023 11:58:06 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902ee5500b001868ed86a95sm1483051plo.174.2023.01.22.11.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jan 2023 11:58:06 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 1/3] branch: fix die_if_checked_out() when
 ignore_current_worktree
References: <eeb0c778-af0a-235c-f009-bca3abafdb15@gmail.com>
        <f7f45f54-9261-45ea-3399-8ba8dee6832b@gmail.com>
        <17f267b1-7f5e-2fb6-fb14-1c37ec355e65@gmail.com>
        <xmqqbkmruykg.fsf@gitster.g>
        <766b25e1-2d7a-7b5c-10a9-43e545a57dba@gmail.com>
Date:   Sun, 22 Jan 2023 11:58:05 -0800
Message-ID: <xmqqk01eqr3m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rubén Justo <rjusto@gmail.com> writes:

>> As the proposed log message explained, updating die_if_checked_out()
>> with this patch would fix a bug---can we demonstrate the existing
>> breakage and protect the fix from future breakages by adding a test
>> or two?
>
> 2/3 and 3/3, I think makes more sense on its own commit.

Hmph, how so?  Especially once you split 1/3 into the preliminary
refactoring and the real fix, the fix becomes fairly small and
clear.  And the tests to protect the fix would go best in the same
commit.

>> The above comment is about find_shared_symref() which iterates over
>> worktrees and find the one that uses the named symref.  Now the
>> comment appears to apply to is_shared_symref() which does not
>> iterate but takes one specific worktree instance.  Do their
>> differences necessitate some updates to the comment?
>
> I think the comment still makes sense as is for the new function, both the
> description and the recommendation.  I will review it again.

OK.  Thanks.

>> > +int is_shared_symref(const struct worktree *wt, const char *symref,
>> > +		     const char *target)
>> > +{
>> 
>> What this function does sound more like "is target in use in this
>> particular worktree by being pointed at by the symref?"  IOW, I do
>> not see where "shared" comes into its name from.
>> 
>> "HEAD" that is tentatively detached while bisecting or rebasing the
>> "target" branch is still considered to point at the "target", so
>> perhaps symref_points_at_target() or something?
>
> I tried to maintain the terms as much as possible.  I'll think about the name
> you suggest.

When you did not change a thing in such a way that it does not
change the relationship between that thing and other things, it
makes perfect sense to keep the same term to refer to the thing.
Otherwise, once the thing starts playing different roles in the
world, there may be a better word to refer to the updated and
improved thing.
