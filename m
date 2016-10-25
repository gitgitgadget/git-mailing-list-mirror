Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8406A2035F
	for <e@80x24.org>; Tue, 25 Oct 2016 17:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941135AbcJYRcn (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Oct 2016 13:32:43 -0400
Received: from mail.javad.com ([54.86.164.124]:45532 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934156AbcJYRcm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2016 13:32:42 -0400
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 46CDB60BFE;
        Tue, 25 Oct 2016 17:32:41 +0000 (UTC)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1bz5aZ-00028D-R0; Tue, 25 Oct 2016 20:32:39 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] reset: --unmerge
References: <xmqqa8dttkbw.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 25 Oct 2016 20:32:39 +0300
In-Reply-To: <xmqqa8dttkbw.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 24 Oct 2016 16:10:11 -0700")
Message-ID: <87bmy81gi0.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> The procedure to resolve a merge conflict typically goes like this:
>
>  - first open the file in the editor, and with the help of conflict
>    markers come up with a resolution.
>
>  - save the file.
>
>  - look at the output from "git diff" to see the combined diff to
>    double check if the resolution makes sense.
>
>  - perform other tests, like trying to build the result with "make".
>
>  - finally "git add file" to mark that you are done.
>
> and repeating the above until you are done with all the conflicted
> paths.  If you, for whatever reason, accidentally "git add file" by
> mistake until you are convinced that you resolved it correctly (e.g.
> doing "git add file" immediately after saving, without a chance to
> peruse the output from "git diff"), there is no good way to recover.

"git reset --unmerge file"

to undo accidental

"git add file"

during conflict resolution?

I'm afraid "unmerge" sounds like revert of "merge", rather than revert
of "resolve". I'd rather prefer to see something like:

git add --undo file

git merge --unresolve file

git reset --unresolve file

in that order, to deal with the issue.

-- Sergey
