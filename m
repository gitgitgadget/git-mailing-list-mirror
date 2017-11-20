Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF85B202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 21:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752931AbdKTVwW (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 16:52:22 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:43198 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751109AbdKTVwV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 16:52:21 -0500
Received: by mail-io0-f193.google.com with SMTP id s37so6393307ioe.10
        for <git@vger.kernel.org>; Mon, 20 Nov 2017 13:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T+7NYxbNc2+eTx3r/FN+/FzkMdUq7uBzshxu6YJugS0=;
        b=rODVx9kaDfLYe7lDDxROPoHubWuKuMZ7vcYnQZs5iiH4z8bUq5blucReiy1ug1QwlA
         2MU+2X0Lf2xRatOVq581Uz+ngGpvMS8ZAH3PMR9Y9U/aw2CLEPBc+Fa9K9CCkri883SY
         MaEaX+OGi154zpSpIM03Xdu0paP/nswwVkFjPImM6dVbdUUnoZF08Q7S+wkiG6VnJNSR
         rN1Sdnj7Ozra367HW0+jgN2BOXs7PZitF9OR6rK4OQBRxoiw1JvFZjIIS7rOF78quVcK
         uVOcbKUSAi+ft+8FSxKBcv8+g9IkDYKN59y0vsmf8r++/X6d5TcpYKMOCIGmOfE+iK1V
         RmuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T+7NYxbNc2+eTx3r/FN+/FzkMdUq7uBzshxu6YJugS0=;
        b=ZJaK2SvsF9sqjaFUyNbJ++KDVqfISBJlwsMT//ong2uprCXLOzbco66ARB3VwnOrKQ
         uVuJgkKMqOmEnadjA3DWDfdNgZ0CAOubM7F8mTTWG5WRU19fXU5nLwjPTMoF8HjjyWx4
         biUSkcKoDo1CYkn/uwzjJ6w0huY2fd6B9NNH0hJNmh0u1Pq+GFf3Oyu53MvGB3afMCRY
         tI5f5g8J3e1UjATetl2wdgSruUy6rcx2/67r8FN7vcu8EEcbQpNUBRFDiwOPz/ZbPrzJ
         t35pgA7gpaIuiKknvusf1TQs71g/6z1qgnNqYYSNj1uiTkY9oyim/DXTLJi3X1TxIn2G
         d4iQ==
X-Gm-Message-State: AJaThX42jM4SMimHyQwbsnw/Ql+RrCHxlpgzh7vKtWR1ELZu74F3VQkn
        3Phx0Tha3NNR+MwLboSBE41BaQ==
X-Google-Smtp-Source: AGs4zMZ0Y5H9eRsaxm2QkVjDekT9lvI9BiNGZKeMa256mn+RhpHdFKzLIfkIPOqClGpSo5jgbO7RKw==
X-Received: by 10.107.53.11 with SMTP id c11mr16261406ioa.293.1511214740824;
        Mon, 20 Nov 2017 13:52:20 -0800 (PST)
Received: from google.com ([2620:0:100e:422:255c:f926:518d:9e83])
        by smtp.gmail.com with ESMTPSA id w195sm5510711ita.44.2017.11.20.13.52.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 20 Nov 2017 13:52:19 -0800 (PST)
Date:   Mon, 20 Nov 2017 13:52:18 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Segev Finer <segev208@gmail.com>
Subject: Re: [PATCH 3/8] connect: split git:// setup into a separate function
Message-ID: <20171120215218.GB92506@google.com>
References: <20171120212134.lh2l4drdzu6fh5g2@aiede.mtv.corp.google.com>
 <20171120212327.ssk6vmw2hd5jwbi5@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171120212327.ssk6vmw2hd5jwbi5@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/20, Jonathan Nieder wrote:
> The git_connect function is growing long.  Split the
> PROTO_GIT-specific portion to a separate function to make it easier to
> read.
> 
> No functional change intended.
> 
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> Reviewed-by: Stefan Beller <sbeller@google.com>
> ---
> As before.
> 
>  connect.c | 103 +++++++++++++++++++++++++++++++++++---------------------------
>  1 file changed, 59 insertions(+), 44 deletions(-)
> 
> diff --git a/connect.c b/connect.c
> index aa994d1518..9425229206 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -861,6 +861,64 @@ static enum ssh_variant determine_ssh_variant(const char *ssh_command,
>  	return ssh_variant;
>  }
>  
> +/*
> + * Open a connection using Git's native protocol.
> + *
> + * The caller is responsible for freeing hostandport, but this function may
> + * modify it (for example, to truncate it to remove the port part).
> + */
> +static struct child_process *git_connect_git(int fd[2], char *hostandport,
> +					     const char *path, const char *prog,
> +					     int flags)
> +{
> +	struct child_process *conn;
> +	struct strbuf request = STRBUF_INIT;
> +	/*
> +	 * Set up virtual host information based on where we will
> +	 * connect, unless the user has overridden us in
> +	 * the environment.
> +	 */
> +	char *target_host = getenv("GIT_OVERRIDE_VIRTUAL_HOST");
> +	if (target_host)
> +		target_host = xstrdup(target_host);
> +	else
> +		target_host = xstrdup(hostandport);
> +
> +	transport_check_allowed("git");
> +
> +	/* These underlying connection commands die() if they
> +	 * cannot connect.
> +	 */

I know this is really just code motion but maybe we can fix the style of
the comment here?

> +	if (git_use_proxy(hostandport))
> +		conn = git_proxy_connect(fd, hostandport);
> +	else
> +		conn = git_tcp_connect(fd, hostandport, flags);
> +	/*
> +	 * Separate original protocol components prog and path
> +	 * from extended host header with a NUL byte.
> +	 *
> +	 * Note: Do not add any other headers here!  Doing so
> +	 * will cause older git-daemon servers to crash.
> +	 */
> +	strbuf_addf(&request,
> +		    "%s %s%chost=%s%c",
> +		    prog, path, 0,
> +		    target_host, 0);
> +
> +	/* If using a new version put that stuff here after a second null byte */
> +	if (get_protocol_version_config() > 0) {
> +		strbuf_addch(&request, '\0');
> +		strbuf_addf(&request, "version=%d%c",
> +			    get_protocol_version_config(), '\0');
> +	}
> +
> +	packet_write(fd[1], request.buf, request.len);
> +
> +	free(target_host);
> +	strbuf_release(&request);
> +	return conn;
> +}
> +
>  /*
>   * This returns the dummy child_process `no_fork` if the transport protocol
>   * does not need fork(2), or a struct child_process object if it does.  Once
> @@ -892,50 +950,7 @@ struct child_process *git_connect(int fd[2], const char *url,
>  		printf("Diag: path=%s\n", path ? path : "NULL");
>  		conn = NULL;
>  	} else if (protocol == PROTO_GIT) {
> -		struct strbuf request = STRBUF_INIT;
> -		/*
> -		 * Set up virtual host information based on where we will
> -		 * connect, unless the user has overridden us in
> -		 * the environment.
> -		 */
> -		char *target_host = getenv("GIT_OVERRIDE_VIRTUAL_HOST");
> -		if (target_host)
> -			target_host = xstrdup(target_host);
> -		else
> -			target_host = xstrdup(hostandport);
> -
> -		transport_check_allowed("git");
> -
> -		/* These underlying connection commands die() if they
> -		 * cannot connect.
> -		 */
> -		if (git_use_proxy(hostandport))
> -			conn = git_proxy_connect(fd, hostandport);
> -		else
> -			conn = git_tcp_connect(fd, hostandport, flags);
> -		/*
> -		 * Separate original protocol components prog and path
> -		 * from extended host header with a NUL byte.
> -		 *
> -		 * Note: Do not add any other headers here!  Doing so
> -		 * will cause older git-daemon servers to crash.
> -		 */
> -		strbuf_addf(&request,
> -			    "%s %s%chost=%s%c",
> -			    prog, path, 0,
> -			    target_host, 0);
> -
> -		/* If using a new version put that stuff here after a second null byte */
> -		if (get_protocol_version_config() > 0) {
> -			strbuf_addch(&request, '\0');
> -			strbuf_addf(&request, "version=%d%c",
> -				    get_protocol_version_config(), '\0');
> -		}
> -
> -		packet_write(fd[1], request.buf, request.len);
> -
> -		free(target_host);
> -		strbuf_release(&request);
> +		conn = git_connect_git(fd, hostandport, path, prog, flags);
>  	} else {
>  		struct strbuf cmd = STRBUF_INIT;
>  		const char *const *var;
> -- 
> 2.15.0.448.gf294e3d99a
> 

-- 
Brandon Williams
