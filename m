Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E4942047F
	for <e@80x24.org>; Mon,  7 Aug 2017 17:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751513AbdHGRVk (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 13:21:40 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:38856 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751453AbdHGRVj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 13:21:39 -0400
Received: by mail-pg0-f44.google.com with SMTP id l64so4001973pge.5
        for <git@vger.kernel.org>; Mon, 07 Aug 2017 10:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=laAYpCkFbxByl/AeJrR1QrjK76E+cUOMcfR/FFGqiwQ=;
        b=M7MfQOdtK/LhYtwvKQZYo3J8nKjbUAbG3cM/ihx+0lx7EX2zOqAkduN9Te3xOOi5BP
         SbPflOWo6xBPWHPZEjgoecBfK6MVIU50xC+E34LKPCmpt9W9Zu30hsK5hirXzVZqvS63
         oYYtRi3YVhWE5U2RV33pacGOIwnX1AEnKMhxJAq8/6oKVzj7Sh/8I4uEAGSmfmaF/Egk
         eDM1Zz7g/hE/N7m2Ms9nzsbe0TSB7qdzXwNzFni+GE2SWdBGJh3/fjJgMQGoXzutBP+0
         bzou8sWhDWdbXQEh2NLsDE/i8O+akfEXlSpHmdVUk7zF1rzUOxBfuznf9O2vIFfNvtag
         cmYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=laAYpCkFbxByl/AeJrR1QrjK76E+cUOMcfR/FFGqiwQ=;
        b=fpSfIMOVP76cUApgfIaDdu8td8xaWBf76xi9VboQP6/4cwcO2dcNjYv7XjeFq1UY7s
         U34Hs6sA5uwXeBqEW2y13UHuc9DiX2awSeUAYAIsvLp4aXukEy1WbYNUaeUFTM3IfeKd
         t5nh5fIXaPp8Ig4VdY7MyByzlHSXh6Yq16A6hkY6kGtMlOXoXhryLWXipAvfcPyQ1c/E
         aWwhZJuIwiIphY3gtjWx/Huns7fqL3gNFqRcb35VsRWO14NOSaJY2pewZPql7+TgMn65
         OnkGE46eokUrIcOTwMMmq/pgoE8MjvAFQYObQc07fKx1MNo/jgV2tJkreNeDK20OwpZU
         YqMw==
X-Gm-Message-State: AHYfb5g4J4+wz7FU8Q+oQSmzcXtJFurVQcajaJsPLC7S1GADhKdeInqU
        6QQxhRQhm/PFntoa
X-Received: by 10.101.69.205 with SMTP id m13mr1182350pgr.105.1502126499069;
        Mon, 07 Aug 2017 10:21:39 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:a0fe:8dcf:c61c:f231])
        by smtp.gmail.com with ESMTPSA id z8sm15590506pfk.130.2017.08.07.10.21.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 07 Aug 2017 10:21:38 -0700 (PDT)
Date:   Mon, 7 Aug 2017 10:21:36 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org, bmwill@google.com, gitster@pobox.com
Subject: Re: [PATCH for NEXT v3 2/2] sub-process: refactor handshake to
 common function
Message-ID: <20170807102136.30b23023@twelve2.svl.corp.google.com>
In-Reply-To: <323E470B-994B-4AD8-9F30-588C2B97A845@gmail.com>
References: <cover.1501092795.git.jonathantanmy@google.com>
        <20170724213810.29831-1-jonathantanmy@google.com>
        <cover.1501092795.git.jonathantanmy@google.com>
        <6327579311fdb941a11b6d452318777a3c42ee65.1501092795.git.jonathantanmy@google.com>
        <323E470B-994B-4AD8-9F30-588C2B97A845@gmail.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 6 Aug 2017 21:58:24 +0200
Lars Schneider <larsxschneider@gmail.com> wrote:

> > +	struct cmd2process *entry = (struct cmd2process *)subprocess;
> > +	return subprocess_handshake(subprocess, "git-filter", versions, NULL,
> > +				    capabilities,
> > +				    &entry->supported_capabilities);
> 
> Wouldn't it make sense to add `supported_capabilities` to `struct subprocess_entry` ?

The members of "struct subprocess_entry" are not supposed to be accessed
directly, according to the documentation. If we relaxed that, then we
could do this, but before that I think it's better to let the caller
handle it.

> > +
> > +static int handshake_version(struct child_process *process,
> > +			     const char *welcome_prefix, int *versions,
> 
> Maybe it would be less ambiguous if we call it `supported_versions` ? 

I thought of that, but I think "supported_versions" is actually more
ambiguous, since we don't know if these are versions supported by the
server or client or both.

> > +			     int *chosen_version)
> > +{
> > +	int version_scratch;
> > +	int i;
> > +	char *line;
> > +	const char *p;
> > +
> > +	if (!chosen_version)
> > +		chosen_version = &version_scratch;
> 
> I am not an C expert but wouldn't 'version_scratch' go out of scope as soon
> as the function returns? Why don't you error here right away?

It does, but so does chosen_version. This is meant to allow the caller
to pass NULL to this function.

> > +	if (packet_write_fmt_gently(process->in, "%s-client\n",
> > +				    welcome_prefix))
> > +		return error("Could not write client identification");
> 
> Nit: Would it make sense to rename `welcome_prefix` to `client_id`?
> Alternatively, could we rename the error messages to "welcome prefix"?

I was retaining the existing terminology, but your suggestions seem
reasonable. This might be best done in another patch once this series
lands in master, though.

> > +	for (i = 0; versions[i]; i++) {
> > +		if (packet_write_fmt_gently(process->in, "version=%d\n",
> > +					    versions[i]))
> > +			return error("Could not write requested version");
> 
> Maybe: "Could not write supported versions"?

Same as above - "supported" is ambiguous.

> > +	}
> > +	if (packet_flush_gently(process->in))
> > +		return error("Could not write flush packet");
> 
> I feel this error is too generic.
> Maybe: "Could not finish writing supported versions"?

That's reasonable. This is a rare error, though, and if it does occur, I
think this message is more informative. But I'm OK either way.

> > +
> > +	if (!(line = packet_read_line(process->out, NULL)) ||
> > +	    !skip_prefix(line, welcome_prefix, &p) ||
> > +	    strcmp(p, "-server"))
> > +		return error("Unexpected line '%s', expected %s-server",
> > +			     line ? line : "<flush packet>", welcome_prefix);
> > +	if (!(line = packet_read_line(process->out, NULL)) ||
> > +	    !skip_prefix(line, "version=", &p) ||
> > +	    strtol_i(p, 10, chosen_version))
> 
> Maybe `strlen("version=")` would be more clear than 10?

The 10 here is the base, not the length. If there's a better way to
convert strings to integers, let me know.

> > +		return error("Unexpected line '%s', expected version",
> 
> Maybe "... expected version number" ?

I'm fine either way.

> > +static int handshake_capabilities(struct child_process *process,
> > +				  struct subprocess_capability *capabilities,
> > +				  unsigned int *supported_capabilities)
> 
> I feel the naming could be misleading. I think ...
> `capabilities` is really `supported_capabilities` 
> and 
> `supported_capabilities` is really `negiotated_capabilties` or `agreed_capabilites`

These "supported capabilities" are those supported by both the client
(Git) and the server (the process Git is invoking). I think it's better
to use this term for the intersection of capabilities, rather than
exclusively for the client or server.

> > +	for (i = 0; capabilities[i].name; i++) {
> > +		if (packet_write_fmt_gently(process->in, "capability=%s\n",
> > +					    capabilities[i].name))
> > +			return error("Could not write requested capability");
> 
> I think this should be "Could not write supported capability", no?

Same comment as above.

> > +	}
> > +	if (packet_flush_gently(process->in))
> > +		return error("Could not write flush packet");
> 
> Maybe " "Could not finish writing supported capability" ?

Same comment as the one about writing flush packets above.

> > +	while ((line = packet_read_line(process->out, NULL))) {
> > +		const char *p;
> > +		if (!skip_prefix(line, "capability=", &p))
> > +			continue;
> 
> Shouldn't we write an error in this case?

I'm preserving the existing behavior.

> > +/*
> > + * Perform the version and capability negotiation as described in the "Long
> > + * Running Filter Process" section of the gitattributes documentation using the
> > + * given requested versions and capabilities. The "versions" and "capabilities"
> > + * parameters are arrays terminated by a 0 or blank struct.
> 
> Should we reference the "gitattributes docs" if we want to make this generic?
> I thought "technical/api-sub-process.txt" would explain this kind of stuff
> and I was surprised that you deleted it in an earlier patch.

I think this should be done only when we have two users of this, for
example, when a patch like [1] (which does contain the change to move
away from the gitattributes doc) lands.

[1] https://public-inbox.org/git/eadce97b6a1e80345a2621e71ce187e9e6bc05bf.1501532294.git.jonathantanmy@google.com/

> The generalization of this protocol is nice to see.
> 
> Thanks for working on it,
> Lars

Thanks for your comments.
