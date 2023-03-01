Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA7DC7EE23
	for <git@archiver.kernel.org>; Wed,  1 Mar 2023 22:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjCAWPu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Mar 2023 17:15:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCAWPt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2023 17:15:49 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7A4211C6
        for <git@vger.kernel.org>; Wed,  1 Mar 2023 14:15:48 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id qa18-20020a17090b4fd200b0023750b675f5so798621pjb.3
        for <git@vger.kernel.org>; Wed, 01 Mar 2023 14:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=2k/dyB+omPdaUiNSgo6mpAWav/Fr2ZOnwbhWRSDja5k=;
        b=nhDTmUh5N2yk50htmWE5f6s7PPHqZL+0iF33tMQT88e8jhgji+4LkxhNzJthhIuPDn
         NKHn27VNhFzAvTtxsHF0+pnbAfmJgD+MkssID55GvzaufCZjM1PSEiiLNv9RlQH5HDl3
         wlfw/GBNqfQFYsE51PgLCLtPhNN7KEUXkOr3jxCL7HFiSl7S2fGX8jythyY3cWo3HkEc
         LwxVMUT8z+8dCvYwQYeOG83ZiCy8yfRyOpNuDTkikYwfaE6DN8R8blrmbwhqyCkcO/bo
         CZ2S67JKi1yJqMiF0scTiSUfQqYBChxu4YJbFwLjuKNs8bkmph2P83CmG+GsdUKkMGET
         x95A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2k/dyB+omPdaUiNSgo6mpAWav/Fr2ZOnwbhWRSDja5k=;
        b=JoyEUERrhMhAoUqmqcDzl5GxR+iSWj6qkW3gZ3ga+wt9LEopJ26CqbSWh3ym4ZjEE3
         O6eKkjK5pFh9+66iKmLYfqTYyhtz8ljNMTEMOfiQrfFDi0UnaAnS2+4AWG+uCUxUiJhe
         VoiFPV2lKWytGV9vZETpMkhBJER8ZQRuSt+8BZEtM4goVR8z5GRoowv7AHU3hP9oVlov
         47kogCNn3rL4ocsdPDg/vO2qEvo+npBG+17Ns13q5zjLE9Nb/RkJ6gSI+HWKN6jNhQ6t
         QNS/TR30GH94MkXGJwmXROFxArTEY4H3wEZx6kBR1X3mvTD5P6+nQXZB5dXlfGtmBGG7
         e7aA==
X-Gm-Message-State: AO0yUKVZKuWJ1DjcAIeGrrPshCTLzZfHRiun97B2DkVUwUSYoip+dsB0
        EXHMuavBJVem5vbZkMU+ELk=
X-Google-Smtp-Source: AK7set8vCldKpwsNRIbRNpVs9HReKHYMl3ycR3l8QjrnwyZabTlWwxK/1eMkBOfyFoviu7V+yKT78Q==
X-Received: by 2002:a17:903:2308:b0:19a:abb0:1e with SMTP id d8-20020a170903230800b0019aabb0001emr10075251plh.38.1677708947579;
        Wed, 01 Mar 2023 14:15:47 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id iy11-20020a170903130b00b0019c8feee025sm8949082plb.39.2023.03.01.14.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 14:15:47 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>
Subject: Re: What's cooking in git.git (Feb 2023, #01; Thu, 2)
References: <xmqqr0v7o0pp.fsf@gitster.g> <871qn5pyez.fsf@osv.gnss.ru>
        <xmqqedr28wwb.fsf@gitster.g> <87357ischs.fsf@osv.gnss.ru>
        <87wn402u3n.fsf@osv.gnss.ru>
Date:   Wed, 01 Mar 2023 14:15:46 -0800
Message-ID: <xmqq356om831.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

>>>>>  May want to discard.  Breaking compatibility does not seem worth it.
>>>>>  source: <20221217132955.108542-1-sorganov@gmail.com>
>>>> ...
> This is still marked as "probably won't merge" in the recent "what's
> cooking". Could it be merged, please?

I found the explanation given by Glen last time you mentioned the
topic much better written than anything I would write myself, and I
haven't seen any new input in the message I am responding to, so...

  https://lore.kernel.org/git/kl6lr0v2i0gn.fsf@chooglen-macbookpro.roam.corp.google.com/

Thanks.
