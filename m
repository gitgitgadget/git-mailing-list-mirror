Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 089391F462
	for <e@80x24.org>; Thu, 30 May 2019 19:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbfE3TFi (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 May 2019 15:05:38 -0400
Received: from resqmta-po-09v.sys.comcast.net ([96.114.154.168]:46632 "EHLO
        resqmta-po-09v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725961AbfE3TFh (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 30 May 2019 15:05:37 -0400
Received: from resomta-po-18v.sys.comcast.net ([96.114.154.242])
        by resqmta-po-09v.sys.comcast.net with ESMTP
        id WQ6LhAi7kP5jGWQMrhJxtE; Thu, 30 May 2019 19:05:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=20190202a; t=1559243137;
        bh=E4NDFpwz5a2Lq7taDEWGLv0G9qP+GiYYrMTwhj2HsgQ=;
        h=Received:Received:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=6LLDn7JpKfxPxogLYZcrLwjqWw+pNtjWsLRIy6AUFiRWwG2lrAUijTbCLkj2tHIRZ
         qbCT6kjq9Rkn01O24SCtNpaXiF7ab7umJybCHw/RcoRuIIYeTDoV1H3/5gzU15x+bZ
         t3QJsH++/RIsahObAplGySKc8nJmX8ATBl6J/Uo5sonT1XPoR8TgpjES92VXOXY+dr
         gYwCThon2I/P4eEP+YIwI5qz1XGruq75IJjdbEEr+w/4Aat9cQz7YU2qzNfLhrknFu
         UKs/+1WDBN7Peq2VsnhDJbBKS7qcNEUc2o3kdBCGwPjjxMP6BoKCLmA+SpEKz+rYjU
         hDOy2vr4DK9Og==
Received: from comcast.net ([IPv6:2601:647:4b02:2491:1ed:c9d3:7cb2:4cca])
        by resomta-po-18v.sys.comcast.net with ESMTPSA
        id WQMohW9p8tBiqWQMqhdF9c; Thu, 30 May 2019 19:05:36 +0000
X-Xfinity-VMeta: sc=-100;st=legit
Date:   Thu, 30 May 2019 12:05:34 -0700
From:   Matthew DeVore <matvore@comcast.net>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Matthew DeVore <matvore@google.com>, jonathantanmy@google.com,
        jrn@google.com, git@vger.kernel.org, dstolee@microsoft.com,
        jeffhost@microsoft.com, jrnieder@gmail.com, pclouds@gmail.com
Subject: Re: [PATCH] list-objects-filter: merge filter data structs
Message-ID: <20190530190534.GB4641@comcast.net>
References: <cover.1558484115.git.matvore@google.com>
 <341bc55d4a3f5438b1523525cf683f96d75e8c3e.1558484115.git.matvore@google.com>
 <20190524004938.GB46998@google.com>
 <20190528184801.GA4556@comcast.net>
 <20190528224010.GA4700@comcast.net>
 <xmqq4l5dyrcu.fsf@gitster-ct.c.googlers.com>
 <e9147614-80f9-4c18-b431-539e2376295d@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9147614-80f9-4c18-b431-539e2376295d@jeffhostetler.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 29, 2019 at 04:57:23PM -0400, Jeff Hostetler wrote:
> I'd also suggest keeping the "oidset omits" inside each of the
> sub-structures, but that's just me.

I just reminded myself that the omits need to be outside of the specialized
sub-structures because the combine filter logic needs to access them in a
type-agnostic manner in order to merge them once the traversal is over.
