Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95FEC54EBE
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 19:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239964AbjALTom (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Jan 2023 14:44:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239768AbjALToG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2023 14:44:06 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317D932260
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 11:35:28 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id p24so21213305plw.11
        for <git@vger.kernel.org>; Thu, 12 Jan 2023 11:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xeefDRaD8FfZIH6FZlMduhu/4JWyRXLUIOGdQaB3GKo=;
        b=UzdF30cbDCpf+YMaw07sKdn4Km5y+c3a4WGDZiThZtU/WOrkS8dhQS0RfF7Mwdy2ly
         4pATwziQtewM1T1s3QvK+F6UM7XxinX1etjpFElEV139ow3SewljCJZelyxmbvNpyjyc
         ygSxkSXLpAXd0/j705QRvmAJYfdtci4wTisJRnNAT0/j7cuI5lKvYSUt0agPLWJC4IUE
         EvRZOUcplAw0GS2stK8bLePX4okWtoEYaNXZ8yar8lGTVt8KgdrxNayi4AaaKAFQyyjy
         H8RnyzUQ/UrnhW2Ao/8vrdcJK7RJTyBPD20KQnd4k0+ZvhgD1qG2EkSRIHuWDvypCVA3
         YWXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xeefDRaD8FfZIH6FZlMduhu/4JWyRXLUIOGdQaB3GKo=;
        b=mgGgL7G5v+BPWbOK/uroJVa/BJwbLZnGqs/oI/clEHE0sYbgGm0Bi6EiMFrt139mJ0
         jbRec3gLecyo2fSnk0yGkHH/eKbJCBDrQmxnfG2+4KGI3sbRNgeuXb1uP4sUhrfUThAQ
         7HAtMycW+Gwv8/KfIl1AZBTkxFOpe/zOubWbiM+tPzIX24LiB9hFFO0GQssHPE703IJr
         ElHcY3ijFtO3VHowjjyamuMF4U1aPXGOrlsDCbx5k5PncxZaSAP3KHvLkd2ZGq/R3uAk
         0dGQhc71dzpXSykxZzexz5r8KhhYgLJQ15sca+4qDlQpPIM5bzE9KlH7zpfSWyZAFIYj
         PjXQ==
X-Gm-Message-State: AFqh2kpsyCHauNgCrKoUmHrUhkiuPUPttO1/6aBvJ7k9D7fMkfvLOFZv
        JzKN71Cd+E09VI1/XMm+DR92
X-Google-Smtp-Source: AMrXdXvWrUfehDKbzSq7fd1eNmYR6OSZJoopn8u8s7lBhP28IFcNyHTRG4dLdAC55CD7ZE+IvYwpkA==
X-Received: by 2002:a17:902:9a98:b0:193:167c:d4b1 with SMTP id w24-20020a1709029a9800b00193167cd4b1mr21731392plp.11.1673552127671;
        Thu, 12 Jan 2023 11:35:27 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902c20600b0019468fe44d3sm316248pll.25.2023.01.12.11.35.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 11:35:27 -0800 (PST)
Message-ID: <3a8d1b66-ed06-16a3-5459-9381faa69420@github.com>
Date:   Thu, 12 Jan 2023 11:35:25 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v5 02/10] daemon: libify child process handling functions
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
 <bc972fc8d3d3a028d3d160aac354d2a13bad37ae.1673475190.git.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <bc972fc8d3d3a028d3d160aac354d2a13bad37ae.1673475190.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew John Cheetham via GitGitGadget wrote:
> From: Matthew John Cheetham <mjcheetham@outlook.com>
> 
> Extract functions and structures for managing child processes started
> from the parent daemon-like process from `daemon.c` to the new shared
> `daemon-utils.{c,h}` files.

As with patch 1, it looks like the main changes here are changing global
references to function arguments. Specifically, those variables are
'firstborn', 'live_children', and 'loginfo':

> -static void add_child(struct child_process *cld, struct sockaddr *addr, socklen_t addrlen)
> +void add_child(struct child_process *cld, struct sockaddr *addr, socklen_t addrlen,
> +	       struct child *firstborn , unsigned int *live_children)

> -static void kill_some_child(void)
> +void kill_some_child(struct child *firstborn)

> -static void check_dead_children(void)
> +void check_dead_children(struct child *firstborn, unsigned int *live_children,
> +			 log_fn loginfo)

Those values are provided by the callers in 'daemon.c'. The major change
here is that 'live_children' is passed as a pointer, since its value is
updated by  difference is passing 'live_children' as a pointer, since its
value is updated by 'check_dead_children()' and 'add_child()':

> @@ -879,9 +797,9 @@ static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
>  	struct child_process cld = CHILD_PROCESS_INIT;
>  
>  	if (max_connections && live_children >= max_connections) {
> -		kill_some_child();
> +		kill_some_child(firstborn);
>  		sleep(1);  /* give it some time to die */
> -		check_dead_children();
> +		check_dead_children(firstborn, &live_children, loginfo);
>  		if (live_children >= max_connections) {
>  			close(incoming);
>  			logerror("Too many children, dropping connection");
> @@ -914,7 +832,7 @@ static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
>  	if (start_command(&cld))
>  		logerror("unable to fork");
>  	else
> -		add_child(&cld, addr, addrlen);
> +		add_child(&cld, addr, addrlen, firstborn, &live_children);
>  }
>  
>  static void child_handler(int signo)
> @@ -944,7 +862,7 @@ static int service_loop(struct socketlist *socklist)
>  	for (;;) {
>  		int i;
>  
> -		check_dead_children();
> +		check_dead_children(firstborn, &live_children, loginfo);
>  
>  		if (poll(pfd, socklist->nr, -1) < 0) {
>  			if (errno != EINTR) {

However, I think that change to 'live_children' may have caused a bug. In
'check_dead_children()', you decrement the 'live_children' *pointer*. That
changes its address, not its value:

> +void check_dead_children(struct child *firstborn, unsigned int *live_children,
> +			 log_fn loginfo)
> +{
...
> +			live_children--;
...
> +}

Same thing in 'add_child()':

> +void add_child(struct child_process *cld, struct sockaddr *addr, socklen_t addrlen,
> +	       struct child *firstborn , unsigned int *live_children)
> +{
...
> +	live_children++;
...
> +}

These should be changed to '(*live_children)--' and '(*live_children)++',
respectively.

There's also one minor functional change in 'check_dead_children()', where
an 'if (loginfo)' check is added guarding the call to 'loginfo()':

> +void check_dead_children(struct child *firstborn, unsigned int *live_children,
> +			 log_fn loginfo)
> +{
...
> +			if (loginfo) {
> +				const char *dead = "";
> +				if (status)
> +					dead = " (with error)";
> +				loginfo("[%"PRIuMAX"] Disconnected%s",
> +					(uintmax_t)pid, dead);
> +			}
...
> +}

I'm guessing this is done because a caller later in the series won't provide
a 'loginfo', but if that's the case, it would help to note that in this
patch's commit message.

The one other thing I noticed is that you removed the function documentation
for 'kill_some_child()':

> -/*
> - * This gets called if the number of connections grows
> - * past "max_connections".
> - *
> - * We kill the newest connection from a duplicate IP.
> - */

Is there a reason why you removed it? Otherwise, it should be added back in
- probably in 'daemon-utils.h'?

Everything else here looks good.
