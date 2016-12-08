Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 725021FC96
	for <e@80x24.org>; Thu,  8 Dec 2016 09:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752781AbcLHJmN (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 04:42:13 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:34972 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751611AbcLHJmL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 04:42:11 -0500
Received: by mail-io0-f194.google.com with SMTP id h133so2253261ioe.2
        for <git@vger.kernel.org>; Thu, 08 Dec 2016 01:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=11enSOKn6j6QjZzYmLeLM+blbmE3pambC8SKbNgRl6I=;
        b=dA0+0xFvSFwt7LMK9zV0LZKj+6n0EA3WzpnQwmrIz1O7Lks2sZttBggDE7IAdem4x9
         ZmrUBu6g2gEJPFgbYqN81fIsRfCTTivRtiZlIRAjmL8YwtsLQujzkJo2pTjqum/PGV8J
         YqebKxpg1zhcvNZieGhWUZ6zNZO5FRU1/AtKd4xuOaEXG0A7GnS9kp9eBHwXsR0qmc6w
         48Vlq/QZ63qWBJ7Wq/EDa2XTdTa0pjIBCOXy4GxRK01BvDkfFWFamyEiO51UoXVzTTAQ
         jfLhX70Lk2l1+DolXEJAIFuOdjZi9besAMs2pcIgrhljtAyvqvs5rV6Uf5olJT8HB8wU
         JNhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=11enSOKn6j6QjZzYmLeLM+blbmE3pambC8SKbNgRl6I=;
        b=KVR4OQaVQN4N/vAegRCFb7KTBoM7uoobbaAxMEAaqQxhsLr2MhiA76sZtfCDOhiNgJ
         lfP8oydDJWqKngQ28FiAUTEWFvTV5uZYlLOHJWaTLofLtoATeRRDXyCYVaB0Xe7Cd8n2
         lKubUWlfl3TCSTC3wrBtqFZ21ijojXpi/mkL/+6raiyjtVR3J+IAlR/OIwV9rNmI6AvD
         E/5Ya7Ec72ZYyIlRCkFHfN2T8F5Iy9umdGLoJENyPe0yPVbzg9RuS78Xx3z743yecmJE
         Afw6e4sNAp3sCFbWhFeAeNU8prxVXmAPoEvPaFJgSysUqqDlnnOIbVrjAMTIqCa7sesa
         ozAA==
X-Gm-Message-State: AKaTC03BpI8AUuJcI7NIhWa0noIZ4zCvYd3K1pvM8Lu3Sc1ZGc97cZLa8HisJxnUMR7mfu/z3SYsR2uS7mxRoQ==
X-Received: by 10.36.66.76 with SMTP id i73mr916091itb.50.1481190130184; Thu,
 08 Dec 2016 01:42:10 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Thu, 8 Dec 2016 01:41:39 -0800 (PST)
In-Reply-To: <20161205201619.GE68588@google.com>
References: <1480964316-99305-1-git-send-email-bmwill@google.com>
 <1480964316-99305-2-git-send-email-bmwill@google.com> <CAGZ79katWewdwU3ZDYDj-QZEeersx9XDPZuTdMJG_u_62YwMsg@mail.gmail.com>
 <20161205201619.GE68588@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 8 Dec 2016 16:41:39 +0700
Message-ID: <CACsJy8BdUsGD-Bx=-qiP3cWt2AjwD1P3NTbqEnjnKa1v0TvySQ@mail.gmail.com>
Subject: Re: [PATCH] real_path: make real_path thread-safe
To:     Brandon Williams <bmwill@google.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 6, 2016 at 3:16 AM, Brandon Williams <bmwill@google.com> wrote:
> On 12/05, Stefan Beller wrote:
>> >  static const char *real_path_internal(const char *path, int die_on_error)
>> >  {
>> > -       static struct strbuf sb = STRBUF_INIT;
>> > +       static struct strbuf resolved = STRBUF_INIT;
>>
>> Also by having this static here, it is not quite thread safe, yet.
>>
>> By removing the static here we cannot do the early cheap check as:
>>
>> >         /* We've already done it */
>> > -       if (path == sb.buf)
>> > +       if (path == resolved.buf)
>> >                 return path;
>>
>> I wonder how often we run into this case; are there some callers explicitly
>> relying on real_path_internal being cheap for repeated calls?
>> (Maybe run the test suite with this early return instrumented? Not sure how
>> to assess the impact of removing the cheap out return optimization)
>>
>> The long tail (i.e. the actual functionality) should actually be
>> faster, I'd imagine
>> as we do less than with using chdir.
>
> Depends on how expensive the chdir calls were.  And I'm working to get
> rid of the static buffer.  Just need have the callers own the memory
> first.

I suggest you turn this real_path_internal into strbuf_real_path. In
other words, it takes a strbuf and writes the result there, allocating
memory if needed.

This function can replace the two strbuf_addstr(..., real_path(..));
we have in setup.c and sha1_file.c. real_path() can own a static
strbuf buffer to retain current behavior. We could also have a new
wrapper real_pathdup() around strbuf_real_path(), which can replace 9
instances of xstrdup(real_path(...)) (and Stefan is adding a few more;
that's what led me back to these mails)
-- 
Duy
