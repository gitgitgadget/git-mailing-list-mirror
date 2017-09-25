Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF478202A5
	for <e@80x24.org>; Mon, 25 Sep 2017 23:33:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966291AbdIYXdU (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 19:33:20 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:46611 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966206AbdIYXdT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 19:33:19 -0400
Received: by mail-pf0-f172.google.com with SMTP id r68so4609869pfj.3
        for <git@vger.kernel.org>; Mon, 25 Sep 2017 16:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K/36uucDh2X05p03cI8+rYqHC/WU4/BQLZsdkCktSnE=;
        b=YAs3BmO9nL8+lXIp8D2BJdf7c18Ypa8RbIE8TP+1ZKrapAOieQJ5UMGcAo9/cl4IPd
         2FuivGgZ2RgKSrLCEYlkTE1p7FJMAFglZUpKvAQwTBTfBtmzjGj+TOkwgiGkdCSGhDVv
         XlC5MA7AsNxpN42pGQLJ1YtbtcFa+lCLqsemaoNG6K6KB0Bs8JMC6NLFZ1In+mdyNBXB
         hwJCVMbPUSoa1g2qGmr5bY7MIn6Di3X8BZV3Et61hBGCrKNxKlz06Fh6Muydky/KnTV9
         4BltkSZD/6ov3v9jsBejB4ceg4qmRxJdy2F3oewwzc23fT1eK2v5w/ZS1YZPpAQAoCO+
         5tPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K/36uucDh2X05p03cI8+rYqHC/WU4/BQLZsdkCktSnE=;
        b=aBM0hFGdWR6rg8J3aZTpVhBKWtTkUcVSa3EhK1DrJENPFVLtdjP4nxfJrlD+/FWaYG
         Q4aiVUdVCakxbyarPi5bHRvRnKctjs2LBecqzyWvL7zMiXanjmGxTrIntXKvTyfBJ6ML
         U04yLZOAIv4Kv9lG+EtTRT1LHn44UN0r+aiXWcZq46XBk9sXDeEzk9uDG1rZB1I9UrwH
         56r6ctAHj+/SdnsHcMGi4idtIpbqCW+59z170Ju6yw5e/FOp7VlMby0Ux0dlsc2hWOpB
         56N70aQNxs/HSv36v8DDhD3HocIjj5YLzi00XgSIMnFxTAkUtBk+DOZdaKGMDKNxkg4y
         IUSA==
X-Gm-Message-State: AHPjjUhtqfixQhume6pZulhsG07lyX9ga6tbXAgO92LM9w6+as8F0p63
        K8Fzk1JJZMuuIh1+qt3mMhV0ep3/
X-Google-Smtp-Source: AOwi7QDQIsYaeksVeG/UHLO7ZPPinBrcQOo9VKW1Y19W2OvO77TGBGY4sDt48ifOhWpnSfqYJGaUNA==
X-Received: by 10.98.68.82 with SMTP id r79mr9177140pfa.184.1506382398794;
        Mon, 25 Sep 2017 16:33:18 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:b5cd:5017:828c:d0cb])
        by smtp.gmail.com with ESMTPSA id f24sm13063082pfk.137.2017.09.25.16.33.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 25 Sep 2017 16:33:18 -0700 (PDT)
Date:   Mon, 25 Sep 2017 16:33:16 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/7] read_in_full: reset errno before reading
Message-ID: <20170925233316.GI27425@aiede.mtv.corp.google.com>
References: <20170925202646.agsnpmar3dzocdcr@sigill.intra.peff.net>
 <20170925202916.4tqo4gttrsoy7kai@sigill.intra.peff.net>
 <20170925220914.GB27425@aiede.mtv.corp.google.com>
 <20170925232313.hhtqpxuzpzbnbdop@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170925232313.hhtqpxuzpzbnbdop@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:

>> --- a/wrapper.c
>> +++ b/wrapper.c
>> @@ -318,8 +318,10 @@ ssize_t read_in_full(int fd, void *buf, size_t count)
>>  		ssize_t loaded = xread(fd, p, count);
>>  		if (loaded < 0)
>>  			return -1;
>> -		if (loaded == 0)
>> +		if (loaded == 0) {
>> +			errno = EILSEQ;
>>  			return total;
>> +		}
>
> If I do this:
>
>   errno = 0;
>   read_in_full(fd, buf, sizeof(buf));
>   if (errno)
> 	die_errno("oops");
>
> then we'll claim an error, even though there was none (remember that
> it's only an error for _some_ callers to not read the whole length).
>
> This may be sufficiently odd that we don't need to care about it. There
> are some calls (like strtoul) which require this kind of clear-and-check
> strategy with errno, but in general we frown on it for calls like
> read().

Correct.  Actually more than "frown on": except for with the few calls
like strtoul that are advertised to work this way, POSIX does not make
the guarantee the above code would rely on, at all.

So it's not just frowned upon: it's so unportable that the standard
calls it out as something that won't work.

> We could also introduce a better helper like this:
>
>   int read_exactly(int fd, void *buf, size_t count)
>   {
> 	ssize_t ret = read_in_full(fd, buf, count);
> 	if (ret < 0)
> 		return -1;
> 	if (ret != count) {
> 		errno = EILSEQ;
> 		return -1;
> 	}
> 	return 0;
>   }
>
> Then we know that touching errno always coincides with an error return.
> And it's shorter to check "< 0" compared to "!= count" in the caller.
> But of course a caller which wants to distinguish the two cases for its
> error messages then has to look at errno:

That sounds nice, but it doesn't solve the original problem of callers
using read_in_full that way.

Thanks,
Jonathan
