Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FC3A2022A
	for <e@80x24.org>; Thu, 27 Oct 2016 02:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934786AbcJ0CT7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Oct 2016 22:19:59 -0400
Received: from mail-qt0-f179.google.com ([209.85.216.179]:33570 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935328AbcJ0CT4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2016 22:19:56 -0400
Received: by mail-qt0-f179.google.com with SMTP id p16so5627791qta.0
        for <git@vger.kernel.org>; Wed, 26 Oct 2016 19:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+4+PBxEfSMtSFCUKusXF3FXBLGTgHAicWEYYwqqcsYY=;
        b=gISx/nCwZrwKQW6kTaGsRURG01hqNN8MH/b6nHYD5qgOxolKRszKrkMl6YHDc9IEMU
         asL3W5U2UWfI1PVyi5JlZrJW+TGf5DFiBIAEZ+T0mnEpxcv1T+Qyku4r4At2pQuImSFD
         HbpQSAD3Gzqwh/hxBrvrOtj1x2zYTTcidM8K/02F6HAkCkgdsRJRkBnZbuh7GZnZo1kh
         3ykE5TdA4R7NC7iq0k2GxV6qJJHuT2aB8mhXl2Qs/G7N+08PGMFuPAtvbqVgTO9tlBJt
         B1zFBGgnkDBLpGPdlyJqWP1xmQ3Cay9GF1X1T5fzDEOpSzMgBLStnIgMOKKMtf486A2p
         B0AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+4+PBxEfSMtSFCUKusXF3FXBLGTgHAicWEYYwqqcsYY=;
        b=Et9S+V8czqc5naZFc5/UXwef6GFzBjXw2DIKvao/7YLNV4JxReewzBH2RkoO5dUSUN
         CTCyMq9dq4NUa6KLfFIQvBMlgn1ncmdoK0WNlCfSQrkIgh2ycTX+MnuvMYjrUqAJE1BZ
         dZR3f/5bVHWi370jxAYnf6uuoz9AGMKxVTalmzIkubis6zkruDaj6hFn19RRz12Q2Yip
         88itKI08YEdXYTS7WtVCRwYqtIxFKJYxIxr5BWTkzPhzZUgO/1PPLF+jmGrS/IDeuhkT
         3uHEeZgI7AHoMcwbuH0xI+NjCArwY5+1jrHHeGdj7kw1o8zucCdK/u6+WCf8Sq7ii2W8
         zUZQ==
X-Gm-Message-State: ABUngvfpEo9zhlrGURRUI5TrENQvq2OzWIq+GianqtPI38VvvLF8m8Y0oWpJVQuExbBTRgS7ILUpS8o52aTBitBu
X-Received: by 10.200.34.145 with SMTP id f17mr4417226qta.149.1477534794997;
 Wed, 26 Oct 2016 19:19:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Wed, 26 Oct 2016 19:19:54 -0700 (PDT)
In-Reply-To: <xmqqbmy6aa6b.fsf@gitster.mtv.corp.google.com>
References: <CAGZ79kYhMVrKHhNGYcf_D9kWEYp+sC+tMGbuE+gnD8AU27dh8g@mail.gmail.com>
 <20161026224104.31844-1-sbeller@google.com> <xmqqbmy6aa6b.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 26 Oct 2016 19:19:54 -0700
Message-ID: <CAGZ79kYiVxJwtAYsgks8LVNWvawWxdy=8Xpdrki-C_u15C3Z9w@mail.gmail.com>
Subject: Re: [PATCHv2 1/2] attr: convert to new threadsafe API
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>,
        Simon Ruderich <simon@ruderich.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 26, 2016 at 5:49 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>  extern struct git_attr *git_attr(const char *);
>> ...
>> +extern void git_attr_check_append(struct git_attr_check *,
>> +                               const struct git_attr *);
>
> Another thing.  Do we still need to expose git_attr() to the outside
> callers?  If we change git_attr_check_append() to take "const char *"
> as its second parameter, can we retire it from the public interface?
>
> It being an "intern" function, by definition it is not thread-safe.
> Its use from prepare_attr_stack() inside git_check_attr() that takes
> the Big Attribute Subsystem Lock is safe, but the callers that do
>
>         struct git_attr_check *check = ...;
>         struct git_attr *text_attr = git_attr("text");
>
>         git_attr_check_append(check, text_attr);
>
> would risk racing to register the same entry to the "all the
> attributes in the known universe" table.
>
> If the attribute API does not have to expose git_attr(const char *)
> to the external callers at all, that would be ideal.  Otherwise, we
> would need to rename the current git_attr() that is used internally
> under the Big Lock to
>
>     static struct git_attr *git_attr_locked(const char*)
>
> that is defined inside attr.c, and then provide the external version
> as a thin wrapper that calls it under the Big Lock.
>
>

Yeah, I can make it work without exposing struct git_attr.
However then the struct git_attr_check will contain more of
internals exposed. (As the header file did not know the size
of git_attr, the patch under discussion even must use a double pointer
to a git_attr inside the git_attr_check as the git_attr size is unknown)

So I'll look into removing that struct git_attr completely.
