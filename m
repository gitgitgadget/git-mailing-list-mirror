Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E42C433E6
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 18:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 321F264F0F
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 18:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbhCOSOt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 14:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbhCOSOq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 14:14:46 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9013EC06174A
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 11:14:41 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cmpwn.com; s=key1;
        t=1615832073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RAsR1HYaA0hxEiaKe3tREWQZ3JmxWXSnjmF0RpOXdlk=;
        b=CBCmUdut3YNTxkxjLezLLbu1qi2Zu4eF8eFSvvXwvqEOsp5OEgOQeQgP3WOrTLlN853soT
        96aO9bme1Yty6/eEg5kdTZhqGIU3O00r73b967Qtb/OQ3uBx3vK5kWqJsV+ZnANLZmdlQX
        zAqAg7z8lZAqZoYi60wJ/jr2AlOYPn+2BZ7UZGl/pA8M/9DEpbVWv7ViAMDR5LdOdl3thk
        YPytm8KdQR2+g4cgmls6LiTUeuJ/e4+PjmvKocXPEOOvFgNemBF9dGpqWif2ct4z4DOEET
        I4QEtS7Z2H4Kwu8tNnHyOEqibbNb/3Lqz7Q9dtZpQLr6LOETOewP3Sp+Eouepg==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 15 Mar 2021 14:14:31 -0400
Message-Id: <C9Y4NXXX6HRI.1IROIK8ZXK4S2@taiga>
Subject: Re: Regarding the depreciation of ssh+git/git+ssh protocols
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Drew DeVault" <sir@cmpwn.com>
To:     "Jonathan Nieder" <jrnieder@gmail.com>
Cc:     <git@vger.kernel.org>
References: <C9Y2DPYH4XO1.3KFD8LT770P2@taiga> <YE+ftT2WaKDzc+45@google.com>
In-Reply-To: <YE+ftT2WaKDzc+45@google.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: sir@cmpwn.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon Mar 15, 2021 at 1:56 PM EDT, Jonathan Nieder wrote:
> The original idea of URI schemes like svn+https is that we can treat
> these version control URLs as part of the general category of uniform
> resource identifiers --- in other words, you might be able to type
> them in a browser's URL bar, browse the content of a repository, use
> an <img> tag to point to a file within a version control repository,
> and so on.

That was indeed the original idea, but I think it's fair to assume that
it's evolved well beyond this. There are many schemes in common use
which don't meet this criteria, such as mailto:, magnet:, bitcoin:,
postgresql:, and so on. None of these examples make productive use of
all of the URI, such as your fragment example, but they still make
productive use of parts of the URI.

To my mind, the contemporary purpose of a URI is to:

1. Identify a resource
2. Identify the protocol used to access it
3. Store domain-specific information that an implementation of that
   protocol can use to accomplish something

> The missing piece is an HTTP header to unambiguously mark that URL as
> being usable by Git. I'm not aware of a standard way to do that; e.g.
> golang's "go get" tool[*] uses a custom 'meta name=3D"go-import"' HTML
> element.

I don't agree that this is the case. It would be much better to be able
to identify a URL as being useful for git without having to perform a
network request to find out.

A standard approach to the go-import kind of deal is also a meritous
idea, but a separate matter - and one I'm also involved in trying to
address!
