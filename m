Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8085C05027
	for <git@archiver.kernel.org>; Tue, 14 Mar 2023 20:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjCNUhw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Mar 2023 16:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjCNUhv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2023 16:37:51 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6322A6E2
        for <git@vger.kernel.org>; Tue, 14 Mar 2023 13:37:50 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id d13so6583633pjh.0
        for <git@vger.kernel.org>; Tue, 14 Mar 2023 13:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678826269;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QCqJ3qEFBJGz6kCHk8HvaYhrnsGa52N08IMyH4FcKxo=;
        b=DAa7HP0lM+c2FY/YQWEIM0/ftB6AD7IJ/ry6IExLXSsjvCQmK87D5ckKgh3uii8JxR
         7NVLEXu5OV5ZInBZ1mos3biJHx8LlI+1prmxnKdTpfnb7Cxtr95EdiABbrZMcRrP756j
         dWRvmGa11pILet07yUjD3yBcQTTqh2kiDOrDbiDMeNfFgjr+lTABsUx7lSmuBfNxDXqF
         /O9sxRfgcIlp4UcRHvhN/hiNITN7OuLZLOtMPzdCeYkoPP988P9GGpnlticY3aR2cb/8
         TLDu7J+Nfv+DllwNO9wAv3dC+mHxDTReS9VkF2be9PfzZzRbGelAaEq1GzEdUUfgpKWO
         NiWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678826269;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QCqJ3qEFBJGz6kCHk8HvaYhrnsGa52N08IMyH4FcKxo=;
        b=UcUYXDtqb775c4S8kTenPFhDvzGBh/B2sjAAOuzmo0TjvFjbG65bmjdMr+m/+q3g7Y
         2yuO1IwOWNI6ZwCGRr2LsDn+W0PdiT/z+IZ8fRbrrGZ2gB/DcONUJb6I14VMPS0yVFVb
         eGq0dkqYOjRAIqJkMKtgB3GI/Y+zgPaicOgJxYlj0mw77DQtWGV1GzXZ6fd/QpBzMNL/
         APlKrF1BYmg/CFEHRAjOmbxo5AqcyHWASwBRybI5P9tXh7rBRpGyYldL7bQIHszsoM7J
         YUeQmxF7l/R7bGqti5f0wqfFiP4wvgLfsDlgwlk5yfwVJsbYJLz8AdVZni+hHj1gqPOm
         S76g==
X-Gm-Message-State: AO0yUKVJliAzsxkuM7JgELxEXyMPxfeSWkn8zE82tj+t6NNu/aTC7buQ
        K04jXPbQGxpIBJUyKI3uLMk=
X-Google-Smtp-Source: AK7set8kuIvUDe2WHs1XoR/wIqVqZV+TrK7k6qqF0NmKBXPREn0/QH+Tb6DIEjuVnHCDocxRi1lWkw==
X-Received: by 2002:a17:902:da87:b0:199:3a4a:d702 with SMTP id j7-20020a170902da8700b001993a4ad702mr283786plx.0.1678826269568;
        Tue, 14 Mar 2023 13:37:49 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id kj6-20020a17090306c600b001a057d36dc1sm2157326plb.138.2023.03.14.13.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 13:37:48 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     John Cai <johncai86@gmail.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/2] diff: use HEAD for attributes when using bare
 repository
References: <pull.1459.git.git.1678758818.gitgitgadget@gmail.com>
        <0fc704cf1c0724473a61086098d44c3a82938b03.1678758818.git.gitgitgadget@gmail.com>
        <xmqqttynqnnj.fsf@gitster.g> <xmqqa60fqld6.fsf@gitster.g>
        <20230314193839.wevenngf324pijhb@pop-os>
Date:   Tue, 14 Mar 2023 13:37:48 -0700
In-Reply-To: <20230314193839.wevenngf324pijhb@pop-os> (John Cai's message of
        "Tue, 14 Mar 2023 15:38:39 -0400")
Message-ID: <xmqqy1nzoyqr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

John Cai <johncai86@gmail.com> writes:

>> Just for illustration, here is one way to do so.
>> 
>> The implementation goes in the opposite direction from the more
>> recent trend, which is why I am not making it an official patch, but
>
> Could you explain why this goes against the "more recent trend" for my
> understanding?

The illustration uses a global state.

The recent trend is to reduce reliance on global states and use the
repository object and others that hold such state through the
callchain.

But a new global variable that holds the fallback tree-ish object name
was a so convenient way to illustrate the core of the idea, without
having to change many callchains.

>> with this you can do things like:
>> 
>>   $ git --attr-source=e83c5163 check-attr whitespace cache.h
>>   cache.h: whitespace: unspecified
>>   $ git --attr-source=e2f6331a142^ check-attr whitespace cache.h
>>   cache.h: whitespace: set
>>   $ git --attr-source=HEAD check-attr whitespace cache.h
>>   cache.h: whitespace: indent,trail,space
>
> I like the idea of an option that is global. For git-check-attr however, we

I guess I shouldn't have used check-attr to avoid confusion.

The point is that the internal mechanisms introduced by 47cfc9bd
(attr: add flag `--source` to work with tree-ish, 2023-01-14), which
taught check-attr the --source option and is reused by this
illustration patch, was a good idea, but its UI was a mistake.  We
do not need per-command --source option the commit adds if we did
the global option from day one.  Yes, I think we can deprecate the
"--source" option from there, if we all prefer the global option
avenue.  I _think_ git_all_attrs() needs to be told about the
default attr-source trick (which I didn't touch in my illustration
patch) before it happens, though.

If you used the mechanism in the illustration patch I gave you, and
adjusted the test part of your patch to match (i.e. "diff" does not
learn "--attr-source" option, but "git --attr-source=... diff" is
how you make it read attributes from a tree-ish), would the result
work well, or do we need more work to make it usable?  How well do
other commands (e.g. "git show") work in the same test repository
you created in your version?

Thanks.
