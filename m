Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC768C433DB
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 22:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9009A64F0F
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 22:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbhCOWfO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 18:35:14 -0400
Received: from mout.web.de ([217.72.192.78]:56173 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233176AbhCOWfM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 18:35:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1615847704;
        bh=GL4l5iTIq99SabsgRjxWT2s9yya34g0pnnc1cXjRRpo=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=aMR83/T/hopGRSDLZihDSOkZxQaUdNWzQGpmdywYGNo71L4alRtay7Vy4kmydxK0g
         xbyW/86Sw4xr6rlGgC8lrHyM6XTVsZczuYhWS2U7v4z3FESE85J1dBzwm/G1mBiaKi
         CoN7MdP7adH1edEGFVLnmY5MCtS4bVdFH+bQ6/vc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.24.70]) by smtp.web.de
 (mrweb105 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1M2gkf-1lHovv2UNL-003r8w; Mon, 15 Mar 2021 23:35:04 +0100
Subject: Re: [PATCH 2/2] use CALLOC_ARRAY
To:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Garima Singh <garima.singh@microsoft.com>
Cc:     Git List <git@vger.kernel.org>
References: <b417c7cc-8e40-04df-0314-d4c3fab278b7@web.de>
 <b2942f67-f0c0-872b-9b8c-11b6ea295412@web.de> <xmqq35ww1amf.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe=2e?= <l.s.r@web.de>
Message-ID: <48772615-4b68-724f-dae6-4153aafbde35@web.de>
Date:   Mon, 15 Mar 2021 23:35:03 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <xmqq35ww1amf.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZbaHmUsl15U1dVHo+b2R83uG7IFd11cXQZU/+l/Lg6vLAIs19iC
 chLRqBuKCSub6Yn64scTVZV4+zbKL1gfPeNLGdxY3u+X8/KYjuAtmQ/bmKvAxnmY/sYHdal
 kncPni3T7+LXENI577JTHVQV2rG8kRKR/MiSP5akWTTumqFUlirDCfAmM/zjC6bMocF+siH
 0pvk3IRC3/Im7rfhFYeNQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ih7Row8LOfE=:zc6u2FrJ744uYFYQ7R1/GP
 qCY5gqJr06v1paVSdkO0nflrvxs9Bl2VKW4TuAucAJ/xeU25Gtib9JIgg7CK50MH1wYPi/voN
 CWWCjHmvseh6bXgL6aFMLhgjaQoLbsfP8cI9Eh0qvFIRgn1w9EJFjwBVuE0Dnd19/26I13lgL
 wZVtsMufYkHAwdGOOEAFzN0sHlKFnTn22lauDHtzXJMDOAuCcwb1Z/0Ll9NsXeScl5sG56uq1
 se4TCnAgiq6NDVmMelye/jcRzAvrKM48gmdVqUKH7E0RY0LgElcP1cg5a8hKY6wPWfdpGrc2W
 DWe71zbvwByBv/F9AaGcrdiMHxrBV37rwjmohIuQsbOUydPDhHDASUyGb/CbjJsyds6sRUU0H
 dlbwRz/ECPth2/pO4pkFa0mo4wS+A7oOGb7mPlNe24cBGoFR60S5z4y3TwccQc5oh7TwLGWQ1
 QomGgjCfWmtV+r95wSCl13hL/pb9TOqNFbZLhGdkMD6AXLvglY9YR9hvYO9uVFkoz9hZGkISv
 EDN8EceMudtt/X7QCM/Ac/mUExUwQ0RRQ6KrFv3SYhKZw0MML+PcOq5/SJpPl6SaI6M8rTESy
 Wv2BVdp1aRlH0AySHrPZ/RYEZQHy0LOWpnkRWiAl/d/nMWtjWiM2yHC6PlZBgAHLzdMJIBGOT
 v1ZQ5qwhrAAkKPH68lWl7opZd/duMNoUFWq6zl1QGzwPHIEtfUOnyFft0SZfCHCjclTgYABSm
 R4v3EjxsuawJgqY9KKTPdlTh5KJUZQgmijDaQH0hV022m1WTk5YnrZg04Zz47/3qcFy5gdbS0
 RCrRQ/nn7pk1J7QI/cGnO32fEuFOuYf2905hzuKe9fUT65D+A/DjtQ3yrcDzOF0TuK3ozdQRr
 mqXUvrG3Qa+aSULDAWJQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.03.21 um 20:26 schrieb Junio C Hamano:
> https://github.com/git/git/runs/2114848725?check_suite_focus=3Dtrue
> tells us that we want to be using CALLOC_ARRAY() instead of
> xcalloc() at these places.
>
> Quite a many are single-element allocations that want NUL-filled
> piece of memory.  We may want to resurrect the "one-element calloc
> is exempt" thing (in other words, xcalloc(1, size_of_one_element) is
> perfectly fine, even though xcalloc(size_of_one_element, 1) must
> swap the order of arguments).

Leaving the idiomatic use of xcalloc for allocating a single cleared
object alone can make sense.  CALLOC_ARRAY with a single element
might become idiomatic over time as well, though, but with "C" (for
continuous) and "ARRAY" having two name parts screaming for multiple
elements might be a bit much.

> But some are true multi-element allocations that we may want to fix
> in each topic in flight.
>
> compat/simple-ipc/ipc-unix-socket.c::836
>     1e7cdcb6 (simple-ipc: add Unix domain socket implementation, 2021-03=
-09)
>
> merge-strategies.c::498
>     72a74644 (merge-octopus: rewrite in C, 2020-11-24)
>
> t/helper/test-bloom.c::72
>     f1294eaf (bloom.c: introduce core Bloom filter constructs, 2020-03-3=
0)
>
>
> Also there are a few multi-element allocations that are old, which
> weren't somehow caught by the patch I am responding to.

When I run coccicheck agains seen it still misses the following
conversions:

 builtin/checkout.c                  |    2 +-
 builtin/log.c                       |    4 ++--
 builtin/receive-pack.c              |   10 ++++------
 t/helper/test-bloom.c               |    2 +-

That's with spatch built from the latest Coccinelle source as of March
2nd.  Strange.

>
> builtin/receive-pack.c::2351
>     0a1bc12b (receive-pack: allow pushes that update .git/shallow, 2013-=
12-05)
>
> ----- >8 ---------- >8 ---------- >8 ---------- >8 ---------- >8 -----
>
> GIT_VERSION =3D 2.31.0.rc2.390.g46dd778bfd
>     SPATCH contrib/coccinelle/hashmap.cocci
>     SPATCH contrib/coccinelle/commit.cocci
>     SPATCH contrib/coccinelle/xcalloc.cocci
>     SPATCH contrib/coccinelle/preincr.cocci
>     SPATCH contrib/coccinelle/free.cocci
>     SPATCH contrib/coccinelle/qsort.cocci
>     SPATCH contrib/coccinelle/object_id.cocci
>     SPATCH contrib/coccinelle/xstrdup_or_null.cocci
>     SPATCH contrib/coccinelle/swap.cocci
>     SPATCH contrib/coccinelle/strbuf.cocci
>     SPATCH contrib/coccinelle/flex_alloc.cocci
>     SPATCH contrib/coccinelle/array.cocci
>      SPATCH result: contrib/coccinelle/array.cocci.patch
> + set +x
> Coccinelle suggests the following changes in 'contrib/coccinelle/array.c=
occi.patch':
> diff -u -p a/builtin/checkout.c b/builtin/checkout.c
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -741,7 +741,7 @@ static int merge_working_tree(const stru
>  				       &new_branch_info->commit->object.oid :
>  				       &new_branch_info->oid, NULL);
>  		if (opts->overwrite_ignore) {
> -			topts.dir =3D xcalloc(1, sizeof(*topts.dir));
> +			CALLOC_ARRAY(topts.dir, 1);
>  			topts.dir->flags |=3D DIR_SHOW_IGNORED;
>  			setup_standard_excludes(topts.dir);
>  		}
> diff -u -p a/builtin/log.c b/builtin/log.c
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -230,7 +230,7 @@ static void cmd_log_init_finish(int argc
>  	}
>
>  	if (mailmap) {
> -		rev->mailmap =3D xcalloc(1, sizeof(struct string_list));
> +		CALLOC_ARRAY(rev->mailmap, 1);
>  		read_mailmap(rev->mailmap);
>  	}
>
> @@ -2141,7 +2141,7 @@ int cmd_format_patch(int argc, const cha
>  	}
>
>  	if (in_reply_to || thread || cover_letter)
> -		rev.ref_message_ids =3D xcalloc(1, sizeof(struct string_list));
> +		CALLOC_ARRAY(rev.ref_message_ids, 1);
>  	if (in_reply_to) {
>  		const char *msgid =3D clean_message_id(in_reply_to);
>  		string_list_append(rev.ref_message_ids, msgid);
> diff -u -p a/builtin/receive-pack.c b/builtin/receive-pack.c
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -1040,7 +1040,7 @@ static int read_proc_receive_report(stru
>  					report =3D hint->report;
>  					while (report->next)
>  						report =3D report->next;
> -					report->next =3D xcalloc(1, sizeof(struct ref_push_report));
> +					CALLOC_ARRAY(report->next, 1);
>  					report =3D report->next;
>  				}
>  				new_report =3D 0;
> @@ -2348,11 +2348,9 @@ static void prepare_shallow_update(struc
>  	ALLOC_ARRAY(si->used_shallow, si->shallow->nr);
>  	assign_shallow_commits_to_refs(si, si->used_shallow, NULL);
>
> -	si->need_reachability_test =3D
> -		xcalloc(si->shallow->nr, sizeof(*si->need_reachability_test));
> -	si->reachable =3D
> -		xcalloc(si->shallow->nr, sizeof(*si->reachable));
> -	si->shallow_ref =3D xcalloc(si->ref->nr, sizeof(*si->shallow_ref));
> +	CALLOC_ARRAY(si->need_reachability_test, si->shallow->nr);
> +	CALLOC_ARRAY(si->reachable, si->shallow->nr);
> +	CALLOC_ARRAY(si->shallow_ref, si->ref->nr);
>
>  	for (i =3D 0; i < si->nr_ours; i++)
>  		si->need_reachability_test[si->ours[i]] =3D 1;
> diff -u -p a/builtin/repack.c b/builtin/repack.c
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -327,7 +327,7 @@ static void init_pack_geometry(struct pa
>  	struct packed_git *p;
>  	struct pack_geometry *geometry;
>
> -	*geometry_p =3D xcalloc(1, sizeof(struct pack_geometry));
> +	CALLOC_ARRAY(*geometry_p, 1);
>  	geometry =3D *geometry_p;
>
>  	for (p =3D get_all_packs(the_repository); p; p =3D p->next) {
> diff -u -p a/compat/simple-ipc/ipc-unix-socket.c b/compat/simple-ipc/ipc=
-unix-socket.c
> --- a/compat/simple-ipc/ipc-unix-socket.c
> +++ b/compat/simple-ipc/ipc-unix-socket.c
> @@ -130,7 +130,7 @@ enum ipc_active_state ipc_client_try_con
>  	trace2_region_leave("ipc-client", "try-connect", NULL);
>
>  	if (state =3D=3D IPC_STATE__LISTENING) {
> -		(*p_connection) =3D xcalloc(1, sizeof(struct ipc_client_connection));
> +		CALLOC_ARRAY((*p_connection), 1);
>  		(*p_connection)->fd =3D fd;
>  	}
>
> @@ -819,7 +819,7 @@ int ipc_server_run_async(struct ipc_serv
>  		return ret;
>  	}
>
> -	server_data =3D xcalloc(1, sizeof(*server_data));
> +	CALLOC_ARRAY(server_data, 1);
>  	server_data->magic =3D MAGIC_SERVER_DATA;
>  	server_data->application_cb =3D application_cb;
>  	server_data->application_data =3D application_data;
> @@ -833,11 +833,9 @@ int ipc_server_run_async(struct ipc_serv
>  	pthread_cond_init(&server_data->work_available_cond, NULL);
>
>  	server_data->queue_size =3D nr_threads * FIFO_SCALE;
> -	server_data->fifo_fds =3D xcalloc(server_data->queue_size,
> -					sizeof(*server_data->fifo_fds));
> +	CALLOC_ARRAY(server_data->fifo_fds, server_data->queue_size);
>
> -	server_data->accept_thread =3D
> -		xcalloc(1, sizeof(*server_data->accept_thread));
> +	CALLOC_ARRAY(server_data->accept_thread, 1);
>  	server_data->accept_thread->magic =3D MAGIC_ACCEPT_THREAD_DATA;
>  	server_data->accept_thread->server_data =3D server_data;
>  	server_data->accept_thread->server_socket =3D server_socket;
> @@ -851,7 +849,7 @@ int ipc_server_run_async(struct ipc_serv
>  	for (k =3D 0; k < nr_threads; k++) {
>  		struct ipc_worker_thread_data *wtd;
>
> -		wtd =3D xcalloc(1, sizeof(*wtd));
> +		CALLOC_ARRAY(wtd, 1);
>  		wtd->magic =3D MAGIC_WORKER_THREAD_DATA;
>  		wtd->server_data =3D server_data;
>
> diff -u -p a/compat/simple-ipc/ipc-win32.c b/compat/simple-ipc/ipc-win32=
.c
> --- a/compat/simple-ipc/ipc-win32.c
> +++ b/compat/simple-ipc/ipc-win32.c
> @@ -184,7 +184,7 @@ enum ipc_active_state ipc_client_try_con
>  	trace2_region_leave("ipc-client", "try-connect", NULL);
>
>  	if (state =3D=3D IPC_STATE__LISTENING) {
> -		(*p_connection) =3D xcalloc(1, sizeof(struct ipc_client_connection));
> +		CALLOC_ARRAY((*p_connection), 1);
>  		(*p_connection)->fd =3D fd;
>  	}
>
> @@ -625,7 +625,7 @@ int ipc_server_run_async(struct ipc_serv
>  		return -2;
>  	}
>
> -	server_data =3D xcalloc(1, sizeof(*server_data));
> +	CALLOC_ARRAY(server_data, 1);
>  	server_data->magic =3D MAGIC_SERVER_DATA;
>  	server_data->application_cb =3D application_cb;
>  	server_data->application_data =3D application_data;
> @@ -640,7 +640,7 @@ int ipc_server_run_async(struct ipc_serv
>  	for (k =3D 0; k < nr_threads; k++) {
>  		struct ipc_server_thread_data *std;
>
> -		std =3D xcalloc(1, sizeof(*std));
> +		CALLOC_ARRAY(std, 1);
>  		std->magic =3D MAGIC_SERVER_THREAD_DATA;
>  		std->server_data =3D server_data;
>  		std->hPipe =3D INVALID_HANDLE_VALUE;
> diff -u -p a/merge-ort.c b/merge-ort.c
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -3439,7 +3439,7 @@ static void merge_start(struct merge_opt
>  		trace2_region_leave("merge", "allocate/init", opt->repo);
>  		return;
>  	}
> -	opt->priv =3D xcalloc(1, sizeof(*opt->priv));
> +	CALLOC_ARRAY(opt->priv, 1);
>
>  	/* Initialization of various renames fields */
>  	renames =3D &opt->priv->renames;
> diff -u -p a/merge-strategies.c b/merge-strategies.c
> --- a/merge-strategies.c
> +++ b/merge-strategies.c
> @@ -495,8 +495,7 @@ int merge_strategies_octopus(struct repo
>  		return 2;
>  	}
>
> -	reference_commit =3D xcalloc(commit_list_count(remotes) + 1,
> -				   sizeof(struct commit *));
> +	CALLOC_ARRAY(reference_commit, commit_list_count(remotes) + 1);
>  	reference_commit[0] =3D head_commit;
>  	reference_tree =3D head_tree;
>
> diff -u -p a/t/helper/test-bloom.c b/t/helper/test-bloom.c
> --- a/t/helper/test-bloom.c
> +++ b/t/helper/test-bloom.c
> @@ -69,7 +69,7 @@ int cmd__bloom(int argc, const char **ar
>  		struct bloom_filter filter;
>  		int i =3D 2;
>  		filter.len =3D  (settings.bits_per_entry + BITS_PER_WORD - 1) / BITS_=
PER_WORD;
> -		filter.data =3D xcalloc(filter.len, sizeof(unsigned char));
> +		CALLOC_ARRAY(filter.data, filter.len);
>
>  		if (argc - 1 < i)
>  			usage(bloom_usage);
> diff -u -p a/unix-stream-server.c b/unix-stream-server.c
> --- a/unix-stream-server.c
> +++ b/unix-stream-server.c
> @@ -72,7 +72,7 @@ int unix_stream_server__create(
>  		return -1;
>  	}
>
> -	server_socket =3D xcalloc(1, sizeof(*server_socket));
> +	CALLOC_ARRAY(server_socket, 1);
>  	server_socket->path_socket =3D strdup(path);
>  	server_socket->fd_socket =3D fd_socket;
>  	lstat(path, &server_socket->st_socket);
> error: Coccinelle suggested some changes
> Error: Process completed with exit code 1.
>
