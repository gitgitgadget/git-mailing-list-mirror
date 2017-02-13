Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F20121FC44
	for <e@80x24.org>; Mon, 13 Feb 2017 22:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751484AbdBMWjD (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 17:39:03 -0500
Received: from mail-ot0-f193.google.com ([74.125.82.193]:35468 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751467AbdBMWjC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 17:39:02 -0500
Received: by mail-ot0-f193.google.com with SMTP id 65so13911836otq.2
        for <git@vger.kernel.org>; Mon, 13 Feb 2017 14:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=p84Ryx8J5z9BsPBqdvLzNzQEG4UYZUeLK129JLdHCKQ=;
        b=GTb58KwdJXYfTbT43VXsaSDYNXoYdy0KRkkNF8jj5t+xeDrX4DilMUabWQMNivNSmb
         aGhAVdaznp0EgPvu+Oa4ydpyLCEbltIeUNBjnw2BpL8VeUlahqV50rrs/3haI8RgyRK5
         xs+ozUccSl/H7y6lbkKr6KrvJ6Ulwbbp55H0pC8iZ2ePWiI2Z9SVs3rfuOVPXAXsjYT5
         iBNM148w7ncsY2HNYsghsbYS3mz1pW9XduDMe96F6IVMuvV1YXwAGVjfd6QWXdItBTrC
         HDYV2sfjiSQ2k3f7SbRDZdRofC84JhJGEqAtnDk/4FuGDcq4xQw5UOMoJfWbz2dxiZn0
         4bpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=p84Ryx8J5z9BsPBqdvLzNzQEG4UYZUeLK129JLdHCKQ=;
        b=tHgBj9rrtMR3K5lbTSySAkJwkerXT1GTcoLkUjNeCLIB+ICEcYHzcf3TqQO+tqpRTz
         JsITFSzEfrCtb51ZMaaJEHW1VhY5gv7CSGEfXawuf/jxWSw/wAeakkmwNx2VcXC45vWf
         AljqDhWYYc7Cd61xcfb7PagArQpxQ9CDQj5GUQaVr9cTGdsU4FfjUCi4Tuc6MbuiXj+/
         itlMC/k5+IaxOURGVSOYeYg1slot9fU35gFd9uJx+fVVS0G/lfat8GEGqb5hoyfy4Srm
         0NH6YpwDxWEh5yzxgA/OPfALjeE52sJYWXeuBC3T1EkBbhYuhq7+LIKWpDG1pTaFP63D
         cwbQ==
X-Gm-Message-State: AMke39ksEz1mbLV4tvqXFxTlXJayI4qBo+PiG2tRbzpKwWEB/vBOZ9bNt8bF9o/erXQA/Q==
X-Received: by 10.99.1.87 with SMTP id 84mr29239226pgb.142.1487025541325;
        Mon, 13 Feb 2017 14:39:01 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:d0e0:42a7:601f:5154])
        by smtp.gmail.com with ESMTPSA id g87sm22775373pfj.20.2017.02.13.14.39.00
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 13 Feb 2017 14:39:00 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH] mingw: make stderr unbuffered again
References: <c88612da0a62bfcbc3e278296f9d3eb010057071.1487025228.git.johannes.schindelin@gmx.de>
Date:   Mon, 13 Feb 2017 14:39:00 -0800
In-Reply-To: <c88612da0a62bfcbc3e278296f9d3eb010057071.1487025228.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Mon, 13 Feb 2017 23:34:06 +0100
        (CET)")
Message-ID: <xmqqlgt9btrv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> When removing the hack for isatty(), we actually removed more than just
> an isatty() hack: we removed the hack where internal data structures of
> the MSVC runtime are modified in order to redirect stdout/stderr.
>
> Instead of using that hack (that does not work with newer versions of
> the runtime, anyway), we replaced it by reopening the respective file
> descriptors.
>
> What we forgot was to mark stderr as unbuffered again.
>
> Reported by Hannes Sixt. Fixed with Jeff Hostetler's assistance.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> Published-As: https://github.com/dscho/git/releases/tag/mingw-unbuffered-stderr-v1
> Fetch-It-Via: git fetch https://github.com/dscho/git mingw-unbuffered-stderr-v1

OK.  Should this go directly to 'master', as the isatty thing is
already in?

>
>  compat/winansi.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/compat/winansi.c b/compat/winansi.c
> index 82b89ab1376..793420f9d0d 100644
> --- a/compat/winansi.c
> +++ b/compat/winansi.c
> @@ -510,6 +510,8 @@ static HANDLE swap_osfhnd(int fd, HANDLE new_handle)
>  	 */
>  	close(new_fd);
>  
> +	if (fd == 2)
> +		setvbuf(stderr, NULL, _IONBF, BUFSIZ);
>  	fd_is_interactive[fd] |= FD_SWAPPED;
>  
>  	return duplicate;
> @@ -547,6 +549,8 @@ static void detect_msys_tty(int fd)
>  			!wcsstr(name, L"-pty"))
>  		return;
>  
> +	if (fd == 2)
> +		setvbuf(stderr, NULL, _IONBF, BUFSIZ);
>  	fd_is_interactive[fd] |= FD_MSYS;
>  }
>  
>
> base-commit: 5588dbffbd61e4906e453808c6ad32f792fea521
