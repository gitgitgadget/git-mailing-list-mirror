Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 583D4C433EF
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 19:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30BB361019
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 19:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241539AbhJHT4b (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 15:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbhJHT42 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 15:56:28 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6A4C061570
        for <git@vger.kernel.org>; Fri,  8 Oct 2021 12:54:32 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id z20so40171534edc.13
        for <git@vger.kernel.org>; Fri, 08 Oct 2021 12:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=lpXBZMPwKqxtaVJluPWvoh1JBpDFR6/1dQmOFQhYq28=;
        b=aIyxUZ9sc7KAn/QgteScXJM7w90CBM1fFT15wXsjl8NYzBcLeBHzFFjLrVE10C9bWj
         dUYCpFkEFFvwpeHm2PW0ey7LzWq76Kug25JaWCytcIWwgcQwGKdr3xYOP74esrT+SEdX
         zttN6p3Xmx/A0iIQZHugOdma0mag9KdOTiJwGZUXXjo8ny+pBe6GL8zMSb2gOc3r7kQ8
         gxWFvqds8bbDpsxEGVe8ou6u1jS124gs4zGcTo4nQXKxSxxyrH88dV1+yA8rxN4x+NzA
         nbX23tE+DKXGi99xs7YrPxVSOp190+cmGMGV0avNaUxY+QWkHOyQDgYiy1NZf36ZK0TZ
         6ukw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=lpXBZMPwKqxtaVJluPWvoh1JBpDFR6/1dQmOFQhYq28=;
        b=Q0wLYb6427l6blhko85EvJFrz1q/1O8f/4oJNJUGccmiX5d6keh0VGoFRtHoUlFJBt
         1tzky/dgVuzN3EoOriKVpya1Nl43G+h6sjThHcBqEa4wAhrX8UyrLBKT0M0gXQUFxSAD
         hE6T8CWqWeb6KcUg0Q80rRzvSklBWEQDMgYyDhUB0mF2JaMdvO806BS4BJXUXYDpot1t
         VXjmcMqFQDUDiqVcldwR6j54paE4mW99Y33g8QD8u2GcZPYjwYcbXzz8GvyYRl5X8R4R
         gjv+QocLIKC7EhlqRmRqTQqVjxyAbAvHh7pc+MSJ9ON1Q8yCZfcMKfweK1GQFdyF4/1l
         3bcg==
X-Gm-Message-State: AOAM530khhngNugvggKjLqMLZpKYZkDUqs8WjL4f23iK8HTOkR+CUZ3I
        CuAureW17tKkmzHt4LZKdPqfnMfJW6xaHg==
X-Google-Smtp-Source: ABdhPJyS/N+YMGBaRBkrPS7en2P8qw1kDz5Md9tUvL3NZPn5OHGVgWmtQoPon2cMsEW1PO+7qpjkPw==
X-Received: by 2002:a50:da06:: with SMTP id z6mr17804990edj.355.1633722871269;
        Fri, 08 Oct 2021 12:54:31 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id 19sm85294ejw.31.2021.10.08.12.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 12:54:30 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Ivan Frade via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Ivan Frade <ifrade@google.com>
Subject: Re: [PATCH 2/2] Documentation: packfile-uri hash can be longer than
 40 hex chars
Date:   Fri, 08 Oct 2021 21:43:24 +0200
References: <pull.1052.git.1633708986.gitgitgadget@gmail.com>
 <497c5fd18d7206c137d8a62d229d2f295c9fe4fa.1633708986.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <497c5fd18d7206c137d8a62d229d2f295c9fe4fa.1633708986.git.gitgitgadget@gmail.com>
Message-ID: <87v927mgw9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 08 2021, Ivan Frade via GitGitGadget wrote:

> From: Ivan Frade <ifrade@google.com>
>
> Packfile-uri line specifies a hash of 40 hex character, but with SHA256
> this hash size is 64. There are already tests using SHA256 (e.g. in
> ubuntu-latest/linux-clang).
>
> Update protocol-v2 documentation to indicate that the hash size depends
> on the hash algorithm in use.
>
> Signed-off-by: Ivan Frade <ifrade@google.com>
> ---
>  Documentation/technical/protocol-v2.txt | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
> index 21e8258ccf3..a23f12d6c2b 100644
> --- a/Documentation/technical/protocol-v2.txt
> +++ b/Documentation/technical/protocol-v2.txt
> @@ -393,7 +393,7 @@ header. Most sections are sent only when the packfile is sent.
>      wanted-ref = obj-id SP refname
>  
>      packfile-uris = PKT-LINE("packfile-uris" LF) *packfile-uri
> -    packfile-uri = PKT-LINE(40*(HEXDIGIT) SP *%x20-ff LF)
> +    packfile-uri = PKT-LINE((40|64)*(HEXDIGIT) SP *%x20-ff LF)
>  
>      packfile = PKT-LINE("packfile" LF)
>  	       *PKT-LINE(%x01-03 *%x00-ff)
> @@ -476,9 +476,9 @@ header. Most sections are sent only when the packfile is sent.
>  	* For each URI the server sends, it sends a hash of the pack's
>  	  contents (as output by git index-pack) followed by the URI.
>  
> -	* The hashes are 40 hex characters long. When Git upgrades to a new
> -	  hash algorithm, this might need to be updated. (It should match
> -	  whatever index-pack outputs after "pack\t" or "keep\t".
> +	* The hashes length is defined by the hash algorithm (40 hex
> +	  characters in SHA-1, 64 in SHA-256). It should match whatever
> +	  index-pack outputs after "pack\t" or "keep\t".
>  
>      packfile section
>  	* This section is only included if the client has sent 'want'

(I forgot to say in my first reply, but welcome to the Git Mailing
List!)

This is well spotted, but it seems even better to simply drop this
exhaustive listing of 40 or 64 hex digits here.

In protocol-common.txt we talk about "obj-id", and that's then used
elsewhere in protocol-v2.txt matter-of-factly, e.g. (quoting from a
handy part that happens to use "obj-id"):

    [...]
    obj-id-or-unborn = (obj-id | "unborn")
    ref = PKT-LINE(obj-id-or-unborn SP refname *(SP ref-attribute) LF)
    [...]

So let's just have packfile-uri do the same.

Now, the thing that *does* need to be updated then is
protocol-common.txt, or this part:

  zero-id   =  40*"0"
  obj-id    =  40*(HEXDIGIT)

Because now if you use obj-id that'll just refer back to that, but
that's also a problem with all the rest of the protocol docs.

It would seem that all our SHA-256 tests and client/servers are in
violation of the documentation, and should truncate their OIDs to 40
chars, or we could fix the docs :)

Anyway, whatever we do here this improvement is unrelated to whatever
we're doing with log redaction in your 1/2, I think it would be better
to submit as its own 1 or 2 patch series.
