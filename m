Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFE08208DB
	for <e@80x24.org>; Fri, 25 Aug 2017 18:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754629AbdHYSxZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Aug 2017 14:53:25 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:38432 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756572AbdHYSxY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Aug 2017 14:53:24 -0400
Received: by mail-pg0-f47.google.com with SMTP id b8so3332551pgn.5
        for <git@vger.kernel.org>; Fri, 25 Aug 2017 11:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JVBFJo+vjwbnYEPExXs5FTLk9ViXkirEO+oV5Yh8pMc=;
        b=pw8wHuhOD0kY1gqjK6ppZJG/s8kpKROpbUvo+8pxPFXJhXUMzV9BA89rnEo3yzQEhM
         qT891bZ2mZsTeK5l1HFkcQ0/2v0hZK55VyEgjAO9SI63u7TRvylLwtoL6AeteK6o2wsm
         GOwP5DY00PA4F/jFHKbD7zk53VyfPXnp7fj6mME6X6Obf36xf0D7E3HKhIVNY162ECCB
         552L3rIQ9A+5qOd/FJVUfJPcq9ScUZt6mQhUiSnX14RCruISe5sQW7+yIfZNpnKNI+27
         B/Nh7yyql/MTnDdaMrXOCyCsFGY3CI2rqP+QkTuQ7T/EF7Lilo+7KqURDEmU1sH/SZYN
         8CXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JVBFJo+vjwbnYEPExXs5FTLk9ViXkirEO+oV5Yh8pMc=;
        b=rU+IqH7+lt36b5uJzGtRK4soKAmojCsG3/9gE/pEtYbZbgRtnOoBRVSCTf7Xh6y0q0
         SXK++PoonfAeRoaQsBxnL/+pzTuabNecBzr6PKeGVjOUaBSWQkBwjchg3DRX2AiOSMo9
         Z+ewrn9335dwm54d3b08Js3QZi7Uq8wMcvhhBF1hMSG4ZYDkog2g6kGqltcqaeRrSXvc
         x2tifmirw7uX2lrSTT9D6iOp9Wx4zwh2mmZJOp772fXmjJDiQ7QwDV61wb7x4SH/DJ4x
         QhUJSeNyzr/SzzNNJ1mEhSUs/HuWyZqjYY0NzyS7hU9XmdI1SJ3PXfkfSHMRVa8wZx4B
         dB5w==
X-Gm-Message-State: AHYfb5hFxfdXKJcu/DJpRO6Ge+Zl0zC+kLQ+iVLxCYxMGfisChAiAuNe
        cJ0JEsMcDNfoNppA
X-Google-Smtp-Source: ADKCNb7IbSif+plj+PRgHOrkyLZprMwgcUxINxeGmbdW+w+WtEqzJCEIaa7eqAdlLNoTLzujB4ML9Q==
X-Received: by 10.84.146.140 with SMTP id g12mr11600835pla.80.1503687203897;
        Fri, 25 Aug 2017 11:53:23 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:f5e9:c606:d78a:b54a])
        by smtp.gmail.com with ESMTPSA id r62sm12062139pfr.111.2017.08.25.11.53.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 25 Aug 2017 11:53:22 -0700 (PDT)
Date:   Fri, 25 Aug 2017 11:53:21 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net, jrnieder@gmail.com,
        sbeller@google.com, jonathantanmy@google.com
Subject: Re: [RFC 3/7] protocol: tell server that the client understands v2
Message-ID: <20170825185321.GB103659@google.com>
References: <20170824225328.8174-1-bmwill@google.com>
 <20170824225328.8174-4-bmwill@google.com>
 <xmqqtw0vsfrz.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtw0vsfrz.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/25, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > +		/* If using a new version put that stuff here after a second null byte */
> > +		strbuf_addch(&request, '\0');
> > +		strbuf_addf(&request, "version=%d%c", 2, '\0');
> > +		/* subsequent supported versions can also be added */
> > +		strbuf_addf(&request, "version=%d%c", 3, '\0');
> 
> Isn't this last one meant only as a comment?

Sorry since this was structured as an RFC I didn't go back through the
code with a fine tooth comb to ensure I removed or commented out any
debugging statements.  Stefan also pointed out to me that I left in an
if (0) statement somewhere haha.

-- 
Brandon Williams
