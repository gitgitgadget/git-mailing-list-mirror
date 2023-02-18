Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1C8C636CC
	for <git@archiver.kernel.org>; Sat, 18 Feb 2023 17:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjBRReP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Feb 2023 12:34:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjBRReO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Feb 2023 12:34:14 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261B61717E
        for <git@vger.kernel.org>; Sat, 18 Feb 2023 09:34:14 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id w3so1192198pjb.4
        for <git@vger.kernel.org>; Sat, 18 Feb 2023 09:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B7mBI+iX1x48vccJxMzFLo6NWwZiWwBQFunGere717Y=;
        b=NhhQ3P8QM/TPU9L3lEvcYegSLe2IPYu/NCHt8lE0nQPlyYFXNs54MqpZvEeUbunEQ7
         07z1Aol09+pk+Job42DxiOlM5Abgh/ka3ykthoZI5cDu8XTrz9U5j817qVZwXtRlfQ9G
         +1kOmQ7EP9MkwL6EFjiRAPTXJQ2r5v0UBlk/jnsOK7z2JRuPVsa0or85/9OPobknKNQU
         NxuIfzfbvP206zA+v3ATgrnDH2FRQxFzBjnouoxOFrq2W2C8Z/S8N9hbdsSYongmPIYx
         VvbMDVQeZDW/fC4LKuutQ1S6P/XSEHC6+usAgFMpp9awn7XoPEjkgwwu+IimYz078K9Y
         NNlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B7mBI+iX1x48vccJxMzFLo6NWwZiWwBQFunGere717Y=;
        b=CmBkl5O2q+qOn4jOQiO760xm/3LjociEz754rd06MRGUAJ8I+jyjnyHd3rkPWit5Wk
         v3v+qnkn/F9fs49e8/ug3DH0e79eOTKgh40ZpxNKVkjbpWXud4AV7zmzLQJhXsC2MAlU
         8Mt6EYKVPyW0Es1+CXpeUBRnY+Ug2mmirQvMbLPMwQQZH/8SnX6/YHo5N1QFbGN0e3zy
         TWJxjXUSwqybMA9Fa5sQ9qNGweh31eMjYdrVo0n7c+nXN14f0WiT5lowdF0cFuRQ0LYy
         6al2bPye273BPEqei9GgL+z60WllA3URyJ5/Ve61+9zT277zqv4LXKV2eTXWv9N7iIA6
         r7iA==
X-Gm-Message-State: AO0yUKXbwX5Vm4cd6qIukf2RlWx0A+2I6P0A2nxXTAf+ODnuQvy2MS04
        6bvtZissTC3iJE6eus+/PcU=
X-Google-Smtp-Source: AK7set+mwsSdvtcOjKKRs+0ZRJokiV/xsJx4XatbFGhHDWKqGwKLO9s5tPlQi/z0AriRRIMN2UqLzg==
X-Received: by 2002:a17:902:eb4d:b0:19a:9691:196d with SMTP id i13-20020a170902eb4d00b0019a9691196dmr863426pli.29.1676741653495;
        Sat, 18 Feb 2023 09:34:13 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902f7c200b0019608291564sm4950947plw.134.2023.02.18.09.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Feb 2023 09:34:12 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Brian Inglis <Brian.Inglis@Shaw.ca>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] format.attach: allow empty value to disable multi-part
 messages
References: <xmqqwn4fkgtq.fsf@gitster.g>
        <b2866322-5654-15d0-df83-a87926a01815@Shaw.ca>
Date:   Sat, 18 Feb 2023 09:34:12 -0800
In-Reply-To: <b2866322-5654-15d0-df83-a87926a01815@Shaw.ca> (Brian Inglis's
        message of "Sat, 18 Feb 2023 10:11:02 -0700")
Message-ID: <xmqqedqmkhd7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brian Inglis <Brian.Inglis@Shaw.ca> writes:

> Thanks Junio,
>
> I'll hope and watch for it to get added, and test if/when released.

That won't be very helpful as reviewing and testing is to prevent
nonsense patches to be added to the released version.  Once it is
released, testing becomes much less valuable, as it is too late to
catch nonsense bugs in the added code.

Thanks.
