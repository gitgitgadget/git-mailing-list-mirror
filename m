Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F42251F453
	for <e@80x24.org>; Thu, 24 Jan 2019 19:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbfAXTC3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 14:02:29 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44128 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfAXTC3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 14:02:29 -0500
Received: by mail-ed1-f66.google.com with SMTP id y56so5451731edd.11
        for <git@vger.kernel.org>; Thu, 24 Jan 2019 11:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jS97Mvmd9TssdUsGsEjoBNddYD/6X/kmZQCfiYJFn+g=;
        b=YF21KdXeiM26M3opZzABbws2nq+w75CDfwPxtVn0RVny3HwKfLk0enugodTkIxfr+G
         hijuYoccVlrkroQt3dW7OtdjtyaKsASaO4H8u4Ommh8PveRLC3Df3QNcU3l6QgiTLl57
         2OWZH1uPbw29lrnd/kD/Gy9FYaZ1qOE4cchMTSCuP5VOsfayI2OWfrXrlB9evbK+BYhM
         xlLnq0t0Ni8h13EXb+B9uw8cq7MGV72tLbjN8k7fI9ihwIHOU8ShyxEXWqhfSdNUcfVJ
         yqlku911ju3iHpqBJUVE6whaM4dBuJfXYwgweqlQew8v1KIpfWSupWI+eBwT28KvEtQW
         wshA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jS97Mvmd9TssdUsGsEjoBNddYD/6X/kmZQCfiYJFn+g=;
        b=NW/TJRwMYHQIVrKNbhW8DzeKzTgwp2hYITvf2FtzpkLS7KNR5WyzlcF9VgqWgLMwNh
         10A8LPSYJ+pIxX2l13ooQgkj0qvDnjPcZIAq2joyqZIsvAhbajI2D0PHZ786BKPJ7/qV
         cUVz5q8phxNR1IzJWsgNXQoIpCZYP02Tp3swz/e5gAdjselZwWMwdR17XzSkz7rBOSLK
         A4Qx9bLPTvDaSbcDYnjj9iCN6oYQaUL+ebukaW48NS67bfq8+tHLrbBc5kiwZP82PIOD
         sgL97o+U3N5fLN1Yd0dF2ve1SyrjaULJ2nKQQ/wukJGod2b1WntaHcubt69emnG/TIlR
         U+iQ==
X-Gm-Message-State: AJcUukeXHVLyfPcB44t/MIdA09RtyaLKOLVbn89gpj8bj4xTsCaSf+WB
        f7A93V0bdOeqVbPqU6PkQ4z7xuAlhNfWtIvw/Xk2aQ==
X-Google-Smtp-Source: ALg8bN4eCSh5ajlTBk3x1KpMV+o5PkMYDR4fnZxUCMU9+kzBqVI+4UIiesP0JS0pwBRwr7Fpb+hjboPDqXjp6LrUQv0=
X-Received: by 2002:a05:6402:1816:: with SMTP id g22mr7962617edy.191.1548356547927;
 Thu, 24 Jan 2019 11:02:27 -0800 (PST)
MIME-Version: 1.0
References: <20190124122603.GA10415@sigill.intra.peff.net> <20190124123450.GD11354@sigill.intra.peff.net>
In-Reply-To: <20190124123450.GD11354@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 24 Jan 2019 11:02:16 -0800
Message-ID: <CAGZ79kbz9QFLG1sr=WQ_kvLMis1hf41wCjK1Ngu4+1iAv3XO1g@mail.gmail.com>
Subject: Re: [PATCH 4/6] combine-diff: treat --shortstat like --stat
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>, David Turner <novalis@novalis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 24, 2019 at 4:34 AM Jeff King <peff@peff.net> wrote:
>
> The --stat of a combined diff is defined as the first-parent stat,
> going all the way back to 965f803c32 (combine-diff: show diffstat with
> the first parent., 2006-04-17).
>
> Naturally, we gave --numstat the same treatment in 74e2abe5b7 (diff
> --numstat, 2006-10-12).
>
> But --shortstat, which is really just the final line of --stat, does
> nothing, which produces confusing results:
>
>   $ git show --oneline --stat eab7584e37
>   eab7584e37 Merge branch 'en/show-ref-doc-fix'
>
>    Documentation/git-show-ref.txt | 2 +-
>    1 file changed, 1 insertion(+), 1 deletion(-)
>
>   $ git show --oneline --shortstat eab7584e37
>   eab7584e37 Merge branch 'en/show-ref-doc-fix'
>
>   [nothing! We'd expect to see the "1 file changed..." line]
>
> This patch teaches combine-diff to treats the two formats identically.
>
> Reported-by: David Turner <novalis@novalis.org>
> Signed-off-by: Jeff King <peff@peff.net>

Both the previous patch and this one is reviewed by me.

Thanks,
Stefan
