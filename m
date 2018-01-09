Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AB311F406
	for <e@80x24.org>; Tue,  9 Jan 2018 19:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933821AbeAITPN (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 14:15:13 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35884 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932998AbeAITPN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 14:15:13 -0500
Received: by mail-pf0-f195.google.com with SMTP id 23so6567852pfp.3
        for <git@vger.kernel.org>; Tue, 09 Jan 2018 11:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=McAt39KXcyrPCTSTZLkqi4cYKGQfSZw3I0BFvClGq4g=;
        b=iprWCxdVBEkswe6h0io9bdEgCAyomeK/PQUeDzHLmf1JylZzT1125Ug9+dlyCH50vP
         e+iMQcLyZ9/MX6pPKoVil8/o9aUqkMd68twbPAyD7XxmddqLNN59H0uffEf5ADtJXASY
         6pbh/Cb0IOqxjqIxSANNjn5vyHlRi5YnBU6UYak9JK7oFfMy4zhjowMJ2dAOXmhd/nEw
         IkN3wjho3NrSzm6txGY7dpdqJ36jtQFnF3UknA8F44TKDsoPxr1uSAxR6Uqa81L+jA+0
         bAknI0QEDSKdSiCpYX3Dl6LnxmX9WB2Wiv+MeUNbFh8vUe/6stvglD9N5csDRweG4xi7
         NJTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=McAt39KXcyrPCTSTZLkqi4cYKGQfSZw3I0BFvClGq4g=;
        b=Pr41rXFZTY4opM13WIA2kldgLSuoLS4gSauj/sWfvBPHiQjum4ftFWtVuz076yu1xE
         y17NA8a0WhJMoUNHupPWFURBZJ+KuI5Za9+ApJ04LFxL9RtGVox7HBlJruffkDVg2+l3
         AefW+18x8M6/LfJ4TaYAJehSdWmpBPNS7WZtsk7c0/+/NAS+E24+jhgaBTX7e0+6OiFU
         46jUJjxWbf3jkPH0bqaN/WRyARPrvuy931Fw+G2cwwAY0CT215jC/oV/uXAAqsyoohb+
         RTg2K2SCHNwSEK61S6EKay4l3QmIY7HWXQvuqrx5N1q5OErUyXE7mW9qTxrpBscQiObE
         LClQ==
X-Gm-Message-State: AKGB3mJhZCtYCvQ1nzNqWJAnvg9pIrjeVoL4/ibz4YAi8NwmA2q9/K2s
        TMa4JvZ3TA6auyWmnnWZdz0N5w==
X-Google-Smtp-Source: ACJfBouSkuxbmMFiqUSgvlTgN5k5YswnTHKwEUtGLeDUeyR0kcNIu8hm6HEE7zdmc8RTZvr2eOuRrw==
X-Received: by 10.159.205.129 with SMTP id v1mr16451393plo.31.1515525312456;
        Tue, 09 Jan 2018 11:15:12 -0800 (PST)
Received: from google.com ([2620:0:100e:422:5de7:5b51:7854:d1a5])
        by smtp.gmail.com with ESMTPSA id b25sm35099695pfd.182.2018.01.09.11.15.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 09 Jan 2018 11:15:11 -0800 (PST)
Date:   Tue, 9 Jan 2018 11:15:10 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, gitster@pobox.com,
        peff@peff.net, philipoakley@iee.org, stolee@gmail.com,
        jrnieder@gmail.com
Subject: Re: [PATCH 09/26] transport: store protocol version
Message-ID: <20180109191510.GB151395@google.com>
References: <20180103001828.205012-1-bmwill@google.com>
 <20180103001828.205012-10-bmwill@google.com>
 <20180109104125.4cb1a3e545cfe354862e4b8e@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180109104125.4cb1a3e545cfe354862e4b8e@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/09, Jonathan Tan wrote:
> On Tue,  2 Jan 2018 16:18:11 -0800
> Brandon Williams <bmwill@google.com> wrote:
> 
> > diff --git a/transport.c b/transport.c
> > index 63c3dbab9..2378dcb38 100644
> > --- a/transport.c
> > +++ b/transport.c
> > @@ -118,6 +118,7 @@ struct git_transport_data {
> >  	struct child_process *conn;
> >  	int fd[2];
> >  	unsigned got_remote_heads : 1;
> > +	enum protocol_version version;
> 
> Should this be initialized to protocol_unknown_version? Right now, as
> far as I can tell, it is zero-initialized, which means protocol_v0.

I don't think it matters as the value isn't used until after the
version has already been discovered.

-- 
Brandon Williams
