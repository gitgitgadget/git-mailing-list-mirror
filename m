Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BD1C1F463
	for <e@80x24.org>; Thu, 12 Sep 2019 19:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbfILTn4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Sep 2019 15:43:56 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44296 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbfILTn4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Sep 2019 15:43:56 -0400
Received: by mail-pg1-f193.google.com with SMTP id i18so13983090pgl.11
        for <git@vger.kernel.org>; Thu, 12 Sep 2019 12:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=h55yqxooSoAkhu1yy8ojqqgbUrxDuePS1Lo9sXqub7A=;
        b=ahrCDS4ddr+3lVcpxFikvb9qlzTdzhHfpHkH85eR7kW4NFFuUHRnduFVUBnnoZtSRb
         AcucEEV8ua9qTjRHf3wgmYx2ILC9QH+RC2Z8y00kytEdZmFSz5iq4UIKNrOUoyG/dCOT
         Z0CaKSFpvO7XKkoqiEE0Bxd5Np9TBk4CDcfWwE7Nx4t+dYNVPnejDnhZ9LR6raBazjmz
         /TsrEqPx5IBQ3opy/uqFcTAdCak7RRk5Oq19ZTjpF0ELnsUR+41wEhkv56iG16wUdNiG
         cQ5Nm0TibhHcdsAm5UOcHzaZF+kZHL3ZICHRsKhC3H3Eeo8JavwqRj0LpKPIeIU3XfhT
         lF0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=h55yqxooSoAkhu1yy8ojqqgbUrxDuePS1Lo9sXqub7A=;
        b=ZsFZpt7IRnEd8U1GWN9IusZEyZt+Zws1tQmUdjofdhCAmzPCx4Ul9v+yyrHyG3+T3N
         CrVmckJYvSbF6ECTZepAV4eSQXOe6OvbSUcVXrSjuXNm7yVO9HcZeiFam5FbJJrU5dMZ
         3Imjfz/DlF0odYHZ8DrZw5pBOxdwAsLUepuvzgRaiOjm5q5R1auAG0RTqtDchsAUEHov
         ld7jfpL6ofkTRIy9vXbE5npwljX8m0HB3lvezLObRb+qXzr65SDbvEjagvbo+KxmQb/9
         SUqjCo+htrAu3Rf9m4+JEQXSTTBA+UyfsX+iqGHE8pqMf5b+GiEwqtH9fado56VGAIwk
         IVXA==
X-Gm-Message-State: APjAAAVunhOHriX7AKyTWepXAsCPSAHQrkNfNB/ngAC/O3PBSmUuNPqj
        IQ/StIC0xNNY6B5lVfn40FsXsOjhyy0=
X-Google-Smtp-Source: APXvYqwcKA/j+QhSSU8DoFx+FxdRHD3NHF1eC7Js55jJphRia7auJYceonsH0eOycvr2JJCArGmriw==
X-Received: by 2002:a17:90a:1150:: with SMTP id d16mr444937pje.2.1568317434967;
        Thu, 12 Sep 2019 12:43:54 -0700 (PDT)
Received: from dentonliu-ltm.internal.salesforce.com ([204.14.239.55])
        by smtp.gmail.com with ESMTPSA id h4sm28396023pfg.159.2019.09.12.12.43.53
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Sep 2019 12:43:54 -0700 (PDT)
Date:   Thu, 12 Sep 2019 12:43:52 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 0/2] completion: teach rebase and archive to use
 __gitcomp_builtin
Message-ID: <cover.1568317093.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, the completion function for rebase and archive don't take
advantage of __gitcomp_builtin(). Teach them to use it so that future
changes to options will automatically be included by the completion
script with no extra work.

I discovered rebase wasn't using it and fixed that and I started looking
for other low-hanging fruit to fix. I deliberately left stuff like diff
and log alone since that's a whole Pandora's box that I don't really
want to open right now.


Denton Liu (2):
  completion: teach rebase to use __gitcomp_builtin
  completion: teach archive to use __gitcomp_builtin

 contrib/completion/git-completion.bash | 27 ++++++++------------------
 1 file changed, 8 insertions(+), 19 deletions(-)

-- 
2.23.0.37.g745f681289

