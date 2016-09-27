Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E39DB20986
	for <e@80x24.org>; Tue, 27 Sep 2016 15:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933624AbcI0PV7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 11:21:59 -0400
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:41118 "EHLO
        homiemail-a15.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752183AbcI0PV6 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 27 Sep 2016 11:21:58 -0400
Received: from homiemail-a15.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a15.g.dreamhost.com (Postfix) with ESMTP id 90D9A76C06F;
        Tue, 27 Sep 2016 08:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=message-id
        :subject:from:to:cc:date:in-reply-to:references:content-type
        :mime-version:content-transfer-encoding; s=novalis.org; bh=mNMZT
        9PwCQsP0QbIqMZNTAP8M0U=; b=HmxTejIol543VDXeJoqlz5Wgl68Zn7LfoAqxw
        3QZ2B7PWC3x9lLBi2UoUD22Tq2PqrTUCS1HCoErT/oycs8TcEGA99SDDxrDU4gQy
        hUto/Vue10KT4rQC6iVlxFgiHsA8Z/zXZAvE+l0Du1nB5n/Po7BGTVpBqYymXZ/M
        zNlxbo=
Received: from [172.31.11.72] (gzac10-107-1.nje.twosigma.com [208.77.214.155])
        (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by homiemail-a15.g.dreamhost.com (Postfix) with ESMTPSA id 1CD8176C06B;
        Tue, 27 Sep 2016 08:21:57 -0700 (PDT)
Message-ID: <1474989716.26902.9.camel@frank>
Subject: Re: [PATCH 1/2] tree-walk: be more specific about corrupt tree
 errors
From:   David Turner <novalis@novalis.org>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, mhagger@alum.mit.edu,
        David Turner <dturner@twosigma.com>
Date:   Tue, 27 Sep 2016 11:21:56 -0400
In-Reply-To: <20160927051453.yuvrnao5ldjpzhcj@sigill.intra.peff.net>
References: <1474918365-10937-1-git-send-email-novalis@novalis.org>
         <1474918365-10937-2-git-send-email-novalis@novalis.org>
         <20160927051453.yuvrnao5ldjpzhcj@sigill.intra.peff.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2016-09-27 at 01:14 -0400, Jeff King wrote:
> I also wonder if $bin_sha1 should actually be more like:
> 
>   hex_sha1=$(echo foo | git hash-object --stdin -w)
>   bin_sha1=$(echo $hex_sha1 | perl -ne 'printf "\\%3o", ord for /./g')
> 
> so that it's a real sha1 (or maybe it is in your original, from an
> object that happens to be in the repo; it's hard to tell). I wouldn't
> expect the code to actually get to the point of looking at the sha1, but
> it's perhaps a more realistic test.

I'm going to do this for this patch, but for the second patch, I don't
think it matters, and it's a bit simpler to avoid it.  I guess it's
probably better to test both ways anyway.

