Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E940C2037C
	for <e@80x24.org>; Mon, 13 Mar 2017 22:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753722AbdCMW5r (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 18:57:47 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:35113 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753219AbdCMW5q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 18:57:46 -0400
Received: by mail-pg0-f46.google.com with SMTP id b129so72086006pgc.2
        for <git@vger.kernel.org>; Mon, 13 Mar 2017 15:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cXHJaVLWYPabXEZtfeTYrhjoujCTEMTuqyB4nlIP6pI=;
        b=Qwzj1iMBPSn0Y38YKDQCT2mdDGwr3TG1Dg+maciWvQEFbgZzvWWKUujivsGsFN/SNz
         7mBg4aLwRd3ZXBFtTy6o3qdykTcr7whc7xntXZu67d/YjN0f+NdoAf1GVyX5DdyM5VuI
         Jkh9GgBZgf+2pHNGS6Owdq8Fp0GmoS/vJ8o54CqNiK9K09bDoolfgN6dFvbY323jIkL/
         ic42qm791PAZajbLDepQtXmFmmuHKrwLFApvENBKjsmmIo+VRkkuD0gdeccoNziQTPOT
         IBGwXot8yTwEa/KrPfLc6eZ/5EHcCuWWi4WxXPJwvFeOB/AnQdk/hYzBVz+tQyH/PMn/
         T9VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cXHJaVLWYPabXEZtfeTYrhjoujCTEMTuqyB4nlIP6pI=;
        b=MWJEoZp6VWj7nDevRu7nRXWzffzV+1IiUIYn5ThV5l2ZUskjATCbQ0kFsFslpJbd9s
         pokphxz5vbQHlL6M6bW8ultH1hG/4t+PNZiAZqcKJCFdKqoVNsi++tYrnIhgQNoLc79a
         CeoD30Zov3SLgwLaViBzliNGRGMDWEx1VhiufNRKsbHOUt7EkuklUt8pIvPSrU1txnQd
         JmdHwiDvCDNcEKgjKlMP002NfiGsOKMjyhJ8NaqT7rjBQ7cmZJb2DRO8XSlbmyMc0FGY
         uy5LLvFTuOhOWspCWOWTsi/QyVc86NVi3NCPHUJ6XiTGt4EgZ830N3vW4UgsCcwfqZk+
         O/xw==
X-Gm-Message-State: AMke39mMMbBvDoB94zQ190kjEVs2WmhyP0vlYeKrqHunEUj3y0cOp1kGpSl01GimmJ4sFYdrRg3jX+KWqG23iJP7
X-Received: by 10.98.91.131 with SMTP id p125mr40439755pfb.165.1489445865033;
 Mon, 13 Mar 2017 15:57:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.187.5 with HTTP; Mon, 13 Mar 2017 15:57:44 -0700 (PDT)
In-Reply-To: <CAGZ79kZrbvJz+S434BmEA_qeMOUXHk60yDSwdcKef62-Bz8nyw@mail.gmail.com>
References: <20170312075404.23951-1-nikhil.benesch@gmail.com>
 <20170312075404.23951-2-nikhil.benesch@gmail.com> <CAGZ79kZrbvJz+S434BmEA_qeMOUXHk60yDSwdcKef62-Bz8nyw@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 13 Mar 2017 15:57:44 -0700
Message-ID: <CAGZ79kZbcLFJPUt3wGsYX-XgAO+xW1ZDGJqN-q=r8i5Zbv_tTw@mail.gmail.com>
Subject: Re: [PATCH 1/1] archive: learn to include submodules in output archive
To:     Nikhil Benesch <nikhil.benesch@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Lars Hjemli <hjemli@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 13, 2017 at 3:12 PM, Stefan Beller <sbeller@google.com> wrote:

>> will recursively traverse submodules in the repository and
>> consider their contents for inclusion in the output archive, subject to
>> any pathspec filters.

git-archive pays attention to export-ignore and export-subst attribute
as read from .gitattributes or $GIT_DIR/info/attributes

When recursing into submodules, we'd need to clarify if the attributes
from the superproject or from the submodules are applied; or both.

Thanks,
Stefan
