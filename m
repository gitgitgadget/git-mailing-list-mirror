Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 092BD20248
	for <e@80x24.org>; Wed,  6 Mar 2019 23:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbfCFXVt (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Mar 2019 18:21:49 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35771 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfCFXVt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Mar 2019 18:21:49 -0500
Received: by mail-wr1-f66.google.com with SMTP id t18so15328623wrx.2
        for <git@vger.kernel.org>; Wed, 06 Mar 2019 15:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=sPPbX7X56bsh3zrfcTbxkrAZ7xQQB0fEtlsJJm154Wg=;
        b=sBsDiOQYN+2Db1qp3RvJIrc2jEvhlNMWuba5Nph10zRaLbOEhiCBp+EgjhWkSN8YBN
         CXga/PURdhRbp51X00peC53usJ9/V8ODkO0A6T1JvmPw1mA/u1IJO8j6uQ5zgoST8v4H
         H9adt3bBJEvD3U3Lr7yfhm+r9VBSntOc4XbT6pJM5WUDfHzuO55M4eKZucOLH+9HyzNy
         p7zOrr4ef0SzGuxrKT9hW8HRYDOO4Jpj8hU31fi+cwYv7JAvH5NqQvYnoAaXKuQOWOR0
         b1paRoi62kFtGhvU3Eo/TK8NLLYQvNFCPvxEiFgqN3+dEbmkSJ/sj0tCmwJJqYrgPOm9
         FfeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=sPPbX7X56bsh3zrfcTbxkrAZ7xQQB0fEtlsJJm154Wg=;
        b=RvjPQBmrZIwZXa/f7N+C73+TlVTu7jGJrtP15KICEkAFgpGl/Dnb7Vlwv2Cph/0sef
         pcp8w8f0lPNz2nk+mxZthGtT5vvkAfSQwlCfabKHinTsRhNhSNc2c0taI6ivNOL1/0yh
         eAl7q79YawKguTcQCEZR4/gDGedRMwhLtlSS7RQ7/0Rrz7KexfMf53LIxrxnsMoHhUMQ
         WFUeDwGDOSH1dC2xvkENeQJD9szUja8D9k2GzSg/7yVcDN6Z/vUv+985S8xQ+pYnwqfd
         49AzyQ2Lo63BpMK69t50MNAIbgQqOTnbKYoPXXYxlxO9ClVab+avUnxBvhLxJldRZbEx
         2rSg==
X-Gm-Message-State: APjAAAX6KE+5Cj0sBP4uvycHzH8/ELhvyw0P0TypYD6kVSGfyXfV5Qix
        idXeArHrUYm29bVsW/dd8Ak=
X-Google-Smtp-Source: APXvYqx1I6+rdjQazOhe7f2s2hP9nfl6c78IDruWHmRzPELbFRHHL4WuSYp6g4oVIzxR6FLJleEMLg==
X-Received: by 2002:adf:e5cc:: with SMTP id a12mr4980666wrn.130.1551914506830;
        Wed, 06 Mar 2019 15:21:46 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id f6sm4999547wrs.45.2019.03.06.15.21.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Mar 2019 15:21:45 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Richardson <brandon1024.br@gmail.com>
Cc:     git@vger.kernel.org, rybak.a.v@gmail.com, pclouds@gmail.com,
        peff@peff.net, sunshine@sunshineco.com
Subject: Re: [PATCH v4] commit-tree: utilize parse-options api
References: <20190305154951.4407-1-brandon1024.br@gmail.com>
Date:   Thu, 07 Mar 2019 08:21:44 +0900
In-Reply-To: <20190305154951.4407-1-brandon1024.br@gmail.com> (Brandon
        Richardson's message of "Tue, 5 Mar 2019 10:49:51 -0500")
Message-ID: <xmqqy35rpp13.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Richardson <brandon1024.br@gmail.com> writes:

> @@ -23,6 +23,9 @@ Creates a new commit object based on the provided tree object and
>  emits the new commit object id on stdout. The log message is read
>  from the standard input, unless `-m` or `-F` options are given.
>  
> +When mixing `-m` and `-F` options, the commit log message will be
> +composed in the order in which the options are given.

It may be just me, but this new paragraph made me think that we can
give at most one -m and one -F option at the same time in any order,
and multiple -m or -F options are not supported.  That, obviously,
is not the impression we want to give to the readers.

Even when you are not mixing -m and -F, but using -m more than once,
the log message will be composed in the order in which options are
given.  So probably the word "mixing" is the primary culprit of
making the sentence easier to be misunderstood.

	When using more than one `-m` or `-F` options, ...

perhaps.

> @@ -41,7 +44,7 @@ state was.
>  OPTIONS
>  -------
>  <tree>::
> -	An existing tree object
> +	An existing tree object.

Good.

> @@ -52,7 +55,8 @@ OPTIONS
>  
>  -F <file>::
>  	Read the commit log message from the given file. Use `-` to read
> -	from the standard input.
> +	from the standard input. This can be given more than once and the
> +	content of each file becomes its own paragraph.

OK, this matches what -m says about giving it multiple times.

> -static const char commit_tree_usage[] = "git commit-tree [(-p <sha1>)...] [-S[<keyid>]] [-m <message>] [-F <file>] <sha1>";
> +static const char * const commit_tree_usage[] = {
> +	N_("git commit-tree [(-p <parent>)...] [-S[<keyid>]] [(-m <message>)...] "
> +		"[(-F <file>)...] <tree>"),
> +	NULL
> +};

Replacing a few placeholder tokens with more meaningful names---very
good attention to the detail.

> +static int parse_parent_arg_callback(const struct option *opt,
> +		const char *arg, int unset)
> +{
> +	struct object_id oid;
> +	struct commit_list **parents = opt->value;
> +
> +	BUG_ON_OPT_NEG_NOARG(unset, arg);
> +
> +	if (get_oid_commit(arg, &oid))
> +		die(_("not a valid object name %s"), arg);
> +
> +	assert_oid_type(&oid, OBJ_COMMIT);
> +	new_parent(lookup_commit(the_repository, &oid), parents);
> +	return 0;

OK, this looks like a quite faithful conversion.  We do not allow
tags that point at commit, for example.  Good.

> +}
> +
> +static int parse_message_arg_callback(const struct option *opt,
> +		const char *arg, int unset)
> +{
> +	struct strbuf *buf = opt->value;
> +
> +	BUG_ON_OPT_NEG_NOARG(unset, arg);
> +
> +	if (buf->len)
> +		strbuf_addch(buf, '\n');
> +	strbuf_addstr(buf, arg);
> +	strbuf_complete_line(buf);
> +
> +	return 0;
> +}

Likewise.  We make ourselves a new paragraph (if there is already
some message), add the message and complete the line.  Good.

> +static int parse_file_arg_callback(const struct option *opt,
> +		const char *arg, int unset)
> +{
> +	int fd;
> +	struct strbuf *buf = opt->value;
> +
> +	BUG_ON_OPT_NEG_NOARG(unset, arg);
> +
> +	if (buf->len)
> +		strbuf_addch(buf, '\n');
> +	if (!strcmp(arg, "-"))
> +		fd = 0;
> +	else {
> +		fd = open(arg, O_RDONLY);
> +		if (fd < 0)
> +			die_errno(_("git commit-tree: failed to open '%s'"), arg);
> +	}
> +	if (strbuf_read(buf, fd, 0) < 0)
> +		die_errno(_("git commit-tree: failed to read '%s'"), arg);
> +	if (fd && close(fd))
> +		die_errno(_("git commit-tree: failed to close '%s'"), arg);
> +
> +	return 0;
> +}

Again, likewise.  And it is far easier to see and read what is going
on, compared to the original that has 2 extra levels of indentation.

>  int cmd_commit_tree(int argc, const char **argv, const char *prefix)
>  {

The change to this main function looks quite straight-forward.  I am
kind of surprised that a very low hanging fruit like this had survived
without getting hit by parseopt a lot earlier ;-)
