Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 284981F4C0
	for <e@80x24.org>; Sat, 26 Oct 2019 11:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbfJZL1g (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Oct 2019 07:27:36 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41964 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfJZL1f (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Oct 2019 07:27:35 -0400
Received: by mail-wr1-f68.google.com with SMTP id p4so5100253wrm.8
        for <git@vger.kernel.org>; Sat, 26 Oct 2019 04:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xk6ALsNQjgkTQNowkGI1To1qKA+Ssg28CP6b/Ve1oXo=;
        b=YaZcc3hxq511jR36VFZv/EGFjNWFsFYomiLyr4/XeJxcacIJrLU28mymjZ/PWfCS8A
         Zj17wnZYXdHAtAjPoricmNh9hEtK8fJQr5v/gbHbK76b3CNCKr3HA3CIQBqrvR1lBmcK
         iSS2S+PyG8LutDXalDRnhsOaAgV/drGQw9IStZiG9FY4t8wGEU/Ac5NYnd2NqUXBLpCW
         SZhGNs2WmueAxs5n08Hc0oR2XWO59albuExODfbwxHuSUfsP2BvnwetdRap0SFej1vKI
         m5Oq3zCd/vIdqPgIWceEGF0Ouh72qCZofn+oWxuTNg4g9Fc0ISTp2FaU80hbvc/+1ocH
         tZpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xk6ALsNQjgkTQNowkGI1To1qKA+Ssg28CP6b/Ve1oXo=;
        b=LDx5GIiqxjoD1gZus3b5yWFE+vwHsk+ibURukJuprEElgDoq+Hv278fGC+2IUBEGQh
         D2UHZTQeSrU2O/g2HNejssuSoEfId4CxYLzwIPuH2BegfsjBex0pKwSsle1rYvai/249
         I/E6zMt/dzVv/dQfGaMnNw2jrGHYHN3oXGOCYFj7RSZLTn+FOszgstHhhXNaXmKC3I6K
         5msPAl8I+pnHQcjVtIOy0b49NEN6raZp8brR44seeLcK6kNmCX1sIwXZag4Logx+Vv8A
         mVEJEiFcfUoIbAcUvmeNriicaGGem7G4KSxChOTDEi3SBHA2YEcUKa0c+P6XBkwjhLkh
         Ny/w==
X-Gm-Message-State: APjAAAXVc3l0pfRPlYLE35XTbaebJ8+FnyiwPt3s/kWxvJRMEVIBXJ4G
        G2vAZY80g31bbrZ3OTIVZXw=
X-Google-Smtp-Source: APXvYqz98038I7TKZ4A6VlKhaRMmPvMiO6kCuQ648DqrIwvnHd1ITrkHT2eQUmodV2paBTOOVekoWg==
X-Received: by 2002:adf:fb0b:: with SMTP id c11mr7348020wrr.50.1572089253510;
        Sat, 26 Oct 2019 04:27:33 -0700 (PDT)
Received: from [192.168.0.104] (atoulouse-658-1-200-5.w90-60.abo.wanadoo.fr. [90.60.97.5])
        by smtp.gmail.com with ESMTPSA id u1sm6412353wru.90.2019.10.26.04.27.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Oct 2019 04:27:32 -0700 (PDT)
Subject: Re: [PATCH v1 5/5] sequencer: directly call pick_commits() from
 complete_action()
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20190925201315.19722-1-alban.gruin@gmail.com>
 <20190925201315.19722-6-alban.gruin@gmail.com>
 <67c98856-55dc-df95-c4a6-61f1af85c480@web.de>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <9b81e879-091b-bbf7-2d1b-51236d19ee9a@gmail.com>
Date:   Sat, 26 Oct 2019 13:27:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <67c98856-55dc-df95-c4a6-61f1af85c480@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi René,

Le 26/10/2019 à 09:47, René Scharfe a écrit :
> Am 25.09.19 um 22:13 schrieb Alban Gruin:
>> Currently, complete_action() calls sequencer_continue() to do the
>> rebase.  Even though the former already has the todo list, the latter
>> loads it from the disk and parses it.  Calling directly pick_commits()
>> from complete_action() avoids this unnecessary round trip.
>>
>> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
>> ---
>>  sequencer.c | 8 +++++---
>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/sequencer.c b/sequencer.c
>> index ec7ea8d9e5..b395dd6e11 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -5140,15 +5140,17 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
>>  		return error_errno(_("could not write '%s'"), todo_file);
>>  	}
>>
>> -	todo_list_release(&new_todo);
>> -
> 
> Moving this call down leaks new_todo on error...
> 
>>  	if (checkout_onto(r, opts, onto_name, &oid, orig_head))
>>  		return -1;
> 
> ... here ...
> 
>>
>>  	if (require_clean_work_tree(r, "rebase", "", 1, 1))
>>  		return -1;
> ... and here.  Perhaps set res to -1 and jump to the end?
> 
>>
>> -	return sequencer_continue(r, opts);
>> +	todo_list_write_total_nr(&new_todo);
>> +	res = pick_commits(r, &new_todo, opts);
>> +	todo_list_release(&new_todo);
>> +
>> +	return res;
>>  }
>>
>>  struct subject2item_entry {
>>
> 

Thank you for the heads up.

Junio, how do you want me to fix that?  Should I reroll the series
altogether, send a "fixup!" commit, or send a standalone patch?

Cheers,
Alban

