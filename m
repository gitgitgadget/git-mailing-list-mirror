Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCC171F404
	for <e@80x24.org>; Thu,  6 Sep 2018 21:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbeIGB4U (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 21:56:20 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39249 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbeIGB4U (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 21:56:20 -0400
Received: by mail-wr1-f66.google.com with SMTP id s14-v6so3875893wrw.6
        for <git@vger.kernel.org>; Thu, 06 Sep 2018 14:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=GfWM6Jiz6iDshNzMIBnAtpn6S1z3FC374YY8iZev2DE=;
        b=ZBGz36WxH3/7heKJbSiOuKjOez0/bSVuiksBq+HAGaOzBs6ZjM7/XtL/GAwXKI2Gpp
         mVvWP7TvERvOxEUFA8GuQ2Jb7psXKgk0QQ1Rtmg4+Zikbc3vfAH5gmoLURNlXp3fmU0I
         WzzL6ye3HXRNVbPZChS5jfH8g1RbAAu/B9KVr1cBLg1S7igxCH5Xb+dYMBXnenlYkQic
         zrOwn713M/oATNdaPg/pIgUK/koWPh4YCxsIXwatmNdNqxufIPrC82CNShCnJYmC9BkJ
         la8OYvy71wRrCZkNs3qY5kdBMRTRmuWsjNfF01bI8aGrnEUkcLsdCe9mKbLQ915+a66l
         Bh3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=GfWM6Jiz6iDshNzMIBnAtpn6S1z3FC374YY8iZev2DE=;
        b=SUPfa9HYKQ7S7XvKjiv3fj6Mr8Sz2nI32DasRA+PZSbIeaIVvqwYeX4QepiTnUQJul
         +7YI1//0biMgElLglrOpS7IVls41c1nPE5ftiBwlaQVMnyTVWmgxGO9wLwssjIPo2ERQ
         7d9A5bsD0bTFEoAet8B+0k4gQzXHojfu5/5JkFihnKqC2fLDKZ8N/tJkby5iSJOiCZTG
         MqEzgkWbR6i1iv8Hgye14wvrVO9MrUrs2XMlGrDT8yii7JO+ujcUJxKuBbvuoG0NUH8S
         TX2A/sisjnuXYPkMn6bNz0HhQlTMf2kMmkK+LvkLE+dIrry7nnmeM391KjJad7G8l8L+
         MsRQ==
X-Gm-Message-State: APzg51CwYFnfoSHxutiYK2Sp8/fiN1ZJ/quAI8dQivZKvpyUh07TG6TL
        vTUCzmMwRCOlvVx9msneWFY=
X-Google-Smtp-Source: ANB0Vdbtp1UcqbddTAAyQBFmh07/XfN0de2Fb8H8LuppTelAT52y4bVNiSKmNEnLD7++JRZoC8qfBQ==
X-Received: by 2002:adf:ac38:: with SMTP id v53-v6mr3766459wrc.135.1536268738145;
        Thu, 06 Sep 2018 14:18:58 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id s24-v6sm3900161wmc.7.2018.09.06.14.18.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Sep 2018 14:18:57 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] submodule.c: convert submodule_move_head new argument to object id
References: <20180905231952.28145-1-sbeller@google.com>
Date:   Thu, 06 Sep 2018 14:18:57 -0700
In-Reply-To: <20180905231952.28145-1-sbeller@google.com> (Stefan Beller's
        message of "Wed, 5 Sep 2018 16:19:51 -0700")
Message-ID: <xmqqa7ouz5mm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> All callers use oid_to_hex to convert the desired oid to a string before
> calling submodule_move_head. Defer the conversion to the
> submodule_move_head as it will turn out to be useful in a bit.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
> This is also part of the other series sent out yesterday, 
> https://public-inbox.org/git/20180904230149.180332-5-sbeller@google.com/

And what is your intention wrt the other one?

Do you want two separate copies of essentially the same patch queued
as part of two separate topics?  Did you change your mind since
yesterday and decided to retract these patches, and instead
concentrate on these two patches that address an issue with tigher
focus before moving on to other things?

Exactly the same comment applies to this copy.  It is somewhat
disturbing to see that new and old, which correspond to each other
and ought to be symmetrical, take the same "commit object" in
different shapes.
