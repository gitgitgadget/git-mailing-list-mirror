Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4898120899
	for <e@80x24.org>; Thu, 27 Jul 2017 23:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751573AbdG0Xuv (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jul 2017 19:50:51 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:38395 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751113AbdG0Xuv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jul 2017 19:50:51 -0400
Received: by mail-pg0-f50.google.com with SMTP id k190so38382158pgk.5
        for <git@vger.kernel.org>; Thu, 27 Jul 2017 16:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/kjUp/kSy9wxgsoJVDvU6xlLzqbJmEBdorCWI65cfgE=;
        b=FPua+m/v4mOVOylj9fNM+9xe7Hrsb+Jq4qnIRznByF+XyJZ2OC9nIfOP4G2GMFXAvN
         gUBJm7SrDDzKMta1M+UzCPEq/EcrJRF7dBShZ+7jFCyiqHoR/2CYW7tgEg6IpQ6Hxj/2
         a/KUzB4OKvXXLVCfcXFwRtz3EDE5cvFWLE9rTrfn9c4WvilTX05f+cjLfQdPTGdFPjK/
         S81pmuOZynd+my9l1JBSWsp3bfkRdVPz6Iu7FC5t17vH/HGPlF7cUvI1lVJMXpMBnpLC
         OaWYYUvhMau7lZ43bW4SBp/92dowqbt2mYF29BQpJpgFCDIj2wcx2PhOwfAx8aQBFXsc
         kOCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/kjUp/kSy9wxgsoJVDvU6xlLzqbJmEBdorCWI65cfgE=;
        b=XRuwQWMvHLdpq5z46skb+vFaFB+ItV7tefiJVx4GLafvJmZu0CpZrC9zeeyg4K7W1y
         cRBQLu/8o/YDY+1d5bQUeTiVUsBkP48imRpfWLftAX4waHqHIfCftoakWTcGI0WUICds
         13evjR8F/Ry0eTOoIQoo3yUHo245G8pxlzJo8nqcpP6NswvJjuM6ce0pA5TmBsTiyV9k
         KF/5f9O1faFdS7NU0COV7+KB2r4JHSD36/CEOPUm6TDVFf0CdUMQVUmF2yzEhU8uvwDM
         8lKpmCdX3C27KR8PoKyqSsh40EZidaiB5/HkPQ2wVvD1VWml989pJ4/wUfEm1pbFUlFx
         PzqA==
X-Gm-Message-State: AIVw113M2yofKfoqE32re/6CCmWAsea75ojteVHr23xI9uj3kGlZXLTs
        9rDH58RZXnEQ1kW8
X-Received: by 10.99.98.69 with SMTP id w66mr5551724pgb.58.1501199450492;
        Thu, 27 Jul 2017 16:50:50 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:6055:1975:96d0:9b69])
        by smtp.gmail.com with ESMTPSA id s18sm17421613pfg.166.2017.07.27.16.50.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 27 Jul 2017 16:50:49 -0700 (PDT)
Date:   Thu, 27 Jul 2017 16:50:45 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peartben@gmail.com, christian.couder@gmail.com
Subject: Re: [RFC PATCH 3/4] fsck: support referenced lazy objects
Message-ID: <20170727165045.6b8da3aa@twelve2.svl.corp.google.com>
In-Reply-To: <xmqqpocln0z2.fsf@gitster.mtv.corp.google.com>
References: <cover.1501111615.git.jonathantanmy@google.com>
        <cover.1501111615.git.jonathantanmy@google.com>
        <1d841f0e4188f0ae9fa3c238c58d3e1b5fb232e8.1501111615.git.jonathantanmy@google.com>
        <xmqqpocln0z2.fsf@gitster.mtv.corp.google.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 27 Jul 2017 12:17:37 -0700
Junio C Hamano <gitster@pobox.com> wrote:

> The same comment as 2/4 applies here.

Noted - whatever the resolution is, I'll apply it to all the patches.
> 
> > @@ -212,6 +221,8 @@ static void check_reachable_object(struct object *obj)
> >  	 * do a full fsck
> >  	 */
> >  	if (!(obj->flags & HAS_OBJ)) {
> > +		if (repository_format_lazy_object)
> > +			return;
> >  		if (has_sha1_pack(obj->oid.hash))
> >  			return; /* it is in pack - forget about it */
> >  		printf("missing %s %s\n", printable_type(obj),
> 
> Also this reminds as a related issue.  Imagine:
> 
>  - An object X was once retrieved, perhaps but not necessarily
>    lazily, together with another object Y that is referred to by X
>    (e.g. X is a tree, Y is a blob in the directory at path D, which
>    is represented by X).
> 
>  - The same blob Y is added to the index in a different directory at
>    path E.
> 
>  - The user decides to make this a slimmed-down "narrow clone" style
>    repository and tells Git that path D is not interesting.  We lose
>    X, but not Y because Y is still referenced from the index.
> 
>  - "git reset --hard" happens, and there no longer is any reference
>    to Y.
> 
> Now, when we run fsck, should we diagnose Y as "unreachable and/or
> dangling"?

I would say yes (or whatever happens in the case where we re-fetch into
a shallow clone).

Come to think of it..."git reset --hard" always has the potential to
create unreachable objects, right (regardless of whether it's a "shallow
clone" or "narrow clone" or ordinary clone)?
