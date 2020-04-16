Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64349C3815B
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 18:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4255F221E8
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 18:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="cdf1+Z1+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729227AbgDPS73 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Apr 2020 14:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727815AbgDPS70 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Apr 2020 14:59:26 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54297C061A0C
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 11:59:26 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id m19so6381552lfq.13
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 11:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r15kLJH/nymbS6aftGscNRjCBYsNDZNiWKkpEW5TdKg=;
        b=cdf1+Z1+8hwcnm6DDwKFEis3V8zVypuBcl5WGtIQikTFs67ZL8mwns1ZvdkhHLVeGd
         3p6nGqHZtZ5tFyKzWqfRd7u3QhWrGjJIBD656VDm6lLTs+fGUiYpdYmHAeoCXKKMfope
         58J0w39RkyvzK4ANG9H/8Q8v36G7XMqg2yOeIPntgQlqFk8sKb8ntpSk4VqtsWYXgxO+
         10+pppwxhImS0Ts7O0HzK0rO20mlRxPb6hp7/4M4L66Ve+iWJnJw8LnkgxO6+ceQJB6e
         PVnTMd0Y1Isbfh4vVgPRLAB70Qa5MwllLZJQneD+kK72iY3OqvmaOQjswpmidf6gabJH
         3pXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r15kLJH/nymbS6aftGscNRjCBYsNDZNiWKkpEW5TdKg=;
        b=sten0M43BCaoZjFuhYM6aS6MA3XsSdMKMQprpAfj1zzxvue78o4eVkryprw3kXwr3i
         BWCG+930sZlSQjiXulXdK0B3wwtsFzcZypnt+GC1+3hKRD6InWWCCB0BOKKaO+YgtedG
         pQH8eFLNDQjaT54rNcEY3e4qkB1ifa+rQ0DX3vgvsBQs3wxNW/wS1W8Gpr++Pu4l1dGE
         F8LFKuOZNNKB0SZHo0VEFeU41NpEXX7ck3iF5PSjRdXEYfrDuSVAhqf445yoHnre0nmv
         kuyjnW/g178NRB4RZ4I0fsprzO0+GHyjV7AKI6W879UdfvTrJkj7Xm38UrmUh98g6MU5
         k2bg==
X-Gm-Message-State: AGi0Puawp5xZfUxMnmPjXMVkxB1637FW8tTntmpM/a9EjQUxyW8HySm8
        pnYbEmFvGps2ZUnqWGbicTsjocEsnJxN1mZcbCXZgDNWelY=
X-Google-Smtp-Source: APiQypKe4bxZfYuzzEQUPhhPKUH1ce1/p4QCL+r6kV/swh+h383j+bfvNUpqmb4qqUT2H1kGVRzSGem7qxQCywgLpEk=
X-Received: by 2002:ac2:5455:: with SMTP id d21mr1114171lfn.23.1587063563989;
 Thu, 16 Apr 2020 11:59:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAOyLvt9=wRfpvGGJqLMi7=wLWu881pOur8c9qNEg+Xqhf8W2ww@mail.gmail.com>
In-Reply-To: <CAOyLvt9=wRfpvGGJqLMi7=wLWu881pOur8c9qNEg+Xqhf8W2ww@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Thu, 16 Apr 2020 15:59:12 -0300
Message-ID: <CAHd-oW4NK3E2umq9OXXW9TUyLKQwWN4R-b1KKK117tWPc=K7aw@mail.gmail.com>
Subject: Re: git-grep's "-z" option misbehaves in subdirectory
To:     git <git@vger.kernel.org>
Cc:     Greg Hurrell <greg@hurrell.net>,
        Junio C Hamano <gitster@pobox.com>,
        Andreas Heiduk <asheiduk@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[Oops, I messed up the headers in my reply, so I'm not sure if the
message was properly delivered. I'm replying again, just in case.]

On Mon, Apr 13, 2020 at 6:57 PM Greg Hurrell <greg@hurrell.net> wrote:
>
> It seems that `git-grep -lz` behaves differently depending on whether
> it is inside a subdirectory:
[...]
> $ git grep -lz content
> an "example".txt^@nested/other "example".txt^@
>
> Note that, as expected, the files are NUL-terminated and not wrapped
> in quotes. ("^@" represents NUL byte.)
>
> $ cd nested
> $ git grep -lz content
> "other \"example\".txt"^@
>
> As soon as we move into a subdirectory, files are wrapped in quotes
> and contain escapes, despite the "-z" switch.

Note that, differently from other Git commands, "-z" doesn't affect
quoting/escaping in git-grep. For example, while git-ls-files' man
page says:

-z
      \0 line termination on output **and do not quote filenames**.

The git-grep one only says:

-z, --null
      Output \0 instead of the character that normally follows a file name.

Indeed, this inconsistency might be a little confusing. The reason for
it may be because "-z" was added in git-grep [1] to mimic the GNU grep
"-Z" flag, which outputs '\0' after file names. In GNU grep, pathnames
are never quoted (regardless of whether or not "-Z" is used). Also
note that, probably due to the same reason, git-grep doesn't obey the
core.quotePath setting (which would make it quote unusual pathnames by
default).

Nevertheless, quoting relative paths but not absolute ones is a bug.
From what I see, we have two options to fix it:

1.  Make git-grep more consistent with other Git commands by always
quoting/escaping unusual pathnames (relative or not), unless "-z" is
given or core.quotePath is set to "false".

2.  Keep git-grep compatible with GNU grep, ripgrep and other grepping
tools, removing the quotes/escaping from relative paths as well. In
this case, I think it is also a good idea to add a note about this
behavior in core.quotePath and in git-grep's description of "-z" (as
it may seem confusing to those who are used to the behavior of "-z" in
other Git commands).

In my previous [and possibly corrupted] reply, I included a patch[2]
in the direction of the second option. But thinking about it again,
I'm not really sure which one is the best way forward here. I'd love
to hear what others have to say about it, before sending a more
refined patch.

[1]: See 83caecc, (git grep: Add "-z/--null" option as in GNU's grep.,
2008-10-01)
[2]: https://public-inbox.org/git/20200414074204.677139-1-matheus.bernardino@usp.br/
(for some reason, the mail didn't reach lore.kernel.org. Probably my
fault, messing with the headers :/)
