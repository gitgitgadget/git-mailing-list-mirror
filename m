Return-Path: <SRS0=B37d=3G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29145C33CB3
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 22:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2F9520748
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 22:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=skyboxlabs-com.20150623.gappssmtp.com header.i=@skyboxlabs-com.20150623.gappssmtp.com header.b="Xi1mMmXO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729340AbgAQWAw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jan 2020 17:00:52 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34829 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729080AbgAQWAw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jan 2020 17:00:52 -0500
Received: by mail-lf1-f66.google.com with SMTP id 15so19495234lfr.2
        for <git@vger.kernel.org>; Fri, 17 Jan 2020 14:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skyboxlabs-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=mzXXQhwcHpX6q6e1mgWZMRZNIlFWo85F22BmkD1cn/o=;
        b=Xi1mMmXO/e/iNY7WPBeNoLiqX6WNRv05aFZXJH+c+Dscou8dgnj+jouiLbRfqqggT3
         dSusey1VAVjVt9wXLuKERGozwUtbH6ms8CSPgCHcx+5qoVn3F2zjs8AsYl2f1fSZA322
         uvd75MbwgmHisRf/Wnwa2CtYDL/xn5c8QoIPfpEEdUm0GxATE6NwpLr7kRpA03xnPENL
         UAVBUUYdfcH1zX1UlZ2+cF09xbLAZ7XMYsbvq3apO+nf4u8lMT+iQxOB/iUnU7nI6gNk
         DcxQhdl5W8ATkYntUfnvE69s6LDqPjqn9LpeWkmvDRI74y+z4o8dIfzsnGLHpdjzP0DN
         VaWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=mzXXQhwcHpX6q6e1mgWZMRZNIlFWo85F22BmkD1cn/o=;
        b=cwks/fMZKN2qlN7O+gaB2tZz4UviL2j4lSRsv/XaN3PK4rV74n1PgnXu00FPqohGWN
         SAnXaIH9wfV+rDdgJXp4pHUyX2krxhzoFV3ldojo+Y8LEiL8kZH6GtiTKmAf26+EQhH2
         PXOKZlBOA2D/afU27t2rhU0wpF5wpKaceVxa50ABkQg6rWn3DVEvol1j6pTa3yX21V9y
         aCB0Qtt/JyVafMUUGnzEV9hElmNmYjgyCPRW+0t9VuV4gWILSzVABNpQOnDPrP4uAZXM
         Caw7sBRleSG0oPamCCMX/kRdbp7M6N6wtJA9sIKmvEH/6KXhre+2unfyb8ZBpf3yCXp5
         NAlg==
X-Gm-Message-State: APjAAAXBozn/PVz4gRgyX5mmNddgE3Deq8sEIHSJqycCzs26UBH5+jBu
        9ZrDw7qIx7s6xFB/JP+sql+7TzolzlzkN95S8MEscK/0yfc=
X-Google-Smtp-Source: APXvYqyAFmckuHeKTTkzgwBC30zZ9NEKhNiumwbmyjMJcyqSKK7zU2PMUf81q6+xObU5oXDBhqGBwi4UDIBOiW9ZvjA=
X-Received: by 2002:a19:c697:: with SMTP id w145mr6763579lff.54.1579298450779;
 Fri, 17 Jan 2020 14:00:50 -0800 (PST)
MIME-Version: 1.0
References: <20191213235247.23660-1-yang.zhao@skyboxlabs.com> <20191213235247.23660-2-yang.zhao@skyboxlabs.com>
In-Reply-To: <20191213235247.23660-2-yang.zhao@skyboxlabs.com>
From:   Yang Zhao <yang.zhao@skyboxlabs.com>
Date:   Fri, 17 Jan 2020 14:00:40 -0800
Message-ID: <CABvFv3LH2tYbobn8xBykyC43FB+z16FFOSAX1XjTLFZ2BUqZ1Q@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] git-p4: python3 compatibility
To:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 13, 2019 at 3:53 PM Yang Zhao <yang.zhao@skyboxlabs.com> wrote:
> This patchset adds python3 compatibility to git-p4.

Ping?
