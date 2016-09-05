Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCC9020193
	for <e@80x24.org>; Mon,  5 Sep 2016 16:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932546AbcIEQQ5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Sep 2016 12:16:57 -0400
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:39745 "EHLO
        homiemail-a22.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932286AbcIEQQ4 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 5 Sep 2016 12:16:56 -0400
Received: from homiemail-a22.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a22.g.dreamhost.com (Postfix) with ESMTP id DC25311406A;
        Mon,  5 Sep 2016 09:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=message-id
        :subject:from:to:cc:date:in-reply-to:references:content-type
        :mime-version:content-transfer-encoding; s=novalis.org; bh=eirII
        /vKgctJPFMU0YsYhWR6CsA=; b=oHHOS2q4yWuTvDkpMTQhVrRidTMfqvJZyMajX
        HzGrWDySQ8y++rvcvKcSYc1+DOg7r1ZxrrXH4JEdhE9C2vwsBW/T4lY+DUmlZKme
        Xtx9apzpjQOjKNhESuZ/RThlChTyLqww1d4pchKYy6DznjOE01la27I+YcGgKpTo
        CXzjfg=
Received: from [10.0.1.180] (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com [207.38.164.98])
        (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by homiemail-a22.g.dreamhost.com (Postfix) with ESMTPSA id E2E05114065;
        Mon,  5 Sep 2016 09:16:54 -0700 (PDT)
Message-ID: <1473092212.6035.30.camel@frank>
Subject: Re: [PATCH v2 05/38] refs: create a base class "ref_store" for
 files_ref_store
From:   David Turner <novalis@novalis.org>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
        <pclouds@gmail.com>, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>
Date:   Mon, 05 Sep 2016 12:16:52 -0400
In-Reply-To: <c6ae77bf-e2e2-c108-648d-75b5164b7ba2@alum.mit.edu>
References: <cover.1473003902.git.mhagger@alum.mit.edu>
         <39277c75122a374b360057d6e1f6d889a90f6fb4.1473003902.git.mhagger@alum.mit.edu>
         <1473021637.6035.27.camel@frank>
         <c6ae77bf-e2e2-c108-648d-75b5164b7ba2@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 2016-09-05 at 05:53 +0200, Michael Haggerty wrote:
> On 09/04/2016 10:40 PM, David Turner wrote:
> > On Sun, 2016-09-04 at 18:08 +0200, Michael Haggerty wrote:
> > 
> >> +/* A linked list of ref_stores for submodules: */
> >> +static struct ref_store *submodule_ref_stores;
> > 
> > I don't like the per-submodule stores being in a linked list, which
> > requires a linear search.  Stefan has, I think, been doing a bunch of
> > work to scale git to support on the order of thousands of submodules,
> > which this potentially breaks.  What about a hashmap?
> 
> I agree it's not ideal, but this linked list is not new. Before this
> patch the same code was in `files-backend.c`, and before patch [03/38]
> essentially the same linked list was stored as `submodule_ref_caches`.
> So this is not a regression, and I'd rather not address it in this patch
> series.

Fair enough!

