Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D45511F404
	for <e@80x24.org>; Fri,  2 Mar 2018 20:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933204AbeCBU42 (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 15:56:28 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35206 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932896AbeCBU40 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 15:56:26 -0500
Received: by mail-wr0-f194.google.com with SMTP id l43so11416085wrc.2
        for <git@vger.kernel.org>; Fri, 02 Mar 2018 12:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=VCutyGBX0xrv4X8s67/c/gUNSqdgkAGDxNniLpFXRh4=;
        b=RrJxteUhijTW6dyhAKG7qo76Ml0SLe/m31kwm3k36t60X0hCcgSiquLJ1x6/US0/In
         g4iwj9874SlPWiD5nu4673rqrpuErGOXQZsYhZ+WFb7yyGjW22AJx5VLS48M+bNJf+KZ
         hXPYXvoMB1e2rPYxrzeEy7a8cTNEQf/SMXMuOynPi/tsLaef+MXPQ70tyHQyF17rBTR6
         GvPGw1b5qdiduOEkv1PZW43LNJsefLjw2iPwaLE4IB9/qp2ra8tQuP255U8UYjwqOLJ4
         CBmFcVu4F3xtIk511m1940/Ly6nI+pyYQz66glznExCkDZgSWgADdzGDmmFzmF6WjTp4
         GN0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=VCutyGBX0xrv4X8s67/c/gUNSqdgkAGDxNniLpFXRh4=;
        b=U9yDWOSTADkTPTqrWKKMJWBb40s/o2CYXKXKRDw+ndtHtbVGGq5TUR/Vf1wmbDqDho
         RsGDyZdID5OUJr87IoloGuLlUDQ+DpNR8DVn1spOZn6zhg3ks/IIPZ8ByUujT3WD6NmO
         BEtS/9kEBqrlRUlykHDte8TeQW2ZyjXwzO3eWFHeuDj/F5bduVRiUoafwGMVMiMwZvFj
         ShmC+t9XeKJjfmOu+F8mQTA+ozwv5uBhQVjuvmuHWSkAfhfEVnokvxe9QCwr5g0JrcZ0
         9C0vtmhspIB4stowmIqARA/vY4DYJqKGxqbkV+ZUcOgmQcF9/11HOypZTetpU9do++Uq
         lVVA==
X-Gm-Message-State: APf1xPCX0xKjI5NddZUvkIfocBwNIGhIywJN/ccX1l7WxDMRqqsAqT85
        VNzLJ3DlfppoGj4yGT3MiqCbYe1ZR9I=
X-Google-Smtp-Source: AG47ELvP/ImZJD8YQ5VyxZ0ZBrPYmfu3hInqPg0rDRcUddFrbkdFsTzjUXnVz1z/2wiyLo84YAImRQ==
X-Received: by 10.223.165.77 with SMTP id j13mr5821388wrb.220.1520024185428;
        Fri, 02 Mar 2018 12:56:25 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 35sm7347982wra.4.2018.03.02.12.56.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Mar 2018 12:56:24 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com
Subject: Re: [PATCH v4 12/35] serve: introduce git-serve
References: <20180207011312.189834-1-bmwill@google.com>
        <20180228232252.102167-1-bmwill@google.com>
        <20180228232252.102167-13-bmwill@google.com>
Date:   Fri, 02 Mar 2018 12:56:24 -0800
In-Reply-To: <20180228232252.102167-13-bmwill@google.com> (Brandon Williams's
        message of "Wed, 28 Feb 2018 15:22:29 -0800")
Message-ID: <xmqqzi3qb3if.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> +	/*
> +	 * Function queried to see if a capability should be advertised.
> +	 * Optionally a value can be specified by adding it to 'value'.
> +	 * If a value is added to 'value', the server will advertise this
> +	 * capability as "<name>=<value>" instead of "<name>".
> +	 */
> +	int (*advertise)(struct repository *r, struct strbuf *value);

So this is "do we tell them about this capability?"

> +static void advertise_capabilities(void)
> +{
> +	...
> +	for (i = 0; i < ARRAY_SIZE(capabilities); i++) {
> +		struct protocol_capability *c = &capabilities[i];
> +
> +		if (c->advertise(the_repository, &value)) {
> +			strbuf_addstr(&capability, c->name);
> +             ...

And used as such in this function.  We tell the other side about the
capability only when .advertise returns true.

> +static int is_valid_capability(const char *key)
> +{
> +	const struct protocol_capability *c = get_capability(key);
> +
> +	return c && c->advertise(the_repository, NULL);
> +}

But this is different---the other side mentioned a capability's
name, and we looked it up from our table to see if we know about it
(i.e. NULL-ness of c), but in addition, we ask if we would tell them
about it if we were advertising.  I am not sure how I should feel
about it (yet).

> +static int is_command(const char *key, struct protocol_capability **command)
> +{
> +	const char *out;
> +
> +	if (skip_prefix(key, "command=", &out)) {
> +		struct protocol_capability *cmd = get_capability(out);
> +
> +		if (!cmd || !cmd->advertise(the_repository, NULL) || !cmd->command)
> +			die("invalid command '%s'", out);
> +		if (*command)
> +			die("command already requested");

Shouldn't these two checks that lead to die the other way around?
When they give us "command=frotz" and we already have *command, it
would be an error whether we understand 'frotz' or not.

Who are the target audience of these "die"?  Are they meant to be
communicated back to the other side of the connection, or are they
only to be sent to the "server log"?

The latter one may want to say what two conflicting commands are in
the log message, perhaps?

> +		*command = cmd;

