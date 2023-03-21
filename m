Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CABC6FD1D
	for <git@archiver.kernel.org>; Tue, 21 Mar 2023 21:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjCUVAG convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 21 Mar 2023 17:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjCUU7s (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2023 16:59:48 -0400
Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9010D3FBBA
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 13:59:36 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 32LKwtWU2371726
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Mar 2023 20:58:55 GMT
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Ridil culous'" <reallyridilculous@gmail.com>,
        <git@vger.kernel.org>
References: <CAEg4PiL+Y8yxCpWaQFUswTj1qegT084w9m0rc14Kf1dEWk5G-g@mail.gmail.com>
In-Reply-To: <CAEg4PiL+Y8yxCpWaQFUswTj1qegT084w9m0rc14Kf1dEWk5G-g@mail.gmail.com>
Subject: RE: Feature Request: Allow to stash push and pop file modification times to avoid rebuilds
Date:   Tue, 21 Mar 2023 16:59:28 -0400
Organization: Nexbridge Inc.
Message-ID: <000a01d95c38$0acfba10$206f2e30$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHYhInJOHR7sbb1jUgcEP+vB0fIYq8HZbqA
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tuesday, March 21, 2023 4:47 PM, Ridil culous wrote:
>"git stash push"
>later followed by
>"git stash pop"
>does restore files but doesn't restore file modification times.
>
>It would be great if there would be an option to opt in for stashing and restoring the
>file modification times because not restoring them potentially triggers rebuilds for
>many IDEs (MSVC in my case) which can be quite expensive for big projects.

IMHO, this request would break a key bit of compatibility git has with build engines that depend on timestamps. The request would cause the IDE to have false negatives during builds because the files that changed are not recognized as changing. A typical approach to do what you are requesting, where make is involved, is to use the --touch option after the stash pop to bring objects up to date - not a great plan in C++ as you can get into signature mismatches that way. Nonetheless, could you not do something like that in MSVC?

--Randall

