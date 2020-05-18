Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0733C433E0
	for <git@archiver.kernel.org>; Mon, 18 May 2020 23:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78D1620829
	for <git@archiver.kernel.org>; Mon, 18 May 2020 23:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avLDMNu4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbgERXGu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 19:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbgERXGt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 19:06:49 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9EBC061A0C
        for <git@vger.kernel.org>; Mon, 18 May 2020 16:06:49 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id s69so500331pjb.4
        for <git@vger.kernel.org>; Mon, 18 May 2020 16:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=PLPD4ulTyuCzZjIz4gczxlqZ1ZGMe9VgEpVSzRr3or8=;
        b=avLDMNu4XbnvuoC4nSk8gWlRzvkI2Oln8wPH9Gq70xLOcjDYWhj6RXhjRbksJsTKJX
         B0HffeeQZCDwm3dyLVAiuwc3N0x7l1hEGa9h2Ka07gmPuzBu9bQd7+2BzSnx4K40/kDc
         vGfxSlBttL5q50GRfttmhkUorDN4JAfZSpilsY3LCIdAN92Kxm9KFsa3miUZzZXkGE6V
         ZhqImaCMEMZ62vYKqbSZLlLQYLcMciYzPWmlJrPSucno7xaV9oaHYxexXlOr6FLr8pDJ
         TyxXxepWny+xQ/0uwmAmHbVLD1kJuxooEZN7B9WAeMJEqgZjQHRNGOCkgZmjTpif06ei
         Qv6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PLPD4ulTyuCzZjIz4gczxlqZ1ZGMe9VgEpVSzRr3or8=;
        b=sTMXfxJENzK03IE2d9sV5LV1fBJlKfXkZ/qkjfrhbqvkgpgJDUPkqimJvIwZdKPBd+
         60QYq8iDmrVnKkvz+Zz3nAqbrw+JAkCFs7G6BtWybIQNoNbdV/dGj5l2wlDdWpYLCqod
         32CcxbzO34E1yYf7ElybAOjKAJBtE0jGwZZVTJJ95HR1Zn7S2bRblIoVzMf0Kq7i0PuR
         f8DWmm5gB6q5r9nCN+2gYOPygqgM5+EXkpAqB79oWYtIGBf/+Ml2bqgRC015e2reOa0W
         S1BqyRMzNhYnZkfU1Nn4pUyGvOFFBSWH6D9eNlz2U5ZjVoqNYOe/9Pd8x7ZjLO2mZJ7E
         MGtg==
X-Gm-Message-State: AOAM531ucLQbX7DjQwtDesX4IBmGm15ncFym/+TIHilN+Yct8J69yTUc
        Ncqg2uSsIDw4XJ3VAv2lv1KeIjEs
X-Google-Smtp-Source: ABdhPJxXjMbULXBHV2neNiWzWJPdONCy6NCs5lGjrVDtJFxsocFOu+FBvE1EMiWLiYXTL8hi+8RWOw==
X-Received: by 2002:a17:90a:8404:: with SMTP id j4mr1777401pjn.12.1589843209058;
        Mon, 18 May 2020 16:06:49 -0700 (PDT)
Received: from Carlos-MBP (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id l33sm483371pje.22.2020.05.18.16.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 16:06:48 -0700 (PDT)
Date:   Mon, 18 May 2020 16:06:46 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 5/7] git-credential.txt: use list continuation
Message-ID: <20200518230646.GA20332@Carlos-MBP>
References: <cover.1589739920.git.martin.agren@gmail.com>
 <e60236e18f73dcabce1a20ec17aee57fd54b11c9.1589739920.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e60236e18f73dcabce1a20ec17aee57fd54b11c9.1589739920.git.martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reviewed-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>

Thanks,

Carlo
