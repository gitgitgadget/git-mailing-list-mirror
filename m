Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDFC71F437
	for <e@80x24.org>; Tue, 24 Jan 2017 19:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750885AbdAXTH7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jan 2017 14:07:59 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34469 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750716AbdAXTH6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2017 14:07:58 -0500
Received: by mail-lf0-f68.google.com with SMTP id q89so18478537lfi.1
        for <git@vger.kernel.org>; Tue, 24 Jan 2017 11:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=SFhAQzN6k4KcQc4eUQZjRyrtSLppzAOIOUHlpM6+lUE=;
        b=F46OZf5IsZvV7uGaIkKtOd2O88U9nxxkiU2fgt+2jY12ECJnCqWQlfztpOakEfyA4s
         xptN04EknTLUGlEK4hq7wEQC/EonvBoC+vCI+nYNQPDctCS1ygr25LV8sWxxXvzKDIza
         xqaLIcLOuYzQPtb2CEbSvHjDAMX+08p3DIUlxEvNXppZULAphPOSEAPIKjQWEQxZaPld
         LThdDn/T7SFi6nm3bUyCH1WriZVpU8W4aTcXl7nuQHsx4/lIo3zNBx82c5rqaQiGOl6k
         27IHgPJcqNss4a4q4Km0geegXYKOzIoplgPljmZBm8BTpL5/u59ETnuUgk8of3zO6zWB
         c62A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=SFhAQzN6k4KcQc4eUQZjRyrtSLppzAOIOUHlpM6+lUE=;
        b=OKmTGnD3XmINR0M52jkjU8Uxc59SlN2AULCSg6mWLD0UL+TeI0ErlbSUsOyGguXBFG
         6+l7YenVxFPTm9eyz+Cz3OVEAJnaZr8qmxDFUVSyWstr9di7dGi2xxf1Sy+QvVjf7qUO
         SULrY3m30yGs6Zl6LI4YadzNcyb9as4xjCW4y6BH8UQTnUKLPx8625HiZJ1U7o7oNdBx
         eElFhfnG0/1Th9RUOdKUv/RbtsYNI2c3j+3qPRU6LFpG3SU7yLKtRNb1cl1v0fxx3u7G
         CD976tqFDWhtIKYh168uqEQcwcvaV8SS6fPiM0T59gt+bC+MqezCulZFJ3jR31iQBeFi
         mT+g==
X-Gm-Message-State: AIkVDXItACB6DvtzgGiImvh8dgdNGGyUyLnx0LdF+x79+76JI1sT9f5pnbB+iuVCVywLCw==
X-Received: by 10.25.40.4 with SMTP id o4mr8888045lfo.1.1485284876515;
        Tue, 24 Jan 2017 11:07:56 -0800 (PST)
Received: from [192.168.1.26] (acuz88.neoplus.adsl.tpnet.pl. [83.11.105.88])
        by smtp.googlemail.com with ESMTPSA id x26sm4103145lja.0.2017.01.24.11.07.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jan 2017 11:07:55 -0800 (PST)
Subject: Re: [RFC 1/2] grep: only add delimiter if there isn't one already
To:     Stefan Hajnoczi <stefanha@redhat.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20170119150347.3484-1-stefanha@redhat.com>
 <20170119150347.3484-2-stefanha@redhat.com>
 <xmqqtw8u28u1.fsf@gitster.mtv.corp.google.com>
 <20170120135612.GB17499@stefanha-x1.localdomain>
 <xmqqlgu5y4u8.fsf@gitster.mtv.corp.google.com>
 <20170123131551.GL29186@stefanha-x1.localdomain>
Cc:     git@vger.kernel.org
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <f90eba2a-ebfa-67f0-68c4-abacb05759ba@gmail.com>
Date:   Tue, 24 Jan 2017 20:07:48 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170123131551.GL29186@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 23.01.2017 o 14:15, Stefan Hajnoczi pisze:
> On Fri, Jan 20, 2017 at 10:16:31AM -0800, Junio C Hamano wrote:

>> My only piece of advice to folks who feel that way is to learn Git
>> more and get comfortable.  You can do neat things like
>>
>>    $ git grep -e pattern rev -- t ':!t/helper/'
>>
>> that you cannot do with "rev:t", for example ;-)
> 
> Neat, thanks for showing the path exclusion syntax.  I wasn't aware of
> it.

That reminds me of mu TODO item: moving extended pathspec information
from gitglossary(7) manpage (sic!) to to-be-created gitpathspec(7).

-- 
Jakub Narębski

