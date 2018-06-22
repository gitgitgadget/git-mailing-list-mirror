Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8DC31F516
	for <e@80x24.org>; Fri, 22 Jun 2018 23:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754559AbeFVXBY (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Jun 2018 19:01:24 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35074 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754482AbeFVXBW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jun 2018 19:01:22 -0400
Received: by mail-pf0-f196.google.com with SMTP id c22-v6so3856394pfi.2
        for <git@vger.kernel.org>; Fri, 22 Jun 2018 16:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JB/yQFfa9AQnN2S4EfDQgn/6EWehgfgzojWULIokLWw=;
        b=b6xu0/syPBZk1X3UA3egxz5o2ghhkAcFBzqqgeQxhtrlPyCt1dJc/3HrNyyNukC7kL
         VWQE57PZUXKkcWSFFGwD95CcYmYXaGu0Mmgd4EeliFzsllnuPT4BF9gFRnxk4oltVM4r
         F9/yDO3FjkcFlY7mAXFvW4vTTuO+u/tQ5xAJAnd9mknrbq0Es0iU44awpTN4Pbu5ADJA
         jI0HoqxloUoqXM9esU4rsO+DV+nuPp/bESngZ1do+HjbZDTTQHm+mwoYbhxfU+/mjIk6
         k/SUKYKpw7bKUukttTY7yDZrGsRvfdB1LYvwLlBEt+JWr9rWeg67sW8gzhUmKPxOzhnz
         ncyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JB/yQFfa9AQnN2S4EfDQgn/6EWehgfgzojWULIokLWw=;
        b=Pl8XKYGUhEXI3ImL3N01X61e4HS3UVsgl9I6+rRPs00R5HP+nODmgHpn5JUsn3LfbK
         JptuQVk4jkco9YQFk6joUJZCuhV4qV2C696U2QSmkia1YdLDwGji5M4pP5hD3rijnjy/
         IoqgujT/uWmBb7d+uDVP+POilIiaIozAmGq/AN59mkZGwU+BycPbBddcNygc0gcUeEpb
         drz4GUirL8pTW6SEltZxynnuj7xol9qHzHjY3LON5W+rwU9EwasMcQh3pIns0uiRxQpW
         qO7fufpYnCfT1RyoDMKdChTtcQp+c+x43AZ7DEBx+RdwovI3I6i3DmFXLaBOC8jgFqYO
         1iOA==
X-Gm-Message-State: APt69E1h96S/CGF86DaHYTExaKDRc702Q6GD1hFASewinw/KAdiFJJN6
        +35jhcnCjIPjF6d972uFxgQ=
X-Google-Smtp-Source: ADUXVKJ4SgBKJJ2ZlVRPi3uf/Da61vB1MyJZ25SrCWU1uC18YVsWcsNh6tBKghVV6CYP6Rmq/vdIXw==
X-Received: by 2002:a62:6f86:: with SMTP id k128-v6mr3595578pfc.150.1529708482117;
        Fri, 22 Jun 2018 16:01:22 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id b74-v6sm19817492pfl.138.2018.06.22.16.01.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jun 2018 16:01:21 -0700 (PDT)
Date:   Fri, 22 Jun 2018 16:01:19 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com, gitster@pobox.com,
        sbeller@google.com
Subject: Re: [PATCH v3 8/8] fetch-pack: implement ref-in-want
Message-ID: <20180622230119.GL12013@aiede.svl.corp.google.com>
References: <20180613213925.10560-1-bmwill@google.com>
 <20180620213235.10952-1-bmwill@google.com>
 <20180620213235.10952-9-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620213235.10952-9-bmwill@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Brandon Williams wrote:

> Implement ref-in-want on the client side so that when a server supports
> the "ref-in-want" feature, a client will send "want-ref" lines for each
> reference the client wants to fetch.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  fetch-pack.c                       | 35 +++++++++++++++++++++++++++---
>  remote.c                           |  1 +
>  remote.h                           |  1 +
>  t/t5703-upload-pack-ref-in-want.sh |  4 ++--
>  4 files changed, 36 insertions(+), 5 deletions(-)

This commit message doesn't tell me what ref-in-want is or is for.  Could
it include

 A. a pointer to Documentation/technical/protocol-v2.txt, or
 B. an example illustrating the effect e.g. using GIT_TRACE_PACKET

or both?

[...]
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -1102,9 +1102,10 @@ static void add_shallow_requests(struct strbuf *req_buf,
>  
>  static void add_wants(const struct ref *wants, struct strbuf *req_buf)
>  {
> +	int use_ref_in_want = server_supports_feature("fetch", "ref-in-want", 0);
> +
>  	for ( ; wants ; wants = wants->next) {

Not about this patch: it's kind of confusing that the iterator is called
'wants' even though it points into the middle of the list.  I would even
be tempted to do

	const struct ref *want;
	for (want = wants; want; want = want->next) {

It wouldn't make sense to do in this patch, though.

[...]
> @@ -1122,8 +1123,10 @@ static void add_wants(const struct ref *wants, struct strbuf *req_buf)
>  			continue;
>  		}
>  
> -		remote_hex = oid_to_hex(remote);
> -		packet_buf_write(req_buf, "want %s\n", remote_hex);
> +		if (!use_ref_in_want || wants->exact_oid)
> +			packet_buf_write(req_buf, "want %s\n", oid_to_hex(remote));
> +		else
> +			packet_buf_write(req_buf, "want-ref %s\n", wants->name);

Very neat.

[...]
> @@ -1334,6 +1337,29 @@ static void receive_shallow_info(struct fetch_pack_args *args,
>  	args->deepen = 1;
>  }
>  
> +static void receive_wanted_refs(struct packet_reader *reader, struct ref *refs)
> +{
> +	process_section_header(reader, "wanted-refs", 0);
> +	while (packet_reader_read(reader) == PACKET_READ_NORMAL) {
> +		struct object_id oid;
> +		const char *end;
> +		struct ref *r = NULL;
> +
> +		if (parse_oid_hex(reader->line, &oid, &end) || *end++ != ' ')
> +			die("expected wanted-ref, got '%s'", reader->line);
> +
> +		for (r = refs; r; r = r->next) {
> +			if (!strcmp(end, r->name)) {
> +				oidcpy(&r->old_oid, &oid);
> +				break;
> +			}

Stefan mentioned that the spec says

        * The server MUST NOT send any refs which were not requested
          using 'want-ref' lines.

Can client enforce that?  If not, can the spec say SHOULD NOT for the
server and add a MUST describing appropriate client behavior?

> +		}
> +	}
> +
> +	if (reader->status != PACKET_READ_DELIM)

The spec says

        * This section is only included if the client has requested a
          ref using a 'want-ref' line and if a packfile section is also
          included in the response.

What should happen if the client already has all the relevant objects
(or in other words if there is no packfile to send in the packfile
section)?  Is the idea that the client should already have known that
based on the ref advertisement?  What if ref values change to put us
in that state between the ls-refs and fetch steps?

[...]
> --- a/remote.c
> +++ b/remote.c
> @@ -1735,6 +1735,7 @@ int get_fetch_map(const struct ref *remote_refs,
>  		if (refspec->exact_sha1) {
>  			ref_map = alloc_ref(name);
>  			get_oid_hex(name, &ref_map->old_oid);
> +			ref_map->exact_oid = 1;

Sensible.  The alternative would be that we check whether the
refname is oid-shaped at want-ref generation time, which would be
unnecessarily complicated.

[...]
> --- a/remote.h
> +++ b/remote.h
> @@ -73,6 +73,7 @@ struct ref {

Not about this patch: why is this in remote.h instead of ref.h?

>  		force:1,
>  		forced_update:1,
>  		expect_old_sha1:1,
> +		exact_oid:1,
>  		deletion:1;

Looks good, and we have room for plenty more bits there.

[...]
> +++ b/t/t5703-upload-pack-ref-in-want.sh

Nice.

Thanks for a pleasant read.

Sincerely,
Jonathan
