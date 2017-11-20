Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 322B3202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 21:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753118AbdKTVyJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 16:54:09 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:43975 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753093AbdKTVyH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 16:54:07 -0500
Received: by mail-pg0-f66.google.com with SMTP id r12so8443801pgu.10
        for <git@vger.kernel.org>; Mon, 20 Nov 2017 13:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7FpywuS3+QerLUPRFshQgx046nWDg+b2xU7DSDquTpI=;
        b=P6WBKzRzoBo+cY4mWrYIihiChlVQCncB8d+K9bWA34JxH+1koJv9FAEPOOB8KGNQxc
         /0TzwCWA7FVk2E2UWEmKURFNW3XDpPvb4bsl6+e8ikYPVp36y8tM0wHnzNAkQpgFtT79
         R4IApduXStb7iYXxL5pamEWS1BADtcXJaFGhCrUeP9Sd8kHAov+M39gkMrRAfENcnBTt
         EX5ZiBmtug4zceb7rcjcDgBMdkRWU+45PCG0mKsanRXThvWxwg4D9/hPkDdin8AQnafa
         uZWfsdi4ttx9RYvCeM7aqcjLMTWQytiHkijJJifZN2IdsSXollBwYywD6ndbMGkTz2dW
         t75g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7FpywuS3+QerLUPRFshQgx046nWDg+b2xU7DSDquTpI=;
        b=egux8rY1QpHhf1VzGhE1E5zn7atCXtSQFsruTZQUgGVzva98yB9XC05ISBjdry6LWI
         Wu+5ZAYKsXz1V1ZP3fRJejUN3wh7AO/EDx5TbeX6JHDAPj5zK8yJm3VUpQ86anohcurj
         +6+lBAQq710uv2RYaQBObKtrrA2Px2oABIbkZhX+FTkvsOdxMlwZXshoTc4uda6/B3fs
         W6N7Mf9qqW6OlVItZUML9KSQnsYmvxQxpyPXEuVE1acy+FA9n5kEnmW+2eXk3cI/LEa2
         3igEQhMLPmdiWyLkk8JVQP/Nw7Hhor7hFfaTAFn2rBTWUuME6NmeOwpVgnDddLSqFwcH
         pUCA==
X-Gm-Message-State: AJaThX5o8IasaasqhKBEWIoVbhbH+SI6+/2Hchv2aOYXSoGHT5WGiky7
        Hybo1eXj9/GaDy0NFilVv0iKEg==
X-Google-Smtp-Source: AGs4zMatMLGaiYAqMnZtmbj3A2MS+UVt4eG9nobREKnqsejVlxzeCSkGKV0CGFwVmXnVFUF07Jki6g==
X-Received: by 10.98.75.77 with SMTP id y74mr12745925pfa.78.1511214846389;
        Mon, 20 Nov 2017 13:54:06 -0800 (PST)
Received: from google.com ([2620:0:100e:422:255c:f926:518d:9e83])
        by smtp.gmail.com with ESMTPSA id a7sm17046434pgc.81.2017.11.20.13.54.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 20 Nov 2017 13:54:05 -0800 (PST)
Date:   Mon, 20 Nov 2017 13:54:04 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Segev Finer <segev208@gmail.com>
Subject: Re: [PATCH 4/8] connect: split ssh command line options into
 separate function
Message-ID: <20171120215404.GC92506@google.com>
References: <20171120212134.lh2l4drdzu6fh5g2@aiede.mtv.corp.google.com>
 <20171120212505.5t6vzvkfvhmjqwsd@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171120212505.5t6vzvkfvhmjqwsd@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/20, Jonathan Nieder wrote:
> The git_connect function is growing long.  Split the portion that
> discovers an ssh command and options it accepts before the service
> name and path to a separate function to make it easier to read.
> 
> No functional change intended.
> 
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> Reviewed-by: Stefan Beller <sbeller@google.com>
> ---
> As before.
> 
>  connect.c | 116 +++++++++++++++++++++++++++++++++-----------------------------
>  1 file changed, 61 insertions(+), 55 deletions(-)
> 
> diff --git a/connect.c b/connect.c
> index 9425229206..a9dc493db2 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -919,6 +919,65 @@ static struct child_process *git_connect_git(int fd[2], char *hostandport,
>  	return conn;
>  }
>  
> +/* Prepare a child_process for use by Git's SSH-tunneled transport. */
> +static void fill_ssh_args(struct child_process *conn, const char *ssh_host,
> +			  const char *port, int flags)
> +{
> +	const char *ssh;
> +	enum ssh_variant variant;
> +
> +	if (looks_like_command_line_option(ssh_host))
> +		die("strange hostname '%s' blocked", ssh_host);
> +
> +	ssh = get_ssh_command();
> +	if (ssh) {
> +		variant = determine_ssh_variant(ssh, 1);
> +	} else {
> +		/*
> +		 * GIT_SSH is the no-shell version of
> +		 * GIT_SSH_COMMAND (and must remain so for
> +		 * historical compatibility).
> +		 */
> +		conn->use_shell = 0;
> +
> +		ssh = getenv("GIT_SSH");
> +		if (!ssh)
> +			ssh = "ssh";
> +		variant = determine_ssh_variant(ssh, 0);
> +	}
> +
> +	argv_array_push(&conn->args, ssh);
> +
> +	if (variant == VARIANT_SSH &&
> +	    get_protocol_version_config() > 0) {
> +		argv_array_push(&conn->args, "-o");
> +		argv_array_push(&conn->args, "SendEnv=" GIT_PROTOCOL_ENVIRONMENT);
> +		argv_array_pushf(&conn->env_array, GIT_PROTOCOL_ENVIRONMENT "=version=%d",
> +				 get_protocol_version_config());
> +	}
> +
> +	if (variant != VARIANT_SIMPLE) {
> +		if (flags & CONNECT_IPV4)
> +			argv_array_push(&conn->args, "-4");
> +		else if (flags & CONNECT_IPV6)
> +			argv_array_push(&conn->args, "-6");
> +	}
> +
> +	if (variant == VARIANT_TORTOISEPLINK)
> +		argv_array_push(&conn->args, "-batch");
> +
> +	if (port && variant != VARIANT_SIMPLE) {
> +		if (variant == VARIANT_SSH)
> +			argv_array_push(&conn->args, "-p");
> +		else
> +			argv_array_push(&conn->args, "-P");
> +
> +		argv_array_push(&conn->args, port);
> +	}
> +
> +	argv_array_push(&conn->args, ssh_host);
> +}
> +
>  /*
>   * This returns the dummy child_process `no_fork` if the transport protocol
>   * does not need fork(2), or a struct child_process object if it does.  Once
> @@ -972,16 +1031,13 @@ struct child_process *git_connect(int fd[2], const char *url,
>  		conn->use_shell = 1;
>  		conn->in = conn->out = -1;
>  		if (protocol == PROTO_SSH) {
> -			const char *ssh;
> -			enum ssh_variant variant;
>  			char *ssh_host = hostandport;
>  			const char *port = NULL;
> +
>  			transport_check_allowed("ssh");
>  			get_host_and_port(&ssh_host, &port);
> -
>  			if (!port)
>  				port = get_port(ssh_host);
> -

Are these random additions and deletions intentional?

>  			if (flags & CONNECT_DIAG_URL) {
>  				printf("Diag: url=%s\n", url ? url : "NULL");
>  				printf("Diag: protocol=%s\n", prot_name(protocol));
> @@ -995,57 +1051,7 @@ struct child_process *git_connect(int fd[2], const char *url,
>  				strbuf_release(&cmd);
>  				return NULL;
>  			}
> -
> -			if (looks_like_command_line_option(ssh_host))
> -				die("strange hostname '%s' blocked", ssh_host);
> -
> -			ssh = get_ssh_command();
> -			if (ssh) {
> -				variant = determine_ssh_variant(ssh, 1);
> -			} else {
> -				/*
> -				 * GIT_SSH is the no-shell version of
> -				 * GIT_SSH_COMMAND (and must remain so for
> -				 * historical compatibility).
> -				 */
> -				conn->use_shell = 0;
> -
> -				ssh = getenv("GIT_SSH");
> -				if (!ssh)
> -					ssh = "ssh";
> -				variant = determine_ssh_variant(ssh, 0);
> -			}
> -
> -			argv_array_push(&conn->args, ssh);
> -
> -			if (variant == VARIANT_SSH &&
> -			    get_protocol_version_config() > 0) {
> -				argv_array_push(&conn->args, "-o");
> -				argv_array_push(&conn->args, "SendEnv=" GIT_PROTOCOL_ENVIRONMENT);
> -				argv_array_pushf(&conn->env_array, GIT_PROTOCOL_ENVIRONMENT "=version=%d",
> -						 get_protocol_version_config());
> -			}
> -
> -			if (variant != VARIANT_SIMPLE) {
> -				if (flags & CONNECT_IPV4)
> -					argv_array_push(&conn->args, "-4");
> -				else if (flags & CONNECT_IPV6)
> -					argv_array_push(&conn->args, "-6");
> -			}
> -
> -			if (variant == VARIANT_TORTOISEPLINK)
> -				argv_array_push(&conn->args, "-batch");
> -
> -			if (port && variant != VARIANT_SIMPLE) {
> -				if (variant == VARIANT_SSH)
> -					argv_array_push(&conn->args, "-p");
> -				else
> -					argv_array_push(&conn->args, "-P");
> -
> -				argv_array_push(&conn->args, port);
> -			}
> -
> -			argv_array_push(&conn->args, ssh_host);
> +			fill_ssh_args(conn, ssh_host, port, flags);
>  		} else {
>  			transport_check_allowed("file");
>  			if (get_protocol_version_config() > 0) {
> -- 
> 2.15.0.448.gf294e3d99a
> 

-- 
Brandon Williams
