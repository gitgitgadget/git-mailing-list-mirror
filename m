Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE5F61F404
	for <e@80x24.org>; Thu, 15 Feb 2018 18:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163376AbeBOSZ2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 13:25:28 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34249 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163288AbeBOSZZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 13:25:25 -0500
Received: by mail-wm0-f66.google.com with SMTP id j21so2307717wmh.1
        for <git@vger.kernel.org>; Thu, 15 Feb 2018 10:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Sjtjk1Xl8KH2tttIlJqgUZd1Z8lGBA8hR96lXaBNplE=;
        b=EHf48BXkINxh3VFZUK/E3bD9HxxaLpOnyX6rJJOHoa2DXM5Wy/qfVBTxZVB2fJpbH+
         M72JJcuvwJEwmIHJfc3n/FTuIHwa4HbH73O8OyuIV/EEka1gcpF+31bP2UykAiU3DpgY
         ws34cJsHrhE5uxvbo8vw+xSsnyzHeyXfl1IeaNzcA19DelCnd20GjPA2i0QY6Y9o277x
         hX8eI/5TUJ21xjmdMJcWActJD5XI3QXb4qcJ86OZlD5zHxI8eA8HdMW2tE5HUG8nsaBN
         SDy4HXD4iLcwuPjDHxRK+icsCZ1CDxHDXjst/QAErSuIcxGb7y3s9Wo/f69F2iAa9Ksv
         rgqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Sjtjk1Xl8KH2tttIlJqgUZd1Z8lGBA8hR96lXaBNplE=;
        b=qu6g61VCIM01YRu51DGvqsGz7l+/CVp6p1wTw2hLNvOad+vx690VYea3OuFEXJzef+
         V5fuES3m8alrWCwnub4KoJF4aYdV0QEveKZYlX3h4+3TfCXitygVgmZc00KeRNZk2oq1
         DnKiAtl+D4l8M5fRn9ByqUTwHJ1tnFEIaiDcqkY88bAgYMZs+IrzUWuC/SbQVU0bKGMN
         0tEqTDhfbJPouq/i3Bpp9Pg0vnmrt09GMFuqg191EzzXlfAdTwH0M49XdLDB5g3ga+Zh
         cLpUkQuFfdfM2GWrtF3T9LcW5qQRyk5Rx/wGmLWQ9MRP6GJDZ4zZ2gJo9YXkz9Ntr2mi
         mt3w==
X-Gm-Message-State: APf1xPBEe5iPm0SNks/iog/pyw9PN8OEK4DPXytdBRHl+wm0/if6eLR+
        5TEAGA0835jdI8JG47XlkOI=
X-Google-Smtp-Source: AH8x227Zoe+GpX6zeT2n8fNUT9QPldXGgtPAgCNvwBbicBZBIJSplk16kjtYUUfkVHJ20SNadh8gyg==
X-Received: by 10.28.93.80 with SMTP id r77mr2703571wmb.73.1518719123640;
        Thu, 15 Feb 2018 10:25:23 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id o13sm25722034wrc.62.2018.02.15.10.25.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Feb 2018 10:25:22 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, git@jeffhostetler.com,
        peff@peff.net, jonathantanmy@google.com, sbeller@google.com,
        szeder.dev@gmail.com
Subject: Re: [PATCH v3 11/14] commit: integrate commit graph with commit parsing
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
        <1518122258-157281-1-git-send-email-dstolee@microsoft.com>
        <1518122258-157281-12-git-send-email-dstolee@microsoft.com>
Date:   Thu, 15 Feb 2018 10:25:21 -0800
In-Reply-To: <1518122258-157281-12-git-send-email-dstolee@microsoft.com>
        (Derrick Stolee's message of "Thu, 8 Feb 2018 15:37:35 -0500")
Message-ID: <xmqqd1169kku.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> +struct object_id *get_nth_commit_oid(struct commit_graph *g,
> +				     uint32_t n,
> +				     struct object_id *oid)
> +{
> +	hashcpy(oid->hash, g->chunk_oid_lookup + g->hash_len * n);
> +	return oid;
> +}

This looks like a rather klunky API to me.  

It seems that many current callers in this series (not limited to
this step but in later patches in the series) discard the returned
value.

I would understand the API a lot better if the function returned
"const struct object_id *" that points into the copy of the oid the
graph structure keeps (and the caller can do hashcpy() if it wants
to).

That would allow the API to later check for errors when the caller
gives 'n' that is too large by returning a NULL, for example.

> +static struct commit_list **insert_parent_or_die(struct commit_graph *g,
> +					   int pos,
> +					   struct commit_list **pptr)
> +{
> +	struct commit *c;
> +	struct object_id oid;
> +	get_nth_commit_oid(g, pos, &oid);
> +	c = lookup_commit(&oid);
