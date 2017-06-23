Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCCC220282
	for <e@80x24.org>; Fri, 23 Jun 2017 17:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754716AbdFWRit (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 13:38:49 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34347 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754625AbdFWRis (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 13:38:48 -0400
Received: by mail-pg0-f66.google.com with SMTP id j186so6950799pge.1
        for <git@vger.kernel.org>; Fri, 23 Jun 2017 10:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=jGsClNZrdpLwxTC/pqlJlSJ2iIXpBg6/7MN1LWCLkNw=;
        b=BEGTnsVG0AyPxcyDhyoelpniP/tgpXPJmE8wC6bPQt3Vq9VyErnn46dggu5xtYk8SP
         1SgkKrZjwvdFrFLu5Wz5nWtQ54BWb2j0RRn6uTsHbH4a3F35pLw0mpj4wdQgnC5LMLKI
         9MWKuAVxCDU24Y9ghHgDxMnBcPmAr/0EPt4MVCaI7qe/RdS98u0WSKVFi9nGMPsMWaPs
         lxZxI92P7wAVgOZIF/FrzK7uD98EyTdQmpRzKCK2oByu9DYYvmCBwCZGsLQXtyw6c1So
         ljO58oGPrl69+42bAYKd7ghMNxEASSDO5yfnWw2O0TgM7ysochDhUUF4kQqqAwtciVjp
         Dm1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=jGsClNZrdpLwxTC/pqlJlSJ2iIXpBg6/7MN1LWCLkNw=;
        b=UVkRdpPIkMUY7zGLNMuBfP3soQlnRnvHDUNMqRB4pKnpyDaVXzCahC2TMdBh0SMUof
         PCukaDt+WMQAFM1mR4tusjRTEzXsD5sNCbgOabNtBPNSFWSJiE6RQ9Ivk6D4F4j44GXx
         cjHjIc+EgVqLayzpHeewi34x3McEkYuxwE8TDLIuKJKwHThwyp6FRzQwh9iBsPu540pW
         K/Qs+dTnW8C78QTgHl1E4jxIgsjfeXYl+ovm7zR6lsybq0OI4ZrrMfwn+l1WTnDmdrrI
         Q5+0kO394XTF4BxHL5R8HCihpvXI5Tid9zI8L/EYXOjbNY9ZEXXdY43B7nUsUMZixyhL
         HPxA==
X-Gm-Message-State: AKS2vOxJU6696opT0NSY6TV0uazsW4n/0565NHxf4qeEjGfv/osOiYoR
        MXLgCrWpU1PKnmi78CsD5Q==
X-Received: by 10.98.163.203 with SMTP id q72mr7974116pfl.97.1498239527637;
        Fri, 23 Jun 2017 10:38:47 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:4cd0:d6d2:1e09:4052])
        by smtp.gmail.com with ESMTPSA id g86sm11853678pfk.101.2017.06.23.10.38.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 23 Jun 2017 10:38:41 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, peff@peff.net,
        avarab@gmail.com, jonathantanmy@google.com
Subject: Re: [PATCH v4 00/20] repository object
References: <20170620191951.84791-1-bmwill@google.com>
        <20170622184348.56497-1-bmwill@google.com>
        <dadf3fe7-180b-df3a-f5f5-932905f08335@jeffhostetler.com>
Date:   Fri, 23 Jun 2017 10:38:41 -0700
In-Reply-To: <dadf3fe7-180b-df3a-f5f5-932905f08335@jeffhostetler.com> (Jeff
        Hostetler's message of "Fri, 23 Jun 2017 12:44:53 -0400")
Message-ID: <xmqq60fmfvtq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> On 6/22/2017 2:43 PM, Brandon Williams wrote:
>> As before you can find this series at:
>> https://github.com/bmwill/git/tree/repository-object
>>
>> Changes in v4:
>>
>> * Patch 11 is slightly different and turns off all path relocation when a
>>    worktree is provided instead of just for the index file (Thanks for the help
>>    Jonathan Nieder).
>> * 'repo_init()' has a tighter API and now requires that the provided gitdir is
>>    a path to the gitdir instead of either a path to the gitdir or path to the
>>    worktree (which has a .git file or directory) (Thanks Jonathan Tan).
>> * Minor comment and commit message chagnes
>>
>> Note: Like v3 this series is dependent on on 'bw/config-h' and
>>        'bw/ls-files-sans-the-index'
>>
>> Brandon Williams (20):
>
> I read thru the v1 and v4 versions.  Very nice.
> And thanks for splitting the earlier parts out
> into independent patches.
>
> I didn't have any complaints, but did want to ACK
> that I had looked at it.

Thanks.
