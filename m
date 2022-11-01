Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A6C5C4332F
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 20:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiKAUOp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 16:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiKAUOn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 16:14:43 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B9EE13
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 13:14:43 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id z3so13331487iof.3
        for <git@vger.kernel.org>; Tue, 01 Nov 2022 13:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hi5D9xFwvt0PjzIsvtm/GOESuH+DNRTp+LEemgEx5tc=;
        b=IiKqf/Cyun77Vdj4qRwNpo/M+kvdBPXOMAy8bTOlvDBroLTsVTjE3d3rB6u9sQQ4Jo
         DKPVJme/Xoyy2a5ZfofiGheAQWJ7C3pfxFZQO0xiJeAxrccC8ThbCRM97UYQ0JoycOyx
         yB5wgHj9WJUbGdbM0uc9C3K4QAqxilX6EMErjnipCMl05bbK66kvug+FZGncCmdsfLNe
         6FQLweREyECQlJ2R96GoIpq0HV780C4IyAGUas2usKRHq/GHBOY1SqIarNuN2/q41Y7i
         8Jq0uzferEU/+tg5aHrWu5ZSG1KVC/JET2roUEiJ4GxphMmZ2kabUU30cMZCDy7cR/2l
         1Kww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hi5D9xFwvt0PjzIsvtm/GOESuH+DNRTp+LEemgEx5tc=;
        b=pRyvyygxeNRbDEVwJ6rcM+KwrrCg+nOzpGpohRTWUKR/hX9h0TK/NH7+X5Eu9yerP0
         fe79rHfuekmweEpgTqmGajEWdvgv8Lmbq54BcNA7e+emw46Td8qtC1xYupIe93baQV7f
         hd7JXHGoFeKWDgBzxb3n8aFgBrraoy9JHuQ3+jrUndajiuJ37n9X6SvMdTM6vMPILsqz
         j4c5f43HTgfbYtwGJi59oWy2Q+L831Jkh+Wo1hLDcvxMDFah01/tyAHR99XppntmxZfK
         cb/dP3prvZWZ2vDk6vKLQCKh3RDA6zzeO6TJdpQvgixnEShQ/mZ5NsLhnO1cw9wMsDHR
         tqLQ==
X-Gm-Message-State: ACrzQf1jAj2qKGgi6pMCjp/7TTcYh+9AqBvwpwh+7oLPuoR6FLjm1diH
        Y38GU/WYAu5t/Q50aHXCXfUXjQ==
X-Google-Smtp-Source: AMsMyM5timL1w6cBAmPmZe1Hbk5c3ywurY4spXDgHax2+q3yvLgDvJYyTAaOzCZNDtu4m3iAuq4kWQ==
X-Received: by 2002:a6b:fd0d:0:b0:6ce:cd92:1643 with SMTP id c13-20020a6bfd0d000000b006cecd921643mr9467556ioi.62.1667333682435;
        Tue, 01 Nov 2022 13:14:42 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e6-20020a921e06000000b003002d1ba94esm3856949ile.42.2022.11.01.13.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 13:14:42 -0700 (PDT)
Date:   Tue, 1 Nov 2022 16:14:40 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jeff King <peff@peff.net>,
        Martin von Zweigbergk <martinvonz@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Bug in `git branch --delete main` when on other orphan brancht
Message-ID: <Y2F+MA+cAsEB0Glb@nand.local>
References: <CAESOdVBpsbJ0obD=qDjHBJg-wwWUL5sQ-7X_h13Vw39Q9QUzHA@mail.gmail.com>
 <Y2DxxZAFbN8juHY6@coredump.intra.peff.net>
 <Y2F9lkCWf/2rjT2E@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y2F9lkCWf/2rjT2E@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 01, 2022 at 04:12:06PM -0400, Taylor Blau wrote:
> Yeah, that looks reasonable to me. Presumably we want a small test, as
> well, but I doubt that is any more complicated than:
>
> --- 8< ---
> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index 7f605f865b..6ace22f7ce 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -279,6 +279,14 @@ test_expect_success 'git branch -M and -C fail on detached HEAD' '
>  	test_cmp expect err
>  '
>
> +test_expect_success 'git branch -d on detached HEAD' '
> +	test_when_finished "git checkout main && git branch -D other" &&
> +	git branch other &&
> +	git checkout --orphan orphan &&
> +	test_must_fail git branch -d other 2>err &&
> +	grep "not fully merged" err
> +'
> +
>  test_expect_success 'git branch -v -d t should work' '
>  	git branch t &&
>  	git rev-parse --verify refs/heads/t &&
> --- >8 ---

Actually, the test doesn't need "other" here, since we aren't actually
going to delete the target branch (for the exact same reason that you
pointed out to Martin earlier in the thread).

So it could actually be as small as something like this:

--- >8 ---
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 7f605f865b..464d3f610b 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -279,6 +279,13 @@ test_expect_success 'git branch -M and -C fail on detached HEAD' '
 	test_cmp expect err
 '

+test_expect_success 'git branch -d on detached HEAD' '
+	test_when_finished git checkout main &&
+	git checkout --orphan orphan &&
+	test_must_fail git branch -d main 2>err &&
+	grep "not fully merged" err
+'
+
 test_expect_success 'git branch -v -d t should work' '
 	git branch t &&
 	git rev-parse --verify refs/heads/t &&
--- 8< ---

Thanks,
Taylor
