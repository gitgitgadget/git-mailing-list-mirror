Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E3AC636D4
	for <git@archiver.kernel.org>; Thu, 16 Feb 2023 02:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjBPC6i (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Feb 2023 21:58:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjBPC6g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2023 21:58:36 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2749A23C7C
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 18:58:34 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id ja21so656927plb.13
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 18:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SoNjJF6fzGquu2U2FfRGJxH5OZik7+F/ryhYF4pSH+k=;
        b=BeRKcU0XV5BYHEfhHOKL1p6P17TQoYpsBjOZA9b4+rWXjU+89u0DjRuMntxi53iOt5
         2Ziz9mB8OSIBffvZSyhpbPqiECrR1OnOTkC2yha02jvAUXQ4S+FJh3Fq2jLcgQMiRdT+
         az+haGurspYKzLdDeGiBwngBiThptROnoB8uc/m2RbZAyvfUYPBfNWrqazYeesEpC8D/
         WsXK7UoMA6CWWO4zL7EwyrdW559ViSk6obq7kMQikhW1dBspUu14r8Qj6FmtelCeKqtf
         KF/WdNc2H+41hU3MPrmHMIFcptO9JkhKo8OgiKJ/f51FM4dXzwK/4S7CsZOuj5OHNHC/
         aXUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SoNjJF6fzGquu2U2FfRGJxH5OZik7+F/ryhYF4pSH+k=;
        b=TUMpkb2hiF8dOymIo51afqs/clnfhPwqibAYcEzAn+e6dKmQGBUjxm92r3b8KRwQOi
         oK1KgDfUOy91IUjtKVZ0cam/QuBeucAQbR5FBM6NBcGx5k0Rohu9qtkFDGQzqqosVEWW
         36lvf7EASAhsYxUZG7Q4bcj85pyvyt8CArrVvlK76vUrUlvFObEDyv4VpTQ/Gm+0Y4fP
         I3X/gl84+TqoPJD+E7W6hfX5Um03hQweTX+UN42Ru0PuxtJ2AqDaWb42BSvuCa2RbWNv
         J5Pj2J73hkwcY7C4cRJ3KVd/N3+puJfHvOyTM/TAxzqV7s8T7G9lga8a4FJy7XZsRKyU
         WFNQ==
X-Gm-Message-State: AO0yUKUrttEbfRjv2F70djlNplUMlqFuPzo7zwIco8yElb5H20nJ1wEf
        pjmeOzgW3QEwA2o90GFdyL0=
X-Google-Smtp-Source: AK7set/KgIwnFMdiwzbX4ZCPO9i/WxdC2h1qu1mrtiehmSbiuHzbSJVcIGzuN5vYbj+Gf3/qlwmU1A==
X-Received: by 2002:a17:90a:398c:b0:233:d91e:e64a with SMTP id z12-20020a17090a398c00b00233d91ee64amr5270097pjb.10.1676516313525;
        Wed, 15 Feb 2023 18:58:33 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id m8-20020a17090a668800b0022bbad75af4sm117884pjj.2.2023.02.15.18.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 18:58:33 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Rafael Dulfer <rafael@dulfer.be>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Rafael Dulfer <rafael.dulfer@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2] rev-list: clarify git-log default date format
References: <20230201155712.86577-1-rafael@dulfer.be>
        <xmqq5ycl1c6h.fsf@gitster.g>
        <230201.864js5q9sv.gmgdl@evledraar.gmail.com>
        <xmqqy1phxabi.fsf@gitster.g>
        <d9fc8688-bbf1-96c2-07bf-a12fe38625a9@dulfer.be>
        <xmqqfsbovy7u.fsf@gitster.g> <xmqqsffouhys.fsf@gitster.g>
        <xmqqcz6av3ta.fsf_-_@gitster.g>
        <Y+2R2qIVQG9hJpEA@coredump.intra.peff.net>
Date:   Wed, 15 Feb 2023 18:58:33 -0800
In-Reply-To: <Y+2R2qIVQG9hJpEA@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 15 Feb 2023 21:15:54 -0500")
Message-ID: <xmqqfsb6tixy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Feb 15, 2023 at 04:42:25PM -0800, Junio C Hamano wrote:
>
>> The documentation mistakenly said that the default format was
>> similar to RFC 2822 format and tried to specify it by enumerating
>> differences, which had two problems:
>> 
>>  * There are some more differences from the 2822 format that are not
>>    mentioned; worse yet
>> 
>>  * The default format is not modeled after RFC 2822 format at all.
>>    As can be seen in f80cd783 (date.c: add "show_date()" function.,
>>    2005-05-06), it is a derivative of ctime(3) format.
>> 
>> Stop saying that it is similar to RFC 2822, and rewrite the
>> description to explain the format without requiring the reader to
>> know any other format.
>> 
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>  * The discussion stalled and the topic was left in limbo for a few
>>    weeks.  Let's attempt to reboot it instead of silently waiting
>>    for a rerolled version from the original author.
>
> Thanks for keeping this moving. The proposed text looks great to me.

Thanks, but the formatting is broken, and needs a line with "--" on
it at the end.  What I will queue on 'seen' already has the
correction.
