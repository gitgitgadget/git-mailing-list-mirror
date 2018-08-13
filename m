Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 154881F404
	for <e@80x24.org>; Mon, 13 Aug 2018 09:57:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbeHMMin (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 08:38:43 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:39296 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728358AbeHMMim (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 08:38:42 -0400
Received: by mail-lj1-f170.google.com with SMTP id l15-v6so12060533lji.6
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 02:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=V703WUt9M3Zndh0AP5cn+lMmFijgoJiABSnWXcpNv2A=;
        b=P81LtfnecA8rZylvHrkBvlU/D+Hv/GxnJf2sJoD37vt62gTc4EKBkjXIlHEB3w50Sg
         Su+tWGfvjzsf0o+Er5FYEXCbCeQqObL3ZuX+eSSgZznQMLzSFVMOTdjLOQnxJji5h8qm
         IknLu80i40GrL4G3Lu/MXlb2XHderimY5bsf2T9s9o9xvckultsCJa2XiJdAirfsvEcI
         DPLmE7g7sB/oltJk7zC0bqEF1LTCOfJzklUHK22HfQqgd1q4PqWcGfcF0KFr6iE6wrzU
         Mbsh3rvUXXsYcLOXkgTUuX87gd+khl6ftEGIWZBsQOXLbtLkecKZsv3PTWrOiub3Sxi5
         cbYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=V703WUt9M3Zndh0AP5cn+lMmFijgoJiABSnWXcpNv2A=;
        b=ErxmcAGURdbGek7wSCDZwF35U1AYum88VJkKiWtloaidSPOerS67+TMh4GcFzm1Gqp
         FOAXCzc6cfQ7sAyfWgk0dCOOOLK3TK4Ub9y115kHZZgKqPUBTJyEQcRTHsvmDxgUR0C1
         DBtZr7VaLMmhqCUSVjVOV6tUQOV1cOLk62p1xhZQL/1nNFiN/bxlRYXx4ZJ622elPVJl
         zOeDXO9yTJ/kizjvgZAtf9et0VVCa6RqabvIP45ADZBG+P7p2QidWXCi9xbbKwBEzTSr
         9zmZ/f/VfJtk+HRtrtfaaxgfxyjbhLY82kYVavwaUkX0z0MMdFyPlFOaz/eDxjD692sV
         Cs6w==
X-Gm-Message-State: AOUpUlFnc/acpcjT+bobp76WLRIYlouEfuwqzK78cdJmzp5cMJxVEYVm
        h1R/Dnr7OFN7xLJCzUrZq8cQHHxeuKrSlBKl4XmsjNiI
X-Google-Smtp-Source: AA+uWPxhhshsw55WgvtGiWBeSGSPoMG4wdP4Ie47wHi27xmlHh1BalqDZmFqSRBsLQDFeSY8q3ZhXII7SnEp7kqc/kM=
X-Received: by 2002:a2e:7d10:: with SMTP id y16-v6mr11144065ljc.29.1534154229147;
 Mon, 13 Aug 2018 02:57:09 -0700 (PDT)
MIME-Version: 1.0
From:   Samuel Maftoul <samuel.maftoul@gmail.com>
Date:   Mon, 13 Aug 2018 11:56:58 +0200
Message-ID: <CAFj+z06S1V3Z7Z0zKPSrpZfWuzku9PTYjG+uu6ig-yCnG4FCLw@mail.gmail.com>
Subject: [RFC] implement branch.sort config option
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, you can:

git tag --sort=$sorting_key

You can also do this on branches:

git branch --sort=$sorting_key

For tags, you can also configure it with a config key:

git config tag.sort $sorting_key

But there is no corresponding config for sorting branches.

Locally, I have a (pretty simple) patch that implements the
branch.sort config key.
Should I contribute that ?
Judging the number of votes and the complexity of answers to this
question https://stackoverflow.com/questions/5188320/how-can-i-get-a-list-of-git-branches-ordered-by-most-recent-commit,
 I would say it's a wanted and useful feature.
I'm still missing tests and docs, but if agreed the feature is useful,
I will write them.

Thanks
