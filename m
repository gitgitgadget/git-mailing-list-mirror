Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13A16209B1
	for <e@80x24.org>; Tue,  5 Sep 2017 22:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754060AbdIEWFR (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 18:05:17 -0400
Received: from mail-yw0-f170.google.com ([209.85.161.170]:34368 "EHLO
        mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753937AbdIEWFO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 18:05:14 -0400
Received: by mail-yw0-f170.google.com with SMTP id r85so1841217ywg.1
        for <git@vger.kernel.org>; Tue, 05 Sep 2017 15:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UWhc+hUKO2773QrH4XRdgtcdWy5m/ZjYUGzNd3XsSXo=;
        b=m7xULU7WcY37ZS1s+BjxLqouQArfedvIq/WkF+HEhgm+SFtadc3fYtYWWf8SyATZI/
         sE4ZpmKJHYkOPYkX9hAsNXApC18+UdESyWmN8G3eWIvbR8EdAH7YCsI5SjBP42RGzPNB
         BA8j77HrZYbExXZ1UkhJhqs+rk8jIYFOFCtwaO1YGhvHkWSD/i9XwrPpZL/qDVLfDuZm
         WB9erLnGLtVb2nWkHgvq0JEtEY/fSDEAdzW9BTE11CpZucD0xonUrK9T4yNbmK0oeUCH
         dEEOlns07Wq4Da4rxYlFsS42aUVAe/AhJKDCMblyukVI/3ZnTtMctNNYJcgylT19Iaou
         3LZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UWhc+hUKO2773QrH4XRdgtcdWy5m/ZjYUGzNd3XsSXo=;
        b=Jb3F7DH3ay9iNxpIC3oI4pWRqy4mxfazf3+gQg+9A5ISBcljktMvUzpYgiQiCEH3s+
         wqLtvtLJmWhC4eket/R0luJ4bR1PYwrMvgfLpFyDt1NJfUWvGOftntijNkZ3gMmwUKsR
         1W+e+hEGty7bCMcxY9FKVjLysODaJoq3uZar5Vm/tiQp2LLJy3PaAQBciQvdAJTxEUp/
         XKcKU2dh+RmCUv1EzDbASKk8I2GQlVgEJ6/U7bpDqoopWuokCFxoN0gLp52uwMcEzF19
         swCH7E4gUd0Yq1soS6J273uxe6ap/aF8vzPvtQvcv87ln/7ZlTG1MQNx7XZhE4qzMq1i
         4rRA==
X-Gm-Message-State: AHPjjUhw+wz5d+j7zvfiNyDpAX+4WDY2fiH8w15tnJ28KzTa3YZFTgFK
        87pw0TFv+22Y8db7Pw8zyBipOwOpce3W
X-Google-Smtp-Source: ADKCNb6Llg+yexUTM+Wf8trJz3HEbqI+BpZPVFwKRKlfUzRdq9Xuz48dVBA2eKJcJiUmhuiB4L1iCHI6WxZR7RJRl0A=
X-Received: by 10.13.251.132 with SMTP id l126mr411015ywf.175.1504649113098;
 Tue, 05 Sep 2017 15:05:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.116.7 with HTTP; Tue, 5 Sep 2017 15:05:12 -0700 (PDT)
In-Reply-To: <20170905130505.him3p4jhxp64r2vy@sigill.intra.peff.net>
References: <20170905130149.agc3zp3s6i6e5aki@sigill.intra.peff.net> <20170905130505.him3p4jhxp64r2vy@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 5 Sep 2017 15:05:12 -0700
Message-ID: <CAGZ79kYmZJ8k2=SVrx9vpEXoKhRBGwu8J=fS=cYiCLdKf+nDGA@mail.gmail.com>
Subject: Re: [PATCH 10/10] add UNLEAK annotation for reducing leak false positives
To:     Jeff King <peff@peff.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 5, 2017 at 6:05 AM, Jeff King <peff@peff.net> wrote:

>   int main(void)

nit of the day:
  s/void/int argc, char *argv/ or in case we do not
  want to emphasize the argument list s/void//
  as that adds no uninteresting things.


>
> In other words, you can do:
>
>   int main(void)
>   {
>         char *p = some_function();
>         printf("%s", p);
>         UNLEAK(p);
>         return 0;
>   }
>
> to annotate "p" and suppress the leak report.

This sounds really cool so far.

After having a sneak peak at the implementation
it is O(1) in runtime for each added element, and the
space complexity is O(well).

> But wait, couldn't we just say "free(p)"? In this toy
> example, yes. But using UNLEAK() has several advantages over
> actually freeing the memory:

This is indeed the big question, that I have had.

>
>   1. It can be compiled conditionally. There's no need in
>      normal runs to do this free(), and it just wastes time.
>      By using a macro, we can get the benefit for leak-check
>      builds with zero cost for normal builds (this patch
>      uses a compile-time check, though we could clearly also
>      make it a run-time check at very low cost).
>
>      Of course one could also hide free() behind a macro, so
>      this is really just arguing for having UNLEAK(), not
>      for its particular implementation.

This is only a real argument in combination with (2), or in other
words you seem to hint at situations like these:

  struct *foo = obtain_new_foo();
  ...
  #if FREE_ANNOTATED_LEAKS
    /* special free() */
    release_foo(foo);
  #endif

With UNLEAK this situation works out nicely as we just
copy over all memory, ignoring elements allocated inside
foo, but for free() we'd have issues combining the preprocessor
magic with the special free implementation.

So how would we use syntactic sugar to made this
more comfortable? Roughly like

    MAYBE(release_foo(foo))

  #if (FREE_ANNOTATED_LEAKS)
  /* we rely on strict text substitution */
  /* as the function signature may change */
  #define MAYBE(fn) fn;
  #else
  #define MAYBE(fn)
  #endif

Me regurgitating this first argument is just a long way of saying
that it put me off even more after reading only the first argument.
Maybe reorder this argument to show up after the current second
argument, so the reader is guided better?

>   2. It's recursive across structures. In many cases our "p"
>      is not just a pointer, but a complex struct whose
>      fields may have been allocated by a sub-function. And
>      in some cases (e.g., dir_struct) we don't even have a
>      function which knows how to free all of the struct
>      members.
>
>      By marking the struct itself as reachable, that confers
>      reachability on any pointers it contains (including those
>      found in embedded structs, or reachable by walking
>      heap blocks recursively.
>
>   3. It works on cases where we're not sure if the value is
>      allocated or not. For example:
>
>        char *p = argc > 1 ? argv[1] : some_function();
>
>      It's safe to use UNLEAK(p) here, because it's not
>      freeing any memory. In the case that we're pointing to
>      argv here, the reachability checker will just ignore
>      our bytes.

This argument demonstrates why the MAYBE above is
inferior.

>
>   4. Because it's not actually freeing memory, you can
>      UNLEAK() before we are finished accessing the variable.
>      This is helpful in cases like this:
>
>        char *p = some_function();
>        return another_function(p);
>
>      Writing this with free() requires:
>
>        int ret;
>        char *p = some_function();
>        ret = another_function(p);
>        free(p);
>        return ret;
>
>      But with unleak we can just write:
>
>        char *p = some_function();
>        UNLEAK(p);
>        return another_function(p);

  5. It's not just about worrying if we can call UNLEAK
      once (in 4), but we also do not have to worry about
      calling it twice, or recursively. (This argument can be bad
      for cargo cult programmers, but we don't have these ;-)



> +#ifdef SUPPRESS_ANNOTATED_LEAKS
> +extern void unleak_memory(const void *ptr, size_t len);
> +#define UNLEAK(var) unleak_memory(&(var), sizeof(var));

As always with macros we have to be careful about its arguments.

  UNLEAK(a++)
  UNLEAK(baz())

won't work as intended.
