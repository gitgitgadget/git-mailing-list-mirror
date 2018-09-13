Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PI_IMPORTANCE_HIGH,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02B381F404
	for <e@80x24.org>; Thu, 13 Sep 2018 16:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbeIMV5w (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Sep 2018 17:57:52 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45248 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbeIMV5w (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Sep 2018 17:57:52 -0400
Received: by mail-wr1-f68.google.com with SMTP id 20-v6so6846130wrb.12
        for <git@vger.kernel.org>; Thu, 13 Sep 2018 09:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:importance:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=jQWV3lBzQSv6vai5j6CVrUzZ0WwGECnVROuTO23rCE4=;
        b=ZJVIkI7uwreWaWH7890xUKJZgiwBCRnfPVJropKA/jzUdvVWGyaoq0MvieJAq1+XSr
         PE5aWOgyrN4JdwP4hrBCA6p9dHsQrSZup+hR5tqt2VWAcD8KifWvRAwIlUt1SNX1uMgg
         BsOuPVnDC8Gph5o68/LzPvXUbRvQX1LKtJWjH7PAgMAAO9H0aYKIyBGYy6N/e1vOdlE4
         st7O3BBjubqy+yPOSqHJV74oUtvZCM92kZJpsYtbUdW9mAIehdGu3yfCaFvhgNpYfy2T
         kOSzPh0njr/tf38eh4M/6z5uJNqVSPcIGsasqMOXXa2AP8vl2TfNel3FEhEQUA3OPMW9
         56YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:importance
         :date:in-reply-to:message-id:user-agent:mime-version;
        bh=jQWV3lBzQSv6vai5j6CVrUzZ0WwGECnVROuTO23rCE4=;
        b=G3sC6m70lg5V/mnLOGG9uWKTyy+vRefOCRdwkYf1EoWTUgJpkmhp7rdKtJ+eTRka83
         XZlD+txtBO9O54QcHBA9wLRHtCXacQCfptYwiGH1nkVqcZzWTTti4Gn3TczFbvQNAsBv
         N3krk/+4z+Au+fi6w0H+jvRTNwG8JpMMZFkorM/8E/0o9RBJbk+SnXYJa6sLbOO27n7W
         gI+S6GnldQCNTWLAoGTiOeteWUx24xMzkF5ZtoYHnl1MQXbrICgDYePKbAz3XyHCdslz
         6hBfUBDliZDNIso0cBOg7a5hAMlqVaxVt8gXlyHQsIRaxPtZdTvG/VxAPL3TxIc1WIxz
         gilA==
X-Gm-Message-State: APzg51CSjtCZdiUpZ6zP04hZsCoAuLGxRbPtvZ8RsTO6pMY5T4ENeJRb
        TCXfG6MeLg9JOS2dwe5OO8A=
X-Google-Smtp-Source: ANB0VdYpCrXu7Bmqcgafc+J+998TNrI9GBt0/ldSLLNCwX0mongwtHFSqqETR+LgA4/90KLQzdpxjg==
X-Received: by 2002:a1c:e581:: with SMTP id c123-v6mr6317989wmh.85.1536857251545;
        Thu, 13 Sep 2018 09:47:31 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id j6-v6sm3112006wrq.25.2018.09.13.09.47.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Sep 2018 09:47:30 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, l.s.r@web.de,
        sandals@crustytoothpaste.net
Subject: Re: [PATCH 3/3] archive: allow archive over HTTP(S) with proto v2
References: <20180912053519.31085-1-steadmon@google.com>
        <20180912053519.31085-4-steadmon@google.com>
Importance: high
Date:   Thu, 13 Sep 2018 09:47:30 -0700
In-Reply-To: <20180912053519.31085-4-steadmon@google.com> (Josh Steadmon's
        message of "Tue, 11 Sep 2018 22:35:19 -0700")
Message-ID: <xmqqworpgx99.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> Signed-off-by: Josh Steadmon <steadmon@google.com>
> ---
>  builtin/archive.c  |  8 +++++++-
>  http-backend.c     | 10 +++++++++-
>  transport-helper.c |  5 +++--
>  3 files changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/archive.c b/builtin/archive.c
> index 73831887d..5fa75b3f7 100644
> --- a/builtin/archive.c
> +++ b/builtin/archive.c
> @@ -87,7 +87,13 @@ static int run_remote_archiver(int argc, const char **argv,
>  		status = packet_reader_read(&reader);
>  		if (status != PACKET_READ_FLUSH)
>  			die(_("git archive: expected a flush"));
> -	}
> +	} else if (version == protocol_v2 &&
> +		   starts_with(transport->url, "http"))
> +		/*
> +		 * Commands over HTTP require two requests, so there's an
> +		 * additional server response to parse.
> +		 */
> +		discover_version(&reader);

What should happen if the version discovered here is different from
v2 or the capabilities offered are different from what we saw
before?  Perhaps we need some sanity checks, as we on this side of
the connection know we are making two requests, and may even end up
talking with an instance of "upload-archive" that is different from
the one we talked with earlier.

> diff --git a/http-backend.c b/http-backend.c
> index 458642ef7..d62d583c7 100644
> --- a/http-backend.c
> +++ b/http-backend.c
> @@ -32,6 +32,7 @@ struct rpc_service {
>  static struct rpc_service rpc_service[] = {
>  	{ "upload-pack", "uploadpack", 1, 1 },
>  	{ "receive-pack", "receivepack", 0, -1 },
> +	{ "upload-archive", "uploadarchive", 1, 1 },
>  };
>  
>  static struct string_list *get_parameters(void)
> @@ -637,6 +638,12 @@ static void service_rpc(struct strbuf *hdr, char *service_name)
>  	struct rpc_service *svc = select_service(hdr, service_name);
>  	struct strbuf buf = STRBUF_INIT;
>  
> +	if (!strcmp(service_name, "git-upload-archive")) {
> +		/* git-upload-archive doesn't need --stateless-rpc */
> +		argv[1] = ".";
> +		argv[2] = NULL;
> +	}
> +
>  	strbuf_reset(&buf);
>  	strbuf_addf(&buf, "application/x-git-%s-request", svc->name);
>  	check_content_type(hdr, buf.buf);
> @@ -713,7 +720,8 @@ static struct service_cmd {
>  	{"GET", "/objects/pack/pack-[0-9a-f]{40}\\.idx$", get_idx_file},
>  
>  	{"POST", "/git-upload-pack$", service_rpc},
> -	{"POST", "/git-receive-pack$", service_rpc}
> +	{"POST", "/git-receive-pack$", service_rpc},
> +	{"POST", "/git-upload-archive$", service_rpc},
>  };
>  
>  static int bad_request(struct strbuf *hdr, const struct service_cmd *c)
> diff --git a/transport-helper.c b/transport-helper.c
> index 143ca008c..b4b96fc89 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -605,7 +605,8 @@ static int process_connect_service(struct transport *transport,
>  		ret = run_connect(transport, &cmdbuf);
>  	} else if (data->stateless_connect &&
>  		   (get_protocol_version_config() == protocol_v2) &&
> -		   !strcmp("git-upload-pack", name)) {
> +		   (!strcmp("git-upload-pack", name) ||
> +		    !strcmp("git-upload-archive", name))) {
>  		strbuf_addf(&cmdbuf, "stateless-connect %s\n", name);
>  		ret = run_connect(transport, &cmdbuf);
>  		if (ret)
> @@ -639,7 +640,7 @@ static int connect_helper(struct transport *transport, const char *name,
>  
>  	/* Get_helper so connect is inited. */
>  	get_helper(transport);
> -	if (!data->connect)
> +	if (!data->connect && !data->stateless_connect)
>  		die(_("operation not supported by protocol"));

This is somewhat curious.  The upload-pack going over HTTP also is
triggered by the same "stateless-connect" remote helper command, as
we just saw in the previous hunk, and that support is not new.  Why
do we need this change then?  What's different between the "data"
that is obtained by get_helper(transport) for driving upload-pack
and upload-archive?  Presumably upload-pack was working without this
change because it also sets the connect bit on, and upload-archive
does not work without this change because it does not?  Why do these
two behave differently?

>  	if (!process_connect_service(transport, name, exec))
