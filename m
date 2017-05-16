Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EA792023D
	for <e@80x24.org>; Tue, 16 May 2017 23:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752764AbdEPXtz (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 19:49:55 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35189 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751730AbdEPXty (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 19:49:54 -0400
Received: by mail-pf0-f194.google.com with SMTP id u26so21504444pfd.2
        for <git@vger.kernel.org>; Tue, 16 May 2017 16:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=rApbSqgR5QiL2GrsL+DlFCei0+zdczcjche9i1OOPEA=;
        b=GbMdpIYEP20Lh0VwRzyXlp2a9dHwAJtKChITSSbyXhSjW+ZOZ4dV3fVxfJNHyw77aH
         rpsRVJKd51e3P1k0w/YO/DBpELmucfYCt7DDMyeAd5W3VomuXRqsMhnkR9c+sJ6OkJOo
         ysFqL86X5PCMIXykNIvieXYdkPAONXgGXu4Jipahhod+LuhuEh9tJGHNwFa3I5gNNn2T
         TKuXDHGdePJEUrma9mpNot72a2AeoCVH9WYUEUVCsFdEeiCGECnu7IakU2bFs6iYIZph
         7TNNLOYvtbxaF3kOYPuppaZqxXv+x2jEX5QncjQDlvCQfMLzb9sY7zxYZbrj6AVS/2j0
         bsEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=rApbSqgR5QiL2GrsL+DlFCei0+zdczcjche9i1OOPEA=;
        b=eaHaTQqF3s0eqnk7Wh2SkkCp6KJKXfex742oF42hKHshLHEh7fly+ztBzTeQKTEDiE
         OSM2/ZuZKTsyM7MMAwaMgzNYxaP72PKJt9WdC1Q7/IZz0rYgLF34uRuOxbeSIVHDGOBm
         YM6UyBYUFaZkcCA0M5sNXDWBBNuGLlhvVxF7rHqQQbXbpKuL9LDvZoKjcNskBzdEPxTG
         vAJekYhqasDAzJF17Hig+kxYN2jwwfgXOe29KdhxpU48m2+3rrhnxd9fJGMfWTvK9g4u
         N6ZBNHKKqvC1o+hhtW68qFVZaXRCb87c3sObvVcDmMk8zx8dY9+FTJVduot1xJ+waAmM
         J9yg==
X-Gm-Message-State: AODbwcAT49wGETLgr0Jv7tzKtKAWM9jL/yqg1TN+IdRaRJKnimhEgQz3
        3QMuUIjG53CLfA==
X-Received: by 10.98.151.2 with SMTP id n2mr611573pfe.29.1494978594246;
        Tue, 16 May 2017 16:49:54 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:8dc7:ff72:325b:10d7])
        by smtp.gmail.com with ESMTPSA id y2sm276643pfk.1.2017.05.16.16.49.53
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 16 May 2017 16:49:53 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     xiaoqiang zhao <zxq_yx_007@163.com>
Cc:     git@vger.kernel.org, viktorin@rehivetech.com, mst@kernel.org,
        pbonzini@redhat.com, mina86@mina86.com, artagnon@gmail.com,
        avarab@gmail.com
Subject: Re: [PATCH v4] send-email: --batch-size to work around some SMTP server limit
References: <20170513015726.20281-1-zxq_yx_007@163.com>
        <xmqqfug6wz0s.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 17 May 2017 08:49:52 +0900
In-Reply-To: <xmqqfug6wz0s.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 15 May 2017 12:59:47 +0900")
Message-ID: <xmqqd1b81hwf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> xiaoqiang zhao <zxq_yx_007@163.com> writes:
> ...
>> Note:
>>    Re-authentication will happen every $<batch-size> messages, so it
>> will be much more acceptable if you use some form of credential helper
>> (e.g. the 'sendemail.smtppass' config option), otherwise you will have
>> to retype password every time when asked.
>
> I think this deserves to be in the end-user documentation (i.e. the
> part of your patch that updates Documentation/git-send-email.txt).

Ah, this came out to be rather obliqu, but you do need an update to
the documentation as part of this patch.

Thanks.
