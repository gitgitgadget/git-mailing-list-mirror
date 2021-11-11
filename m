Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB55C433F5
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 23:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0B9961268
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 23:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbhKKXGE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Nov 2021 18:06:04 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51157 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbhKKXGD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Nov 2021 18:06:03 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 030CF16592C;
        Thu, 11 Nov 2021 18:03:13 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+lpjY9d6KjURckm1z7/FDo5ZGPmUTGW6bJaeEJ
        foREo=; b=EdJ6Jew/UlVE0spsYoYyehqdvbGmzG78UTaiRTwCj6dPwLMFW+amMz
        6maaqVOC5k1e6yoyKhSlQtPi03kGkDMZ/GgHPIOwm5+RZxXChRjLrda2BYMjuAD1
        GG8hJaqpfkT6+9WzHnHE/JqiTmvGLE/lQkeP2a/NVi29n+XqeMATQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EAA6E16592B;
        Thu, 11 Nov 2021 18:03:13 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 514FA165929;
        Thu, 11 Nov 2021 18:03:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com
Subject: Re: [PATCH] trace2: increment event format version
References: <ebc4d9a6960f0350772c14981ef211876f29d0fa.1636669891.git.steadmon@google.com>
Date:   Thu, 11 Nov 2021 15:03:10 -0800
In-Reply-To: <ebc4d9a6960f0350772c14981ef211876f29d0fa.1636669891.git.steadmon@google.com>
        (Josh Steadmon's message of "Thu, 11 Nov 2021 14:34:25 -0800")
Message-ID: <xmqqh7cijnwx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8AE05E4E-4343-11EC-A663-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> In 64bc752 (trace2: add trace2_child_ready() to report on background
> children, 2021-09-20), we added a new "child_ready" event. In
> Documentation/technical/api-trace2.txt, we promise that adding a new
> event type will result in incrementing the trace2 event format version
> number, but this was not done. Correct this in code & docs.
>
> Signed-off-by: Josh Steadmon <steadmon@google.com>
> ---
>  Documentation/technical/api-trace2.txt | 4 ++--
>  trace2/tr2_tgt_event.c                 | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)

Hmph, it seems to me that this is better done before the release,
or am I mistaken?


>
> diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
> index ef7fe02a8f..bb13ca3db8 100644
> --- a/Documentation/technical/api-trace2.txt
> +++ b/Documentation/technical/api-trace2.txt
> @@ -128,7 +128,7 @@ yields
>  
>  ------------
>  $ cat ~/log.event
> -{"event":"version","sid":"sid":"20190408T191610.507018Z-H9b68c35f-P000059a8","thread":"main","time":"2019-01-16T17:28:42.620713Z","file":"common-main.c","line":38,"evt":"2","exe":"2.20.1.155.g426c96fcdb"}
> +{"event":"version","sid":"sid":"20190408T191610.507018Z-H9b68c35f-P000059a8","thread":"main","time":"2019-01-16T17:28:42.620713Z","file":"common-main.c","line":38,"evt":"3","exe":"2.20.1.155.g426c96fcdb"}
>  {"event":"start","sid":"20190408T191610.507018Z-H9b68c35f-P000059a8","thread":"main","time":"2019-01-16T17:28:42.621027Z","file":"common-main.c","line":39,"t_abs":0.001173,"argv":["git","version"]}
>  {"event":"cmd_name","sid":"20190408T191610.507018Z-H9b68c35f-P000059a8","thread":"main","time":"2019-01-16T17:28:42.621122Z","file":"git.c","line":432,"name":"version","hierarchy":"version"}
>  {"event":"exit","sid":"20190408T191610.507018Z-H9b68c35f-P000059a8","thread":"main","time":"2019-01-16T17:28:42.621236Z","file":"git.c","line":662,"t_abs":0.001227,"code":0}
> @@ -391,7 +391,7 @@ only present on the "start" and "atexit" events.
>  {
>  	"event":"version",
>  	...
> -	"evt":"2",		       # EVENT format version
> +	"evt":"3",		       # EVENT format version
>  	"exe":"2.20.1.155.g426c96fcdb" # git version
>  }
>  ------------
> diff --git a/trace2/tr2_tgt_event.c b/trace2/tr2_tgt_event.c
> index 70cfc2f77c..3a0014417c 100644
> --- a/trace2/tr2_tgt_event.c
> +++ b/trace2/tr2_tgt_event.c
> @@ -20,7 +20,7 @@ static struct tr2_dst tr2dst_event = { TR2_SYSENV_EVENT, 0, 0, 0, 0 };
>   * a new field to an existing event, do not require an increment to the EVENT
>   * format version.
>   */
> -#define TR2_EVENT_VERSION "2"
> +#define TR2_EVENT_VERSION "3"
>  
>  /*
>   * Region nesting limit for messages written to the event target.
>
> base-commit: e9e5ba39a78c8f5057262d49e261b42a8660d5b9
