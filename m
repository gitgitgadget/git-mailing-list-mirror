Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19281C6FD1D
	for <git@archiver.kernel.org>; Tue, 21 Mar 2023 18:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjCUS1N (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Mar 2023 14:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjCUS1J (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2023 14:27:09 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385792FCDE
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 11:27:09 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id o11so16972620ple.1
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 11:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679423228;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ngUNBRwaq+sBEj6ycKkMLElvbvMDr7muFn2LpLKAREA=;
        b=i3Xrl+6lM22zlhJTc5aMMSUYtl0DdNblLyuQbwKtj4OuSynOiz0a0kHwJIKTEnxyzT
         6/hIhsb0+OqwraFjGnHsWb/Yz7bwx2lw/xABq3SS/IyZxb+TyqdUInbbWxEjwyjOXiRR
         A7tJB2QlHdqRv8b45WbS0MJ+yRUiSFP2hMGgkX7W9/Zv0jSQVviMA4EmUdHhRkvRhZsY
         17K/iSBrzrWXyGNKK3/oq19ZpcPf0RyOhdnS23Nd5enWYqvC7K5458iWeua9h4BMWsTL
         SSK6m/DsD9cY45AEnta+saV5/kAM9hL6IhhfP3oNSjR2BXo3u4sQUjQiC8mRze9cBcMs
         l12A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679423228;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ngUNBRwaq+sBEj6ycKkMLElvbvMDr7muFn2LpLKAREA=;
        b=ODNJzAkz/lrBYr9bPrzv7kvJ8o6WJwMk/LFj5xe05fR2kmtVENjJESOa7+6DF0MrAZ
         PgB6Gicqx06Kaj9SR7NZE+SOFfC9M2JU1Q4Kh8648DrJ/jdMhoI/WqVa8+GOPevZsBhx
         E6PTlOk4NXXHPOlTZyrMrfe6m726CfYZW/3jMQum3ryxx1/mGdaduy1LkKsC2yJNgtjG
         Ll7bkjTpjrq58eiNTRl2LtL/qMwd4Uf9YCn1N/ABaxEpFaY4/hRfSjZbXwAkwcndowg2
         2yfLzSt/2SnoRxGGLoP2rDpIHxKEKannMD9LiqENP2WdOPx7CZPgSWbwz46t8Aqa/Ydy
         BQ+Q==
X-Gm-Message-State: AO0yUKUBy/bc0dMI2SoPGPK1fMV+b2vy002ZsHNeSYhiDpWT4AOY3Wip
        ZvZdjKvjhSr/fr9NccRRYIk=
X-Google-Smtp-Source: AK7set9TrMiJGKFj9e1FQ39RmEgRW0x5Dwoi4KTWusHptHHKLgScYJaF5PJIaPLvtih2zNhH5fBXkw==
X-Received: by 2002:a17:902:e807:b0:19e:76b7:c7d2 with SMTP id u7-20020a170902e80700b0019e76b7c7d2mr111494plg.26.1679423228730;
        Tue, 21 Mar 2023 11:27:08 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id m3-20020a170902bb8300b0019a7d58e595sm9049081pls.143.2023.03.21.11.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 11:27:08 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] doc: remove GNU troff workaround
References: <20230320190047.79836-1-felipe.contreras@gmail.com>
        <20230321173206.GC3119834@coredump.intra.peff.net>
        <xmqqcz52hu7n.fsf@gitster.g>
        <20230321181702.GI3119834@coredump.intra.peff.net>
Date:   Tue, 21 Mar 2023 11:27:08 -0700
In-Reply-To: <20230321181702.GI3119834@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 21 Mar 2023 14:17:02 -0400")
Message-ID: <xmqq4jqehseb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I could believe that some people are still stuck on 2016-era versions of
> dependencies, but yeah, I agree we can be a little more cavalier with
> documentation. Anyway, I think the right date really is 2010, as above.

Thanks.
