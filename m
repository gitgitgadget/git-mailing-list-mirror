Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14A301F453
	for <e@80x24.org>; Thu, 27 Sep 2018 20:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbeI1Csc (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 22:48:32 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33461 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbeI1Csb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 22:48:31 -0400
Received: by mail-pf1-f195.google.com with SMTP id d4-v6so2711384pfn.0
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 13:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oBsUAfzKTBsI+weHvBSwNIhaPV/e7Psd3VjRawGBxQM=;
        b=g0LorYBDi92c0iR6WijMK48AcbvFOQ3nIlYFoHNsnS3b15MyDi+W6i4OsI0ILOxi/H
         QdXDE7nPkioQA1SGnjNAt3CkHNiWktUwMcR0FFS7OAzGe3pyNWxjDoGD3dLekl5U3HvK
         ojY2A/ktCruHj16LRv9wH/wBJmMgje6LEERpnts2Hz5uWKzS0FVnnETFnLmRcpQNUyxf
         qKQcW0d2gmSH/Oc89sAHGo31+kHiKd0+V/eKKMvNtLjbMcvCZUugP8jgCcASxpPLgHAS
         /KICIii9UeyWFNp2mqjhGfEjkAXjynWJd6qgPnXRyrEj43NFi7/oy75z2by2H0/9yjO+
         pIaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oBsUAfzKTBsI+weHvBSwNIhaPV/e7Psd3VjRawGBxQM=;
        b=m/S5f16r/DYDPCjPwTxHkBoJpxCPQpdy3LpbHiW7hozZ1LhmIRGz+tmRYNTYole6Kp
         lSy0n4MdmrItY7Oo+GtjauPpyQmKXcf06fg+DvI88JJ6gVZxi90PebTMIDEAMryBYwEU
         10vZ+U9gjhdXhmAaE7KNwaEepz0ODMkq4Rj7wV6rFSEf7wXqsnOLz+4zYd/XTRqvNAF1
         Zehc02nUTCz/jkEOy13r75q5B21CykWsGjlE38oCaTltrGZ+jc03GCsvqGngoN0yAAik
         s85+Lb45G2WnQCSERJ6cHozLZ68ecVJ1llvWgnECo2pVhDg+o/ouQjeiAlVomJtyZ48t
         v0cw==
X-Gm-Message-State: ABuFfog+u6qwP7U2aGZSufBlAfGfG1naDJnpbEmqnEwYAx9IJYRtFjgY
        lxKUPWy5/7cLf3MDxW89yQm/OQ==
X-Google-Smtp-Source: ACcGV619Ii9kfgtAxuR1UjYm5Ieu+ehXFAhQyHjmRbzxE8FJRQQ0EU0hLrAuW+bj+qSsKdAR1DMRHA==
X-Received: by 2002:a17:902:3183:: with SMTP id x3-v6mr144705plb.105.1538080108187;
        Thu, 27 Sep 2018 13:28:28 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:79fb:7d7a:4d6b:acb7])
        by smtp.gmail.com with ESMTPSA id c5-v6sm4844375pfg.2.2018.09.27.13.28.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 13:28:26 -0700 (PDT)
Date:   Thu, 27 Sep 2018 13:28:15 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, l.s.r@web.de,
        sandals@crustytoothpaste.net
Subject: Re: [PATCH 3/3] archive: allow archive over HTTP(S) with proto v2
Message-ID: <20180927202815.GB55647@google.com>
References: <20180912053519.31085-1-steadmon@google.com>
 <20180912053519.31085-4-steadmon@google.com>
 <xmqqworpgx99.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqworpgx99.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1+54 (2af6caa1) (2018-07-26)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018.09.13 09:47, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> > Signed-off-by: Josh Steadmon <steadmon@google.com>
> > ---
> >  builtin/archive.c  |  8 +++++++-
> >  http-backend.c     | 10 +++++++++-
> >  transport-helper.c |  5 +++--
> >  3 files changed, 19 insertions(+), 4 deletions(-)
> >
> > diff --git a/builtin/archive.c b/builtin/archive.c
> > index 73831887d..5fa75b3f7 100644
> > --- a/builtin/archive.c
> > +++ b/builtin/archive.c
> > @@ -87,7 +87,13 @@ static int run_remote_archiver(int argc, const char **argv,
> >  		status = packet_reader_read(&reader);
> >  		if (status != PACKET_READ_FLUSH)
> >  			die(_("git archive: expected a flush"));
> > -	}
> > +	} else if (version == protocol_v2 &&
> > +		   starts_with(transport->url, "http"))
> > +		/*
> > +		 * Commands over HTTP require two requests, so there's an
> > +		 * additional server response to parse.
> > +		 */
> > +		discover_version(&reader);
> 
> What should happen if the version discovered here is different from
> v2 or the capabilities offered are different from what we saw
> before?  Perhaps we need some sanity checks, as we on this side of
> the connection know we are making two requests, and may even end up
> talking with an instance of "upload-archive" that is different from
> the one we talked with earlier.
> 
> > diff --git a/http-backend.c b/http-backend.c
> > index 458642ef7..d62d583c7 100644
> > --- a/http-backend.c
> > +++ b/http-backend.c
> > @@ -32,6 +32,7 @@ struct rpc_service {
> >  static struct rpc_service rpc_service[] = {
> >  	{ "upload-pack", "uploadpack", 1, 1 },
> >  	{ "receive-pack", "receivepack", 0, -1 },
> > +	{ "upload-archive", "uploadarchive", 1, 1 },
> >  };
> >  
> >  static struct string_list *get_parameters(void)
> > @@ -637,6 +638,12 @@ static void service_rpc(struct strbuf *hdr, char *service_name)
> >  	struct rpc_service *svc = select_service(hdr, service_name);
> >  	struct strbuf buf = STRBUF_INIT;
> >  
> > +	if (!strcmp(service_name, "git-upload-archive")) {
> > +		/* git-upload-archive doesn't need --stateless-rpc */
> > +		argv[1] = ".";
> > +		argv[2] = NULL;
> > +	}
> > +
> >  	strbuf_reset(&buf);
> >  	strbuf_addf(&buf, "application/x-git-%s-request", svc->name);
> >  	check_content_type(hdr, buf.buf);
> > @@ -713,7 +720,8 @@ static struct service_cmd {
> >  	{"GET", "/objects/pack/pack-[0-9a-f]{40}\\.idx$", get_idx_file},
> >  
> >  	{"POST", "/git-upload-pack$", service_rpc},
> > -	{"POST", "/git-receive-pack$", service_rpc}
> > +	{"POST", "/git-receive-pack$", service_rpc},
> > +	{"POST", "/git-upload-archive$", service_rpc},
> >  };
> >  
> >  static int bad_request(struct strbuf *hdr, const struct service_cmd *c)
> > diff --git a/transport-helper.c b/transport-helper.c
> > index 143ca008c..b4b96fc89 100644
> > --- a/transport-helper.c
> > +++ b/transport-helper.c
> > @@ -605,7 +605,8 @@ static int process_connect_service(struct transport *transport,
> >  		ret = run_connect(transport, &cmdbuf);
> >  	} else if (data->stateless_connect &&
> >  		   (get_protocol_version_config() == protocol_v2) &&
> > -		   !strcmp("git-upload-pack", name)) {
> > +		   (!strcmp("git-upload-pack", name) ||
> > +		    !strcmp("git-upload-archive", name))) {
> >  		strbuf_addf(&cmdbuf, "stateless-connect %s\n", name);
> >  		ret = run_connect(transport, &cmdbuf);
> >  		if (ret)
> > @@ -639,7 +640,7 @@ static int connect_helper(struct transport *transport, const char *name,
> >  
> >  	/* Get_helper so connect is inited. */
> >  	get_helper(transport);
> > -	if (!data->connect)
> > +	if (!data->connect && !data->stateless_connect)
> >  		die(_("operation not supported by protocol"));
> 
> This is somewhat curious.  The upload-pack going over HTTP also is
> triggered by the same "stateless-connect" remote helper command, as
> we just saw in the previous hunk, and that support is not new.  Why
> do we need this change then?  What's different between the "data"
> that is obtained by get_helper(transport) for driving upload-pack
> and upload-archive?  Presumably upload-pack was working without this
> change because it also sets the connect bit on, and upload-archive
> does not work without this change because it does not?  Why do these
> two behave differently?

The data struct is not different between upload-pack vs. upload-archive.
Neither of them set the connect bit. The difference is that upload-pack
doesn't need to call transport_connect(), so it never hits
connect_helper().
