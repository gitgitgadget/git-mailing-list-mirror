Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4ECD71F51C
	for <e@80x24.org>; Sun, 20 May 2018 20:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751451AbeETUA0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 May 2018 16:00:26 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36853 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751348AbeETUAZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 May 2018 16:00:25 -0400
Received: by mail-wr0-f196.google.com with SMTP id k5-v6so1887141wrn.3
        for <git@vger.kernel.org>; Sun, 20 May 2018 13:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=kMt2iw/lbzhMkU0FM7W9Ian8waL02pll/1GVMKgT9sg=;
        b=GTVjoqt5Tm/v4DR5ipBz1ZCug+EOZTGRumsIJ7M2TILdqV/dXEsvdpyQLRdg1ot2Hm
         GdrFxbX73miYWnQyU7ZDMTc8AWckqPPgEnPjZT+xhpzqOVCJjKnv485kfbOhf7F2VpWn
         JaRKA6p1S/WKtPhaoeGwp/V2uP0SRDA96JGZW5PS37F4Ncdgj9zEAgZilhYx2PxrEV2G
         24s06RetGesSCcbPUVHjbxmWT//Ir0eg0fRnSMTs/32XU5qARRPZkOnooq0Asp5qN5Kn
         IKJPQwyzbAg+yka7X0RjdXXE7LP9YknwszrVg2vT7eN+HHdDdOoPw14IeOyP5SB++tn3
         yQOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=kMt2iw/lbzhMkU0FM7W9Ian8waL02pll/1GVMKgT9sg=;
        b=UD3/ZalchggSsLaU4xDKTOUqjAbZnmo3ZTH2pp1X5jFxZQXkZLlTDg/JjD60Y/11pV
         ucUPH9Udr/ErgaDRZsoL8sw5hOGSe7mPU3/QAL8inXSfvP5a5Jr3LpALuD7smwp09hEx
         knqiXqIdJIj3VZrFi2X/WxTDI44WDohxZFPjH6TOVuETzAYwV+s4xQdH1983MYiUu4Bg
         mRCNCdAqTWe6OfC10plsDmvzRHC9lCXzbMLi/K3SWEFEgrT+b/jac2UWnyXg4LDyxk9+
         gDepe/sFbbEWn4Sviamxe0O1flgCKVw9yY7KoDTNB87/fHL7NQbytc7sqMvCvHYyCtT4
         BL0A==
X-Gm-Message-State: ALKqPwcFGgUguevWtNabotyP59Fc+cqH3Ck/5f96pmqnw4urwBB8mXyw
        kfq0yiRT/hY7/l+n/bJ1c2rFbaAe
X-Google-Smtp-Source: AB8JxZqGFOIjYA+0G1ypCTFf/0YYeaNW+80Q4bJd7TS8rs0TNg/IfXaK6LHds/PYrVT4rUUkIJFzvg==
X-Received: by 2002:adf:86fa:: with SMTP id 55-v6mr15188866wry.232.1526846423839;
        Sun, 20 May 2018 13:00:23 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (abpv179.neoplus.adsl.tpnet.pl. [83.8.63.179])
        by smtp.gmail.com with ESMTPSA id h81-v6sm21715153wmd.0.2018.05.20.13.00.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 20 May 2018 13:00:22 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "avarab\@gmail.com" <avarab@gmail.com>,
        "martin.agren\@gmail.com" <martin.agren@gmail.com>,
        "peff\@peff.net" <peff@peff.net>
Subject: Re: [PATCH v2 02/12] commit-graph: verify file header information
References: <20180510173345.40577-1-dstolee@microsoft.com>
        <20180511211504.79877-1-dstolee@microsoft.com>
        <20180511211504.79877-3-dstolee@microsoft.com>
Date:   Sun, 20 May 2018 22:00:20 +0200
In-Reply-To: <20180511211504.79877-3-dstolee@microsoft.com> (Derrick Stolee's
        message of "Fri, 11 May 2018 21:15:16 +0000")
Message-ID: <867enydrmz.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

> During a run of 'git commit-graph verify', list the issues with the
> header information in the commit-graph file. Some of this information
> is inferred from the loaded 'struct commit_graph'. Some header
> information is checked as part of load_commit_graph_one().
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  commit-graph.c | 32 +++++++++++++++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)
>
> diff --git a/commit-graph.c b/commit-graph.c
> index b25aaed128..d2db20e49a 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -818,7 +818,37 @@ void write_commit_graph(const char *obj_dir,
>  	oids.nr =3D 0;
>  }
>=20=20
> +static int verify_commit_graph_error;
> +
> +static void graph_report(const char *fmt, ...)
> +{
> +	va_list ap;
> +	struct strbuf sb =3D STRBUF_INIT;
> +	verify_commit_graph_error =3D 1;
> +
> +	va_start(ap, fmt);
> +	strbuf_vaddf(&sb, fmt, ap);
> +
> +	fprintf(stderr, "%s\n", sb.buf);
> +	strbuf_release(&sb);
> +	va_end(ap);
> +}
> +
>  int verify_commit_graph(struct commit_graph *g)
>  {
> -	return !g;
> +	if (!g) {
> +		graph_report("no commit-graph file loaded");
> +		return 1;
> +	}

I won't be repeating what Martin said, but I agree with it.  Well, that
or make it a separate patch.

> +
> +	verify_commit_graph_error =3D 0;
> +

A quick reminder for myself.  The load_commit_graph_one() that is used
to fill the commit_graph parameter alreaady verifies that:
 - file is not too small, i.e. smaller than GRAPH_MIN_SIZE
 - it has correct signature
 - it has correct graph version
 - it has correct hash version
 - chunks [offsets] all fit within file
 - that OID Fanout, OID Lookup, Commit Data and Large Edges chunks are
   not repeated, though not that all required chunks are present

> +	if (!g->chunk_oid_fanout)
> +		graph_report("commit-graph is missing the OID Fanout chunk");
> +	if (!g->chunk_oid_lookup)
> +		graph_report("commit-graph is missing the OID Lookup chunk");
> +	if (!g->chunk_commit_data)
> +		graph_report("commit-graph is missing the Commit Data chunk");

This one checks that all chunks that needs to be present are present.
Nice.

There are a few more things that we can check about CHUNK LOOKUP part.
For example we would detect if file was truncated because the offset of
some chunk would be pointing outside the file... unless the truncation
falls within the last chunk.  We don't check that terminating label
(chunk "\0\0\0\0" offset) is outside file, I think.

We also don't check that positions of subsequent chunks are sorted
(increasing offsets), so that each chunk length is positive.


I also wonder if we shouldn't at least _warn_ about unknown chunks.

> +
> +	return verify_commit_graph_error;
>  }

Nice trick to be able to check as much as possible without segfaulting,
while still returning correct error result.


Testing newly intruduced functionality would be hard, unless relying on
hand-crafted files, or on some helper to produce invalid commit-graph
files.

--=20
Jakub Nar=C4=99bski
