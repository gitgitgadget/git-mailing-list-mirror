Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA2611F404
	for <e@80x24.org>; Mon,  1 Jan 2018 23:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752498AbeAAX5h (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jan 2018 18:57:37 -0500
Received: from mail-oi0-f49.google.com ([209.85.218.49]:43794 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751849AbeAAX5g (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jan 2018 18:57:36 -0500
Received: by mail-oi0-f49.google.com with SMTP id f69so32464481oig.10
        for <git@vger.kernel.org>; Mon, 01 Jan 2018 15:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kTV7c7VNOdsFwG/v4szFZTZ+L6DICZa9eqduKANwLIw=;
        b=WWQ24d7CkzhVGf6jt0QpdXmW4mlREmfpjt8riCx98dLd/nGNJrH6US05lDlBINYqhE
         inHW65pUILOtkxjOhZVgDyR3BosAnnjZVOWEwRLOb0NiElg9IgDgR2Y8jCcz5jujZd2e
         6Q+DxWM4C2tUshiIKPAcg6yn4j4PynmiORwTDxCihemNAkfk7ciemC/wPbFxbKEYqFDY
         xAe3fREzOoH+95cSrFG1GPdlQA2KshSgJ4qZDOlXvSaAx6OXMZrRlZegyeQ11xzg45GO
         +wlIvBiDzDYha8ckSZWbT7IZxDnkExCxqeA/kv49MuQ0ne3CPB/hl6fIFv9c1Am1ZVIV
         yiRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kTV7c7VNOdsFwG/v4szFZTZ+L6DICZa9eqduKANwLIw=;
        b=W3QBlY3DxSnL1yMBkr13EaZyF9gFvTWkgrvtOaTpePhuBIWjfTKYi75EddhldIrhhg
         M24EzOCUXklWZ6Yi2UgJyBMmmYx5W3ikJdKi/zE9OfwJbmnhahE2QCGddUAqxSUpgI2H
         Gt+DM2bSV/bFizhSrS9lTlkENJ++7JSQXCp0JfEMk5nWPGFQf9zGQX/R+AWf9mCX/2Xa
         o1joJW50lKnpQxJlm2MS6F39OWD9IQBR3PfqJ4iLKSXkF47QYEkoMHoZ9GsXrcI6S4k5
         7zZFQMiQaVVEYhuYbBeRKETaV/C6rCs1b5YNxeGmGsbrnqjIXWxc6JcvwYthZYRHEEWz
         82xw==
X-Gm-Message-State: AKGB3mIcakg7uIPtJbe5gbkfrDgTZ0Ts0t3jPDL0QVhtmzVWCGFjQPos
        K/8EToDr08LmhuC0I7twVz/Ez3H6+KERkTsnVyY=
X-Google-Smtp-Source: ACJfBovNPKEq0r77H56xDxdK7fJhlr2CQZG+3pfvaXgsY0PKUHbkqlBeY3YBmkM6oesURpPOFzzzFJtPfh17BTBjEqk=
X-Received: by 10.202.46.69 with SMTP id u66mr31178409oiu.253.1514851056288;
 Mon, 01 Jan 2018 15:57:36 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.141.5 with HTTP; Mon, 1 Jan 2018 15:57:05 -0800 (PST)
In-Reply-To: <xmqq608qllcd.fsf@gitster.mtv.corp.google.com>
References: <20171228002807.22388-1-pclouds@gmail.com> <xmqqd12yllkz.fsf@gitster.mtv.corp.google.com>
 <xmqq608qllcd.fsf@gitster.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 2 Jan 2018 06:57:05 +0700
Message-ID: <CACsJy8BnxOz9brnkyZ58guTsUhgKKN_XQvbYaZJz17888pgHoQ@mail.gmail.com>
Subject: Re: [PATCH] dir.c: avoid stat() in valid_cached_dir()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 29, 2017 at 2:10 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>>>  [1] https://public-inbox.org/git/CACsJy8AmbKSp0mDLRaDCWn45veeNc03B-Gq8r8PQPrDt9bM_EA@mail.gmail.com/
>>>
>>>  dir.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/dir.c b/dir.c
>>> index 7c4b45e30e..edcb7bb462 100644
>>> --- a/dir.c
>>> +++ b/dir.c
>>> @@ -1809,7 +1809,7 @@ static int valid_cached_dir(struct dir_struct *dir,
>>>       */
>>>      refresh_fsmonitor(istate);
>>>      if (!(dir->untracked->use_fsmonitor && untracked->valid)) {
>>> -            if (stat(path->len ? path->buf : ".", &st)) {
>>> +            if (lstat(path->len ? path->buf : ".", &st)) {
>
> Hmph, I have to wonder if this is sufficient, though.  When you got
> "a/b/c" in path->buf, is it sufficient to avoid mistaking 'c' that
> is (eh, rather, "has unexpectedly turned into") a symbolic link to a
> directory as a true directory?  Wouldn't we have to be equally careful
> about "a" and "a/b" as well?

We do. But the way directory traversal works, I believe a and a/b must
have been checked (by this function too) before we call
valid_cached_dir("a/b/c").
-- 
Duy
