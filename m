Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE57C433E1
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 00:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8313D20702
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 00:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b="xe9Kdyh9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgHUA5d (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Aug 2020 20:57:33 -0400
Received: from out0.migadu.com ([94.23.1.103]:31376 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbgHUA5a (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Aug 2020 20:57:30 -0400
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
        s=default; t=1597971448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=mOo7+J8B+98N/2swMjjqxuWqzJYQODxqUHTDKt1J0UA=;
        b=xe9Kdyh9/nXRo9Bj8mIpZZoXUkBdnw90kZPQT2YOl4DkaLO6Uhq8gMLaniDgP3/Hb48Me+
        PmsrKj5YwHHfQCRFldI0vxJiWXkkvqnzdlGZDOOyYwwVuJ12bvabI9d+8qF/DaLt2ETZl8
        Oz3ynmV1dQB2QUcAsI+akem9e747jwc=
Content-Type: text/plain; charset=UTF-8
Subject: Re: [PATCH v2] git-apply.txt: update descriptions of --cached,
 --index
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Raymond E. Pasco" <ray@ameretat.dev>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     <git@vger.kernel.org>, "Phillip Wood" <phillip.wood@dunelm.org.uk>
Date:   Thu, 20 Aug 2020 20:26:38 -0400
Message-Id: <C528Y3DXYRMW.22FBYW4FHMALJ@ziyou.local>
In-Reply-To: <xmqq4kowc1ls.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu Aug 20, 2020 at 7:57 PM EDT, Junio C Hamano wrote:
> I do not see why we want to stress the last part after ", even if".
> The safety mechanism insists on the working tree file and the index
> entry to be identical, and the location where in the file the
> difference is, is irrelevant, whether it is outside the area the
> incoming patch touches, or it overlaps.

It's because this is the confusing part of the option - it's easy to
grasp "apply the patch to both the working copy and the index", but
that's not exactly what the option does, it applies only in the case of
identical preimages (and therefore, identical postimages). If you do
want to apply it to both the working copy and the index, which aren't
identical (e.g., you're a heavy worktree mangler and "add -p" user, like
me), this points you towards invoking it twice, once with no option and
once with "--cached".
