Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1016C433B4
	for <git@archiver.kernel.org>; Tue, 11 May 2021 19:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97E4161466
	for <git@archiver.kernel.org>; Tue, 11 May 2021 19:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbhEKTEm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 15:04:42 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:37001 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbhEKTEm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 15:04:42 -0400
X-Originating-IP: 73.26.133.58
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gpanders.com;
        s=gm1; t=1620759814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W3/qeflopevjwtTgK0MtJtuqI5rvEUm7qIs/iO+ceKc=;
        b=JC6tx95L9LT5VYf1zK78L787b3LpvoQngt2iF1OZFhl1Mwz4kt2mtg+jYtUq4kAcVLTUWz
        KyhOI+08J46bdimUPvbYC3rocJu5yF3dGg1Q3BNLQPVb9DWDNfuiCMcT8xKHX6QL3QPvkI
        TtQzKYRLpLTUX6BDyGwpnzzCWFeX242vSoXo3+fpR8HqLA5PpxlvLx4IJXm7Tix/0/+qK8
        FfVoBivxjh2v2gIycH6AThAzDSDFmA/UCCUAFLMx/GHqY9oy68fMb27npjd9mwJVDwwkBj
        zMCZnVDgGtMKNHGR7Uc2rU3zgTIklFkh1WnOKKJA6JOMqstpDr3m3wFSBfCXIg==
Received: from localhost (c-73-26-133-58.hsd1.nm.comcast.net [73.26.133.58])
        (Authenticated sender: greg@gpanders.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 4BC1E1BF206;
        Tue, 11 May 2021 19:03:33 +0000 (UTC)
Date:   Tue, 11 May 2021 13:03:32 -0600
From:   Gregory Anders <greg@gpanders.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] git-send-email: use ! to indicate relative path to
 command
Message-ID: <YJrVBA4HP0HEqRLD@gpanders.com>
References: <20210511183703.9488-1-greg@gpanders.com>
 <YJrTlXzuuMoxeJay@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <YJrTlXzuuMoxeJay@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I also noticed this after some quick testing and just sent a v2 right 
before seeing your reply.

Your (untested) implementation seems much cleaner than mine, and I'm 
happy to give that a try. Question: is it okay that we pass just a raw 
command name to exec instead of a full path? That is, is there any 
reason we need to first find the command in PATH *and then* pass it to 
exec (which is what my v2 implementation does)?
