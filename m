Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53990C54EBE
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 19:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239676AbjALToi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 14:44:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232819AbjALToE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 14:44:04 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9773218B
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 11:35:12 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id g20so14561999pfb.3
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 11:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s283uBWOW452H4zsrsQ2/lekp9iZ/B+nQE8IuamOJJc=;
        b=BuLTIOoQIS+gdeZhk5UYGKsHgqFs8bD54NThiBiykF0993E4zNXYv8OTf6uSDj5EHj
         j2Qyxg6rA0N5iZcR3eVLuBfuXhRBpCpIWW4ULPr61gLb6YtULcH+3qFdLcomb5eoqj34
         HrHIBo7pEcpnR+ooTMpH19l3G8tj9HYfyuagzQEoTxgEW7P1tHlR72BidtpFrFi1Fsia
         OIYdg6lS7QUM+ExRZZaFjOhd/E10OIin9PEU7oao1MhWcsQOyXJYXKOnG27P9wFsFyCm
         EcKjPyEX+td9oXq7p4EeGCzEjLbFvWmnmDdh61tmAZ/by8nBo9mlbHYJQ+fUjJurarda
         spyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s283uBWOW452H4zsrsQ2/lekp9iZ/B+nQE8IuamOJJc=;
        b=RlmV9fi9jB710n3rDVYtg1bLuapDqB8SIDUuFUUg97IFeLQ4F25/cTCftv3ZzHqFhD
         Iox3j8Us4UeX7b815jytl70fUAfgj4IlUURIFioOZZXH1SKcyVKNBxCbtMZl/HMZ9ct2
         vU7wM1LbY8uYneD4qKFeukP3bi/gNwb9YBzE9c/Th5rDtuxia8tad/sBdcQ88nPHK8lu
         xUTj40tuItzFZjJCe3shVj10maEQlGTnv7Qget20cpPI1hImInwRO+i2ElEBy71/ra9N
         669HKznXtipNQNU1HZ2uTl5uMzZLNuiuBWko2l4qaMwVOY4Js3KcmDilQI3zExmw9BZ2
         blXw==
X-Gm-Message-State: AFqh2kooLarm4W5kJw4vw9MW/bLB2Y/XPoksDMkESrPQblB/ZSmk/yki
        5I12vDb3u1aWcjAUbbG9J8DoTTHkdohNlmA=
X-Google-Smtp-Source: AMrXdXugjo6UTw4eO1HFtsnHvHYAiP8rG2HamYY4lqXFkzLeXgChOetH4feyM7VU3gKWLsGZQb2zFA==
X-Received: by 2002:a05:6a00:722:b0:587:f436:6ea8 with SMTP id 2-20020a056a00072200b00587f4366ea8mr14774013pfm.16.1673552112486;
        Thu, 12 Jan 2023 11:35:12 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id q6-20020aa79606000000b005813f365afcsm3072531pfg.189.2023.01.12.11.35.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 11:35:12 -0800 (PST)
Message-ID: <e1b1a53b-69d7-6fd6-513d-0f6cb3751b51@github.com>
Date:   Thu, 12 Jan 2023 11:35:10 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v5 01/10] daemon: libify socket setup and option functions
Content-Language: en-US
To:     Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        Matthew John Cheetham <mjcheetham@github.com>
References: <pull.1352.v4.git.1670880984.gitgitgadget@gmail.com>
 <pull.1352.v5.git.1673475190.gitgitgadget@gmail.com>
 <74b0de14185120c9d53d7470e59f57fa20a1927f.1673475190.git.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <74b0de14185120c9d53d7470e59f57fa20a1927f.1673475190.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew John Cheetham via GitGitGadget wrote:
> From: Matthew John Cheetham <mjcheetham@outlook.com>
> 
> Extract functions for setting up listening sockets and keep-alive options
> from `daemon.c` to new `daemon-utils.{c,h}` files. Remove direct
> dependencies on global state by inlining the behaviour at the callsites
> for all libified functions.

Thanks for making this change, the reduced code duplication should make the
common daemon-related code more maintainable.

For reference, I used 

'git blame -s -b -C -C -C master..<this patch> -- daemon-utils.c' 

to help identify which lines in 'daemon-utils.c' were changed from their
original implementation in 'daemon.c'. I'll try to rearrange the diff to
show those differences more directly.

The first main change I see is that 'logerror' and 'reuseaddr' are changed
from global references to arguments in 'set_keep_alive()',
'setup_named_sock()' (same for 'NO_IPV6' defined and undefined), and
'socksetup()':

> -static void set_keep_alive(int sockfd)
> +void set_keep_alive(int sockfd, log_fn logerror)

> -static int setup_named_sock(char *listen_addr, int listen_port, struct socketlist *socklist)
> +static int setup_named_sock(char *listen_addr, int listen_port,
> +			    struct socketlist *socklist, int reuseaddr,
> +			    log_fn logerror)

> -static void socksetup(struct string_list *listen_addr, int listen_port, struct socketlist *socklist)
> +void socksetup(struct string_list *listen_addr, int listen_port,
> +	       struct socketlist *socklist, int reuseaddr,
> +	       log_fn logerror)

The external calls in 'daemon.c' to 'set_keep_alive()' and 'socksetup()' are
updated to pass the  'logerror()' function and global 'reuseaddr' as
arguments, so there isn't any change in behavior.

> @@ -759,7 +748,7 @@ static int execute(void)
>  	if (addr)
>  		loginfo("Connection from %s:%s", addr, port);
>  
> -	set_keep_alive(0);
> +	set_keep_alive(0, logerror);
>  	alarm(init_timeout ? init_timeout : timeout);
>  	pktlen = packet_read(0, packet_buffer, sizeof(packet_buffer), 0);
>  	alarm(0);
> @@ -1246,7 +1039,8 @@ static int serve(struct string_list *listen_addr, int listen_port,
>  {
>  	struct socketlist socklist = { NULL, 0, 0 };
>  
> -	socksetup(listen_addr, listen_port, &socklist);
> +	socksetup(listen_addr, listen_port, &socklist, reuseaddr,
> +		  logerror);
>  	if (socklist.nr == 0)
>  		die("unable to allocate any listen sockets on port %u",
>  		    listen_port);

The other notable change is moving the 'if (!reusaddr) return 0' block in
'set_reuse_addr()' to its callers in both 'setup_named_sock()'s:

> +#ifndef NO_IPV6
> +
> +static int setup_named_sock(char *listen_addr, int listen_port,
> +			    struct socketlist *socklist, int reuseaddr,
> +			    log_fn logerror)
> +{
...
> +		if (reuseaddr && set_reuse_addr(sockfd)) {
> +			logerror("Could not set SO_REUSEADDR: %s", strerror(errno));
> +			close(sockfd);
> +			continue;
> +		}
...
> +}
> +
> +#else /* NO_IPV6 */
> +
> +static int setup_named_sock(char *listen_addr, int listen_port,
> +			    struct socketlist *socklist, int reuseaddr,
> +			    log_fn logerror)
> +{
...
> +	if (reuseaddr && set_reuse_addr(sockfd)) {
> +		logerror("Could not set SO_REUSEADDR: %s", strerror(errno));
> +		close(sockfd);
> +		return 0;
> +	}
...
> +}
> +
> +#endif

Where, previously, that region looked like:

> -#ifndef NO_IPV6
> -
> -static int setup_named_sock(char *listen_addr, int listen_port, struct socketlist *socklist)
> -{
...
> -		if (set_reuse_addr(sockfd)) {
> -			logerror("Could not set SO_REUSEADDR: %s", strerror(errno));
> -			close(sockfd);
> -			continue;
> -		}
...
> -}
> -
> -#else /* NO_IPV6 */
> -
> -static int setup_named_sock(char *listen_addr, int listen_port, struct socketlist *socklist)
> -{
...
> -	if (set_reuse_addr(sockfd)) {
> -		logerror("Could not set SO_REUSEADDR: %s", strerror(errno));
> -		close(sockfd);
> -		return 0;
> -	}
...
> -}
> -
> -#endif

'reuseaddr' is passed into 'setup_named_sock()' from 'socksetup()' calls in
'daemon.c', so this also won't result in changed behavior.

Otherwise, you only expose functions & types that are called in 'daemon.c'
(the rest are still static), and everything else is a verbatim copy. Looks
good to me!

