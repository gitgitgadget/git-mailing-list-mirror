Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6929E2070F
	for <e@80x24.org>; Thu,  8 Sep 2016 06:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752883AbcIHGQh (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 02:16:37 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36851 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752040AbcIHGQK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 02:16:10 -0400
Received: by mail-wm0-f66.google.com with SMTP id l65so6206338wmf.3
        for <git@vger.kernel.org>; Wed, 07 Sep 2016 23:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=k43qmSnquTl+u7AtbLhZEWuaI1nSlAfSkiwDB9HdrL0=;
        b=qGPGxB4FOYsbK19lLvTwgCLz4JEOraFS4xR9VbAiIXsQ3hPcWWSJg8mZf+I00Xqps/
         lgvqXlosbJeJ5De6NXFXw+lZrkZ/CxQHQCqf3Tladth/nJp+gCJDXF/dHSaDL9TBFNXT
         R7KjKqPUoWrY8kSfTzl3p9pL1+5b0Cupb6/NE6weqVAaZ/5Ffu5B5yCnCwoVJHhU0LwX
         h1cBcG6pZPTdSpZKRM25KJhlgsrHdtuEry5fDHNDBggOzb8tVYDrUtw1VPqMBTTihCqd
         TWLZz4VosGpA1f/6ucS95sxAOUfme7PYI/pIyXTtDBVJLJLct+1VcCF7VJmQLucc4ypc
         nb6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=k43qmSnquTl+u7AtbLhZEWuaI1nSlAfSkiwDB9HdrL0=;
        b=QG2DVBMU6Pb7dggW05gX7hZ5rwITsWwou2xFSHYEY30xVHz4X2MhF6YMA6rSrphwKl
         C/9B/HaK4/bRaeRS7igFeg9KJdgPzk+jwgSK1woeQhOs3dnwoF5oYrdM2kH4ugzPcGPF
         rFyKM3qI1KOXy1B6A1Jnm6zTP8P92NRWEi/iRuz6Se6E0Rb7HJIFfGVqtVQRBvmXclJr
         7XNz1Fd2kqsRqvHJF6ofpwWEdayroQQ2lAPyLHaz/NxIF+UN16FRbQra08f7QYsr5dC2
         Gggc46VWz7UrbXVWTWZJQhO+tobeoOExct2XoThtdJPMtA5lE5lQ6RjhqPieY8y3tr0T
         xipw==
X-Gm-Message-State: AE9vXwP6Xj63CPlwNquXwpb7T3hdQHmmcsEJUMWjQUnduFClMKLqIAAQ38KYtETC8AGX6A==
X-Received: by 10.194.106.73 with SMTP id gs9mr513332wjb.160.1473314275494;
        Wed, 07 Sep 2016 22:57:55 -0700 (PDT)
Received: from [192.168.0.185] (HSI-KBW-085-216-063-210.hsi.kabelbw.de. [85.216.63.210])
        by smtp.gmail.com with ESMTPSA id v203sm7746061wmv.2.2016.09.07.22.57.47
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 07 Sep 2016 22:57:54 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v1 2/2] read-cache: make sure file handles are not inherited by child processes
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqtwdrmuvo.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 8 Sep 2016 07:57:39 +0200
Cc:     Eric Wong <e@80x24.org>, Git Mailing List <git@vger.kernel.org>,
        tboegi@web.de, Johannes.Schindelin@gmx.de
Content-Transfer-Encoding: 7bit
Message-Id: <F33245FC-C53A-4977-8E72-68AF3D2BB8BB@gmail.com>
References: <20160905211111.72956-1-larsxschneider@gmail.com> <20160905211111.72956-3-larsxschneider@gmail.com> <20160906210632.GA28263@starla> <7B903664-0324-4375-A81C-1317020CBE9B@gmail.com> <20160907181036.GA14931@starla> <xmqqtwdrmuvo.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 07 Sep 2016, at 20:23, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Eric Wong <e@80x24.org> writes:
> 
>> We probably should be using O_NOATIME for all O_RDONLY cases
>> to get the last bit of performance out (especially since
>> non-modern-Linux systems probably still lack relatime).
> 
> No, please do not go there.
> 
> The user can read from a file in a working tree using "less",
> "grep", etc., and they all update the atime, so should "git grep".
> We do not use atime ourselves on these files but we should let
> outside tools rely on the validity of atime (e.g. "what are the
> files that were looked at yesterday?").
> 
> If you grep for noatime in our current codebase, you'd notice that
> we use it only for files in objects/ hierarchy, and that makes very
> good sense.  These files are what we create for our _sole_ use and
> no other tools can peek at them and expect to get any useful
> information out of them (we hear from time to time that virus
> scanners leaving open file descriptors on them causing trouble, but
> that is an example of a useless access), and that makes a file in
> objects/ hierarchy a fair game for noatime optimization.

How do we deal with read-cache:ce_compare_data, though?

By your definition above we shouldn't use NOATIME since the read file
is not in objects/. However, the file read is not something the user
explicitly triggers. The read is part of the Git internal "clean"
machinery.

What would you suggest? Should I open the file with or without NOATIME?

Thanks,
Lars
