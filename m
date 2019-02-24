Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B282420248
	for <e@80x24.org>; Sun, 24 Feb 2019 21:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbfBXVHq (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Feb 2019 16:07:46 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55241 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfBXVHq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Feb 2019 16:07:46 -0500
Received: by mail-wm1-f65.google.com with SMTP id a62so6263840wmh.4
        for <git@vger.kernel.org>; Sun, 24 Feb 2019 13:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DfWDFsOX35qp3JsXIEFdn4YlW+WkpQjOf1/kPpAKd1U=;
        b=eYqAUecf3JEDz34XkaK+58eq5/ZO+ZdWdKX0T37sWOqSw756LeV1R2WOl1OKImOva0
         SZ4CxgMfVfhelWT4xOAd2N50N8K2ewt5x1oeZcAir7fpsDMliwJ4FwIsaQ/vhUGY76zO
         Rv4xIYspf9c8MK3si+BRqjW9E+553lU1qoxyq1mtnVt04eG1tCZvIzSnpcqGiIOGuTE4
         DorX5ZMKmLxii0c0sq6IVCGYX7Wh+NJTZzkdzbFgLbnyW7cQLFWP70kLDzLD/tvvVU7Q
         QXmtt5zgHDU2yIK4rNx8IKdWy9CgREBmUEt4RpvihHqjiitB8z0W5GeW0uoEI9otfNfO
         WZfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DfWDFsOX35qp3JsXIEFdn4YlW+WkpQjOf1/kPpAKd1U=;
        b=WhKMF94s1upXaJRU/+ryiSd4guc3qany9NmG34VSuVvwtyplpIAEMBnlB75q4Q+C6I
         zeHpmVOiHQzqeKY40RJhkHfRglLMxXEUj3dgsizsv7sxyz1w2QhF4hkOryXgB/JJoVbM
         l7YxNqQeE6jDDTwvBswmQ+AYgDVTkS6JHPq6GstQ2bdjPkSRZi6Q+84HdtnNraJMeBgd
         uWpcz+fdI4rV5tsGChD9Lbkog4Z5Z2bxKYm4C49sy0le2rk77NKVlFYS1GGjDM9thY/v
         M9Id+x1llrXbZ72Q/mg5GUJOJc+TW0Kb42f2lY3IE3AWt2dSmLeZHJZMYqpyfeccPdm/
         6zLA==
X-Gm-Message-State: AHQUAuZYOD7ubX8ysUV+OJew/B3+cZpsjeMVmipcZt57H7qtXg6+18qO
        kt3gTtB3CiDPcKmhLEBY613eGe7c
X-Google-Smtp-Source: AHgI3IbgKHgCxxObMABtaFxWOIZzFbbrFI/hOhf5nkrC6Df3TeocX7kozJkiZOg+ejvBkgeRNlUE9Q==
X-Received: by 2002:a1c:cf82:: with SMTP id f124mr8912706wmg.95.1551042464398;
        Sun, 24 Feb 2019 13:07:44 -0800 (PST)
Received: from localhost ([95.149.189.205])
        by smtp.gmail.com with ESMTPSA id z129sm12684254wmc.33.2019.02.24.13.07.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Feb 2019 13:07:43 -0800 (PST)
Date:   Sun, 24 Feb 2019 21:07:42 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [GSoC][PATCH 0/3] clone: convert explicit dir traversal to
 dir-iterator
Message-ID: <20190224210742.GB27711@hank.intra.tgummerer.com>
References: <20190223190309.6728-1-matheus.bernardino@usp.br>
 <20190223215906.GR6085@hank.intra.tgummerer.com>
 <CAHd-oW5zQQkJ7WCcKpz0V7btNAbwuwCn0fvkcvAmXE1U9BhMxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHd-oW5zQQkJ7WCcKpz0V7btNAbwuwCn0fvkcvAmXE1U9BhMxA@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/24, Matheus Tavares Bernardino wrote:
> I am part of a FLOSS group here at USP called FLUSP
> (https://flusp.ime.usp.br/), and I plan to write some posts on our
> website about what I am learning in the git community so that other
> people in the group can have as a base if they decide to start
> contributing to git too. So all this tips and explanations are of
> great value, not only for me but for others here! Thanks a lot.

Great to hear!  Please do post links to those posts on the mailing
list as well, I'm interested in reading them.
