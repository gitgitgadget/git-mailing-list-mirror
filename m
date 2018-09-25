Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77EB61F453
	for <e@80x24.org>; Tue, 25 Sep 2018 18:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbeIZAPK (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Sep 2018 20:15:10 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45845 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbeIZAPK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Sep 2018 20:15:10 -0400
Received: by mail-wr1-f68.google.com with SMTP id m16so7834173wrx.12
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 11:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=FS8q/fdqK6Q+BlOMvLG1QvRni5w5IJNoTCsykXje0LM=;
        b=u+VMuj0gzvR0mc8iNR51vb31ZEH0O1IdE1h1CqXHHmnSBkTvBRQbdpriPzFvFnZPYs
         D0oe8+a7jpVOc/3obrGoMrxU3RJX3N9X+jiPgJTOw3uPX/Eod5w5CKoGVgJCAFVtCDPX
         VDaVZyebnS7yRATT1Q3cOaULVzaRIoZohICjTG5dLYO7BdZeb054T32d5C1MFVaqfdHT
         RV1KgVMaIkNcZSjJJyuPW31aysYpTXDjFtYjBhqqh3RgDfspU3ROg261F7LFgRtIUpPA
         3XY+sDf5mGmMcOGNHyPCe5gZaY4OddTS5pn15UcFqG0GsZxmcDfdVcXUU8x0SeKfqBre
         9rxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=FS8q/fdqK6Q+BlOMvLG1QvRni5w5IJNoTCsykXje0LM=;
        b=Q5B5EJHmjToyeo8XZ87q0oCk/4nidlqKTzAzEYwcgBgP1kjqV7PdxXOzk0MfjOejmg
         9nBpQGQnz8qGEmVUFA4IVOOWQEARyLSDatkyC0rYuY+/XJq08/5cXVqZCHonDzBT42DB
         B+fPaTTSGRWlSTO6t/bk6SeCTEFCtpcypmVWKwNDl69ybeWHXHikf2coS9Ecz8T8+DSJ
         B7kykfKVvtD1AynclqxYnubMu/xHj2Uc0QHpFk8A1wy10ALaSEFYRyK0W8edB/mNHtSy
         8DgGesPXCYxn1nsUFnE/HSY14G9ZHDfKphI10ORxAjnlY0AwifGQ83uN92P5t5yMHvlP
         wA7g==
X-Gm-Message-State: ABuFfoj3EsXAWiCPV93xehBlP7TxXGeLYx9JBsRQ9JjO/s0GmctYRZyB
        aBcU61uU+9NVZv/FC441piU=
X-Google-Smtp-Source: ACcGV62tCi7g1ozkR9enfCq+Arqz5OTz8sYDYobemOVzeXJiiXAq/FmhHXS/vCV22vmD3QS5Hm6S9g==
X-Received: by 2002:adf:e5c7:: with SMTP id a7-v6mr2146709wrn.190.1537898786653;
        Tue, 25 Sep 2018 11:06:26 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id j2-v6sm2122162wmj.5.2018.09.25.11.06.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 11:06:25 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] commit-reach: cleanups in can_all_from_reach...
References: <pull.39.v4.git.gitgitgadget@gmail.com>
        <20180925132741.223513-1-dstolee@microsoft.com>
Date:   Tue, 25 Sep 2018 11:06:25 -0700
In-Reply-To: <20180925132741.223513-1-dstolee@microsoft.com> (Derrick Stolee's
        message of "Tue, 25 Sep 2018 13:27:41 +0000")
Message-ID: <xmqqwor9pi3i.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> @@ -622,10 +623,7 @@ int can_all_from_reach_with_flag(struct object_array *from,
>  	}
>  
>  cleanup:
> -	for (i = 0; i < nr_commits; i++) {
> -		clear_commit_marks(list[i], RESULT);
> -		clear_commit_marks(list[i], assign_flag);
> -	}
> +	clear_commit_marks_many(nr_commits, list, RESULT | assign_flag);
>  	free(list);
>  
>  	for (i = 0; i < from->nr; i++)
>
> base-commit: 4067a64672f9db8ca38d5a2682a7cdba7938c18b

This change looks good to me. 

This is a tangent, but while re-reading clear_commit_marks() and its
helpers to refresh my memory, I found that the bottom-most helper in
the callchain was written in a very confusing way, but it is not a
fault of this clean-up.  I however suspect that it would not help us
all that much to use clear_commit_marks_many() with its current
implementation.  It first clears all commits on the first-parent
chain from each list[] element, while accumulating the parent
commits that are yet to be processed in a commit_list in LIFO order,
and then consumes these accumulated side parents the same way.  We
probably would benefit by rewriting clear_commit_marks_many() to
traverse from all the tips given in list[] taking advantage of the
generation numbers, using a prio queue to manage the commits
yet-to-be-cleared, or something.
