Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA25C77B6E
	for <git@archiver.kernel.org>; Fri,  7 Apr 2023 22:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbjDGWNl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Apr 2023 18:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjDGWNj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2023 18:13:39 -0400
Received: from forward201a.mail.yandex.net (forward201a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4FE2736
        for <git@vger.kernel.org>; Fri,  7 Apr 2023 15:13:38 -0700 (PDT)
Received: from mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net [IPv6:2a02:6b8:c18:58f:0:640:3768:0])
        by forward201a.mail.yandex.net (Yandex) with ESMTP id 74C59600E4
        for <git@vger.kernel.org>; Sat,  8 Apr 2023 01:13:36 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id YDaGaBaWuuQ0-wPyROIuh;
        Sat, 08 Apr 2023 01:13:36 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1680905616;
        bh=PPdn712lmuJQsyYQC0ApqVlzhJ//G0sw5TzpVZiKiRc=;
        h=Message-ID:Subject:To:From:Date;
        b=Gf3d0y/tgql2t1vNR0QS+1x+wnJlsBJaR+fJl0fN68ucsjcYFo+sR55N9gi4I9Tdx
         gQ/39Bz7bT+vR3UV7rPOl7VYtJVx0893uslyzwP2Az/VX8K5K3SAp7WiU8hWQbiPVn
         G1PWccP2ieyQhQULd4w+OgquzfOuLwbuey+IEVqo=
Authentication-Results: mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Date:   Fri, 7 Apr 2023 18:13:33 -0400
From:   Eugen Konkov <kes-kes@yandex.ru>
Message-ID: <486910214.20230407181333@yandex.ru>
To:     Git Mailing List <git@vger.kernel.org>
Subject: BUG: Inconsistent behavior for `git stash push`
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I found this issue with inconsistent exit codes.

Expected 'false' return code when I trying to stash staged changes when *they does not exists*:
$ git stash push -S && echo "YES"
No staged changes

Unexpected 'true' return code when I trying to stash changes when *they does not exists*:
$ git stash && echo "YES"
No local changes to save
YES

I expect that "YES" here should not be printed.

Could it be possible to return 'false' exit code for second case?
Thank you.

-- 
Best regards,
Eugen Konkov

