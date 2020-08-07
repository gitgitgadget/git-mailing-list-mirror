Return-Path: <SRS0=eX0j=BR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1959DC433DF
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 03:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E15562177B
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 03:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ameretat.dev header.i=@ameretat.dev header.b="jHmYyIsG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgHGDua (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 23:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbgHGDu3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 23:50:29 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670A6C061574
        for <git@vger.kernel.org>; Thu,  6 Aug 2020 20:50:28 -0700 (PDT)
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ameretat.dev;
        s=default; t=1596772226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
        bh=jcGMQgzd3Wnk7MlRTQ0sPlCADHy6fR1FIJS4eNydueQ=;
        b=jHmYyIsGK7Y38vCDSmEk8nGBn8FsQEkNJ54Y7TXWohEmKdeOdUJkDw8ejmqto0k+osXfYd
        5CvEBN1aBg8doCS2+5CLeWfr3n85Bc6IhJQUeILtXPS2Pt3TgpQLYhoRFFhwsdovDU2TTK
        x7U3FGhxUE15s365YmHuW4SplsG/PP4=
Content-Type: text/plain; charset=UTF-8
Cc:     <git@vger.kernel.org>
Subject: Re: [PATCH v4 3/3] t4140: test apply with i-t-a paths
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Raymond E. Pasco" <ray@ameretat.dev>
To:     "Junio C Hamano" <gitster@pobox.com>
Date:   Thu, 06 Aug 2020 23:44:11 -0400
Message-Id: <C4QGDPQHMV1C.2LUL2YNOHAYTW@ziyou.local>
In-Reply-To: <xmqqeeojjxf0.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu Aug 6, 2020 at 5:07 PM EDT, Junio C Hamano wrote:
> We can delete an I-T-A entry. I wonder if
>
> git apply --cached -R creation-patch
>
> also serves as a way to remove the path? It should succeed, right?

It fails to apply because the inverse patch to creation-patch removes
lines, while the i-t-a entry has no lines. (Looking at it from the other
angle, deletion-patch doesn't delete lines, because there are none.)

(Of course, -R creation-patch after creation-patch removes the path
cleanly.)
