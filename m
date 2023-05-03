Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12AEC77B7F
	for <git@archiver.kernel.org>; Wed,  3 May 2023 17:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjECRgq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 13:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjECRgo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 13:36:44 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A18B1
        for <git@vger.kernel.org>; Wed,  3 May 2023 10:36:43 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1a5197f00e9so41321725ad.1
        for <git@vger.kernel.org>; Wed, 03 May 2023 10:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683135403; x=1685727403;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=mhlx8MuSPD1JAgCHZKzR9aFqNSJ9P07MArYHK5ABCx8=;
        b=ZyIUzU8vQMBjnE1goc+giPsIiBlpFzENQnH3iFlk2UEsdNxTBOqIWG6ExVtm3NWHI2
         yiXkmdE5i2wM62AuaoNNWq35syeYa520VipGZtf+x8kY/hd64zcVBHgCsvslIP1YlZ6v
         gHEmPOwtkHNURdUIZ36T6p9tg+3vU6zl3wenf0XWL71pG+Sc5OanzmtJysKmM6zjWx1m
         KXWmT2TSX5pZ1Qa6QEbuVVv6+7XR62UezXhV87aBm0bvYMdZDdyKeaVHbwkwWpTxABoa
         FnH/BFAjwkjFY8xlzdPo/idFvJyIKpqJbro6UdFmmqWsPpJboZ32cGOcpalZtjMpBcv0
         h0BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683135403; x=1685727403;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mhlx8MuSPD1JAgCHZKzR9aFqNSJ9P07MArYHK5ABCx8=;
        b=j02Wp52avF4xYRWv4rDu7K0cZMUa3X8m/0oeKTWHJ8vjz0tVLOyNZMlgkukggth+fY
         yDCA8zXk79LKmmlgrDeHGP7BClzkondXC5nynF8XsEiu5Dw9Ci0TwjajHO+x9Ki4B527
         8NVU1WqfP34QJZAGG2L6Vav5oMV70gHZKMMu1ZQlb6mpiYrhbwSinip3kWiG/emF5dO5
         R/N/ORQsKOXBS/8+cyK5O2wpll0MdZK7fC9sI5dQzje7ZudRqCVAdpiejnEvPjEQt+SU
         7SpGWe6OOpRXILK4wAFb4riT6jGCb5FrZ2+CmJOkfIV1oSKJfwAzp+Ostt3rJPp5ozHP
         XhFA==
X-Gm-Message-State: AC+VfDwzKbqt070a4+0lkgzFu+1X90qNNKwo+dhAvn7bhid4X28pAkVR
        TeL+tD3TPwONtGWQaxqtWi0=
X-Google-Smtp-Source: ACHHUZ4eW3loRoCninJ2AwzAALjmX4zfC/G9paPt+Dmt+ZuPtbETkUxYKLvSbOgC9LL7SHEKiczUKQ==
X-Received: by 2002:a17:902:e810:b0:1a6:7ed0:147e with SMTP id u16-20020a170902e81000b001a67ed0147emr1094860plg.33.1683135403145;
        Wed, 03 May 2023 10:36:43 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id t1-20020a1709028c8100b001a80d7c6954sm21888066plo.288.2023.05.03.10.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 10:36:42 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2023, #01; Tue, 2)
References: <xmqqcz3ixsas.fsf@gitster.g>
        <6451d97570a4a_2ac9f29445@chronos.notmuch>
X-Gnus-Delayed: Wed, 03 May 2023 20:45:05 -0700
Date:   Wed, 03 May 2023 10:36:42 -0700
Message-ID: <xmqqa5yltiz9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> What's wrong with:
> https://lore.kernel.org/git/20230418011828.47851-1-felipe.contreras@gmail.com/

By itself there may not be.  And we have the "checkout" thing that
may have been made worse updated already on the 'master' front, so
this should be a good addition.

Thanks for pinging.  Queued on top of the more recent 'master'.
