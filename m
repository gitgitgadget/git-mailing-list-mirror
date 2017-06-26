Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2739A207D2
	for <e@80x24.org>; Mon, 26 Jun 2017 19:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751739AbdFZTCz (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Jun 2017 15:02:55 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33516 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751386AbdFZTCy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2017 15:02:54 -0400
Received: by mail-pf0-f196.google.com with SMTP id e199so1374411pfh.0
        for <git@vger.kernel.org>; Mon, 26 Jun 2017 12:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=mQHBMHSlZhSCDbrDE8ECmBbeUrFrcFiaX/3o3P/forU=;
        b=fj1X6s8CEdsm3ReAg2+ivwtuzT9IRlCIqgqKeC/tFNb7fMHPaRO3B5hVJc3NpJ09t9
         4ET9VTiqqzTtWFYfQRNp9aZI7sVU5SS81fMMcQFkXz/PUPKI77DseFs5Y9qxNzxhTIcq
         O2xY8gne98BVtJ6JS+BTgCz3QWZUjcYY9kcLxmaKWpNCBWtoza4fZ2sJXLNo1gdK+Ubc
         apZBYJR0FhgpFJA2CJ8sg8eGDQlff8WjSbY7FeuGGDlJzFulrf9msIBf8pVb+gaT+PYZ
         Pq0vBo+hGiqKeR4gCVOAGWADBTns038c9OEos4T/e2AgbYlTO5nYVb9eVMI+hN7Oku/3
         cN9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=mQHBMHSlZhSCDbrDE8ECmBbeUrFrcFiaX/3o3P/forU=;
        b=HINxR2lfbQGR9ZfPHRcsgP4gQorofkNuhcL4EYgHKY1kcBUpBZggrc0+J06o0aH+kA
         B62V/LEeCNs0K34jqQ8KZkbrzoJwRavateGZ/Nn94MagNdqiL3KFEpvF+UvWbEA2L4z/
         r9QAbjb2Ln/1OMsx4v8gxLHQynk6EcH/uzpM76dt4RbV/p+y4Qid9mlr3sGDGs7zGzOw
         RrwDT1FG/RVaa22QLUOJnLjuL5T+Lvmir4Udw+S5/dkOfTfLaPlN/K8ouKXxSMjT3+dP
         QcUH/IYlpovyrZoHCME6SNDG25T0sMLtPhQ2u31TgRIZz+HweFjxjwVXbxO4xa7HVgkl
         +f7Q==
X-Gm-Message-State: AKS2vOyXnW02YMLdYVyY7bDjho+2ANoYNk3MbNv3HzTsFEZPrvph3EAY
        fT8h9+xYrKwc5A==
X-Received: by 10.99.166.18 with SMTP id t18mr1515962pge.218.1498503773392;
        Mon, 26 Jun 2017 12:02:53 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b537:cc1a:8e81:b9ca])
        by smtp.gmail.com with ESMTPSA id z4sm1282002pgc.22.2017.06.26.12.02.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 26 Jun 2017 12:02:51 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, tboegi@web.de, e@80x24.org,
        ttaylorr@github.com, peartben@gmail.com
Subject: Re: [PATCH v6 6/6] convert: add "status=delayed" to filter process protocol
References: <20170625182125.6741-1-larsxschneider@gmail.com>
        <20170625182125.6741-7-larsxschneider@gmail.com>
Date:   Mon, 26 Jun 2017 12:02:49 -0700
In-Reply-To: <20170625182125.6741-7-larsxschneider@gmail.com> (Lars
        Schneider's message of "Sun, 25 Jun 2017 20:21:25 +0200")
Message-ID: <xmqqzicu4lnq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> Some `clean` / `smudge` filters might require a significant amount of
> time to process a single blob (e.g. the Git LFS smudge filter might
> perform network requests). During this process the Git checkout
> operation is blocked and Git needs to wait until the filter is done to
> continue with the checkout.

Good motivation.  I'd say s/might/may/ to stress the fact that this
is addressing a real-world problem, i.e. some filters incur network
latencies.

> Teach the filter process protocol (introduced in edcc858) to accept the

When referring to an old commit, we recommend this format

    edcc8581 ("convert: add filter.<driver>.process option", 2016-10-16)

(with or without dq around the title) which helps readers by telling
them how old the thing is and what it was about.

> @@ -512,12 +512,69 @@ the protocol then Git will stop the filter process and restart it
>  with the next file that needs to be processed. Depending on the
>  `filter.<driver>.required` flag Git will interpret that as error.
>  
> -After the filter has processed a blob it is expected to wait for
> -the next "key=value" list containing a command. Git will close
> +After the filter has processed a command it is expected to wait for
> +a "key=value" list containing the next command. Git will close

Good generalization.

> +Delay
> +^^^^^
> +
> +If the filter supports the "delay" capability, then Git can send the
> +flag "can-delay" after the filter command and pathname. This flag
> +denotes that the filter can delay filtering the current blob (e.g. to
> +compensate network latencies) by responding with no content but with
> +the status "delayed" and a flush packet.
> +------------------------
> +packet:          git> command=smudge
> +packet:          git> pathname=path/testfile.dat
> +packet:          git> can-delay=1
> +packet:          git> 0000
> +packet:          git> CONTENT
> +packet:          git> 0000
> +packet:          git< status=delayed
> +packet:          git< 0000
> +------------------------
> +
> +If the filter supports the "delay" capability then it must support the
> +"list_available_blobs" command. If Git sends this command, then the
> +filter is expected to return a list of pathnames of blobs that are
> +available. The list must be terminated with a flush packet followed

Is it correct to read the above "pathnames of blobs that are
availble" as "pathnames, among which Git earlier requested to be
filtered with "can-delay=1", for which the filtered result is
ready"?  I do not mean to suggest this awkward wording to replace
yours, but I found yours a bit too fuzzy for first time readers.

Perhaps my brain has rotten by hearing the "delayed/lazy transfer of
large blobs", but it went "Huh?" upon seeing "...are available".

> +by a "success" status that is also terminated with a flush packet. If
> +no blobs for the delayed paths are available, yet, then the filter is
> +expected to block the response until at least one blob becomes
> +available.

Ahh, this is better, at least you use "the delayed paths".

What if the result never gets available (e.g. resulted in an error)?
Or is it considered "we _now_ know the result is an error" and such
a delayed path that failed to retrieve from LFS store "available" at
that point?

It may be too late to raise to a series that went to v6, but this
smells more like "ready" not "available" to me.

> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index a6b2af39d3..c1a256df8d 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -376,6 +376,8 @@ static int checkout_paths(const struct checkout_opts *opts,
>  	state.force = 1;
>  	state.refresh_cache = 1;
>  	state.istate = &the_index;
> +
> +	enable_delayed_checkout(&state);
>  	for (pos = 0; pos < active_nr; pos++) {
>  		struct cache_entry *ce = active_cache[pos];
>  		if (ce->ce_flags & CE_MATCHED) {
> @@ -390,6 +392,7 @@ static int checkout_paths(const struct checkout_opts *opts,
>  			pos = skip_same_name(ce, pos) - 1;
>  		}
>  	}
> +	errs |= finish_delayed_checkout(&state);

OK.


>  	if (write_locked_index(&the_index, lock_file, COMMIT_LOCK))
>  		die(_("unable to write new index file"));

> diff --git a/cache.h b/cache.h
> index ae4c45d379..2ec12c4477 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1551,8 +1552,11 @@ struct checkout {
>  };
>  #define CHECKOUT_INIT { NULL, "" }
>  
> +
>  #define TEMPORARY_FILENAME_LENGTH 25

You probably do not need that new blank line.

>  extern int checkout_entry(struct cache_entry *ce, const struct checkout *state, char *topath);
> +extern void enable_delayed_checkout(struct checkout *state);
> +extern int finish_delayed_checkout(struct checkout *state);

OK.

> diff --git a/convert.c b/convert.c
> index e55c034d86..6452ab546a 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -533,7 +534,8 @@ static int start_multi_file_filter_fn(struct subprocess_entry *subprocess)
>  	if (err)
>  		goto done;
>  
> -	err = packet_writel(process->in, "capability=clean", "capability=smudge", NULL);
> +	err = packet_writel(process->in,
> +		"capability=clean", "capability=smudge", "capability=delay", NULL);
>  
>  	for (;;) {
>  		cap_buf = packet_read_line(process->out, NULL);
> @@ -549,6 +551,8 @@ static int start_multi_file_filter_fn(struct subprocess_entry *subprocess)
>  			entry->supported_capabilities |= CAP_CLEAN;
>  		} else if (!strcmp(cap_name, "smudge")) {
>  			entry->supported_capabilities |= CAP_SMUDGE;
> +		} else if (!strcmp(cap_name, "delay")) {
> +			entry->supported_capabilities |= CAP_DELAY;
>  		} else {
>  			warning(
>  				"external filter '%s' requested unsupported filter capability '%s'",

The above makes me wonder if we want to introduce a table, e.g.

	static const struct {
		const *name;
		unsigned cap;
	} known_caps[] = {
		{ "clean", CAP_CLEAN },
		{ "smudge", CAP_SMUDGE },
		{ "delay", CAP_DELAY },
	};

and drive everything (i.e. capability announcement in hunk +534,8
and parsing of request in hunk +551,8) off of it.

That would be overkill for two capabilities, but adding another to
make it three is when such a refactoring starts to become plausible.

> @@ -590,9 +594,11 @@ static void handle_filter_error(const struct strbuf *filter_status,
>  
>  static int apply_multi_file_filter(const char *path, const char *src, size_t len,
>  				   int fd, struct strbuf *dst, const char *cmd,
> -				   const unsigned int wanted_capability)
> +				   const unsigned int wanted_capability,
> +				   struct delayed_checkout *dco)
>  {
>  	int err;
> +	int can_delay = 0;
>  	struct cmd2process *entry;
>  	struct child_process *process;
>  	struct strbuf nbuf = STRBUF_INIT;
> @@ -647,6 +653,14 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
>  	if (err)
>  		goto done;
>  
> +	if ((entry->supported_capabilities & CAP_DELAY) &&
> +	    dco && dco->state == CE_CAN_DELAY) {
> +		can_delay = 1;
> +		err = packet_write_fmt_gently(process->in, "can-delay=1\n");
> +		if (err)
> +			goto done;
> +	}
> +
>  	err = packet_flush_gently(process->in);
>  	if (err)
>  		goto done;
> @@ -662,14 +676,74 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
>  	if (err)
>  		goto done;
>  
> -	err = strcmp(filter_status.buf, "success");
> +	if (can_delay && !strcmp(filter_status.buf, "delayed")) {
> +		dco->state = CE_DELAYED;
> +		string_list_insert(&dco->filters, cmd);
> +		string_list_insert(&dco->paths, path);

The dco->state CE_CAN_DELAY is global to all the paths involved in
this checkout, but filter_status.buf being "delayed" is per path
(i.e. the filter can be told "can-delay=1" but still respond with
success right away), and in such a case dco->state will not advance
from CE_CAN_DELAY to CE_DELAYED (which in turn means we will show
"can-delay=1" to the next path).  On the other hand, once we are
responded by "delayed" after sending "can-delay=1", we will go into
CE_DELAYED state and will not say "can-delay=1" to any subsequent
path.

This feels somewhat unsatisfactory.  From the protocol exchange
description in the documentation part of this patch, I was sort of
expecting that Git can selectively say "You can delay response to
this path" and "I am willing to wait until you give the filtered
result" for each command/pathname pair.  But this code structure
does not seem to allow that.

I would understand it if CE_CAN_DELAY and CE_DELAYED are unified,
and the assignment to dco->state here is removed.  You may be using
these two states in other parts of the code to optimize between the
case where *no* delayed path exists (even if Git is capable of
delaying) and *some* delayed path exist, but I think that can be
done by checking if dco->paths is empty, or something like that.

Such a change will allow us later to add more logic (perhaps driven
by attributes) to the decision to send "can-delay=1" in hunk +653,14
above, to express "this won't be delayed".

Alternatively, the semantics of "the entire checkout exchange is
allowed to be delayed" can be kept but then the protocol looks too
confusing---it shouldn't have "can-delay=1" after a command/pathname
pair, as if it can be specified per path.

> +	} else {
> +		/* The filter got the blob and wants to send us a response. */
> +		err = strcmp(filter_status.buf, "success");
> +		if (err)
> +			goto done;
> +
> +		err = read_packetized_to_strbuf(process->out, &nbuf) < 0;
> +		if (err)
> +			goto done;
> +
> +		err = subprocess_read_status(process->out, &filter_status);
> +		if (err)
> +			goto done;
> +
> +		err = strcmp(filter_status.buf, "success");
> +	}
> +
> +done:
> +	sigchain_pop(SIGPIPE);
> +
> +	if (err)
> +		handle_filter_error(&filter_status, entry, wanted_capability);
> +	else
> +		strbuf_swap(dst, &nbuf);
> +	strbuf_release(&nbuf);
> +	return !err;
> +}

OK.

> +int async_query_available_blobs(const char *cmd, struct string_list *delayed_paths)
> +{
> +	int err;
> +	char *line;
> +	struct cmd2process *entry;
> +	struct child_process *process;
> +	struct strbuf filter_status = STRBUF_INIT;
> +
> +	assert(subprocess_map_initialized);
> +	entry = (struct cmd2process *)subprocess_find_entry(&subprocess_map, cmd);
> +	if (!entry) {
> +		error("external filter '%s' is not available anymore although "
> +		      "not all paths have been filtered", cmd);
> +		return 0;
> +	}
> +	process = &entry->subprocess.process;
> +	sigchain_push(SIGPIPE, SIG_IGN);
> +
> +	err = packet_write_fmt_gently(
> +		process->in, "command=list_available_blobs\n");
>  	if (err)
>  		goto done;
>  
> -	err = read_packetized_to_strbuf(process->out, &nbuf) < 0;
> +	err = packet_flush_gently(process->in);
>  	if (err)
>  		goto done;
>  
> +	while ((line = packet_read_line(process->out, NULL))) {
> +		const char *path;
> +		if (skip_prefix(line, "pathname=", &path))
> +			string_list_insert(delayed_paths, xstrdup(path));

I am assuming that the caller passes an empty string list to
delayed_paths variable (shouldn't it be called available_paths, or
ready_paths if we follow the earlier discussion above, by the way?),
and it will compare the resulting set with the set of paths that got
"delayed" response in the apply_multi_file_filter() function earlier.

I am wondering whose responsibility it will be to deal with a path
"list-available" reports that are *not* asked by Git or Git got no
"delayed" response.  The list subtraction done by the caller is
probably the logical place to do so.

> diff --git a/entry.c b/entry.c
> index d6b263f78e..c6d5cc01dc 100644
> --- a/entry.c
> +++ b/entry.c
> @@ -137,6 +137,85 @@ static int streaming_write_entry(const struct cache_entry *ce, char *path,
> ...
> +static int remove_available_paths(struct string_list_item *item, void *cb_data)
> +{
> +	struct string_list *available_paths = cb_data;
> +	return !string_list_has_string(available_paths, item->string);
> +}
> +
> +int finish_delayed_checkout(struct checkout *state)
> +{
> +	int errs = 0;
> +	struct string_list_item *filter, *path;
> +	struct delayed_checkout *dco = state->delayed_checkout;
> +
> +	if (!state->delayed_checkout)
> +		return errs;
> +
> +	dco->state = CE_RETRY;
> +	while (dco->filters.nr > 0) {
> +		for_each_string_list_item(filter, &dco->filters) {
> +			struct string_list available_paths;
> +			string_list_init(&available_paths, 0);

STRING_LIST_INIT_NODUP?

> +
> +			if (!async_query_available_blobs(filter->string, &available_paths)) {
> +				/* Filter reported an error */
> +				errs = 1;
> +				filter->string = "";
> +				continue;
> +			}
> +			if (available_paths.nr <= 0) {
> +				/* Filter responded with no entries. That means
> +				   the filter is done and we can remove the
> +				   filter from the list (see
> +				   "string_list_remove_empty_items" call below).
> +				*/

	/*
         * Our multi-line comments
	 * look like this.
	 */

> +				filter->string = "";
> +				continue;
> +			}
> +
> +			/* In dco->paths we store a list of all delayed paths.
> +			   The filter just send us a list of available paths.
> +			   Remove them from the list.
> +			*/
> +			filter_string_list(&dco->paths, 0,
> +				&remove_available_paths, &available_paths);

We first remove from the outstanding request list (dco->paths) what
are now ready...

> +			for_each_string_list_item(path, &available_paths) {

...and go over those paths that are now ready.

> +				struct cache_entry* ce = index_file_exists(
> +					state->istate, path->string,
> +					strlen(path->string), 0);
> +				assert(dco->state == CE_RETRY);
> +				errs |= (ce ? checkout_entry(ce, state, NULL) : 1);
> +			}

But we never checked if the contents of this available_paths list is
a subset of the set of paths we originally asked the external
process to filter.  This will allow the process to overwrite any
random path that is not even involved in the checkout.

> +		}
> +		string_list_remove_empty_items(&dco->filters, 0);
> +	}
> +	string_list_clear(&dco->filters, 0);
> +
> +	/* At this point we should not have any delayed paths anymore. */
> +	errs |= dco->paths.nr;
> +	for_each_string_list_item(path, &dco->paths) {
> +		warning(_("%s was not filtered properly."), path->string);
> +	}
> +	string_list_clear(&dco->paths, 0);

And "list-available" that says "path X is ready" when we never asked
for X gets away free without detected as a bug, either.
