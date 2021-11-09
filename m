Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A67F5C433FE
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 01:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9066461105
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 01:53:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241671AbhKIB4J (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Nov 2021 20:56:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241543AbhKIB4I (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Nov 2021 20:56:08 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1587CC061764
        for <git@vger.kernel.org>; Mon,  8 Nov 2021 17:53:23 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id r12so70004156edt.6
        for <git@vger.kernel.org>; Mon, 08 Nov 2021 17:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=KddpwaDLzm96g+glxwybIghBUzcqORGZQB+C7S9hgSE=;
        b=gerVWYYY4wrOkAQr1c8Ey07t4JF8VrjzqneRSL1cyJo2pkWmEc+rk2W475d3dFqyvW
         AVMKEd5ZfznA6gMImVDNxzRXSzWnPspOe7LXIyRuNtf5rt/LYlnGctYN32ko5uH5cw3H
         yCIpXOwUFOYV9CqQj9eB33faYcSrJ3IegjEuIp3LcIRlMuBjx7hxVaiW/3K/da5BPfea
         CnSN3f+wrbvLoBMcZwMKZ2J/YYCI+afkuHbqgAvCSO4XNrNpo78JTYlXxic1x6ywzDXm
         6Kpgy3syJ7l8ablgO7LOt952mr6GCKQ+ZyNQt1m+cj8sJfmQVoft45FRPs5IoKEChE4l
         3zAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=KddpwaDLzm96g+glxwybIghBUzcqORGZQB+C7S9hgSE=;
        b=lLAZPayKbFr+xxpfX2Mdu19ZKhKebnBZgRp0q5Dj11ciUS7zADeTpLRS/SJes4hL0u
         GB6x8E1giqLxmjjUOpnyrQmBAb2xfC7oWWMHVpXbQfmrK9TgqagmTc0jzP1EN/YIIyuF
         +7AlDMwMgb+zUdvRTV92X80TAg6pt6BQiqavYTO8x5V9v23ajXz5yjpZZrz9y7omoZnR
         JXt4NZs7xhoWSeBzELv0kk/477yrnXagLnHjZYPgG+xUqzg4244vL9+EtyenMPhY+Ljs
         Naa58+zy4CPYmXnooQ7Rx5RWjzvVJMJFTuwpRMbs4LynV1V7S6ZYqQa4WbNti2dCf2JZ
         HYfw==
X-Gm-Message-State: AOAM530igq8gvYuzL5b+sn5l5D1QcOs7fthskWt5tKkNJiGKONGOOHO7
        5lYlJJCjNzjiwRMrqdD+TaLXVX0aemY=
X-Google-Smtp-Source: ABdhPJylgYyGPS3zP1AAS/T3qojD9B2h4nZ71ba9k4VCuQj83RCnx0uO37qUERfBoRYKT0Dnl7TMwQ==
X-Received: by 2002:a17:907:774d:: with SMTP id kx13mr4825338ejc.239.1636422801503;
        Mon, 08 Nov 2021 17:53:21 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id s28sm10033270edw.81.2021.11.08.17.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 17:53:20 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mkGK8-001J4c-HZ;
        Tue, 09 Nov 2021 02:53:20 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     gitgitgadget@gmail.com, git@vger.kernel.org,
        sunshine@sunshineco.com, ifrade@google.com
Subject: Re: [PATCH v6 1/2] fetch-pack: redact packfile urls in traces
Date:   Tue, 09 Nov 2021 02:36:58 +0100
References: <a6098f98946bd9cc1186ab9c83d917566c78b805.1635532975.git.gitgitgadget@gmail.com>
 <20211108230111.1101434-1-jonathantanmy@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.6
In-reply-to: <20211108230111.1101434-1-jonathantanmy@google.com>
Message-ID: <211109.86mtmedrhr.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 08 2021, Jonathan Tan wrote:

>> diff --git a/fetch-pack.c b/fetch-pack.c
>> index a9604f35a3e..62ea90541c5 100644
>> --- a/fetch-pack.c
>> +++ b/fetch-pack.c
>> @@ -1653,8 +1653,12 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
>>  				receive_wanted_refs(&reader, sought, nr_sought);
>>  
>>  			/* get the pack(s) */
>> +			if (git_env_bool("GIT_TRACE_REDACT", 1))
>> +				reader.options |= PACKET_READ_REDACT_URI_PATH;
>>  			if (process_section_header(&reader, "packfile-uris", 1))
>>  				receive_packfile_uris(&reader, &packfile_uris);
>> +			reader.options &= ~PACKET_READ_REDACT_URI_PATH;
>
> Probably worth commenting why you're resetting the flag (avoid the
> relatively expensive URI check when we don't need it).

...yeah...

>> diff --git a/pkt-line.c b/pkt-line.c
>> index 2dc8ac274bd..5a69ddc2e77 100644
>> --- a/pkt-line.c
>> +++ b/pkt-line.c
>> @@ -370,6 +370,31 @@ int packet_length(const char lenbuf_hex[4])
>>  	return (val < 0) ? val : (val << 8) | hex2chr(lenbuf_hex + 2);
>>  }
>>  
>> +static char *find_packfile_uri_path(const char *buffer)
>> +{
>> +	const char *URI_MARK = "://";
>> +	char *path;
>> +	int len;
>> +
>> +	/* First char is sideband mark */
>> +	buffer += 1;
>> +
>> +	len = strspn(buffer, "0123456789abcdefABCDEF");
>> +	if (len != (int)the_hash_algo->hexsz || buffer[len] != ' ')
>> +		return NULL; /* required "<hash>SP" not seen */
>
> Optional: As I said in my reply (just sent out), checking for both SHA-1
> and SHA-256 lengths is reasonable too.
>
> [1] https://lore.kernel.org/git/20211108224335.569596-1-jonathantanmy@google.com/

Correct me if I'm wrong, but I find it really strange that we're trying
to parse things in pkt-line.c like this.

We'll only get these from a client in code that's invoked in
fetch-pack.c, specifically the process_section_header() quoted above,
no?

From there we'll call packet_reader_read(), which will call
packet_read_with_status(), and from there we'll call packet_trace().

Then right after all this happens we've got a loop that parses out these
packfile URIs, including this being-done-first-here parsing of the hex
value just for logging, except in pkt-line.c we've lost the information
about what hash algorithm length we should be using, which fetch-pack.c
of course needs to know.

Why can't that process_section_header() in fetch-pack.c just be made to
call some pkt-line.c API saying "don't log yet", i.e. something like
this pseudocode:

diff --git a/fetch-pack.c b/fetch-pack.c
index a9604f35a3e..31f5ee7fc6b 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1518,14 +1518,18 @@ static void receive_wanted_refs(struct packet_reader *reader,
 static void receive_packfile_uris(struct packet_reader *reader,
                                  struct string_list *uris)
 {
+       struct string_list log = STRING_LIST_INIT_DUP;
+
        process_section_header(reader, "packfile-uris", 0);
-       while (packet_reader_read(reader) == PACKET_READ_NORMAL) {
+       while (packet_reader_read_log_to(reader, &log) == PACKET_READ_NORMAL) {
                if (reader->pktlen < the_hash_algo->hexsz ||
                    reader->line[the_hash_algo->hexsz] != ' ')
                        die("expected '<hash> <uri>', got: %s\n", reader->line);
 
+               /* move the parsing of the URLs here */
                string_list_append(uris, reader->line);
        }
+       log_stuff(&log);
        if (reader->status != PACKET_READ_DELIM)
                die("expected DELIM");
 }

I.e. we'll eventually call trace_strbuf() in pkt-line.c, and we know
that we're doing these packfile-uris, and we know that we're just about
to parse them. Let's just:

 1. Start reading the section
 2. Turn off tracing
 3. Parse the URIs as we go
 3. When done (or on the fly), scrub URIs, log any backlog suppressed trace, and turn on tracing again

Instead of:

 1. Set a flag to scrub stuff
 2. Because of the disconnect between fetch-pack.c and pkt-line.c,
    effectively implement a new parser for data we're already going to be
    parsing some microseconds later during the course of the request.

That "turn off the trace" could be passing down a string_list/strbuf, or
even doing the same via a nev member in "struct packet_reader", both
would be simpler than needing to re-do the parse. Probably simplest is just:

    struct string_list log = STRING_LIST_INIT_DUP;

    reader.deferred_trace = &log;
    /* packet_reader_read() etc. code, unchanged from now */
    /* parse URIs (just move the existing code around a bit) */
    packet_reader.deferred_trace = NULL;
    for_each...(item, &log)
        trace_strbuf(...);
