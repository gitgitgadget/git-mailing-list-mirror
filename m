Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4E102027C
	for <e@80x24.org>; Thu,  1 Jun 2017 09:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751283AbdFAJPP (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 05:15:15 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:37313 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751229AbdFAJPO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 05:15:14 -0400
Received: by mail-it0-f41.google.com with SMTP id m47so13305959iti.0
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 02:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Dyc7NXGZWNuDiRWhzVRuomk11t6RtTAtgkf3u3+dhCc=;
        b=BN5K+KVdXb26iPxci+Pl8ObioED5aGgyaD1FC5+b/gh+ZfuIt24vBZAIaf9cXNu6jH
         d570rmUvziXoT2t6jlT4mbw3UiK4kRNJ6r6qvpjPeTjp3lVgJGy+RJbkO8S0DizJvERd
         Yaztcoxp2h6/Xe10vLeH7tGgs9KLCi/iT9QDobGNjNLwOemQ9ca7fldSjhPnClf9eOni
         2NUl0n2wRsMLdrtn+rNo+pxGYZ2qf4f1TjBjJIpYr1dhBH0u9/zQ4L6fgVQBi4x5Sep1
         Qb/sCkuPbJllNo9EuijbpRvIsKkTHWK236JEPeY1AYc9AVHhGgTZfSZgrJYpRWMRUDxu
         u3HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Dyc7NXGZWNuDiRWhzVRuomk11t6RtTAtgkf3u3+dhCc=;
        b=Eqo9Mo953U6fs2lOP2cbv+SqCsMtaXKSObNx5Mggvq7iy8pLzDVJrXwo9PjDzy6h/f
         yMbn+v5SUTmHms4cxa6PLxEU1b2CtxTlCOjNfLu0iLuKaAPug56IdKiHS/RA3CjII6O7
         NViMlFfshsGUVtLR9ljnhV9HpQItqbG4SJnWeAkMljiesDrEEMfrneLpVQZ0nN0Z3nZp
         ZjwkMEx55LPFtYcGlSyOVI0SFN4chAEKSMPJSOXOQBTmW1q/MQtauvxm792XFtkzXbYN
         zei/9Mn0ef1aRT2R7fTp+nhvp3YPAPk3Jsi3k/upf7kk27TS4wZsIuOzPNPrVMBAakig
         GG0Q==
X-Gm-Message-State: AODbwcBAGcszPp5aWlB+e4m3t+KPCPrKS9oDbBmxdHQwpXJ65NxMYqw8
        rJdPYxeOLmr2Nw==
X-Received: by 10.36.57.68 with SMTP id l65mr1675705ita.101.1496308513803;
        Thu, 01 Jun 2017 02:15:13 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:9c1c:dca9:c6e3:133e])
        by smtp.gmail.com with ESMTPSA id b197sm12344235iti.16.2017.06.01.02.15.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 01 Jun 2017 02:15:13 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andreas Schwab <schwab@suse.de>
Cc:     git@vger.kernel.org, Marc Stevens <marc@marc-stevens.nl>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: Unaligned accesses in sha1dc
References: <mvm4lw0un5n.fsf@suse.de>
Date:   Thu, 01 Jun 2017 18:15:12 +0900
In-Reply-To: <mvm4lw0un5n.fsf@suse.de> (Andreas Schwab's message of "Thu, 01
        Jun 2017 10:28:52 +0200")
Message-ID: <xmqqk24w5asf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Is this with or without a0103914 ("sha1dc: update from upstream",
2017-05-20)?
