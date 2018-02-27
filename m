Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 947D51F404
	for <e@80x24.org>; Tue, 27 Feb 2018 18:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751304AbeB0S34 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 13:29:56 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:43920 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751062AbeB0S3y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 13:29:54 -0500
Received: by mail-pl0-f68.google.com with SMTP id f23so11884096plr.10
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 10:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i1kO2/j7nEfWpx5LmwLNaiTNjL4PU0WksiNAlJlIsZE=;
        b=gVlRRgB6N/24s+8zdYWjLoVp00hlzdkomX+WLtuMy/ZPO4/rxCsvFKLwFo1f3ieTd1
         KfIlH/JTHVHnSGjHFrFTPeN6cZ9RvH8WWPd6s+9NPwIy1BABWw0GSMO8pkTaLlwUMbWM
         q3FsNAIgAJYtcn2yZMNrNk4KKmgKZiWyKZGMOc5N/eixOgQzRvyb2sm1nx1DmO7cX4fU
         j0M3UVsG11n4rtJ56UpDR2Im1/5ito0XNpZ2XgII5Ys8DK8B6F7hLOreV/dIctIYPBil
         7ha+M6tlhe20VLwu4xPQfCMYGakyHCBJOKtB3pdXSLLrRNYqIANoPezBjCaBKjWB1jDr
         Um4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i1kO2/j7nEfWpx5LmwLNaiTNjL4PU0WksiNAlJlIsZE=;
        b=PHdsZuXhW/tIDfZaeEsemlG8azsd9HOFOjzo7KjfMXyr3pOSpEpwAG3gGdJ5rHCocv
         0oJVEia4pHwzw9pnUWuEXZJzeX1nHNJLlDs/BJMBFkeXMFlxP3DKZFgkDu5fyOPMzld3
         SEc2CFzREbLBvc3/x+pnxV3aSjce1h3lQI3kHyzbpY9pRsO7nCpSK50570I5Ucd/07pA
         g12VjEwnemdb5ujHY4YTJ8VriapCGeACQ3OxuKQOF5p0Z2zFmhkmxHK473v+w6BfvJTs
         6UH7USfO75U1oZlBg3k9aWHb5x/RncHucBbtVR69oWxiaovEHLDuEkQCS2bJVS3+NaoK
         /JHw==
X-Gm-Message-State: APf1xPCTUx0lNYXxrZ9laIXpkUCzrI6M3CS6CGt5ZhG1rQTI03HS7TJ8
        pK2LE70tnTwxQJ3UhkLLy3A=
X-Google-Smtp-Source: AH8x225DAnMQG6n5Ima4o5pTgMZWDPKrRLZz9pQabNPTFyIOGNLmnKtA0mRJkwrIWEv65D2FDN+KYQ==
X-Received: by 2002:a17:902:ad0a:: with SMTP id i10-v6mr15046129plr.130.1519756193996;
        Tue, 27 Feb 2018 10:29:53 -0800 (PST)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id b5sm18591782pgc.13.2018.02.27.10.29.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Feb 2018 10:29:53 -0800 (PST)
Date:   Tue, 27 Feb 2018 10:29:49 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        gitster@pobox.com, stolee@gmail.com, git@jeffhostetler.com,
        pclouds@gmail.com
Subject: Re: [PATCH v3 22/35] upload-pack: support shallow requests
Message-ID: <20180227182854.GA174036@aiede.svl.corp.google.com>
References: <20180125235838.138135-1-bmwill@google.com>
 <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-23-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180207011312.189834-23-bmwill@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Brandon Williams wrote:

> Add the 'shallow' feature to the protocol version 2 command 'fetch'
> which indicates that the server supports shallow clients and deepen
> requets.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  Documentation/technical/protocol-v2.txt |  67 +++++++++++++++-
>  serve.c                                 |   2 +-
>  t/t5701-git-serve.sh                    |   2 +-
>  upload-pack.c                           | 138 +++++++++++++++++++++++---------
>  upload-pack.h                           |   3 +
>  5 files changed, 173 insertions(+), 39 deletions(-)

Yay!  We've been running with this for a while at Google (for file://
fetches, at least) and it's been working well.

[...]
> --- a/Documentation/technical/protocol-v2.txt
> +++ b/Documentation/technical/protocol-v2.txt
> @@ -201,12 +201,42 @@ packet-lines:
>  	to its base by position in pack rather than by an oid.  That is,
>  	they can read OBJ_OFS_DELTA (ake type 6) in a packfile.
>  
> +    shallow <oid>
> +	A client must notify the server of all objects for which it only
> +	has shallow copies of (meaning that it doesn't have the parents

Grammar nit: "for which it only has shallow copies of" should be e.g.
"for which it only has shallow copies" or "that it only has shallow
copies of" or "that it only has shallow copies for".

I think s/objects/commits/ would also help clarify.

> +	of a commit) by supplying a 'shallow <oid>' line for each such
> +	object so that the serve is aware of the limitations of the

s/serve/server/

> +	client's history.

Is it worth mentioning that this is about negotiation?  E.g. "so that
the server is aware that the client may not have all objects reachable
from such commits".

> +
> +    deepen <depth>
> +	Request that the fetch/clone should be shallow having a commit depth of

nit: s/Request/Requests/, for consistency with the others?

> +	<depth> relative to the remote side.

What does the value of <depth> mean? E.g. does a depth of 1 mean to
fetch only the commits named in "have", 2 to fetch those commits plus
their parents, etc, or am I off by one?

Is <depth> always a positive number?

What happens if <depth> starts with a 0?  Is that a client error?

> +
> +    deepen-relative
> +	Requests that the semantics of the "deepen" command be changed
> +	to indicate that the depth requested is relative to the clients
> +	current shallow boundary, instead of relative to the remote
> +	refs.

s/clients/client's/

s/remote refs/requested commits/ or "wants" or something.

> +
> +    deepen-since <timestamp>
> +	Requests that the shallow clone/fetch should be cut at a
> +	specific time, instead of depth.  Internally it's equivalent of
> +	doing "rev-list --max-age=<timestamp>". Cannot be used with
> +	"deepen".

Nits:
  s/rev-list/git rev-list/
  s/equivalent of/equivalent to/ or 'the equivalent of'.

Since the git-rev-list(1) manpage doesn't tell me: what is the format
of <timestamp>?  And is the requested time interval inclusive of
exclusive?

> +
> +    deepen-not <rev>
> +	Requests that the shallow clone/fetch should be cut at a
> +	specific revision specified by '<rev>', instead of a depth.
> +	Internally it's equivalent of doing "rev-list --not <rev>".
> +	Cannot be used with "deepen", but can be used with
> +	"deepen-since".

Interesting.

nit: s/rev-list/git rev-list/

What is the format of <rev>?  E.g. can it be an arbitrary revision
specifier or is it an oid?

[...]
>      output = *section
> -    section = (acknowledgments | packfile)
> +    section = (acknowledgments | shallow-info | packfile)
>  	      (flush-pkt | delim-pkt)

It looks like sections can go in an arbitrary order.  Are there
tests to make sure the server can cope with reordering?  (I ask
not because I mistrust the server but because I have some vague
hope that other server implementations might be inspired by our
tests.)

[...]
> @@ -215,6 +245,11 @@ header.
>      nak = PKT-LINE("NAK" LF)
>      ack = PKT-LINE("ACK" SP obj-id LF)
>  
> +    shallow-info = PKT-LINE("shallow-info" LF)
> +		   *PKT-LINE((shallow | unshallow) LF)
> +    shallow = "shallow" SP obj-id
> +    unshallow = "unshallow" SP obj-id

Likewise: it looks like shallows and unshallows can be intermixed; can
this be either (a) tightened or (b) covered by tests to make sure a
later refactoring doesn't accidentally tighten it?

[...]
> @@ -247,6 +282,36 @@ header.
>  	  determined the objects it plans to send to the client and no
>  	  further negotiation is needed.
>  
> +----
> +    shallow-info section
> +	If the client has requested a shallow fetch/clone, a shallow
> +	client requests a fetch or the server is shallow then the
> +	server's response may include a shallow-info section.

I'm having trouble parsing this sentence.

>                                                              The
> +	shallow-info section will be include if (due to one of the above

nit: s/include/included/

> +	conditions) the server needs to inform the client of any shallow
> +	boundaries or adjustments to the clients already existing
> +	shallow boundaries.
> +
> +	* Always begins with the section header "shallow-info"
> +
> +	* If a positive depth is requested, the server will compute the
> +	  set of commits which are no deeper than the desired depth.
> +
> +	* The server sends a "shallow obj-id" line for each commit whose
> +	  parents will not be sent in the following packfile.
> +
> +	* The server sends an "unshallow obj-id" line for each commit
> +	  which the client has indicated is shallow, but is no longer
> +	  shallow as a result of the fetch (due to its parents being
> +	  sent in the following packfile).
> +
> +	* The server MUST NOT send any "unshallow" lines for anything
> +	  which the client has not indicated was shallow as a part of
> +	  its request.
> +
> +	* This section is only included if a packfile section is also
> +	  included in the response.

Neat.

I wonder if shallow information is also useful for negotiation.  I
guess mostly not today, since the client is the only one that suggests
"have"s for negotiation and although it could accidentally exclude too
many "have"s by going down a path from a server's ack, that feels like
a rare case.

[...]
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -710,7 +710,6 @@ static void deepen(int depth, int deepen_relative,
>  	}
>  
>  	send_unshallow(shallows);
> -	packet_flush(1);

What does this part do?
>  }
>  
>  static void deepen_by_rev_list(int ac, const char **av,
> @@ -722,7 +721,52 @@ static void deepen_by_rev_list(int ac, const char **av,
>  	send_shallow(result);
>  	free_commit_list(result);
>  	send_unshallow(shallows);
> -	packet_flush(1);

Same question.

> +}
> +
> +static int send_shallow_list(int depth, int deepen_rev_list,
> +			     timestamp_t deepen_since,
> +			     struct string_list *deepen_not,
> +			     struct object_array *shallows)

What does the return value from this function represent?  It doesn't
appear to be the usual "0 means success, -1 means failure" so a
comment would help.

> +{
> +	int ret = 0;
> +
> +	if (depth > 0 && deepen_rev_list)
> +		die("git upload-pack: deepen and deepen-since (or deepen-not) cannot be used together");

nit: long line (can/should "make style" find these?)

The error message is pretty long, longer than a typical 80-column
terminal, so probably best to find a way to make the message shorter.
E.g.

		die("upload-pack: deepen cannot be combined with other deepen-* options");

That still would be >80 columns with the indent, so the usual style
would be to break it into multiple strings and use C preprocessor
concatenation (yuck):

		die("upload-pack: "
		    "deepen cannot be combined with other deepen-* options");

[...]
> +	if (depth > 0) {
> +		deepen(depth, deepen_relative, shallows);
> +		ret = 1;
> +	} else if (deepen_rev_list) {
> +		struct argv_array av = ARGV_ARRAY_INIT;
> +		int i;
> +
> +		argv_array_push(&av, "rev-list");
> +		if (deepen_since)
> +			argv_array_pushf(&av, "--max-age=%"PRItime, deepen_since);
> +		if (deepen_not->nr) {
> +			argv_array_push(&av, "--not");
> +			for (i = 0; i < deepen_not->nr; i++) {
> +				struct string_list_item *s = deepen_not->items + i;
> +				argv_array_push(&av, s->string);

This accepts arbitrary rev-list arguments, which feels dangerous
(could end up doing an expensive operation or reading arbitrary files
or finding a way to execute arbitrary code).

[...]
> -		if (deepen_not.nr) {
> -			argv_array_push(&av, "--not");
> -			for (i = 0; i < deepen_not.nr; i++) {
> -				struct string_list_item *s = deepen_not.items + i;
> -				argv_array_push(&av, s->string);

Huh.  Looks like some of the above comments are better addressed to an
earlier patch.

[...]
> @@ -1071,6 +1085,13 @@ struct upload_pack_data {
>  	struct object_array wants;
>  	struct oid_array haves;
>  
> +	struct object_array shallows;
> +	struct string_list deepen_not;
> +	int depth;
> +	timestamp_t deepen_since;
> +	int deepen_rev_list;
> +	int deepen_relative;

Nice.

Comments describing deepen_Rev_list and deepen_relative would be nice.

Are those boolean?  Can they be unsigned:1 to make that
self-explanatory?

[...]
> @@ -1080,12 +1101,14 @@ struct upload_pack_data {
>  	unsigned done : 1;
>  };
>  
> -#define UPLOAD_PACK_DATA_INIT { OBJECT_ARRAY_INIT, OID_ARRAY_INIT, 0, 0, 0, 0, 0, 0 }
> +#define UPLOAD_PACK_DATA_INIT { OBJECT_ARRAY_INIT, OID_ARRAY_INIT, OBJECT_ARRAY_INIT, STRING_LIST_INIT_DUP, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }

Long line, "make style" should be able to fix it.

[...]
>  
>  static void upload_pack_data_clear(struct upload_pack_data *data)
>  {
>  	object_array_clear(&data->wants);
>  	oid_array_clear(&data->haves);
> +	object_array_clear(&data->shallows);
> +	string_list_clear(&data->deepen_not, 0);

Thanks for remembering to clean up.

[...]
> @@ -1284,6 +1323,23 @@ static int process_haves_and_send_acks(struct upload_pack_data *data)
>  	return ret;
>  }
>  
> +static void send_shallow_info(struct upload_pack_data *data)
> +{
> +	/* No shallow info needs to be sent */
> +	if (!data->depth && !data->deepen_rev_list && !data->shallows.nr &&
> +	    !is_repository_shallow())
> +		return;
> +
> +	packet_write_fmt(1, "shallow-info\n");
> +
> +	if (!send_shallow_list(data->depth, data->deepen_rev_list,
> +			       data->deepen_since, &data->deepen_not,
> +			       &data->shallows) && is_repository_shallow())
> +		deepen(INFINITE_DEPTH, data->deepen_relative, &data->shallows);
> +
> +	packet_delim(1);
> +}

Nice.

[...]
> @@ -1346,3 +1404,11 @@ int upload_pack_v2(struct repository *r, struct argv_array *keys,
>  	upload_pack_data_clear(&data);
>  	return 0;
>  }
> +
> +int upload_pack_advertise(struct repository *r,
> +			  struct strbuf *value)
> +{
> +	if (value)
> +		strbuf_addstr(value, "shallow");
> +	return 1;
> +}

This is about capabilities?

Maybe a doc comment in the header file would help.

Thanks,
Jonathan
