Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E9FC433F5
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 12:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbiDFMKG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 08:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbiDFMJz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 08:09:55 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551EC3ADAC7
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 00:51:25 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id k2so1575714edj.9
        for <git@vger.kernel.org>; Wed, 06 Apr 2022 00:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=zGJbZBSxjBGa0XuKhgp0ZUXUhFsOFKZ+ENsajbiT+kQ=;
        b=WGkPKOD5XiDxNhZSSfG+mF+TICTUCVUxPdokJfORouueWmhTCwgLTblxiYQgVkmhZD
         KZpbfQ9r6TdGgL5ymQF/W+Pk/z0gAb10HJQKXSYdvNd+ydRWRfF1dNFu/dL0mdLbeDqB
         DUHcgBN/bemwlPRHgos8dJBYOna/0nCa1Opxz68OBuNrB251i4mF97ObAAjWrJC6osVM
         VWfC0WsVFLT0qD1SyXtfRaOGdz6oC6/W7YbDmEntuIp6x9Qs5KGZoPWCVK1hVFci7Qwv
         0sWWfOtsk/hY7zXZr7F6GbheMwko+iKsuJucwbMIXYjKXBZVB0Ek1jm/sZfWLjVcaGY+
         IVaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=zGJbZBSxjBGa0XuKhgp0ZUXUhFsOFKZ+ENsajbiT+kQ=;
        b=T0wQ2VUShuCJgDztOAQ9u63O2X/FAxio1Y08f4ungpBc9FPlzjaQxMmjK+dsgb2dd4
         r0cwVl4xswUg6461ROafZV1+cmtvSn/fZstGr8rlIPfsC+sxhvXR4JDZBXJBPtyY2UoI
         L19UG4H7yhoVlzghxL7iognREsVUH3zr07fgdBQ31mc9C/rev3AV/qfb7kD44fhDLso9
         mkOe5vIpa5t6AntNBZYt1vGhYYoQY+/BC21GDUSo1TrahE3LrC9RfFa9Mwh/4Uu/cAty
         8E59PT7G7iVjaKCgr9/8snIunshAm/7M6o9aM95biLPkJFmo2wrAs1bqzDkJ8DchffE3
         5d/w==
X-Gm-Message-State: AOAM533fMmnO6SlHDLqfnnCt+abz+ZaDgoggd6wIJBPJSRj898MN6iz0
        kWb+de+dkG4RnCDSlASBbnQ=
X-Google-Smtp-Source: ABdhPJyXDw+FISXZzDPOKfTPGkPUYddGkHkHIyAYFZz7QZ76cx/gb1t3yPwWcek/mbYP23G3h0nAjw==
X-Received: by 2002:aa7:c789:0:b0:413:605d:8d17 with SMTP id n9-20020aa7c789000000b00413605d8d17mr7412766eds.100.1649231483851;
        Wed, 06 Apr 2022 00:51:23 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id o21-20020a170906289500b006d144662b24sm6255194ejd.152.2022.04.06.00.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 00:51:23 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nc0Rm-000YkY-P1;
        Wed, 06 Apr 2022 09:51:22 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Garrit Franke <garrit@slashdev.space>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 2/4] bisect.c: remove unnecessary include
Date:   Wed, 06 Apr 2022 09:50:27 +0200
References: <20220331194436.58005-1-garrit@slashdev.space>
 <20220405114505.24389-3-garrit@slashdev.space>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220405114505.24389-3-garrit@slashdev.space>
Message-ID: <220406.86a6cyfy4l.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 05 2022, Garrit Franke wrote:

> Remove include "hash-lookup.h".

Like your 3/4 it would be nice to have a "orphaned since xyz", or was it
never used etc?

In these cases unlike most such C changes the compiler isn't of much use
for validation (we might be including this implicitly), so an
explanation saying why is helpful.
