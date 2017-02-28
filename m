Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B388A202C9
	for <e@80x24.org>; Tue, 28 Feb 2017 21:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751898AbdB1VqN (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 16:46:13 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35268 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751557AbdB1VqM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 16:46:12 -0500
Received: by mail-pg0-f67.google.com with SMTP id 1so3087751pgz.2
        for <git@vger.kernel.org>; Tue, 28 Feb 2017 13:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=QR7XXHuTvJy7J7eY1QpjsnkzSXp0I/bxh4AarmnpXZI=;
        b=dirr/PCX5wTqz3HpMzfmo7RFvZL7KrvwrkW7C+Rqo6QHzybIDrRWGdQ4PcxPvBcd1H
         sYRZR7Fix0CDDBPctPsOiujW68qHNQDkCqM5sKF+xab55k685Ll0jUOvg7RuUTcVNiTX
         drRaXtEnKIhAPf1aWFnH/mLYkBjK7S9VYgkeJmzk+b5ocCtZsdgA4iOo7qp5X+CiTMmX
         upPxkmPnhaHjekeatU1ps1sHhU4GKx9OpZDIk+wUSZmk6/MPFU2tE782eFO5RI/f6ReZ
         CThcupA5mSQkb3ILjTTWILxqNrW7feO52sLvfFppJ7JfVI92tS8BYWww85Y/cyVGRhhc
         z9kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=QR7XXHuTvJy7J7eY1QpjsnkzSXp0I/bxh4AarmnpXZI=;
        b=kPY39QaI21p7+P9hlUmRelG94u8TWp1dNzTyXJFBZ1u5NHMsxSrTqFvX43VmFsVMGM
         FRYl3nk/dOCeQ+DMAHjSOPVpv5j1+1aQpz/R290r/pbEnctOaL0avcZj9A2E1JPywm6P
         zVnYbNN5t6elbqU4wRvS+6Qm9b4ljNcPGCqV7eDvSqlkkX5gGi2BpzMPBMquYLr+2KdH
         Y/sb5GWESuqkg51qQcO7rWMf0jdsTiE46DKqf+EoGCmj+KY2aqKF7Mgw+fAIRmCEUu8r
         4eFDXbTVgzMoE/sexRqBfrwDQAkB4UbNoq8VDnCx6WLq35tjh6X/4GICELG78P4rrjGj
         oeHw==
X-Gm-Message-State: AMke39mDyySinLY1AucX+a3mOT+9uHz//qr+upx5CNAlKn8WPH6dHWlyk3WsbIsJAcT4fg==
X-Received: by 10.84.193.101 with SMTP id e92mr5777356pld.4.1488318255599;
        Tue, 28 Feb 2017 13:44:15 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:e0d7:55f8:67f2:62dd])
        by smtp.gmail.com with ESMTPSA id z27sm6028062pfg.38.2017.02.28.13.44.14
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 28 Feb 2017 13:44:14 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, peartben@gmail.com,
        benpeart@microsoft.com
Subject: Re: [PATCH 2/3] revision: exclude trees/blobs given commit
References: <cover.1487984670.git.jonathantanmy@google.com>
        <cover.1487984670.git.jonathantanmy@google.com>
        <7082d91f30663b2e6d7fb1795c5ea37d3fe3446c.1487984670.git.jonathantanmy@google.com>
Date:   Tue, 28 Feb 2017 13:44:14 -0800
In-Reply-To: <7082d91f30663b2e6d7fb1795c5ea37d3fe3446c.1487984670.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Fri, 24 Feb 2017 17:18:37 -0800")
Message-ID: <xmqqwpcahtxt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> When the --objects argument is given to rev-list, an argument of the
> form "^$tree" can be given to exclude all blobs and trees reachable from
> that tree, but an argument of the form "^$commit" only excludes that
> commit, not any blob or tree reachable from it. Make "^$commit" behave
> consistent to "^$tree".
>
> Also, formalize this behavior in unit tests. (Some of the added tests
> would already pass even before this commit, but are included
> nevertheless for completeness.)
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  revision.c               |  2 ++
>  t/t6000-rev-list-misc.sh | 88 ++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 90 insertions(+)
>
> diff --git a/revision.c b/revision.c
> index 5e49d9e0e..e6a62da98 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -254,6 +254,8 @@ static struct commit *handle_commit(struct rev_info *revs,
>  			die("unable to parse commit %s", name);
>  		if (flags & UNINTERESTING) {
>  			mark_parents_uninteresting(commit);
> +			if (revs->tree_and_blob_objects)
> +				mark_tree_uninteresting(commit->tree);

I fear that this may end up to be quite expensive.  Can we have a
perf test?
