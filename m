Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ACB2C07E9D
	for <git@archiver.kernel.org>; Sat, 24 Sep 2022 09:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbiIXJqL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Sep 2022 05:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233509AbiIXJqJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Sep 2022 05:46:09 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BEC9105D6F
        for <git@vger.kernel.org>; Sat, 24 Sep 2022 02:46:08 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id t3so2201771ply.2
        for <git@vger.kernel.org>; Sat, 24 Sep 2022 02:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=x/hbdje9AcyBShr55hsnGvyE/ZZaSlF/BCrPDErxBSc=;
        b=TtQaKVUqRJb/1zG/6S9myu39KyiJpUqIFYcYZVxkUUfJlIB9b0Whjaymbb0I6uNrcf
         d1c4wqCYqjpW7P/d9oa7t0RGbS8WDQVphGYeDQePcgZVmwUvKaGiYRTsRyXknUC1U/Vj
         SAYinsl4KWVnywyZ6JZd8oGyKBC6ruaQjlY+uxlI4OuZj9b+JiE+xHxsKV3TgyR0Y8SX
         LCiG1+UcmJahQbzRdEwIqXtHvUOGaS/reY/tZsNJ4P8KEw+99u4pMmO+KWWx3rNiRBzD
         RazHLXtHflNxt9k1XFyBSIHH1Ve4br4IWxYbDiT83EKgZsDQDXkLwrnCo2aBOQOjphV4
         rg9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=x/hbdje9AcyBShr55hsnGvyE/ZZaSlF/BCrPDErxBSc=;
        b=QdWmgN8m4XahDng8sAy/cgIPVzNGKFou0tJpkzaSSKHJlP4NhXo/bMSau10hX7AJud
         h5W5gRgTlEusAAvmDQE2mCQtD7EL8nrwSEEqz2LJyOSIJqJIAU0Z1fLbQHa2GqZhCBuS
         fix/xBWHIeKFoMu4SY0QUeG7qCX5XDpItKUg0qwQI8OwMPAdC9kywKZCi3PrIW136dpv
         yyaj+YnHHsPqinNN6elWdSc//qI8F7ZJCNeqCOzCDwitGlRJLtXSWC7EYvvmgNj6rB/X
         Ods0FS05F/E2IEsMZlSVMc27lcCYEwmJCDo7Gbbjd9EBuCyR6/NUBdj/tdhJafjxw4zs
         kNZA==
X-Gm-Message-State: ACrzQf3sACBinjagDU//V6C4tZmtkgE3JiNr70V09fpM6m1HWQQdf7vd
        +0d8G3UTi/zRnTP9qkkaoSvMXAM1+aI=
X-Google-Smtp-Source: AMsMyM4q4M5jFRLthvGQD0VO4VDawIM6UHco9KXY3X4YTMeu26gu/RY2yNnE0hC7oRPrMybjdRUaDg==
X-Received: by 2002:a17:902:c7d1:b0:178:54cf:d69e with SMTP id r17-20020a170902c7d100b0017854cfd69emr12683533pla.86.1664012767376;
        Sat, 24 Sep 2022 02:46:07 -0700 (PDT)
Received: from localhost ([2001:ee0:5008:db00:ddb6:aa04:656c:8163])
        by smtp.gmail.com with ESMTPSA id e1-20020a17090301c100b00172cb8b97a8sm7531794plh.5.2022.09.24.02.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 02:46:06 -0700 (PDT)
Date:   Sat, 24 Sep 2022 16:46:03 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Claus Fischer <claus.fischer@clausfischer.com>
Cc:     git@vger.kernel.org
Subject: Re: Scriptable mode for git bisect
Message-ID: <Yy7R20yhOjIODpJ6@danh.dev>
References: <Yy4c6/jHupgThj7j@clausfischer.com>
 <Yy5g80OtVG4op8L1@danh.dev>
 <E10623C2-FF73-4E5B-AD28-C255B02F3B0F@clausfischer.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E10623C2-FF73-4E5B-AD28-C255B02F3B0F@clausfischer.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022-09-24 11:32:52+0200, Claus Fischer <claus.fischer@clausfischer.com> wrote:
> I tried that but it turns out it does not always stop at the bad revision.

"git bisect" won't stop at the bad revision, it only left
"refs/bisect/bad" point to the first bad revision, assuming
non-alternative terms were used.

If refs/bisect/bad doesn't point to the first bad revision, your
installation is borked. Please file a bug report.

> 
> Claus
> 
> > On 24.09.2022, at 03:44, Đoàn Trần Công Danh <congdanhqx@gmail.com> wrote:
> > 
> > On 2022-09-23 22:54:03+0200, Claus Fischer <claus.fischer@clausfischer.com> wrote:
> >> 
> >> Dear Git maintainers,
> >> 
> >> I have looked at the manpage of git bisect but have not found
> >> what I need:
> >> I would like git bisect not just to report the 'bad' revision
> >> within a bunch of text but instead either stop at the first
> >> bad revision (the last good will then be HEAD~1) or report
> >> it in a scriptable way, i.e.
> >> 
> >>  BADHEAD=$(git bisect run --shut-up-and-report-the-bad)
> >> 
> >> Have I overlooked anything?
> > 
> > After running "git bisect run"
> > You can take its revisions with:
> > 
> > 	BADHEAD=$(git rev-parse --verify refs/bisect/bad)
> > 
> >> 
> >> ***
> >> 
> >> The pourpose is to keep the source trees of two different
> >> projects that share a few files synchronous.
> >> My good/bad-script is a script that checks whether these
> >> files are similar.
> >> I want git to stop at the first change in source tree A
> >> so that I can update source tree B with the same commit
> >> message, then proceed to the next change in A that
> >> changes one of those files.
> >> 
> >> Regards,
> >> 
> >> Cluas
> > 
> > -- 
> > Danh
> 

-- 
Danh
