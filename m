Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE3FDEB64DD
	for <git@archiver.kernel.org>; Sun, 16 Jul 2023 23:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbjGPXGn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Jul 2023 19:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjGPXGl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jul 2023 19:06:41 -0400
Received: from mail.nicholasjohnson.ch (mail.nicholasjohnson.ch [93.95.231.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CD7E45
        for <git@vger.kernel.org>; Sun, 16 Jul 2023 16:06:40 -0700 (PDT)
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nicholasjohnson.ch;
        s=dkim1; t=1689548798;
        bh=SlfETutjzRhZAk8A03YKAEXquaaOrlOzr8EHA+6rvTI=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=gndq7LGaRl3h5MChYW3TklLh7UOkobFxPozkAn13jNkX4D18ZwzVYLFcHXpuThPfE
         0Rlr+zrsiS37uoVsjG7fXG2yWHGCHQIx+mkh5deTet5IILXdABTREVE3yukbnjNp0b
         I9GceoLVnndSDS1Orc/V0nbqeY6AGuyb6u6ccwhFkt4lAW2C8g/vCN8NYzcGoDxCfs
         fYEq83CQQ/W5sxMBESxsbANmGCFEE3G+Eq17htmZMj2JoV8Yr0pyZ8ipi6Sb6EGJV0
         kfEjEezWkuVB+iO1YK6tSkvconCV5kX0cZVA4BQ2XYXH8YADXMPXFWygv+AWZPOD0X
         13WnfALgPisGQ==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 16 Jul 2023 23:07:06 +0000
Message-Id: <CU3Z2NYP6BGG.1PQ6S5AF60XX6@anonymous>
Cc:     <git@vger.kernel.org>
Subject: Re: Git Privacy
From:   "nick" <nick@nicholasjohnson.ch>
To:     "Junio C Hamano" <gitster@pobox.com>
References: <CTZ9RD9RQ5UO.3OIJX50PKMIR0@anonymous>
 <xmqqlefjpwif.fsf@gitster.g> <CU1SAE4WGP3X.3R7TTIWFSHGDI@anonymous>
 <xmqqbkgeqw6n.fsf@gitster.g> <CU2GQHQV5GD3.CL67078EF4OO@anonymous>
In-Reply-To: <CU2GQHQV5GD3.CL67078EF4OO@anonymous>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

nick wrote:
> The time zones reveal private information about developers and they
> don't even serve a use case, as far as I'm aware. A backwards-compatible
> way to solve this leak would be to convert timestamps to UTC by default
> and have a Git config option to revert back to the current behavior.

Come to think of it, even if timezones were converted to UTC by default,
time of day would still leak information about a user's likely timezone.

So based on that and keeping in mind Git's desire for strong
backwards-compatibility, I'm amending my proposal to just a standalone
Git option which would allow for forging timestamp and timezone
information, with timestamp information being forgeable to varying
degrees of granularity.

A new Git option is appropriate because Git doesn't already have
features which make this possible. So it would be necessary to implement
a new option anyways.
