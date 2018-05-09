Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F57D1F424
	for <e@80x24.org>; Wed,  9 May 2018 14:54:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935173AbeEIOyB (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 10:54:01 -0400
Received: from mail-qt0-f173.google.com ([209.85.216.173]:36720 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934517AbeEIOyA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 10:54:00 -0400
Received: by mail-qt0-f173.google.com with SMTP id q6-v6so45977447qtn.3
        for <git@vger.kernel.org>; Wed, 09 May 2018 07:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=OwfpqHw3GiUIGC+SpWc0cf1VFY2lvfhTLE8Gk9aU2PI=;
        b=mTnm5ppUMn+q59S1Jv+V4mY7ueqPT7SbDmYMf9tq/XBf2lxfCcjloqMBORgRfft6M6
         jm1pGxNFnOqTFQ4r5CvEw6781p24Yv2s+ny9GJSlQWvQcp84lISOdPaAJ7BrilV7GXVY
         B6c2z/dzbavAU397Vn6UNzmDaMlSTxYe0y8bPhK2IHpnmybuN/1pMRhqrdznYo9p7qVc
         W6LtMNb0+4ZLx1FKGHbid3bExpSUxkyRkF1g1JlN1BoslQD4aTni0cev6cicA7r2wRH8
         BZC1jaBC7cWBRAX5CQCTd8I3BK3n3+tgwwCFWLeqiV5RQxAK+xNwnVakdjklcubIkITW
         rcSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=OwfpqHw3GiUIGC+SpWc0cf1VFY2lvfhTLE8Gk9aU2PI=;
        b=tFiqL/LuuZF5qL+xLAsUDlX5IiShMdmBIQO8MksX0e6bpkqG9gG+gSrBRoidu6zocW
         OMOUZx1TFSGWpUHBVg2dRbSrpqIyyJhZQ0sqWvk7sOH2M2N6VesgFXu8MQqcKGCfMZId
         J6iQ+cTP9nx+Vbi1sUFwjhllE8PUx7B89tQb4iGHCrt9dH8j6ohJiQ3dXpQ+oDtJIzTR
         xi0Z7UvOTjmeDGHxkzoYkKrTD0CkOMbniyZfSqzVwOv8uhwv8WPsPApj1d2XLmw2wr22
         b6SUuw//Ys59g7WcJ39kyjKAohGrjojWVUAdIDW4TJkNjEHRJLJrKW82R3zxXDIagBwx
         K6bA==
X-Gm-Message-State: ALQs6tD0tGzCZJnHA7rYtNmq4BigX9p0iqip+gv32v5NQ8WggGP5uLqE
        TK4g4WgaMVWWHSTzoBXHXDAXZpB1
X-Google-Smtp-Source: AB8JxZry4NyKE5YoHr7D8pUv7LBg4QlvWoQg5lU8Ruf2BLL2kx21mDXlxI++Pk5elBTaIPTEjaH+8g==
X-Received: by 2002:aed:3e67:: with SMTP id m36-v6mr42856772qtf.279.1525877640083;
        Wed, 09 May 2018 07:54:00 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id s127sm9419442qkf.21.2018.05.09.07.53.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 May 2018 07:53:59 -0700 (PDT)
Subject: Re: [PATCH 1/1] commit-graph: fix UX issue when .lock file exists
To:     Jeff King <peff@peff.net>, Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>
References: <20180509141523.89896-1-dstolee@microsoft.com>
 <20180509141523.89896-2-dstolee@microsoft.com>
 <20180509144221.GA14714@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <926ef4a5-83c1-3d5f-6dfc-0b74fc7090bd@gmail.com>
Date:   Wed, 9 May 2018 10:53:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180509144221.GA14714@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/9/2018 10:42 AM, Jeff King wrote:
> On Wed, May 09, 2018 at 02:15:38PM +0000, Derrick Stolee wrote:
>
>> The commit-graph file lives in the .git/objects/info directory.
>> Previously, a failure to acquire the commit-graph.lock file was
>> assumed to be due to the lack of the info directory, so a mkdir()
>> was called. This gave incorrect messaging if instead the lockfile
>> was open by another process:
>>
>>    "fatal: cannot mkdir .git/objects/info: File exists"
>>
>> Rearrange the expectations of this directory existing to avoid
>> this error, and instead show the typical message when a lockfile
>> already exists.
> Sounds like a reasonable bug fix.
>
> Your cover letter is way longer than this description. Should some of
> that background perhaps go in the commit message?

I did want a place to include the full die() message in the new 
behavior, but that seemed like overkill for the commit message.

> (I would go so far as to say that sending a cover letter for a single
> patch is an anti-pattern, because the commit message should be able to
> stand on its own).
>
>> @@ -754,23 +755,14 @@ void write_commit_graph(const char *obj_dir,
>>   	compute_generation_numbers(&commits);
>>   
>>   	graph_name = get_commit_graph_filename(obj_dir);
>> -	fd = hold_lock_file_for_update(&lk, graph_name, 0);
>>   
>> -	if (fd < 0) {
>> -		struct strbuf folder = STRBUF_INIT;
>> -		strbuf_addstr(&folder, graph_name);
>> -		strbuf_setlen(&folder, strrchr(folder.buf, '/') - folder.buf);
>> -
>> -		if (mkdir(folder.buf, 0777) < 0)
>> -			die_errno(_("cannot mkdir %s"), folder.buf);
>> -		strbuf_release(&folder);
>> -
>> -		fd = hold_lock_file_for_update(&lk, graph_name, LOCK_DIE_ON_ERROR);
>> -
>> -		if (fd < 0)
>> -			die_errno("unable to create '%s'", graph_name);
>> -	}
>> +	strbuf_addstr(&folder, graph_name);
>> +	strbuf_setlen(&folder, strrchr(folder.buf, '/') - folder.buf);
>> +	if (!file_exists(folder.buf) && mkdir(folder.buf, 0777) < 0)
>> +		die_errno(_("cannot mkdir %s"), folder.buf);
>> +	strbuf_release(&folder);
> The result is racy if somebody else is trying to create the directory at
> the same time. For that you'd want to notice EEXIST coming from mkdir
> and consider that a success.
>
> I think you probably ought to be calling adjust_shared_perm() on the
> result, too, in case core.sharedrepository is configured.
>
> If you use safe_create_leading_directories(), it should handle both.
> Something like:
>
>    if (safe_create_leading_directories(graph_name))
> 	die_errno(_("unable to create leading directories of %s"),
> 		  graph_name));
>
> I think I'm holding it right; that function is a little short on
> documentation, but it's the standard way to do this in Git's codebase,
> and you can find lots of example callers.

Thanks for this method. I was unfamiliar with it. Saves the effort of 
creating the strbuf, too.

Thanks,
-Stolee
