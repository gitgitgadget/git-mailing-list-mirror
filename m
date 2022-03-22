Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922DAC433F5
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 18:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240725AbiCVSfu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 14:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239061AbiCVSfs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 14:35:48 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB87313CDC
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:34:19 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id o10so19382629ejd.1
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=Ut1T/FhF9SF6sp6AEjYQxpULE2xmZgkAkfqGFYRxijU=;
        b=YWiqXibWzWtIzXLCmfAbtzAjZDKj6nI11OqUR1L/PvolT/FYC4eJERhJ9w98ExGi86
         h8CEH9y/KogsglFXJM3nqGW7t3g6NP9QeqphuUjx3ekw+vl53DzMEvRtDVkPOGQ8RfDH
         YNOmn6WLjLgVtc887DXgT+f/ax6Yrn5w6nyrdhtbPBdTg0ZgL5ig2w/IOQrZzefKGHR1
         mcPn0Ev1dqUPQIlSjNqEUAjodj/YxWI/rHsCdT4p6kf14cSgXealGcG94R1i1UTRkttt
         ZcfcAlzOVT2JSAgRBdzamUtkth+k2FeLc+Q8t5VvRIfTjb/6aOU5OeklaL8fQCVnqfTD
         uskQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=Ut1T/FhF9SF6sp6AEjYQxpULE2xmZgkAkfqGFYRxijU=;
        b=gqMcUh7JbhZQn6hJM7Fzt6QoSFjpt+f2M4oJ5U7qbWmHardiD6wLEAuIsDN6zjF9xO
         hQb3a5iP2NFosRq/fVErgP6JiaUq7/3Fv2S6ZhEK1EMZm5o92OR3B2nDZsIWaoBfeNDE
         d8dvBSs/BoR8pUJoy0QaIaghDGUt/Od33k/F8Cn9j39DriR9XN9kc8CI4OTwoRWNzF7o
         pDQyvkzC3EBIPLXIjICWrI958dCwLq5Ta0uuL/NNh2ujKe+In2uN1zkCMayOFnbzJBGR
         wxAnnk3h56n/HvYyChZlX79PTSODN9Nv9AAYdUq6feTRZQgqCVoAAUzxXB/1pk/K3H3H
         atqA==
X-Gm-Message-State: AOAM533rv5agHRGKnzd88oKg5bZv6T0OPDhXJ5e8VKPWgI0yD5/4XT63
        KSHD9CpUwVfulkHNMXqBa/vS5kDkyTvIZg==
X-Google-Smtp-Source: ABdhPJw49EKH4MAMcXrBtWnf9sQiiYED6ire+PLEi3M1KNwx+I/9K7KXsEWxvyppWOGWElFmbcHSxQ==
X-Received: by 2002:a17:906:58d2:b0:6da:b635:fbf3 with SMTP id e18-20020a17090658d200b006dab635fbf3mr26719894ejs.40.1647974057917;
        Tue, 22 Mar 2022 11:34:17 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id hs12-20020a1709073e8c00b006dfd8074d27sm4610064ejc.79.2022.03.22.11.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 11:34:17 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nWjKi-000C6m-Ps;
        Tue, 22 Mar 2022 19:34:16 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tao Klerks <tao@klerks.biz>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v7 18/29] fsmonitor--daemon: implement handle_client
 callback
Date:   Tue, 22 Mar 2022 19:30:35 +0100
References: <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
 <pull.1041.v7.git.1647972010.gitgitgadget@gmail.com>
 <1f4b5209bf6092dc389db4046e0bdedc61cc4581.1647972010.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.10
In-reply-to: <1f4b5209bf6092dc389db4046e0bdedc61cc4581.1647972010.git.gitgitgadget@gmail.com>
Message-ID: <220322.86ee2tq1jr.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 22 2022, Jeff Hostetler via GitGitGadget wrote:

> From: Jeff Hostetler <jeffhost@microsoft.com>
> [...]
> +static int do_handle_client(struct fsmonitor_daemon_state *state,
> +			    const char *command,
> +			    ipc_server_reply_cb *reply,
> +			    struct ipc_server_reply_data *reply_data)
> +{
> +	struct fsmonitor_token_data *token_data = NULL;
> +	struct strbuf response_token = STRBUF_INIT;
> +	struct strbuf requested_token_id = STRBUF_INIT;
> +	struct strbuf payload = STRBUF_INIT;
> +	uint64_t requested_oldest_seq_nr = 0;
> +	uint64_t total_response_len = 0;
> +	const char *p;
> +	const struct fsmonitor_batch *batch_head;
> +	const struct fsmonitor_batch *batch;
> +	intmax_t count = 0, duplicates = 0;
> +	kh_str_t *shown;
> +	int hash_ret;
> +	int do_trivial = 0;
> +	int do_flush = 0;

Just noticed while skimming, isn't initializing do_trivial here (didn't
exhaustively check the others) getting in the way of uninitialized
analysis the compiler will do...

> +
> +	/*
> +	 * We expect `command` to be of the form:
> +	 *
> +	 * <command> := quit NUL
> +	 *            | flush NUL
> +	 *            | <V1-time-since-epoch-ns> NUL
> +	 *            | <V2-opaque-fsmonitor-token> NUL
> +	 */
> +
> +	if (!strcmp(command, "quit")) {
> +		/*
> +		 * A client has requested over the socket/pipe that the
> +		 * daemon shutdown.
> +		 *
> +		 * Tell the IPC thread pool to shutdown (which completes
> +		 * the await in the main thread (which can stop the
> +		 * fsmonitor listener thread)).
> +		 *
> +		 * There is no reply to the client.
> +		 */
> +		return SIMPLE_IPC_QUIT;
> +
> +	} else if (!strcmp(command, "flush")) {
> +		/*
> +		 * Flush all of our cached data and generate a new token
> +		 * just like if we lost sync with the filesystem.
> +		 *
> +		 * Then send a trivial response using the new token.
> +		 */
> +		do_flush = 1;
> +		do_trivial = 1;
> +
> +	} else if (!skip_prefix(command, "builtin:", &p)) {
> +		/* assume V1 timestamp or garbage */
> +
> +		char *p_end;
> +
> +		strtoumax(command, &p_end, 10);
> +		trace_printf_key(&trace_fsmonitor,
> +				 ((*p_end) ?
> +				  "fsmonitor: invalid command line '%s'" :
> +				  "fsmonitor: unsupported V1 protocol '%s'"),
> +				 command);
> +		do_trivial = 1;
> +
> +	} else {
> +		/* We have "builtin:*" */
> +		if (fsmonitor_parse_client_token(command, &requested_token_id,
> +						 &requested_oldest_seq_nr)) {
> +			trace_printf_key(&trace_fsmonitor,
> +					 "fsmonitor: invalid V2 protocol token '%s'",
> +					 command);
> +			do_trivial = 1;
> +
> +		} else {
> +			/*
> +			 * We have a V2 valid token:
> +			 *     "builtin:<token_id>:<seq_nr>"
> +			 */
> +		}
> +	}

Since we'll set it here in all branches except the "else" branch,
i.e. if you move this to "we have a v2 valid" we'll catch future bugs if
we ever have it uninitialized still, 

> +
> +	pthread_mutex_lock(&state->main_lock);
> +
> +	if (!state->current_token_data)
> +		BUG("fsmonitor state does not have a current token");
> +
> +	if (do_flush)
> +		with_lock__do_force_resync(state);
> +
> +	/*
> +	 * We mark the current head of the batch list as "pinned" so
> +	 * that the listener thread will treat this item as read-only
> +	 * (and prevent any more paths from being added to it) from
> +	 * now on.
> +	 */
> +	token_data = state->current_token_data;
> +	batch_head = token_data->batch_head;
> +	((struct fsmonitor_batch *)batch_head)->pinned_time = time(NULL);
> +
> +	/*
> +	 * FSMonitor Protocol V2 requires that we send a response header
> +	 * with a "new current token" and then all of the paths that changed
> +	 * since the "requested token".  We send the seq_nr of the just-pinned
> +	 * head batch so that future requests from a client will be relative
> +	 * to it.
> +	 */
> +	with_lock__format_response_token(&response_token,
> +					 &token_data->token_id, batch_head);
> +
> +	reply(reply_data, response_token.buf, response_token.len + 1);
> +	total_response_len += response_token.len + 1;
> +
> +	trace2_data_string("fsmonitor", the_repository, "response/token",
> +			   response_token.buf);
> +	trace_printf_key(&trace_fsmonitor, "response token: %s",
> +			 response_token.buf);
> +
> +	if (!do_trivial) {

I.e. this would start warning.

> +		if (strcmp(requested_token_id.buf, token_data->token_id.buf)) {
> +			/*
> +			 * The client last spoke to a different daemon
> +			 * instance -OR- the daemon had to resync with
> +			 * the filesystem (and lost events), so reject.
> +			 */
> +			trace2_data_string("fsmonitor", the_repository,
> +					   "response/token", "different");
> +			do_trivial = 1;
> +
> +		} else if (requested_oldest_seq_nr <
> +			   token_data->batch_tail->batch_seq_nr) {
> +			/*
> +			 * The client wants older events than we have for
> +			 * this token_id.  This means that the end of our
> +			 * batch list was truncated and we cannot give the
> +			 * client a complete snapshot relative to their
> +			 * request.
> +			 */
> +			trace_printf_key(&trace_fsmonitor,
> +					 "client requested truncated data");
> +			do_trivial = 1;
> +		}
> +	}
> +
> +	if (do_trivial) {
> +		pthread_mutex_unlock(&state->main_lock);
> +
> +		reply(reply_data, "/", 2);
> +
> +		trace2_data_intmax("fsmonitor", the_repository,
> +				   "response/trivial", 1);
> +
> +		strbuf_release(&response_token);
> +		strbuf_release(&requested_token_id);
> +		return 0;

Nit: instead of strbuf_release() here, just a 'goto cleanup' and ...

> +	}
> +
> +	/*
> +	 * We're going to hold onto a pointer to the current
> +	 * token-data while we walk the list of batches of files.
> +	 * During this time, we will NOT be under the lock.
> +	 * So we ref-count it.
> +	 *
> +	 * This allows the listener thread to continue prepending
> +	 * new batches of items to the token-data (which we'll ignore).
> +	 *
> +	 * AND it allows the listener thread to do a token-reset
> +	 * (and install a new `current_token_data`).
> +	 */
> +	token_data->client_ref_count++;
> +
> +	pthread_mutex_unlock(&state->main_lock);
> +
> +	/*
> +	 * The client request is relative to the token that they sent,
> +	 * so walk the batch list backwards from the current head back
> +	 * to the batch (sequence number) they named.
> +	 *
> +	 * We use khash to de-dup the list of pathnames.
> +	 *
> +	 * NEEDSWORK: each batch contains a list of interned strings,
> +	 * so we only need to do pointer comparisons here to build the
> +	 * hash table.  Currently, we're still comparing the string
> +	 * values.
> +	 */
> +	shown = kh_init_str();
> +	for (batch = batch_head;
> +	     batch && batch->batch_seq_nr > requested_oldest_seq_nr;
> +	     batch = batch->next) {
> +		size_t k;
> +
> +		for (k = 0; k < batch->nr; k++) {
> +			const char *s = batch->interned_paths[k];
> +			size_t s_len;
> +
> +			if (kh_get_str(shown, s) != kh_end(shown))
> +				duplicates++;
> +			else {
> +				kh_put_str(shown, s, &hash_ret);
> +
> +				trace_printf_key(&trace_fsmonitor,
> +						 "send[%"PRIuMAX"]: %s",
> +						 count, s);
> +
> +				/* Each path gets written with a trailing NUL */
> +				s_len = strlen(s) + 1;
> +
> +				if (payload.len + s_len >=
> +				    LARGE_PACKET_DATA_MAX) {
> +					reply(reply_data, payload.buf,
> +					      payload.len);
> +					total_response_len += payload.len;
> +					strbuf_reset(&payload);
> +				}
> +
> +				strbuf_add(&payload, s, s_len);
> +				count++;
> +			}
> +		}
> +	}
> +
> +	if (payload.len) {
> +		reply(reply_data, payload.buf, payload.len);
> +		total_response_len += payload.len;
> +	}
> +
> +	kh_release_str(shown);
> +
> +	pthread_mutex_lock(&state->main_lock);
> +
> +	if (token_data->client_ref_count > 0)
> +		token_data->client_ref_count--;
> +
> +	if (token_data->client_ref_count == 0) {
> +		if (token_data != state->current_token_data) {
> +			/*
> +			 * The listener thread did a token-reset while we were
> +			 * walking the batch list.  Therefore, this token is
> +			 * stale and can be discarded completely.  If we are
> +			 * the last reader thread using this token, we own
> +			 * that work.
> +			 */
> +			fsmonitor_free_token_data(token_data);
> +		}
> +	}
> +
> +	pthread_mutex_unlock(&state->main_lock);
> +
> +	trace2_data_intmax("fsmonitor", the_repository, "response/length", total_response_len);
> +	trace2_data_intmax("fsmonitor", the_repository, "response/count/files", count);
> +	trace2_data_intmax("fsmonitor", the_repository, "response/count/duplicates", duplicates);
> +

add a "cleanup" label here?

> +	strbuf_release(&response_token);
> +	strbuf_release(&requested_token_id);
> +	strbuf_release(&payload);
> +
> +	return 0;
> +}
> +
>  static ipc_server_application_cb handle_client;
