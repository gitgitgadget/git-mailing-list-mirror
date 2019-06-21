Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 380F81F461
	for <e@80x24.org>; Fri, 21 Jun 2019 16:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbfFUQdy (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 12:33:54 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64007 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfFUQdy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 12:33:54 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0EECE69216;
        Fri, 21 Jun 2019 12:33:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+Rb7AYfEqCgKH6SHR7oxBjxcT/k=; b=c2FU4D
        bSHDutDC1dC/eQmZ+KGS4wgq94k5+uYon+FmJoqs9ZoC9BTN2PnlPl1v8qm6ElqE
        wdzytNMbr4e1frsGqPsg3oKSTjVq4xuVUpzrrX5AAbByBDcETy8C+DSOlIrIh7s7
        zHTmCorp89B8AwMLPRZFOdmFAHCJgs3wtPZ+I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EQOycupdMNiO6gmwC7S+A5CBnQEGu7xF
        Y/ulL6TMj6y90XnCigm4s3c09qElPAUK9PM/vswfuN+eKrNA2Ns9EfYRAMB55+WJ
        vzNnY9CfpZDA1BlEVhSdUJGco3iSJH9gTxviuBoKU6iUn1Sg87M5VbhkforZv5ku
        LA3WyFuDVUo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0603269215;
        Fri, 21 Jun 2019 12:33:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 31D9269214;
        Fri, 21 Jun 2019 12:33:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.pobox.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 1/3] status: add status.aheadbehind setting
References: <pull.272.git.gitgitgadget@gmail.com>
        <2f0f2a2df9410947b985d83a924d2549d62bb65f.1560889284.git.gitgitgadget@gmail.com>
Date:   Fri, 21 Jun 2019 09:33:47 -0700
In-Reply-To: <2f0f2a2df9410947b985d83a924d2549d62bb65f.1560889284.git.gitgitgadget@gmail.com>
        (Jeff Hostetler via GitGitGadget's message of "Tue, 18 Jun 2019
        13:21:25 -0700 (PDT)")
Message-ID: <xmqqzhmakidw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 58ECDC4E-9442-11E9-AF4C-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> The --[no-]ahead-behind option was introduced in fd9b544a
> (status: add --[no-]ahead-behind to status and commit for V2
> format, 2018-01-09). This is a necessary change of behavior
> in repos where the remote tracking branches can move very
> quickly ahead of the local branches. However, users need to
> remember to provide the command-line argument every time.
>
> Add a new "status.aheadBehind" config setting to change the
> default behavior of all git status formats.
>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/config/status.txt |  5 +++++
>  builtin/commit.c                | 17 ++++++++++++++++-
>  t/t6040-tracking-info.sh        | 31 +++++++++++++++++++++++++++++++
>  t/t7064-wtstatus-pv2.sh         |  4 ++++
>  4 files changed, 56 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/config/status.txt b/Documentation/config/status.txt
> index ed72fa7dae..0fc704ab80 100644
> --- a/Documentation/config/status.txt
> +++ b/Documentation/config/status.txt
> @@ -12,6 +12,11 @@ status.branch::
>  	Set to true to enable --branch by default in linkgit:git-status[1].
>  	The option --no-branch takes precedence over this variable.
>  
> +status.aheadBehind::
> +	Set to true to enable `--ahead-behind` and false to enable
> +	`--no-ahead-behind` by default in linkgit:git-status[1] for
> +	non-porcelain status formats.  Defaults to true.

Sensible.

> @@ -1078,9 +1078,11 @@ static const char *read_commit_message(const char *name)
>  static struct status_deferred_config {
>  	enum wt_status_format status_format;
>  	int show_branch;
> +	enum ahead_behind_flags ahead_behind;
>  } status_deferred_config = {
>  	STATUS_FORMAT_UNSPECIFIED,
> -	-1 /* unspecified */
> +	-1, /* unspecified */
> +	AHEAD_BEHIND_UNSPECIFIED,

This obviously is not a problem introduced by this patch, but is
there a plan to extend this beyond a boolean?

Otherwise, a separate enum is way overkill.  Naming the field so
that it is clear it is either true or false (e.g.  perhaps call it
"ahead_behind_detailed" as the current "QUICK" is merely "are they
equal?" which corresponds to "false", and "FULL" is to show the
detailed info), and then use the usual "-1 is unspecified, 0 and 1
are usual bools" convention would be more appropriate.

