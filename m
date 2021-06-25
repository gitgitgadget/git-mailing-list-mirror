Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E923AC2B9F4
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 08:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C953C6141F
	for <git@archiver.kernel.org>; Fri, 25 Jun 2021 08:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhFYI7G (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Jun 2021 04:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbhFYI7F (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jun 2021 04:59:05 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7FFC061574
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 01:56:43 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso7954918wmh.4
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 01:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=kLIgOXevfOq85Zml0LJI1XnW+p/Zl8OIBeo64tnP5SI=;
        b=JBuXV/utLWRaL68cprRtZ7u+0KviqYVG6iKu34umxYTWk1yCawfkO3QQSuYF5kIYev
         qP8UKM83ZFYjDMJ1Ftfl97BJXSHfQJMvjvgusqaElX+JHdTQjAWemg9xfQmlMI7Aw5T4
         tXg9oWx+TBdJQD16aKPluOiME0J91qKkNIPI0NL1Pjh3gYIH5iSJhWoRQGTS1zVc4gJS
         r9srocRRIpEdZCrRJ4KwZIuVic3baP9O7NDLYJ6GtUcMf/a8FgiAmOkyfk6HrugTvr/B
         ipLa4ElgGjxlaeM1qT+KeQYTykGf5nhY5b28+i6Rex3tpR0SRyXl+tBel0b1UG6qp9OL
         w4zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kLIgOXevfOq85Zml0LJI1XnW+p/Zl8OIBeo64tnP5SI=;
        b=F4zpa4fgwIr+jFZIMbTtEtfNCzw+jCv1rNSHhin+cxq5oWa/4xv5X08uV0dFfXBgc2
         ArWvt79YDsxsLBfRvx9ygFRGvPkiR9WQGUGoFgmwDws/08Lw98QOP+JBz8eHcN6DeD8V
         c5Zaj9iVu0RF34MKPaaKwk7tJszz07TIwk/Pj2bgJ8tj0Qi1+55Xuu+uKKzdGT37H2xg
         NPSPphfS3ijezOh348iUv44JVeBPPB6JytknSVdTWkC19uSKImvd68BkBzrvpKaXcFXx
         zD7a8wMK7ZbIbLG5mWIMVaG9Zo5hhrTuTNIRXrn93mLh71s9YoJPDeR1NGOeTst+Jlv3
         vp2A==
X-Gm-Message-State: AOAM532jXuxzl5MfpDVYVK8Hx5WCaNEqTKHN+I9RWog6RdCfRQbK1xAU
        AMT8houXb/EBj90LDtYE0VQ68kw6k4M=
X-Google-Smtp-Source: ABdhPJyF9L6EEKLU9O/ErIwR2K1lyvcrngU/guk/w+arWvi9jz6tDCEKkjOZ3ukPDJaeylBWunV/vA==
X-Received: by 2002:a05:600c:1c2a:: with SMTP id j42mr9031720wms.173.1624611401891;
        Fri, 25 Jun 2021 01:56:41 -0700 (PDT)
Received: from [192.168.5.102] ([87.116.176.212])
        by smtp.gmail.com with ESMTPSA id g10sm5095820wmh.33.2021.06.25.01.56.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jun 2021 01:56:41 -0700 (PDT)
Subject: Re: Definition of "the Git repository"
To:     Kevin Buckley <Kevin.Buckley@pawsey.org.au>, git@vger.kernel.org
References: <7dd55e85-38eb-7346-ff10-7124102cd22b@pawsey.org.au>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <9099ab09-f6d0-f1e2-1b8e-a55d22a903c5@gmail.com>
Date:   Fri, 25 Jun 2021 10:56:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <7dd55e85-38eb-7346-ff10-7124102cd22b@pawsey.org.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 25/06/2021 03:44, Kevin Buckley wrote:
> 
> raising this on the back of a discussion over at the Software
> Carpentry lesson about Git,
> 
>    https://github.com/swcarpentry/git-novice/issues/810
> 
> I used the book to justify my claim that it is the .git directory
> that is the repository, but I do have to concede that the way that
> the text in section 2.1 of the book reads, does suggest that one
> can refer to the working directory PLUS the .git directory as a
> "repository" as well as being able to refer to the .git directory
> alone as the "repository".
> 
> In the way I think of it
> 
> git init
> 
> initialises a Git repository, however, the only thing that changes
> as a result is that a .git directory has been created, ergo, the
> .git directory is the repository.
> 
> Furthermore, the fact that one can take the .git directory, move it
> to a new directory and start using it there (very much a nice feature)
> also suggests to me that it is the .git directory that is the repository,
> as distict from a working directory, under Git control because of the
> existence of a repository within it.
> 
> Interested to hear any thoughts around the semantics here,

Thinking out loud, and without discussing various places where "Git 
repository" might be described one way or the other, a "repository" 
is a place where *something* is *stored*.

"Source code repository" would thus be a place where source code is 
stored, possibly with some metadata (current version, last change, 
etc.), but not necessarily the whole (versioned) history. For storage 
purpose alone, Git's own working tree could be then considered a 
repository in its own right (source code repository, if it contains 
source code, but it could contain other stuff as well, in addition or 
standalone). But as soon as you start working in it it's not really 
(only) a storage anymore (so not a repository), but a working area. 
It's more of a conceptual thing.

So if we strictly speak of "Git repository", I think it should be a 
place where Git keeps (stores) your (committed) work, alongside its 
own (meta)data - and that is the ".git" directory, indeed. Seems 
simple enough :)

One place where the confusion might be extended is the notion of 
"bare repository" for ".git" directory alone (without the working 
tree), which should then imply ".git" + working tree is in fact 
"a repository"... which it is, but bare with me - pun intended :)

As Git is mainly used to version artifacts being more or less actively 
worked on (changing, that is), one needs a working area in order to 
do the actual work, thus we have a working tree happily and conveniently 
provided by Git by default, as part of *working with* a Git repository.

As you said, having ".git" directory alone is enough to recreate the 
contents of the working tree, where if you would have the working tree 
alone, even if that could be considered to be "a repository" (for 
storage, not work), you would definitely not have "a Git repository" 
(no ".git" directory).

Also, when you work with a remote Git repository, it's only the 
committed stuff you can work with - what's inside ".git". You have no 
idea of contents of a working tree (and ideally not knowing if one 
even exists, though that's not always the case, like if you try to 
push to a checked out branch).

For some additional understanding, I guess we can compare "repository" 
with "archive", possibly being a more familiar concept - you can 
store source code somewhere, and that's your archive. You don't work 
on it in there, as then it would not be an archive anymore, but you 
keep it as a backup which you can always retrieve if needed.

If you use ZIP to compress your archive, it's then a "ZIP archive". 
And for the most of the time these two would in fact be interchangeable 
- you can have one or the other, being able to recreate one from the 
other (unlike with ".git" and working tree).

BUT, if you add some additional (meta)data to your ZIP archive - like 
password, description, etc. - then the two are not interchangeable 
anymore, "ZIP archive" not being the same as "archive", not being able 
to be recreated from it.

To conclude - Git's concept of a "working tree" alone could be "a 
repository" (used for storage, not working), but it's not "a Git 
repository" without the ".git" directory in it. On the other hand, 
while "Git repository" must have a ".git" directory, it can have a 
"working tree", too - but it doesn't need to (called "bare [Git] 
repository" in such a case), as it can be completely recreated from 
".git" directory alone, being a mere convenience in order to be able 
to do the actual (development) work (and not required for "Git 
repository" to be a "repository").

Finally, as "Git repository" could be referred to as only a 
"repository" for brevity (which it is, in general), it's important to 
notice the latter might be ambiguous (as it does not imply "Git 
repository" in particular), thus using "Git repository" when being in 
the clear is paramount, indicating that you're interested in ".git" 
directory precisely (and possibly, but not necessarily the working 
tree as well). If interested in ".git" directory alone, "bare Git 
repository" is the most precise term.

Regards, Buga
