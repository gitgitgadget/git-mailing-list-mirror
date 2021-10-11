Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6AE9C433F5
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 04:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CD8D603E5
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 04:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233193AbhJKEMz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Oct 2021 00:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbhJKEMy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Oct 2021 00:12:54 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DD2C061570
        for <git@vger.kernel.org>; Sun, 10 Oct 2021 21:10:54 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id z15so10247898qvj.7
        for <git@vger.kernel.org>; Sun, 10 Oct 2021 21:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xJsvffHFGqL7qFDZC+FmJag229OGvR6JVvvLa+KOwZo=;
        b=kumcgafIMBi73qMVowCLGO3Ut66E+PEzdaq5vMjtmPu4Sr9/HNELUwR72FoH9PtVvm
         ouAaGAUsLZTZQ4o1r3ESZr9JYsynvquTWDBrbyHkSXzYmEF2Nkqn6k9LvqsRSPy220PX
         jKDbY1LjHHnsXbVQNtXsguRI+gyNM/CKT8mg2EdsCZYKUrP8BpPYCjyoRijUzY5m522Q
         RFnf8skMZx6d++WJ01QMZ2WpgppYOjm0GZ1LHMeTcTZuG4Z1D3byePZxUc1ISkriFvsT
         RvuG08fOTFkQRJZhKaFgOVj76FC3N2tS6zbDJ9yAp+MQ+UKqCxeQl0P9lsoYby9S2xnB
         f7Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xJsvffHFGqL7qFDZC+FmJag229OGvR6JVvvLa+KOwZo=;
        b=HnYeu0TzndMxVQfUhhVG2BQPgpXYc3Gm1uakEvqsYsvLzpUMLVqbJAeP2E3jkZX+IR
         36dy9nohUsEHt2uxOEjZZXvNko7JFcmGqTLy77CllH0gYnDZF8i+JfTw15q+qQeFtmqm
         0WZ/rxwCOFvAvx+HfjXKzFChExKN5SN4TdRTJoTHElFKgF2ihVV9Ip5sjfshVMykPhp/
         mFTqUoiuA3xZToy3B/i3L5cHuEDg5cVCMY3Z3w/p7WdmYT+5HiCofYHy2vVN4qRPvUJG
         ilsn0OTqxY6BhLcfxzjK73Y2yEDnk0A1U9JZh6Csf5pVx0Iv+tSPDvTXl7J2pVPWDQwn
         muLw==
X-Gm-Message-State: AOAM532Mm11+76LebOshQJpC8Qo0qEMngL4YshtPXdUB6bPxB1YEygGa
        Y0PhYDaLKU2JXxKLs70iKWBvkgIeyTc=
X-Google-Smtp-Source: ABdhPJw3oKk/gjTqjR6To0Cz4l8C7gj3yaDqlJcDi8vgg6hwgmyxHgl9Z2mtBtUDA7n5oNEIANg6uw==
X-Received: by 2002:a0c:90c8:: with SMTP id p66mr22243053qvp.55.1633925454138;
        Sun, 10 Oct 2021 21:10:54 -0700 (PDT)
Received: from valhalla.. (cpee03f49946310-cm589630b5b38a.cpe.net.cable.rogers.com. [99.250.23.181])
        by smtp.gmail.com with ESMTPSA id 74sm3683814qke.109.2021.10.10.21.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Oct 2021 21:10:53 -0700 (PDT)
From:   Thiago Perrotta <tbperrotta@gmail.com>
To:     carenas@gmail.com, gitster@pobox.com, bagasdotme@gmail.com,
        avarab@gmail.com
Cc:     Thiago Perrotta <tbperrotta@gmail.com>, git@vger.kernel.org
Subject: [PATCH v7 0/3] send-email: shell completion improvements
Date:   Mon, 11 Oct 2021 00:10:30 -0400
Message-Id: <20211011041033.20004-1-tbperrotta@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <YWE41xTLhBFWqUFl@carlos-mbp.lan>
References: <YWE41xTLhBFWqUFl@carlos-mbp.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Differences from V6:

2/3: Addresses all of Carlos's comments:
  - make indentation consistent (tabs): note that there's a giant diff
    for the largest GetOptions now, it adds a bit of noise to the patch
  - do not reuse the options variable, for improved readability.

2/3: One extra improvement:
  - deduplicate send-email and format-patch common options (for example,
    now --from appears only once)

3/3:
  - updated git-send-email.perl USAGE to be consistent with
    git-send-email(1)
  - still haven't touched anything else, waiting on Carlos's RFC patch
    ongoing discussion to settle.

Thiago Perrotta (3):
  send-email: terminate --git-completion-helper with LF
  send-email: programmatically generate bash completions
  send-email docs: add format-patch options

 Documentation/git-send-email.txt       |   6 +-
 contrib/completion/git-completion.bash |  11 +-
 git-send-email.perl                    | 156 ++++++++++++++-----------
 t/t9902-completion.sh                  |   3 +
 4 files changed, 97 insertions(+), 79 deletions(-)

-- 
2.33.0

