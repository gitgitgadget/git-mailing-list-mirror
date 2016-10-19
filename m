Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61C3E20988
	for <e@80x24.org>; Wed, 19 Oct 2016 00:07:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932197AbcJSAHY (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Oct 2016 20:07:24 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:35268 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755702AbcJSAHR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Oct 2016 20:07:17 -0400
Received: by mail-qk0-f173.google.com with SMTP id z190so12688567qkc.2
        for <git@vger.kernel.org>; Tue, 18 Oct 2016 17:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=eZe6QhpcBmNsxDheJo5dx+cKi3/kyJx+Ov0OOxICNIs=;
        b=FRwopo7XbgClnIj/rudr5yuUxVD/WqJ4tpAy7vIbucADGP14B6tcMNkRllapK+psEj
         us9Wy0qzXeAoBkeshyQO/X/mlXn+/ZF24p7KhKUcRWWGJacX5qhF3koImZSXQBZp/E1k
         9fzxYaDU0Sa7rlfzvbjVfK8Cz3Ug2Ao8UJ4nXpiDGyHtFu4baVEZ5uiAlg+AIlV7vWPk
         LyWvW3WIHu8XRDdN0+QSqPTumZII2FYwf6zCm80GTZ5rSY9mC96jLPCgaYoo+VMHE2YR
         zJFnHMfZo58+MlQIqyn8S+xJ5f9PzxtXKvb+/yCwu/XQShS2oVyt8Q8E0KFFnFEAg1Dw
         M+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=eZe6QhpcBmNsxDheJo5dx+cKi3/kyJx+Ov0OOxICNIs=;
        b=HtOCFA0iE1+DutQKnwmJ3PR6pFELloyZyGfCVlbqEvBxH3EoDVJdPDl1gcgzzGBIgD
         keSrhNYSzOLq/YrekmTvjWIY73JE0QgiDziAYzd7BUnkHbJHjnCSRLVYDFFODBzHhaRJ
         I4kq2uVgxlV9mKheTvU+vQs28zOZkxzaBImo04r/hB0m0DOI3gpZssLxlghTQZsH3N5y
         79G+U8fa4ypqju+0clSRPe5k4Pvb4RH57uDpyWrvdNcZZEfv4B1NB7u8aLgpqLbMYAz2
         mWDIgc/71ow/p+GXuAapnXEKTIBIxmjFYbPc/tLDTIEP5H2VWheEsXJ8p/N63DNSlAI9
         HFKg==
X-Gm-Message-State: AA6/9RkIW5QXritIG5Pmy5nKVLPX8fi0u9/h/Tggzb13ajj/h8+0qy4pdad2hjAxo8DEhyNzSsOKsBILzArspA==
X-Received: by 10.55.140.199 with SMTP id o190mr3144462qkd.299.1476835636008;
 Tue, 18 Oct 2016 17:07:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.212.204 with HTTP; Tue, 18 Oct 2016 17:06:55 -0700 (PDT)
In-Reply-To: <CAGZ79kbS4mP7sVTCM+QJXTwKsgZ40xvVDng-F3igZnJWLYek0A@mail.gmail.com>
References: <20161012224109.23410-1-sbeller@google.com> <xmqqfuo116t0.fsf@gitster.mtv.corp.google.com>
 <xmqq8ttr0wny.fsf@gitster.mtv.corp.google.com> <CAGZ79kbS4mP7sVTCM+QJXTwKsgZ40xvVDng-F3igZnJWLYek0A@mail.gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Tue, 18 Oct 2016 17:06:55 -0700
X-Google-Sender-Auth: USEIHSrUFRlOawBUNiidYxU00_w
Message-ID: <CAPc5daVF2HBD2DfP=w2oG-2PMWQ+guXP_onQX+foSgVYH4N1Qg@mail.gmail.com>
Subject: Re: [PATCHv3] attr: convert to new threadsafe API
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 18, 2016 at 4:52 PM, Stefan Beller <sbeller@google.com> wrote:
>
> >
> > By the way, I do see a merit on the "check" side (tl;dr: but I do
> > not think "result" needs it, hence I do not see the need for the
> > "ugly" variants).
>
> So we'd rather go with const char **result instead of our own new struct there.
> Ok, got it.

I do not think you got it. I am talking about wrapping struct around
an array of element,
not each element in the array. IOW

> > If we were still to do the wrapping for result, I would say that
> > basing it around the FLEX_ARRAY idiom, i.e.
> >
> >>         struct git_attr_result {
> >>                 int num_slots;
> >>                 const char *value[FLEX_ARRAY];
> >>         };

the structure around the array of elements (value) that allows us to have
something other than value[] in it. That is what I said "I do not see
the need for".

It is perfectly fine future-proofing to have

struct git_attr_result_value {
  const char *value;
};

and have the users of API declare

struct git_attr_result value[5];

or whatever. That way we could fatten the structure later if we wanted
to without having to update the users of API, and there is no downside.

Having wrapping strut around the array does have a huge downside,
and that is what I said I see no need for.
