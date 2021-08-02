Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2422C4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 09:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D41661050
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 09:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbhHBJnG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 05:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233110AbhHBJnF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 05:43:05 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B96C061796
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 02:42:56 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id nd39so29915773ejc.5
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 02:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=MzJW1dhcISt9W2MHKwz+Jb9Z9QH7NbH4qqAncEICTEA=;
        b=GB3lh/aIPjdfjaJ1cytX0/r6Eq6PA9G+djGh4pTZC88g/tfBXsoEvDKTwFr+ALiZo/
         mNmhajwc/IrRbIO5jU5rV0z5HQoPh7fODD51d3z2K+Ms2kxKYbeXzTqWL3FWHzXkIW+l
         R+Yg/qbUjlH27rNOKy7XNUXL6+cbMSOoKABIhiTn0IVGCv5S3/RI8+e6ZNor61HmscbC
         /t8GJybzapKqUdQFS1PNTn9MROl58Vkk62Zqhw8Q1FIwr3h0l//HI3dzI6KBhtxVINVu
         vp0hokImVwTQOCW7ilyyb4lxVdm9VyV+yuH71C1xPSvpji/yUTkafIwiHIYDn2CcYW3S
         7NVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=MzJW1dhcISt9W2MHKwz+Jb9Z9QH7NbH4qqAncEICTEA=;
        b=qZPHMRR8NAvWdQ1KpnWhqe3UF9ehimLFQAhm6STTnYaWdV3Wi4LbpoQBt61eDxH5Zx
         2kOs1NhLrHRaa2iWx/VKA6QCjUVVHThVMSFYZRG3zri9SfUOyMdYpwrGHTD3a0ALS0FD
         4Lu/JdRJXA/o6+t+3TOzF3nmu2hMXU9rrnSy7Cx91RGvRis8bjTuNjb6VOaTTzjdkIDR
         XKu5QUqy9gnxuq9DLUOQHxCzEiRg9gyuXC5qDmeUNM6To0qb9CWzkJnoGcVEJzCyVkcF
         eSf1++CFraxg0DktSLf/tjS4caeIY1BExdbRPO99+kKrYPyxy+XjkbSS/N0dXVompqUh
         kBDw==
X-Gm-Message-State: AOAM53206OX4xupdoeUNF4kV7XNqxApe+sXmYs45kks2AjiDN8Tv8AYj
        OWSRQJOpXk32OvuhLT0JomA=
X-Google-Smtp-Source: ABdhPJx3lZK9qspZz+L+pnh18l6qjV2mjEEtXd11ttyXqTkUSHgJIP279+vFtY4DKxUGBCF2CmhWgA==
X-Received: by 2002:a17:906:5e45:: with SMTP id b5mr14852482eju.301.1627897374990;
        Mon, 02 Aug 2021 02:42:54 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id p2sm5778139edx.81.2021.08.02.02.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 02:42:54 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v6 2/2] tr2: log parent process name
Date:   Mon, 02 Aug 2021 11:38:40 +0200
References: <20210722012707.205776-1-emilyshaffer@google.com>
 <20210722012707.205776-3-emilyshaffer@google.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <20210722012707.205776-3-emilyshaffer@google.com>
Message-ID: <87r1fcp4gy.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jul 21 2021, Emily Shaffer wrote:

> +`"cmd_ancestry"`::
> +	This event contains the text command name for the parent (and earlier
> +	generations of parents) of the current process, in an array ordered from
> +	nearest parent to furthest great-grandparent. It may not be implemented
> +	on all platforms.
> ++
> +------------
> +{
> +	"event":"cmd_ancestry",
> +	...
> +	"ancestry":["bash","tmux: server","systemd"]
> +}
> +------------
> +

Okey, so because of later NEEDSWORK no system that runs systemd will
currrently have output like this, just Windows.

> +	/*
> +	 * NEEDSWORK: We could gather the entire pstree into an array to match
> +	 * functionality with compat/win32/trace2_win32_process_info.c.
> +	 * To do so, we may want to examine /proc/<pid>/stat. For now, just
> +	 * gather the immediate parent name which is readily accessible from
> +	 * /proc/$(getppid())/comm.
> +	 */

This comment:

> +	struct strbuf procfs_path = STRBUF_INIT;
> +	struct strbuf name = STRBUF_INIT;
> +
> +	/* try to use procfs if it's present. */
> +	strbuf_addf(&procfs_path, "/proc/%d/comm", getppid());
> +	if (strbuf_read_file(&name, procfs_path.buf, 0)) {
> +		strbuf_release(&procfs_path);
> +		strbuf_trim_trailing_newline(&name);
> +		strvec_push(names, strbuf_detach(&name, NULL));
> +	}
> +
> +	return;
> +	/* NEEDSWORK: add non-procfs-linux implementations here */
> +}
> +
> +void trace2_collect_process_info(enum trace2_process_info_reason reason)
> +{
> +	if (!trace2_is_enabled())
> +		return;
> +
> +	/* someday we may want to write something extra here, but not today */
> +	if (reason == TRACE2_PROCESS_INFO_EXIT)
> +		return;
> +
> +	if (reason == TRACE2_PROCESS_INFO_STARTUP) {

This should be a switch/case, so we get the compiler asserting/warning
if we don't check enum arms, in this case there's just these two, let's
have that be clear for readability.

> +		/*
> +		 * NEEDSWORK: we could do the entire ptree in an array instead,
> +		 * see compat/win32/trace2_win32_process_info.c.
> +		 */

Seems to remove the need for this comment, i.e. we comment on this
limitation of linux-specific get_ancestry_names twice, both in the
function and its caller.

> -    
> +    elsif ($event eq 'cmd_ancestry') {
> +	# 'cmd_ancestry' is platform-specific and not implemented everywhere, so
> +	# just skip it for testing purposes.
> +    }

The rest of this code uses two "\n" between elsif arms, let's be
consistent here.
