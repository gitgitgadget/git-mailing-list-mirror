Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C15A320188
	for <e@80x24.org>; Fri, 12 May 2017 06:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756346AbdELG24 (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 02:28:56 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33131 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756201AbdELG2z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 02:28:55 -0400
Received: by mail-pg0-f68.google.com with SMTP id s62so6425726pgc.0
        for <git@vger.kernel.org>; Thu, 11 May 2017 23:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=gmDOwm4xe7wbTIwml1y3fxFhoLhWHjqEHwOWGXzTxTM=;
        b=iZuDh8zsxeEQk4iGB+iS8Y/YXiFJn8jPX2YlUGtOBq4I34fui2exa1zBoYggXN1HD/
         /nJogxvnmPTw6RDc3Dn+V43FuRZd1ydJqA9dRfEGeMSdB3bF056pZduQaEIIF1FGGd/p
         5LSiqNGTPONSR5sXIeF5mamxSydUpXArK0vRFshwoLNUJxkHNpJd3OoY4O/cyt0u5Vlw
         joX2vTnK+jr5cEhbqWl+XUx3W65jqcl79YJxJ/p1Xt3JJ24JPoKA1mT7NG3ClfpNDQE/
         hm0wzku4NzV8pQCfaDEw1Emsv1aIfVbcbLCR86mH/1fAF09wJZxzoTKDyuQN8AqxNDg4
         b5cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=gmDOwm4xe7wbTIwml1y3fxFhoLhWHjqEHwOWGXzTxTM=;
        b=Ro7jDIBWxksoS2YEN0nYF/QM1Md8/1DC2oUqr/Onkz69tnVcdTl7mwnfoN5Z4xurhg
         4MGbryJlpfhek13jmEnC4TiwtT63SJoCn6bGK76iGraXuu2p0UcUj+Cvt4GSCrnRslIz
         BoF+ahLwaZ0SB3WAkBVpaeoAZAnturToIZ3gAvMZ74iFvWWpn1QZZCiNnh9jF30SjiOz
         tr1VSA+rAb4hW71G8FnqJkElrdeZHwA8NrViwq1ajwywoPFW5b2c94iMNhsY/Bo02edE
         0DL8/Mf2aMINfHl167dNWNvTSU/Wxij5poEY558DqBhTIJ5Y+xTc0Mmjiy/2NLu/0mkW
         PRmg==
X-Gm-Message-State: AODbwcA23lO+T0DP6I0To5ZAJzbCgbu3FsgV8NNcn2AKqwWF37cLwk4m
        f4iQtWQThpOIfQ==
X-Received: by 10.84.218.71 with SMTP id f7mr3492566plm.135.1494570535164;
        Thu, 11 May 2017 23:28:55 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:954c:c08b:c855:8b7f])
        by smtp.gmail.com with ESMTPSA id r73sm3479180pfa.65.2017.05.11.23.28.54
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 11 May 2017 23:28:54 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jean-Noel Avila <jn.avila@free.fr>, git@vger.kernel.org
Subject: Re: [PATCH v3 2/3] read-tree -m: make error message for merging 0 trees less smart aleck
References: <20170503162931.30721-1-jn.avila@free.fr>
        <20170511120634.17683-1-jn.avila@free.fr>
        <20170511120634.17683-2-jn.avila@free.fr>
        <20170511190809.GB12516@aiede.svl.corp.google.com>
Date:   Fri, 12 May 2017 15:28:53 +0900
In-Reply-To: <20170511190809.GB12516@aiede.svl.corp.google.com> (Jonathan
        Nieder's message of "Thu, 11 May 2017 12:08:09 -0700")
Message-ID: <xmqqtw4q6122.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

>> @@ -226,9 +226,10 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
>>  		setup_work_tree();
>>  
>>  	if (opts.merge) {
>> -		if (stage < 2)
>> -			die("just how do you expect me to merge %d trees?", stage-1);
>>  		switch (stage - 1) {
>> +		case 0:
>> +			die(_("you must specify at least one tree to merge"));
>> +			break;
>
> This part looks good.

Thanks.  Modulo _(""); I do not think other messages from read-tree
are marked for i18n (yet).
