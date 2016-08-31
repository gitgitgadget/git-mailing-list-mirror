Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDDEC1F859
	for <e@80x24.org>; Wed, 31 Aug 2016 19:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757702AbcHaTYd (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 15:24:33 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34795 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753019AbcHaTYc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 15:24:32 -0400
Received: by mail-wm0-f68.google.com with SMTP id d196so5008740wmd.1
        for <git@vger.kernel.org>; Wed, 31 Aug 2016 12:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=6qJjSssqRSlQOeYvanEcshdlp7CB6Yzpg94xE+L0B/Y=;
        b=nbbI5B0p57NjGSqSePSv6JsHbXB32q5gwA8aOgwHgjKKEk4An2KMq1OPM9fuBR9nI2
         DKl7XxiJvxWspJYnuKc/9JmgkF+OkXo6TPXHTx2CbE8C1gsMXtONMVCyt3ElOMjdoNkH
         L6V6rtCTcj5f/JeARAMnbnQUXuv+qEHCn7QK0KTfO3b9dP9VHEGBStrkqQt6/0FSMDZu
         xRK6rk4MSVbDelhcqmMJMLTZYiav++WkauBkfy1lNCJy5QcW3Ag/RaCLLhV0GjFpoY/F
         8n0dp5htGmX4hgOsIqmajKiGtdMJFav7KzNKjP8PoPzbECvCVTnAcWV3xFwMB0rFNwk0
         oQSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=6qJjSssqRSlQOeYvanEcshdlp7CB6Yzpg94xE+L0B/Y=;
        b=fFmif+I2eU7/+XcGo+/nhVtwyja35MVH4ghOc9cJyiGpLGbAdKS0lXS0eX9AyFeHWj
         CNr01tNQngnTg+yx4K3EtQ+VG2Gah3xVAozILJcuAS0B1uTTV3UXTuKCfcnRT0f4GtfT
         owdKpWxQsYp6pYW+tFPk3fA9WgMYXkzMAa7E6VtqdVUMYlckBHwVfqzOGDL3fKww9z0Y
         lZMy+3Cd7D3AVPfMCAdjVT0C4/fBuqwqzxKa5K/ceHBLKhL2NClCED/R9uds8llCG7xg
         aVGEWV8MBCur/qCOoLjL8IH5ClIpziJ4IhCr59yprMYLxbXNFwvR/mDZdZ8svuOs1e6l
         jFxQ==
X-Gm-Message-State: AE9vXwNge4BSxNXVwWCCUPr3CTj5ciHucxxCYTUF/VqzD0aVG7cuFnuRiVoNQhK0KNv8UA==
X-Received: by 10.194.118.39 with SMTP id kj7mr10025515wjb.172.1472671470868;
        Wed, 31 Aug 2016 12:24:30 -0700 (PDT)
Received: from [192.168.1.26] (enu134.neoplus.adsl.tpnet.pl. [83.20.10.134])
        by smtp.googlemail.com with ESMTPSA id a3sm1330155wjw.15.2016.08.31.12.24.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Aug 2016 12:24:29 -0700 (PDT)
Subject: Re: [PATCH 13/22] sequencer: remember the onelines when parsing the
 todo file
To:     Junio C Hamano <gitster@pobox.com>
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
 <12bffd6ca4eb7acc00a102d13348bb96ad08371d.1472457609.git.johannes.schindelin@gmx.de>
 <52d61bef-668b-fdc4-30b3-a34c11b39f81@gmail.com>
 <xmqq8tvc21re.fsf@gitster.mtv.corp.google.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <a9831d93-f5b4-d729-eae0-1f7c1123a6a6@gmail.com>
Date:   Wed, 31 Aug 2016 21:24:25 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <xmqq8tvc21re.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 31.08.2016 o 21:10, Junio C Hamano pisze:
> Jakub Narębski <jnareb@gmail.com> writes:
> 
>>> diff --git a/sequencer.c b/sequencer.c
>>> index 06759d4..3398774 100644
>>> --- a/sequencer.c
>>> +++ b/sequencer.c
>>> @@ -709,6 +709,8 @@ static int read_and_refresh_cache(struct replay_opts *opts)
>>>  struct todo_item {
>>>  	enum todo_command command;
>>>  	struct commit *commit;
>>> +	const char *arg;
>>> +	int arg_len;
 
> I am not sure what the "commit" field of type "struct commit *" is
> for.  It is not needed until it is the commit's turn to be picked or
> reverted; if we end up stopping in the middle, parsing the commit
> object for later steps will end up being wasted effort.

From what I understand this was what sequencer did before this
series, so it is not a regression (I think; the commit parsing
was in different function, but I think at the same place in
the callchain).

> 
> Also, when the sequencer becomes one sequencer to rule them all, the
> command set may contain something that does not even mention any
> commit at all (think: exec).

The "exec" line is a bit of exception, all other rebase -i commands
take commit as parameter.  It could always use NULL.

>
> So I am not sure if we want a parsed commit there (I would not
> object if we kept the texual object name read from the file,
> though).  The "one sequencer to rule them all" may even have to say
> "now give name ':1' to the result of the previous operation" in one
> step and in another later step have an instruction "merge ':1'".
> When that happens, you cannot even pre-populate the commit object
> when the sequencer reads the file, as the commit has not yet been
> created at that point.

True, --preserve-merges rebase is well, different.

Best,
-- 
Jakub Narebski

