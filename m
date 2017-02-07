Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CEE31FC46
	for <e@80x24.org>; Tue,  7 Feb 2017 20:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754758AbdBGUDi (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Feb 2017 15:03:38 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33636 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754715AbdBGUDg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2017 15:03:36 -0500
Received: by mail-pf0-f196.google.com with SMTP id e4so9924048pfg.0
        for <git@vger.kernel.org>; Tue, 07 Feb 2017 12:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=HGdPqWK4Ucc8p1Aj2ivpNMG7gprVKWBd5Ck0XN1MypA=;
        b=Q911axczpWXrcEN9Q16MIsqi2iaz3nKBibrlksBRoQcZX/NJsfrB/Uol2K6TkNhii0
         FdpoigE5b6lC5e39MGGqvan/YGgWjpmidacg3r4a05isA83pzVgxrZJQp84S3X+6kcq5
         eeGLrkwvVARsKhRsUn+C7x33RGyCj8QNtKtgbEEg229UdiYIX6xNKq5nyYjPonhOVOK0
         L0+XObKj2kPdNVfSDdATvul0XR0p2604f1YwHRO3qaE6u3oACwp0aBTwZKzHVaerxUkK
         SPa8JMoD7/CCymC999G0y8zVFjeWC8M0jDIWr7CX07IMYzR5yZA7lsgNfq66Z1bzCUKm
         34oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=HGdPqWK4Ucc8p1Aj2ivpNMG7gprVKWBd5Ck0XN1MypA=;
        b=mia4hPrcVGkysaa2iKtHY1dLhMhGo3jC7rn9Bp7j9b+ig3qNDBKwEzV8V1WnQcxI3q
         2W0tvvD+GF25HFaROnUu7BvGNYoHxZ61xZknfYOjtRsjc7eYc9dTudfhAuGanoWrqBCP
         6jJmdYGKVqhe3RR8kxZ3TgiljUei82ty2TBahSiGA0SCXz/qguufWMeENU6VUh4gXASw
         zAwVoP3he0DTuoE+pUJmXM/A86XWY1qqzCidmmTEDeP9FMZOidJIwn3+bgRoHwwnzZZV
         jxUKe00MnT6sv70piDz0X9BkzF5JMKv/vQlWTm/eln63fN+WsMKH5M9XQWxGgbA8g1kJ
         CAUQ==
X-Gm-Message-State: AIkVDXIsTElS7zd0iUD2KwQ+FZd02QGpsGZg8BtVfS1ig+GU0/dW+iVabygoLIlZh1I1mQ==
X-Received: by 10.84.143.165 with SMTP id 34mr28563658plz.2.1486497801305;
        Tue, 07 Feb 2017 12:03:21 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:1564:f4f3:f1b4:c9b2])
        by smtp.gmail.com with ESMTPSA id d69sm13660795pfd.11.2017.02.07.12.03.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 07 Feb 2017 12:03:20 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     David Aguilar <davvid@gmail.com>, Git ML <git@vger.kernel.org>,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH] difftool: fix bug when printing usage
References: <20170205201751.z4rfmy5xxaqg472l@gmail.com>
        <20170205212338.17667-1-davvid@gmail.com>
        <alpine.DEB.2.20.1702061716120.3496@virtualbox>
        <xmqqinon2nnt.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1702071220290.3496@virtualbox>
Date:   Tue, 07 Feb 2017 12:03:19 -0800
In-Reply-To: <alpine.DEB.2.20.1702071220290.3496@virtualbox> (Johannes
        Schindelin's message of "Tue, 7 Feb 2017 12:21:47 +0100 (CET)")
Message-ID: <xmqqh945zs3c.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > Likewise, this would become
>> >
>> > 	GIT_CEILING_DIRECTORIES="$PWD/not" \
>> > 	test_expect_code 129 git -C not/repo difftool -h >output &&
>> > 	grep ^usage: output
>> 
>> I agree with the intent, but the execution here is "Not quite".
>> test_expect_code being a shell function, it does not take the
>> "one-shot environment assignment for this single invocation," like
>> external commands do.
>
> So now that we know what is wrong, can you please enlighten me about what
> is right?

David's original is just fine, isn't it?
