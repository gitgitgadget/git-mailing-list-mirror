Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F9CC10DCE
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 15:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67181206BE
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 15:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="Gcdx0uXm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgCLPGr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 11:06:47 -0400
Received: from forward103o.mail.yandex.net ([37.140.190.177]:58648 "EHLO
        forward103o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727133AbgCLPGr (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 12 Mar 2020 11:06:47 -0400
Received: from mxback16o.mail.yandex.net (mxback16o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::67])
        by forward103o.mail.yandex.net (Yandex) with ESMTP id 091735F813C8
        for <git@vger.kernel.org>; Thu, 12 Mar 2020 18:06:45 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback16o.mail.yandex.net (mxback/Yandex) with ESMTP id FYIsNNRTV5-6ijel5GI;
        Thu, 12 Mar 2020 18:06:44 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1584025604;
        bh=4W6tqzAHGKq7kb95wUnpZokhDqGftghzT9WDZelm8iU=;
        h=Message-Id:Date:Subject:To:From;
        b=Gcdx0uXmneCgqoDiT4fLgVEYsjvbiX3UZ6Rc3JTs+OZX/tfDwhsGGOJK/o6H4SLF1
         XsAps5NDEMQYLoFF0X8bdbLCdtIgOfLzupz5FLYel1aWLapaavvR7lzAgrL2gsafQ7
         zteukCVxuDxABfS01CrAYD1D37BAnb70n+qwOZvI=
Authentication-Results: mxback16o.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by iva1-398527a32f9a.qloud-c.yandex.net with HTTP;
        Thu, 12 Mar 2020 18:06:44 +0300
From:   Konstantin Tokarev <annulen@yandex.ru>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [Feature request] "Hooks" for git log
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Thu, 12 Mar 2020 18:06:44 +0300
Message-Id: <558831584024173@sas1-438a02fc058e.qloud-c.yandex.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

While it's possible to filter commits in `git log` by their contents with
--grep and -S options, it's not always possible for formulate desirable
filter in their terms.

I think it would be very useful if git log provided new option named e.g.
--hook or --script, which would take script path as an argument.
git log would follow it's normal way of operation, applying other filtering
options it was given, however intstead of printing info on commit that
matches filters, it invokes script with commit hash as an argument.
Script can do whatever it needs with hash, including any git operations,
can print commit info to log if needed, or print something else, or keep
silence. If script returns non-zero, parent git log command terminates,
otherwise it continues.

-- 
Regards,
Konstantin


