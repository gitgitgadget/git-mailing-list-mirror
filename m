Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04767202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 21:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752094AbdIVVBI (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 17:01:08 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:53220 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751974AbdIVVBH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 17:01:07 -0400
Received: by mail-pg0-f43.google.com with SMTP id i195so1188159pgd.9
        for <git@vger.kernel.org>; Fri, 22 Sep 2017 14:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VzGMA2tDh/EkaHwcg5p5p5pC4TaD9F3eqBRfPWKm4Jc=;
        b=YW9V8bB0BAoXDOHuz/klowe/flzcd5q8qGd3BIGWeu8aH7e/Dq8jF1nvRwetapLXqS
         g4BE1J7xhndbXCACDUHaMgMVxLHCRyksxb/DJywWzq7wNE6ywLxSRfAedQ5/cR00b8Fr
         fgIAZuehQTn6U9pnSbw40spVXxivVop5ol14255YY5OEDar2qrABAcLSmCwTtzRCmB5L
         olAbpPudz33L+WrKTa4nheNYeZlXm0c97jZhmSFyR7HGsBA9kokoHGl/kZHi1LaNr0o9
         BiqeoXgp8ZEKZ6Q3fZQldHnDRB4fxIS81/1dSZHRe7jOBiW/r0kKp2q7NgjA5xcLXc7V
         OCXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VzGMA2tDh/EkaHwcg5p5p5pC4TaD9F3eqBRfPWKm4Jc=;
        b=nDPoRBioQQjmSaYIEbipFLPYJCM3lXxFrv9wSkxAwgWRxjIwfsBchS877Tmu105GKO
         PC9j9SjpKy1h0chnxA8PeDb8Epwggm1+FFhmQsJPVtRcWof96dieqJdlKgMFoi7Epc//
         EiEJvkU3QxOnuLm3Rr+YF8Q9iocMSpYyFXLEt5nmJlQ77c/i41fvvDPCPfwvZe2oiuY+
         9RmbkyRY0I7GEselu1STQAgybG6scsw3CONmu4b7++HJlcCMKR0ATGhkBWzDnn7NxQt6
         iDj5+Xmz+iJ1Um+0iNuVztX4njmo2Xnu/VGciKmCIGGN4Z39lEJnF8iFaVWuHJ0JavAN
         Exyg==
X-Gm-Message-State: AHPjjUj8cvMsBUTRJatVg73ag4h3UmAqgQ8ajPtTtFNcgtnHWTgQsRMx
        pThsoYjuw14z2riVxhUSuelYoO9qZZ4=
X-Google-Smtp-Source: AOwi7QD5Fl/BTSqLyKzkE9oKorC+eCp2HJfyNqOXK89LiDj+8ISqg9AE1N8HqEb99b9/QLRyrQU8dg==
X-Received: by 10.101.88.134 with SMTP id d6mr331211pgu.339.1506114066683;
        Fri, 22 Sep 2017 14:01:06 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:1986:3ebf:8c68:2a02])
        by smtp.gmail.com with ESMTPSA id h90sm886718pfj.32.2017.09.22.14.01.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 22 Sep 2017 14:01:05 -0700 (PDT)
Date:   Fri, 22 Sep 2017 14:01:04 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, gitster@pobox.com,
        peff@peff.net
Subject: Re: [PATCH v4] connect: in ref advertisement, shallows are last
Message-ID: <20170922210104.GB24036@google.com>
References: <20170922164504.GD77641@google.com>
 <20170922201551.15012-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170922201551.15012-1-jonathantanmy@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/22, Jonathan Tan wrote:
> Currently, get_remote_heads() parses the ref advertisement in one loop,
> allowing refs and shallow lines to intersperse, despite this not being
> allowed by the specification. Refactor get_remote_heads() to use two
> loops instead, enforcing that refs come first, and then shallows.
> 
> This also makes it easier to teach get_remote_heads() to interpret other
> lines in the ref advertisement, which will be done in a subsequent
> patch.
> 
> As part of this change, this patch interprets capabilities only on the
> first line in the ref advertisement, ignoring all others.
> 
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> I've updated state transitions to occur in get_remote_heads() instead,
> as suggested. I didn't want to do that previously because each step in
> the state machine needed to communicate if (i) the line is "consumed"
> and (ii) the state needed to be advanced, but with Junio's suggestion to
> reorganize the methods, that is no longer true.
> 
> As Junio said, the free(server_capabilities) can be removed.
> 
> As for whether how capabilities on subsequent lines are handled, I think
> it's better to ignore them - they are behind NULs, after all.
> 
> Yes, "connect: teach client to recognize v1 server response" will need
> to be modified.
> 
> This change does have the side effect that if the server sends a ref
> advertisement with "shallow"s only (and no refs), things will still
> work, and the server can even tuck capabilities on the first "shallow"
> line. I think that's fine, and it does make the client code cleaner.
> ---
>  connect.c | 171 ++++++++++++++++++++++++++++++++++++++------------------------
>  1 file changed, 105 insertions(+), 66 deletions(-)
> 
> diff --git a/connect.c b/connect.c
> index 49b28b83b..978d01359 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -11,6 +11,7 @@
>  #include "string-list.h"
>  #include "sha1-array.h"
>  #include "transport.h"
> +#include "strbuf.h"
>  
>  static char *server_capabilities;
>  static const char *parse_feature_value(const char *, const char *, int *);
> @@ -107,6 +108,86 @@ static void annotate_refs_with_symref_info(struct ref *ref)
>  	string_list_clear(&symref, 0);
>  }
>  
> +/*
> + * Read one line of a server's ref advertisement into packet_buffer.
> + */
> +static int read_remote_ref(int in, char **src_buf, size_t *src_len,
> +			   int *responded)
> +{
> +	int len = packet_read(in, src_buf, src_len,
> +			      packet_buffer, sizeof(packet_buffer),
> +			      PACKET_READ_GENTLE_ON_EOF |
> +			      PACKET_READ_CHOMP_NEWLINE);
> +	const char *arg;
> +	if (len < 0)
> +		die_initial_contact(*responded);
> +	if (len > 4 && skip_prefix(packet_buffer, "ERR ", &arg))
> +		die("remote error: %s", arg);
> +
> +	*responded = 1;
> +
> +	return len;
> +}
> +
> +#define EXPECTING_FIRST_REF 0
> +#define EXPECTING_REF 1
> +#define EXPECTING_SHALLOW 2
> +
> +static void process_capabilities(int len)
> +{
> +	int nul_location = strlen(packet_buffer);

It may make more sense to not rely on accessing a global buffer here
directly and instead pass in the buff you're working on, much like your
are doing with len.

> +	if (nul_location == len)
> +		return;
> +	server_capabilities = xstrdup(packet_buffer + nul_location + 1);
> +}
> +
> +static int process_dummy_ref(void)
> +{
> +	static char *template;
> +	if (!template)
> +		template = xstrfmt("%040d capabilities^{}", 0);

I'm not the biggest fan of dynamically allocating this and then using it
to compare.  Maybe we can check to make sure that the oid matches the
null_oid and that the name matches the "capabilities^{}" string?  That
way you can avoid the allocation?

> +	return !strcmp(packet_buffer, template);
> +}
> +
> +static int process_ref(struct ref ***list, unsigned int flags,
> +		       struct oid_array *extra_have)

So from comparing this to the current code it doesn't look like there is
a check in 'process_ref' that ensures that a 'capabilities^{}' line
doesn't show up after a normal ref, or am I missing something?

> +{
> +	struct object_id old_oid;
> +	const char *name;
> +
> +	if (parse_oid_hex(packet_buffer, &old_oid, &name))
> +		return 0;
> +	if (*name != ' ')
> +		return 0;
> +	name++;
> +
> +	if (extra_have && !strcmp(name, ".have")) {
> +		oid_array_append(extra_have, &old_oid);
> +	} else if (check_ref(name, flags)) {
> +		struct ref *ref = alloc_ref(name);
> +		oidcpy(&ref->old_oid, &old_oid);
> +		**list = ref;
> +		*list = &ref->next;
> +	}
> +	return 1;
> +}
> +
> +static int process_shallow(struct oid_array *shallow_points)
> +{
> +	const char *arg;
> +	struct object_id old_oid;
> +
> +	if (!skip_prefix(packet_buffer, "shallow ", &arg))
> +		return 0;
> +
> +	if (get_oid_hex(arg, &old_oid))
> +		die("protocol error: expected shallow sha-1, got '%s'", arg);
> +	if (!shallow_points)
> +		die("repository on the other end cannot be shallow");
> +	oid_array_append(shallow_points, &old_oid);
> +	return 1;
> +}
> +
>  /*
>   * Read all the refs from the other end
>   */
> @@ -123,76 +204,34 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
>  	 * willing to talk to us.  A hang-up before seeing any
>  	 * response does not necessarily mean an ACL problem, though.
>  	 */
> -	int saw_response;
> -	int got_dummy_ref_with_capabilities_declaration = 0;
> +	int responded = 0;
> +	int len;
> +	int state = EXPECTING_FIRST_REF;
>  
>  	*list = NULL;
> -	for (saw_response = 0; ; saw_response = 1) {
> -		struct ref *ref;
> -		struct object_id old_oid;
> -		char *name;
> -		int len, name_len;
> -		char *buffer = packet_buffer;
> -		const char *arg;
> -
> -		len = packet_read(in, &src_buf, &src_len,
> -				  packet_buffer, sizeof(packet_buffer),
> -				  PACKET_READ_GENTLE_ON_EOF |
> -				  PACKET_READ_CHOMP_NEWLINE);
> -		if (len < 0)
> -			die_initial_contact(saw_response);
> -
> -		if (!len)
> -			break;
>  
> -		if (len > 4 && skip_prefix(buffer, "ERR ", &arg))
> -			die("remote error: %s", arg);
> -
> -		if (len == GIT_SHA1_HEXSZ + strlen("shallow ") &&
> -			skip_prefix(buffer, "shallow ", &arg)) {
> -			if (get_oid_hex(arg, &old_oid))
> -				die("protocol error: expected shallow sha-1, got '%s'", arg);
> -			if (!shallow_points)
> -				die("repository on the other end cannot be shallow");
> -			oid_array_append(shallow_points, &old_oid);
> -			continue;
> -		}
> -
> -		if (len < GIT_SHA1_HEXSZ + 2 || get_oid_hex(buffer, &old_oid) ||
> -			buffer[GIT_SHA1_HEXSZ] != ' ')
> -			die("protocol error: expected sha/ref, got '%s'", buffer);
> -		name = buffer + GIT_SHA1_HEXSZ + 1;
> -
> -		name_len = strlen(name);
> -		if (len != name_len + GIT_SHA1_HEXSZ + 1) {
> -			free(server_capabilities);
> -			server_capabilities = xstrdup(name + name_len + 1);
> -		}
> -
> -		if (extra_have && !strcmp(name, ".have")) {
> -			oid_array_append(extra_have, &old_oid);
> -			continue;
> -		}
> -
> -		if (!strcmp(name, "capabilities^{}")) {
> -			if (saw_response)
> -				die("protocol error: unexpected capabilities^{}");
> -			if (got_dummy_ref_with_capabilities_declaration)
> -				die("protocol error: multiple capabilities^{}");
> -			got_dummy_ref_with_capabilities_declaration = 1;
> -			continue;
> +	while ((len = read_remote_ref(in, &src_buf, &src_len, &responded))) {
> +		switch (state) {
> +		case EXPECTING_FIRST_REF:
> +			process_capabilities(len);
> +			if (process_dummy_ref()) {
> +				state = EXPECTING_SHALLOW;
> +				break;
> +			}
> +			state = EXPECTING_REF;
> +			/* fallthrough */
> +		case EXPECTING_REF:
> +			if (process_ref(&list, flags, extra_have))
> +				break;
> +			state = EXPECTING_SHALLOW;
> +			/* fallthrough */
> +		case EXPECTING_SHALLOW:
> +			if (process_shallow(shallow_points))
> +				break;
> +			die("protocol error: unexpected '%s'", packet_buffer);
> +		default:
> +			die("unexpected state %d", state);

Looks much cleaner, thanks!

>  		}
> -
> -		if (!check_ref(name, flags))
> -			continue;
> -
> -		if (got_dummy_ref_with_capabilities_declaration)
> -			die("protocol error: unexpected ref after capabilities^{}");
> -
> -		ref = alloc_ref(buffer + GIT_SHA1_HEXSZ + 1);
> -		oidcpy(&ref->old_oid, &old_oid);
> -		*list = ref;
> -		list = &ref->next;
>  	}
>  
>  	annotate_refs_with_symref_info(*orig_list);
> -- 
> 2.14.1.728.g20a5b67d5.dirty
> 

-- 
Brandon Williams
