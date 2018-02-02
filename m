Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26FC81F404
	for <e@80x24.org>; Fri,  2 Feb 2018 20:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752016AbeBBUQ7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Feb 2018 15:16:59 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34514 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751589AbeBBUQ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Feb 2018 15:16:57 -0500
Received: by mail-wr0-f195.google.com with SMTP id z6so3035585wrb.1
        for <git@vger.kernel.org>; Fri, 02 Feb 2018 12:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ULtlgicEd8dq2x4aNNoyYp4OhNGARzshcn/wu2BJki0=;
        b=sO0u18/EgHNZSfhGiLYrHGTw/ISCTehI71pOlTY/Tc0gt1Jay8NRrUwJNzmLkw+2pU
         tNXUiGtsAFVtQDz04lruQCKMwaTp/fXwUnBxdH2N/vktZNQ6qH2VTHtQ7K6vdG/UJkJN
         h87gOD2sp3JPrV2cJJus2gSh1HwsPC3xdYfawhjLwLyfU8tRms/dsVn1v8TCVvyV7OpH
         Kmv7gtKpBTtmEm91gSlM6VhU6IKD5bFMaEjKPsTURWJekYCxF56tT+pdQ3b6CfAEy/fI
         RF8LEzryfZBBY2E37xjgbvcAvhzz/vsgyQmzIJoSRMbnyTPw702e1lzF0lfWQlhP+PQ6
         C9WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ULtlgicEd8dq2x4aNNoyYp4OhNGARzshcn/wu2BJki0=;
        b=PXJbputVsTKgKdCj0/wQVMNV4M5GXtD/FV/gP2Ck1FrG9ykBl86xdjTKKNvCQllljo
         /eWkl1igoKK7fPnEVzrVUPz63AfVjsp13CBByLqtWxbur3TWmLWwtg4SMDUOiqro5or+
         YydRW/6lqv9HRD1l2ju1Xm+rundKSdCV72KoB82vAzdaIlQD55ggOcvU3wuZn9gByQ0r
         8o8w0nCORN9I0ydFPfi58OOw90JHOE/1USIDRejsITn/u7vQn3Yu/hNf4kX01TuSl+01
         ZnRkqb6nQuXPNq99ldAxFtqHIwDyu+Qx1fJVeLQM6lM2vur/shGYMwclDNQRoft0bk81
         8qJA==
X-Gm-Message-State: AKwxytdaB3TXsyI3oTgcXPoejqgiO0frvCqlJd4LVaykG8Xq0wwYHVW3
        DU042F26qmZeNlx11BlGXco=
X-Google-Smtp-Source: AH8x2245DheTuo7ShfIelsFw0ty4DWGjAXd/QKc0dtXsB1+3Nm2t85O1sfCu1epVdUcLf5HeU3F9hw==
X-Received: by 10.223.209.80 with SMTP id b16mr13541118wri.86.1517602616392;
        Fri, 02 Feb 2018 12:16:56 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id i75sm826891wmg.41.2018.02.02.12.16.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Feb 2018 12:16:55 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC/PATCH] reset --hard: make use of the pretty machinery
References: <20180201205721.30087-1-t.gummerer@gmail.com>
Date:   Fri, 02 Feb 2018 12:16:54 -0800
In-Reply-To: <20180201205721.30087-1-t.gummerer@gmail.com> (Thomas Gummerer's
        message of "Thu, 1 Feb 2018 20:57:21 +0000")
Message-ID: <xmqqa7wrcfk9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> In addition to the easier to follow code, this makes the output more
> consistent with other commands that print the title of the commit, such
> as 'git commit --oneline' or 'git checkout', which both use
> 'pp_commit_easy()' with the CMIT_FMT_ONELINE modifier.

Yes, this is absolutely the right thing to do.

> +
> +	pp_commit_easy(CMIT_FMT_ONELINE, commit, &buf);
> +	if (buf.len > 0)
> +		printf(" %s", buf.buf);
> +	putchar('\n');
> +	strbuf_release(&buf);
>  }
>  
>  static void update_index_from_diff(struct diff_queue_struct *q,

Thanks, will queue.
