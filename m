Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA6AC4332F
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 22:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiJMWCq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 18:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiJMWCo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 18:02:44 -0400
Received: from mail-oo1-xc49.google.com (mail-oo1-xc49.google.com [IPv6:2607:f8b0:4864:20::c49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B0B18BE27
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 15:02:43 -0700 (PDT)
Received: by mail-oo1-xc49.google.com with SMTP id d12-20020a4a918c000000b0047fce9c58bbso1421083ooh.10
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 15:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nk1yJ8DPDYGOExJola6davohyj3DtiDcR0WNe5n1+bE=;
        b=nI6RHYAEyfGlGF8OZ0FoR6Uzzh3zYEFdde15UrVQxD0MRx1NxTswu7Zw7kDQoOJrHE
         LvGwp+AcC4d1XQAR3hRuKqUHH/tMm1vnQ+6gvJCBrikeYOvk/1j/HhbbGT7Y6INKunmX
         YrRPKs2QPKHWRpg3rLaSUtM10GD22yGQnR+R/FWKMvwTEj837D19tTHmrxDIdZyX/6Ae
         oLQUjl+Sg6CkLwVbxre94RASirCVV/iwXv0twpaqnIBIv+KBhXHCIpG7q8XQXS91r5zX
         o3xGO6/jTpMisPaaQFcuLs7+x17BBX0uKzsqChEwuXZsyL5dR+kYScSPDMu1iTOFavZy
         gTGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nk1yJ8DPDYGOExJola6davohyj3DtiDcR0WNe5n1+bE=;
        b=7+aVqe5VIqsRLw8R3fz3hzhE+EZtr2OfZM+6j7EH7OGKQlMWB0ISMGsHdDDoEerDiA
         p10iEQqD0VgeLHiWdpWMTyclpJPAzkGHr7gNSr3RV3UbVAwUD+3zLkeXLG8ncGKUw40e
         zxro6PyP1YZkNmCWm1PhcgVs5jI/+MaZoLd5iWVWOGKnqYVStkJXV8s7oot6x1HTuvJ6
         jck4vbjCpSuEv/c2X/5pDmN4VcclBN14alUpNCt761jXot36lyagteVHZYFhEUuMdDJe
         Lbc5oOVDa1vd1/bzlovuYlqeWzamJ9l1ukKy/La7YxR5kTAdFB87Ko6RfYTCNmIdDS0D
         8uhw==
X-Gm-Message-State: ACrzQf2Y3L+TiaLAA/76YbLUMjBKvxipZP+yZ6xG8RHFCKdS6OjMbifo
        WOserDe3VmAvdUNWy/99A+qmEOuLkupmTQ==
X-Google-Smtp-Source: AMsMyM6ZR6vM7i1Y/5reGVsD893MPN+EJNUqAV61FS1K3QpLzLTmQL8xaXa2eBGohnOKmllwG8HGHqL9FwuRig==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6870:609c:b0:131:c972:818f with SMTP
 id t28-20020a056870609c00b00131c972818fmr1010766oae.2.1665698562814; Thu, 13
 Oct 2022 15:02:42 -0700 (PDT)
Date:   Thu, 13 Oct 2022 15:02:30 -0700
In-Reply-To: <patch-v3-15.15-39a20be0cbb-20221012T205712Z-avarab@gmail.com>
Mime-Version: 1.0
References: <cover-v2-00.22-00000000000-20221012T084850Z-avarab@gmail.com>
 <cover-v3-00.15-00000000000-20221012T205712Z-avarab@gmail.com> <patch-v3-15.15-39a20be0cbb-20221012T205712Z-avarab@gmail.com>
Message-ID: <kl6lsfjrz8jt.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v3 15/15] run-command.c: remove "max_processes", add
 "const" to signal() handler
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason         <avarab@gmail.com> writes:

> In this case we need the number of processes for the kill_children()
> function, which will be called from a signal handler. To do that
> adjust this code added in c553c72eed6 (run-command: add an
> asynchronous parallel child processor, 2015-12-15) so that we use a
> dedicated "struct parallel_processes_for_signal" for passing data to
> the signal handler, in addition to the "struct parallel_process" it'll
> now have access to our "opts" variable.

[...]

> -static void kill_children(const struct parallel_processes *pp, int signo=
)
> +struct parallel_processes_for_signal {
> +	const struct run_process_parallel_opts *opts;
> +	const struct parallel_processes *pp;
> +};

(Treat this feedback as non-blocking)

I find this struct a little odd because it isn't specific to
kill_children_signal(), rather, this seems like we are saying that
"run_process_parallel_opts" and "parallel_processes" belong together.
This also seems confirmed by the fact that at the end of the series, we
pass the opts almost everywhere - only pp_output() takes
"parallel_processes" without "run_process_parallel_opts".

I assume you've already considered this, but I wonder if the code is
simpler if we drop 10-15/15, i.e. use options just for end users
(allowing us to get rid of the *_tr2() variant too, which is great), but
only use "parallel_processes" inside of run-command.c. There's also a
tiny benefit of passing one fewer pointer per function, with the tiny
cost of one-time copying.

Thoughts?

> +
> +static void kill_children(const struct parallel_processes *pp,
> +			  const struct run_process_parallel_opts *opts,
> +			  int signo)
>  {
> -	for (size_t i =3D 0; i < pp->max_processes; i++)
> +	for (size_t i =3D 0; i < opts->processes; i++)
>  		if (pp->children[i].state =3D=3D GIT_CP_WORKING)
>  			kill(pp->children[i].process.pid, signo);
>  }
> =20
> -static struct parallel_processes *pp_for_signal;
> +static void kill_children_signal(const struct parallel_processes_for_sig=
nal *pp_sig,
> +				 int signo)
> +{
> +	kill_children(pp_sig->pp, pp_sig->opts, signo);
> +}
> +
> +static struct parallel_processes_for_signal *pp_for_signal;
> =20
>  static void handle_children_on_signal(int signo)
>  {
> -	kill_children(pp_for_signal, signo);
> +	kill_children_signal(pp_for_signal, signo);
>  	sigchain_pop(signo);
>  	raise(signo);
>  }
> =20
>  static void pp_init(struct parallel_processes *pp,
> -		    const struct run_process_parallel_opts *opts)
> +		    const struct run_process_parallel_opts *opts,
> +		    struct parallel_processes_for_signal *pp_sig)
>  {
>  	const size_t n =3D opts->processes;
> =20
> @@ -1561,7 +1574,9 @@ static void pp_init(struct parallel_processes *pp,
>  		}
>  	}
> =20
> -	pp_for_signal =3D pp;
> +	pp_sig->pp =3D pp;
> +	pp_sig->opts =3D opts;
> +	pp_for_signal =3D pp_sig;
>  	sigchain_push_common(handle_children_on_signal);
>  }
> =20
> @@ -1759,8 +1774,8 @@ void run_processes_parallel(const struct run_proces=
s_parallel_opts *opts)
>  	int i, code;
>  	int output_timeout =3D 100;
>  	int spawn_cap =3D 4;
> +	struct parallel_processes_for_signal pp_sig;
>  	struct parallel_processes pp =3D {
> -		.max_processes =3D opts->processes,
>  		.buffered_output =3D STRBUF_INIT,
>  	};
>  	/* options */
> @@ -1772,7 +1787,7 @@ void run_processes_parallel(const struct run_proces=
s_parallel_opts *opts)
>  		trace2_region_enter_printf(tr2_category, tr2_label, NULL,
>  					   "max:%d", opts->processes);
> =20
> -	pp_init(&pp, opts);
> +	pp_init(&pp, opts, &pp_sig);
>  	while (1) {
>  		for (i =3D 0;
>  		    i < spawn_cap && !pp.shutdown &&
> @@ -1783,7 +1798,7 @@ void run_processes_parallel(const struct run_proces=
s_parallel_opts *opts)
>  				continue;
>  			if (code < 0) {
>  				pp.shutdown =3D 1;
> -				kill_children(&pp, -code);
> +				kill_children(&pp, opts, -code);
>  			}
>  			break;
>  		}
> @@ -1800,7 +1815,7 @@ void run_processes_parallel(const struct run_proces=
s_parallel_opts *opts)
>  		if (code) {
>  			pp.shutdown =3D 1;
>  			if (code < 0)
> -				kill_children(&pp, -code);
> +				kill_children(&pp, opts,-code);
>  		}
>  	}
> =20
> --=20
> 2.38.0.971.ge79ff6d20e7
