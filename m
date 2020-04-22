Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4656BC5518C
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 16:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CBAC20774
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 16:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJF5qhvJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbgDVQyC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 12:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbgDVQyB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Apr 2020 12:54:01 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760C5C03C1A9
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 09:54:01 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id f8so1173951plt.2
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 09:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AqQTm4aPFgGIlKg+VlLsIWdaq1jI4CitE9h9IwNaHKo=;
        b=jJF5qhvJ+VbbaHb2kmT4kDIQwMYaryAWvUogIF10IJ2pkV5dMtpDAepJ7nHKiYpm+X
         MfFfERnf5RyPC7KKS5hUbMA0NAvBSaD9WoxNpfBMPCEfTFvd3t15g9SWk4V66775xvfB
         E76k0xLzKVKuflr4VHM2Xg+yrDdJ1ruo1Mxw4WDyq7rA3e+pNSwLLFwdp94tFuMLZ6+D
         /0XTl7MAefGSkBnU1eYFd6wXL1xJfi/jM3Gtfhh8cOLZD3BimgeVi8UINmLwkEHVn2VW
         T8ao08JA0coTTnQPw6MjhUCdzmNJjngF+Q39PO/8tbMLszboinWJcStg2xj2CFxXoZ+9
         U7VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AqQTm4aPFgGIlKg+VlLsIWdaq1jI4CitE9h9IwNaHKo=;
        b=H9Tmucd5Csf10OnPEIkeb+Y9Q0+jFSSkbtOYr0pFpvnp5Pgp8qTPadA+ZCou9VWhqI
         qYyVcN9Ij5fzDatxnSF3/mL/f+FFpV4un6/8qf7+NAN33SqQLXpCkedIrU6pPTWvkNVs
         GW5azlcmAn4PugGZrQZrv1PiiV8YSZZNNkM5z1R62F1fcUavB5LLFSRH4x9JjEtYqE5E
         9bsFeVhC5qKwedpBiuy9Q5iCqF4Y4MkvFaKXMfM5gF7cb53Kaw6ZeIbHECc8dDlQZSkb
         e7GelCMGCTslZimFjJ8fnM1oi6nRuvCTQWUCSXpMAHKQ455/78pmE7yDJ4Ts2E1MgcdY
         /jJg==
X-Gm-Message-State: AGi0PuZQ5VOi3zg3bkUO5n1BdbwCoJnmr6q8E65Z6wmaRJzHmA1gRepk
        lUHB5gz0Rs/Y8lri6f/lUwc=
X-Google-Smtp-Source: APiQypIqGp3WATIFFJMYeQZ9ZfeVxlQofVNbWMt4scM6YH35ZMoqp0M0tFFUertL2cBQLBsaXJc7Vw==
X-Received: by 2002:a17:90a:c707:: with SMTP id o7mr12584783pjt.135.1587574440844;
        Wed, 22 Apr 2020 09:54:00 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id t12sm5578821pgm.37.2020.04.22.09.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 09:54:00 -0700 (PDT)
Date:   Wed, 22 Apr 2020 09:53:58 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Lubomir Rintel <lkundrak@v3.sk>, git@vger.kernel.org,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: Git 2.26 fetches many times more objects than it should, wasting
 gigabytes
Message-ID: <20200422165358.GB140314@google.com>
References: <20200422084254.GA27502@furthur.local>
 <20200422095702.GA475060@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422095702.GA475060@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:

> So it really does seem like something in v2 is not trying as hard to
> negotiate as v0 did, even when using stateless-http.
>
> I'm attaching for-each-ref output before and after the xo fetch. That
> should be sufficient to recreate the situation synthetically even once
> these repos have moved on.

Thanks again.  Looked a little closer and the advertised refs shouldn't
matter.  We just have two completely different code paths for
negotiation, one for v0 and one for v2.  In v0, we do

	fetch_negotiator_init(r, negotiator);
	mark_complete_and_common_ref(negotiator, args, &ref);
	filter_refs(argrs, &ref, sought, nr_sought);
	find_common(negotiator, args, &ref, sought, nr_sought);

find_common does

	count = 0;
	while ((oid = negotiator->next(negotiator)) {
		write "have %s\n", oid
		if (++count >= flush_at) {
			... flush ...
			flush_at = next_flush(args->stateless_rpc, count);
			...

In v2, the corresponding code is in add_haves:

	while ((oid = negotiator->next(negotiator))) {
		write "have %s\n", oid
		if (++haves_added >= *haves_to_send)
			break;
	}
	*in_vain += haves_added;
	if (!haves_added || *in_vain >= MAX_IN_VAIN)
		write "done"
	*haves_to_send = next_flush(1, *haves_to_send);

In other words, in v2 we reset the counter on each round whereas in v0
we keep a running total.  That would be expected to produce larger
negotiate requests in v2 than v0 (which looks like an unintentional
difference, but not the one producing this bug).

So much for flush_at handling.  in_vain seems like another area to
compare: in v2, the driving logic is in do_fetch_pack_v2:

	haves_to_send = INITIAL_FLUSH;
 negotiate_loop:
	while (!send_fetch_request(negotiator, fd, args, ref,
				   &common, &haves_to_send,
				   &in_vain, reader.use_sideband))
		switch (process_acks(negotiator, &reader, &common)) {
		case 1:
			in_vain = 0; /* renewed hope!
			continue;
		case 2:
			break negotiate_loop; /* time to move on */
		default:
			continue;
		}

When process_acks sees an ACK, it passes it on to the negotiator.
It wants to record that it received an ack to reset in_vain, but
it forgets to!  The function is initialized and read but never
written to.

So I'd expect the following to help:

diff --git i/fetch-pack.c w/fetch-pack.c
index 1734a573b01..a1d743e1f61 100644
--- i/fetch-pack.c
+++ w/fetch-pack.c
@@ -1287,6 +1287,8 @@ static int process_acks(struct fetch_negotiator *negotiator,
 			struct object_id oid;
 			if (!get_oid_hex(arg, &oid)) {
 				struct commit *commit;
+
+				received_ack = 1;
 				oidset_insert(common, &oid);
 				commit = lookup_commit(the_repository, &oid);
 				if (negotiator)
