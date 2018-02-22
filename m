Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 204D51F404
	for <e@80x24.org>; Thu, 22 Feb 2018 18:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933720AbeBVSZm (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 13:25:42 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:42439 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933711AbeBVSZl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 13:25:41 -0500
Received: by mail-pl0-f67.google.com with SMTP id 31so3335445ple.9
        for <git@vger.kernel.org>; Thu, 22 Feb 2018 10:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dZ02YksmU5qLFV4lfavXaB/h2IC1X60wGv1tGqwZYu4=;
        b=MVwr3klnr3hFN+3zpQPI/5TqVk+lNWBc9x+JhIXihU51dhz2ZKk0yfoATF/0BrXmpR
         VuW6TncU7D0DcGDVH9bJEAkAbWQ8rYnOIQ7qzkK9bAEAHFye70WyCOfn1GunyqySZG2J
         etKWQvGqK/AqOE7QfCOouSMBknufOyFexEf1Nf7RSzxtuGJzQ59YM8p/+zSvaskC0uc2
         puxaknRkxnSOJ8o2nU27r7BpZxhbz8N6RF8ue3CjJah20NZeubVLyBjzIuBeWGAeSvou
         frj3Zfj/K0hUxrL/XZHR/y2XiWes4+yM25pL9QmWITbMguNrroSxAYgJOpJVg3sAQmyB
         lOkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dZ02YksmU5qLFV4lfavXaB/h2IC1X60wGv1tGqwZYu4=;
        b=ZstWiSZsUHzG5tfRjYiKM1z6KwZeuwDWtkCK1hTbIySvUMmDb8clZ2uSAtv3kdSv7w
         oPbKTDf8kmBxdn88StqXoNhzsUTp1SaB/bQjT5e3+W6phiSQH1XPLVY23vykFIzqquZJ
         Xj3A0HBQLk2ibiCEYVNeEZsUSs7Sm8sA30SCAzGJm9WwuLFhyNN5WiNAGhzYb+cwxdh8
         wBxZSGZ/Vrekx0sdKRoRZH50tbGQmOo8G+PzAIK/x3zDDPs6fYhJICTBv0KcX81fI7zR
         E9+PXgUOyUCIhSQIp/ImCBnpbqEOPSTGzOhHxUDUxONUnW2hwrsM2IQBDpOOe9HbqPUM
         GYDQ==
X-Gm-Message-State: APf1xPDFUBrH30exS2BoIehD18K9kUo7+4LBZ4InQu6Hnuwp8RJ2lj11
        hNzmWz+Io9YyG5rFcOIOqDq/RTuagNU=
X-Google-Smtp-Source: AH8x224Nn14Nbx0bNdBytlc4CeKF3+iN7gwAHy67ohBljWMTCCm7MiVfsNYRwCEN6KUO4+akloNuzw==
X-Received: by 2002:a17:902:71c9:: with SMTP id t9-v6mr7371105plm.107.1519323940545;
        Thu, 22 Feb 2018 10:25:40 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id p125sm1129153pfp.43.2018.02.22.10.25.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Feb 2018 10:25:39 -0800 (PST)
Date:   Thu, 22 Feb 2018 10:25:38 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        gitster@pobox.com, jrnieder@gmail.com, stolee@gmail.com,
        git@jeffhostetler.com, pclouds@gmail.com
Subject: Re: [PATCH v3 15/35] transport: convert get_refs_list to take a list
 of ref patterns
Message-ID: <20180222182538.GE185096@google.com>
References: <20180125235838.138135-1-bmwill@google.com>
 <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-16-bmwill@google.com>
 <20180221145639.c6cf2409ce2120109bdd169f@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180221145639.c6cf2409ce2120109bdd169f@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/21, Jonathan Tan wrote:
> On Tue,  6 Feb 2018 17:12:52 -0800
> Brandon Williams <bmwill@google.com> wrote:
> 
> > @@ -21,7 +22,8 @@ struct transport_vtable {
> >  	 * the ref without a huge amount of effort, it should store it
> >  	 * in the ref's old_sha1 field; otherwise it should be all 0.
> >  	 **/
> > -	struct ref *(*get_refs_list)(struct transport *transport, int for_push);
> > +	struct ref *(*get_refs_list)(struct transport *transport, int for_push,
> > +				     const struct argv_array *ref_patterns);
> 
> Also mention in the documentation that this function is allowed to
> return refs that do not match the ref patterns.

I'll add a comment.

-- 
Brandon Williams
