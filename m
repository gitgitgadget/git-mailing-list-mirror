Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DCA8C4332F
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 09:39:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiJMJjO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 05:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJMJjL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 05:39:11 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2AF914D8C0
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 02:39:06 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id q19so1779039edd.10
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 02:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yJAngGENNkPjnbGxwgms2fO381DK/juUaZDMRcLVDd8=;
        b=biT2i0PIpWkBjfN8amj6PxPKgCIW0Q+O51cDzxPYVNJgcjKl0G0EhvwJ5Qivadr9zR
         PUcZAiueDJwZ9scEk3LPlHa1BYK87hTXA9yWT+wr31FCOUY5gRqJ9Amv4WhZdZtFz/fK
         4IFgZOHHtP4z3BC5AD9yYa0W9t4S7f1vyrOpHNpGg4Q9A2gLNRwmfeQI9J+sjH9MgQF4
         XwrUkXUTI/+QRBwhJ3ZkXb4HSH4i5iRnPrlbMbQeYa86XfcK2MMkgW4VWZkimftSJ54S
         VyLKtHwDAynqRErosBiPUPStvcwLRt4MtNcIXEpj9NPwn4WvootD93l0hIWADeXqBh0y
         GU4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yJAngGENNkPjnbGxwgms2fO381DK/juUaZDMRcLVDd8=;
        b=g77tJqCoMko6Ke/CyZtDjsolk4mVJ2LkfpVlGLo7lqaqzaVEVREyA/kakW94Ld7UhH
         zlZdFLL3reqkHzMRqxoG1PH0w3juaH+Y7vaMzg5fdUsay0sDtiToIGuBo9xsyD0PLZRC
         JBhnWbd/UZpZE6qjPYq0Nr3Y7t2EK4khSEFboNnvsVDh8OiDfdoiZcdx6aDR1wCrJVbx
         vvf1HWuYeTSZxBQgG++boy3tt2Gc47kdRuXOwiVdQHloCmFh5eTBKAw1zJ/Wo7mlVpYH
         oELRx4jycQw9/Uno7zp85J9qhI84UoD2mTsbs1EMQee7+9bRduYMe+dHIDN30RitOb3+
         Tb9Q==
X-Gm-Message-State: ACrzQf18+2bvWfGJG4U0Eynb9oQnVOWAMWQCRrai1xSjyAaO1QQH/uoK
        ELQ3j1HwBGc/5qCLytGXGF0eB3rnE3meyA==
X-Google-Smtp-Source: AMsMyM6VPUTdxtnTt/2n8HxkwMQJTeCLNYQagjmhG9nOn6B/TVIbucc6cfEXD0COGnC/c/EOpY0LGw==
X-Received: by 2002:a50:9ecd:0:b0:45c:da8e:837d with SMTP id a71-20020a509ecd000000b0045cda8e837dmr3075556edf.18.1665653944372;
        Thu, 13 Oct 2022 02:39:04 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id t16-20020a508d50000000b00459cd13fd34sm13024217edt.85.2022.10.13.02.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 02:39:03 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oiugA-004ftw-39;
        Thu, 13 Oct 2022 11:39:02 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     git@vger.kernel.org, --cc=avarab@gmail.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: [RFC PATCH 2/2] notes.c: fixed tip when target and append note
 are both empty
Date:   Thu, 13 Oct 2022 11:36:42 +0200
References: <20221013055654.39628-1-tenglong.tl@alibaba-inc.com>
 <20221013055654.39628-3-tenglong.tl@alibaba-inc.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20221013055654.39628-3-tenglong.tl@alibaba-inc.com>
Message-ID: <221013.86wn94kqq1.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 13 2022, Teng Long wrote:

> From: Teng Long <dyroneteng@gmail.com>
>
> When "git notes append <object>" is executed, if there is no note in
> the given object and the appended note is empty, the command line
> prompt will be as follows:
>
>      "Removing note for object <object>"
>
> Actually, this tip is not that accurate, because there is no note in
> the original <object>, and it also does no remove work on the notes
> reference, so let's fix this and give the correct tip.
>
> Signed-off-by: Teng Long <dyroneteng@gmail.com>
> ---
>  builtin/notes.c  | 13 +++++++++++--
>  t/t3301-notes.sh |  3 ++-
>  2 files changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/notes.c b/builtin/notes.c
> index 1ca0476a27..cc1e3aa2b6 100644
> --- a/builtin/notes.c
> +++ b/builtin/notes.c
> @@ -567,9 +567,10 @@ static int append_edit(int argc, const char **argv, const char *prefix)
>  	struct notes_tree *t;
>  	struct object_id object, new_note;
>  	const struct object_id *note;
> -	char *logmsg;
> +	char *logmsg = NULL;

Hrm, interesting that (at least my) gcc doesn't catch if we don't
NULL-initialize this, but -fanalyzer does (usually it's not needed for
such trivial cases0. Anyawy...

>  	const char * const *usage;
>  	struct note_data d = { 0, 0, NULL, STRBUF_INIT };
> +	struct note_data cp = { 0, 0, NULL, STRBUF_INIT };

This is probably better "fixed while at it" to set both to use "{ .buf =
STRBUF_INIT }", rather than copying the pre-C99 pattern.
