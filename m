Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 259251FAF4
	for <e@80x24.org>; Wed,  8 Feb 2017 23:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751991AbdBHXCD (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 18:02:03 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36400 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751958AbdBHXCC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 18:02:02 -0500
Received: by mail-pg0-f65.google.com with SMTP id 75so16023667pgf.3
        for <git@vger.kernel.org>; Wed, 08 Feb 2017 15:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=DqJvIsw61MoltKRCPUNpulCwm0zBcQ7NLAC29DoQeck=;
        b=nc/3m4Pwudr/2oPB2p5LDfNgWeZrhxQBCHqGcSk56vc9OsxYdw/rkip/TpqsEjMf6W
         Oa9PaxTRSqocD/NVe0vpylnbiyXxi4ZLVBsZiOrQ1igo4GCcT707HUc1+rdb0Q6cQQVs
         9OgJtOw+XukYH63ybj5tnXKyv1gs+btmOIQupEJ7Z7TKal14JReTpTFPr6uWLHzCKONi
         I7U5UAqjvICQQyEjr3JP/QXG3rQ1Bz+NCN+8HIZsSD1sZbNpGa4xgtNk6UbYEDKaKlnP
         Pq2uS+BQf5htRUXzOyEcTCw8PYrcoDOTrDtqiDxtkLo6caH0EWNYy6k3xcOXkKVw0f0g
         s8MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=DqJvIsw61MoltKRCPUNpulCwm0zBcQ7NLAC29DoQeck=;
        b=WFOuX9L7h2BwpakzQvx0GwVHV3ojUfwWb0D0nDkY2n3kGxqwsxHuMiK36pgPZesHkG
         /Vhdp2MwzhJe3H8kKXuH8XZkK36UIDUG1Unw2BDw4soNQJlCfh3ldHGK0L1jyBdvZZyd
         Gbg/OEhMo2lZfeMUZo5SkSoEB1h/piJ96hd0d1yMzp9WmPQmQQ09USS9mPPenxPak5Cw
         VLW0g4TqrQjL1t6epSdFvqWx1yOD0p8udBSzVg50yZ7aU0qByEqbpQpIW1i07uBuAd/J
         1yo6D8prrHvnAiSQ8N6MfC/nJPIhYOvIkelaJNpZLpI+uNjsD7o+ybUbJPA6OEDlvU0j
         U4pg==
X-Gm-Message-State: AIkVDXKcXPFq8Ln+TUR8zhFnhcxFl+PRlkfdYdYggNd7xYjWrHb4UQQAXJF/avRBz2vq4A==
X-Received: by 10.98.8.11 with SMTP id c11mr28723657pfd.135.1486594921623;
        Wed, 08 Feb 2017 15:02:01 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:7c20:fa7c:46cb:2209])
        by smtp.gmail.com with ESMTPSA id v186sm22936794pgv.44.2017.02.08.15.01.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 08 Feb 2017 15:01:57 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] push options: fail properly in the stateless case
References: <20170208010954.19478-1-sbeller@google.com>
        <xmqqpoiswo0l.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kaszczpnu+VEV3y+61qgji-0+vRFVLk8Q1+BbSDgiHz1Q@mail.gmail.com>
Date:   Wed, 08 Feb 2017 15:01:57 -0800
In-Reply-To: <CAGZ79kaszczpnu+VEV3y+61qgji-0+vRFVLk8Q1+BbSDgiHz1Q@mail.gmail.com>
        (Stefan Beller's message of "Wed, 8 Feb 2017 12:51:00 -0800")
Message-ID: <xmqq7f50uw0q.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>>> +'option push-option <c-string>::
>>> +     Transmit this push option.
>>> +
>>
>> There is no "c-string" in the current documentation used or
>> defined.  The closest thing I found is
>>
>>     ... that field will be quoted in the manner of a C string ...
>>
>> in git-status page, but I do not think you send the value for an
>> push-option after running quote_c_style(), so I am puzzled.
>
> When implementing push options, we discussed that and according to
> Documentation/git-push:
>
>     The given string must not contain a NUL or LF character.

OK, so "Transmit <string> as a push option" is sufficient, as the
string is sent as-is.  OK.

Thanks.
