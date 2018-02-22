Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58C661F404
	for <e@80x24.org>; Thu, 22 Feb 2018 19:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751334AbeBVTXD (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 14:23:03 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:43890 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750725AbeBVTXC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 14:23:02 -0500
Received: by mail-pf0-f194.google.com with SMTP id z14so2469887pfe.10
        for <git@vger.kernel.org>; Thu, 22 Feb 2018 11:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sd1AAsuyj8LLsxTc0nNLc2ziHnfr/XKMeDb+rO4YoSw=;
        b=iZFOZuDHjsL0Bx9toY0Bwz5DW8+bK6iaNINiNyPN+rHdyTJ48kxWO1NoF/Phy71PPW
         IM2ZvNtQGsWSsqRVJPsLCGqgggoTguni5dj/lbzNRC5nJKXtrC6rJUXJSEUirCbGR2co
         M7YuJp2FBdlamZrIQZMyo/XalPoCQpmeVbUVTD7h80gXX1LF4+Uq8F2VTyoSRcJrEK46
         hXTEmUcTrREaSIQd1qQvCDv72HtHIBWIyNutSt5MPX+apujJCThiO4hcPAGpEiKYDSll
         O2oxh3HA3fWvIeUgNPtmR1ND8tUpYlFBTN+MeT55yfFUjqtjKngj+gWAB8CcxKSB210+
         pOfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sd1AAsuyj8LLsxTc0nNLc2ziHnfr/XKMeDb+rO4YoSw=;
        b=PB7pVvctcydgRoRcpWqSaB7nDI1Xsth9JQ1JLS5T/EHRMIRD7s91nI2wYj6Kr6NJuX
         89UkWMawR5y0t0YbPbG3fIleO3shr7Fsy3el0HFv3kjJgH8oX7wy8Y7LxXWDabny6c8t
         dyJ/kuBnloJirEYglXAXmmIFRjv8UP5nq+Cce/J/8uUKawlDIRBRgFJtind+yG0ABtUt
         XkVlnWGmjOmf2Vz5FpR77Upp8a0lzDKYLp90Aj6pztMNcwp9WwMQ9bGDrffKNhF5+oUe
         2nIoa9wPTm05SFOeuUa/XljI29syE6iQuiM9h/wdfy6y7bpOT9CZq5wRg+L3Iu7Qg7yV
         M3dQ==
X-Gm-Message-State: APf1xPCdv3Bp1Xhje3v9mbEODdg3gThhUo4YWAWe5T4WC1jmnuYe1Bfi
        QN7JIJDLIGhH6jVBvZmkVHC78SPSnOU=
X-Google-Smtp-Source: AH8x225P34uoqawqEEGqHGb1TEDOVWHkijTNVeHPiJgf2UFJM+EAhNZZNI9nMeBv9+KxK2qcmW6ZuQ==
X-Received: by 10.167.128.6 with SMTP id j6mr7928942pfi.56.1519327381591;
        Thu, 22 Feb 2018 11:23:01 -0800 (PST)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id x123sm1147539pgb.5.2018.02.22.11.22.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Feb 2018 11:23:00 -0800 (PST)
Date:   Thu, 22 Feb 2018 11:22:58 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        gitster@pobox.com, jrnieder@gmail.com, stolee@gmail.com,
        git@jeffhostetler.com, pclouds@gmail.com
Subject: Re: [PATCH v3 08/35] connect: discover protocol version outside of
 get_remote_heads
Message-Id: <20180222112258.7a71601780be9e42f54c5f61@google.com>
In-Reply-To: <20180222181739.GC185096@google.com>
References: <20180125235838.138135-1-bmwill@google.com>
        <20180207011312.189834-1-bmwill@google.com>
        <20180207011312.189834-9-bmwill@google.com>
        <20180221141135.c78d72b422f985aae5375bca@google.com>
        <20180222181739.GC185096@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 22 Feb 2018 10:17:39 -0800
Brandon Williams <bmwill@google.com> wrote:

> > > diff --git a/remote.h b/remote.h
> > > index 1f6611be2..2016461df 100644
> > > --- a/remote.h
> > > +++ b/remote.h
> > > @@ -150,10 +150,11 @@ int check_ref_type(const struct ref *ref, int flags);
> > >  void free_refs(struct ref *ref);
> > >  
> > >  struct oid_array;
> > > -extern struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
> > > +struct packet_reader;
> > > +extern struct ref **get_remote_heads(struct packet_reader *reader,
> > >  				     struct ref **list, unsigned int flags,
> > >  				     struct oid_array *extra_have,
> > > -				     struct oid_array *shallow);
> > > +				     struct oid_array *shallow_points);
> > 
> > This change probably does not belong in this patch, especially since
> > remote.c is unchanged.
> 
> Yes this hunk is needed, the signature of get_remote_heads changes.  It
> may be difficult to see that due to the fact that we don't really have a
> clear story on how header files are divided up within the project.

Thanks - I indeed didn't notice that the implementation of
get_remote_heads() is modified too in this patch.

My initial comment was about just the renaming of "shallow" to
"shallow_points", but yes, you're right - I see in the implementation
that it is indeed named "shallow_points" there, so this change is
justified, especially since you're already changing the signature of
this function.
