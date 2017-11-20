Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEA5F202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 22:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751212AbdKTW2Y (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 17:28:24 -0500
Received: from mail-io0-f181.google.com ([209.85.223.181]:38470 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751146AbdKTW2X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 17:28:23 -0500
Received: by mail-io0-f181.google.com with SMTP id h205so16647653iof.5
        for <git@vger.kernel.org>; Mon, 20 Nov 2017 14:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FUQEYKHwc9+CE0N8yYtpyZNTpl+m/IoCwd0/ApdS1qs=;
        b=KdXCwtZFpeY48UBo3zIUrwXETKFjxYDvttHw82TPoUyinhaArKqXsqRnTwjE2aSZzp
         PGCnYQQ9k97pNqXYVw0EKcvRa6ZQILjMmUDzDsWbyx6+wpqetJlRiSWMZg+rV6GZ6Aka
         /lkMlX3ABIVedVD6yx/yIPZIfEfWSFpVI2IpCjQ2mAPjqp4rlDzfS2WGvt5afy2hgGDa
         5J9tW9o0qOnRvpKsAVLkCYAD2k1uslcZ3w7i92rb0777E3gVcV55BGjTEunj1qwlCyXQ
         D9n0ZrLlJwlKEDFAKP+XUNLsDfYCR/q3wGDjb1N1N+ZOtxCdg1ApjICtqoIdV9n63w6k
         gxwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FUQEYKHwc9+CE0N8yYtpyZNTpl+m/IoCwd0/ApdS1qs=;
        b=ebVWCJ8llY1vF9nr3ivSyw8zA6rmXSBx03O7e39X5RY1YEDrejyH6jj5b6TIF2T8CX
         HXPmmIxyl1cy38IZFr7jiHZjKQYjbcy3jzL7GFhg+p+ZC7hoI4+hTEiWzepW8zuF2NSZ
         7Sq1Wj5KwH8cCfDpbNPSKR/95duBbdt1vM+maGIuA1arQ0qvMh/Io6obpKfL2Vf+ujub
         BicK4WxcsEr8pBvdqJddUG1HVsluvwRzoliNrDBpZBfI3eQKsn3/gpRZkYXmLm+yT38d
         nYkv6Vh4FFKqp6Fe46WxETgFtx6bDKZvExrCOfZDbRD0fO5sh+YWDv7+1vg4vNdLmJDJ
         1XKw==
X-Gm-Message-State: AJaThX4pE2Zo9h3+G1CJCb/6U61x26VyiJeKY6rcvHCln8YNY02D0FpZ
        xPpSkD/YfIBMQj/SKHb3WX/Ugg==
X-Google-Smtp-Source: AGs4zMaKhX/yQUFKzRJL2QT1X6SrOr/JITFKkFEfSdOuu0A6vHC96mFSuc0XZzTh8DB94yWHIjP8HQ==
X-Received: by 10.107.142.72 with SMTP id q69mr635378iod.205.1511216903045;
        Mon, 20 Nov 2017 14:28:23 -0800 (PST)
Received: from google.com ([2620:0:100e:422:255c:f926:518d:9e83])
        by smtp.gmail.com with ESMTPSA id e82sm4781829iof.34.2017.11.20.14.28.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 20 Nov 2017 14:28:22 -0800 (PST)
Date:   Mon, 20 Nov 2017 14:28:20 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Segev Finer <segev208@gmail.com>
Subject: Re: [PATCH 4/8] connect: split ssh command line options into
 separate function
Message-ID: <20171120222820.GE92506@google.com>
References: <20171120212134.lh2l4drdzu6fh5g2@aiede.mtv.corp.google.com>
 <20171120212505.5t6vzvkfvhmjqwsd@aiede.mtv.corp.google.com>
 <20171120215404.GC92506@google.com>
 <20171120220950.f5ipri354x6squck@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171120220950.f5ipri354x6squck@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/20, Jonathan Nieder wrote:
> Hi,
> 
> Brandon Williams wrote:
> > On 11/20, Jonathan Nieder wrote:
> [long stream of quoted context snipped; please cut down the quoted
>  text to what you are replying to in the future]
> >> @@ -972,16 +1031,13 @@ struct child_process *git_connect(int fd[2], const char *url,
> >>  		conn->use_shell = 1;
> >>  		conn->in = conn->out = -1;
> >>  		if (protocol == PROTO_SSH) {
> >> -			const char *ssh;
> >> -			enum ssh_variant variant;
> >>  			char *ssh_host = hostandport;
> >>  			const char *port = NULL;
> >> +
> >>  			transport_check_allowed("ssh");
> >>  			get_host_and_port(&ssh_host, &port);
> >> -
> >>  			if (!port)
> >>  				port = get_port(ssh_host);
> >> -
> >
> > Are these random additions and deletions intentional?
> 
> Sorry about that.  It was to make the code easier to read, but I can
> see how it's jarring during review.  I can resend without the removed
> blank lines if you like.

If its for better code readability I'm all for the additions and
deletions.  I just wanted to make sure they were intentional :)

So I'm fine with either the original or the modified patch.

> 
> For context, here's the code in question after the current patch:
> 
> 	if (protocol == PROTO_SSH) {
> 		char *ssh_host = hostandport;
> 		const char *port = NULL;
> 
> 		transport_check_allowed("ssh");
> 		get_host_and_port(&ssh_host, &port);
> 		if (!port)
> 			port = get_port(ssh_host);
> 		if (flags & CONNECT_DIAG_URL) {
> 			printf("Diag: url=%s\n", url ? url : "NULL");
> 			printf("Diag: protocol=%s\n", prot_name(protocol));
> 			printf("Diag: userandhost=%s\n", ssh_host ? ssh_host : "NULL");
> 			printf("Diag: port=%s\n", port ? port : "NONE");
> 			printf("Diag: path=%s\n", path ? path : "NULL");
> 
> 			free(hostandport);
> 			free(path);
> 			free(conn);
> 			strbuf_release(&cmd);
> 			return NULL;
> 		}
> 		fill_ssh_args(conn, ssh_host, port, flags);
> 	} else {
> 		transport_check_allowed("file");
> 		if (get_protocol_version_config() > 0) {
> 			argv_array_pushf(&conn->env_array, GIT_PROTOCOL_ENVIRONMENT "=version=%d",
> 					 get_protocol_version_config());
> 		}
> 	}
> 
> Jonathan

-- 
Brandon Williams
