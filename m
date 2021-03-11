Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA1C8C433DB
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 09:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6566764DF0
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 09:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbhCKJzE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 04:55:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbhCKJyp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 04:54:45 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0353C061574
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 01:54:44 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id y124-20020a1c32820000b029010c93864955so12789798wmy.5
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 01:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:openpgp:autocrypt:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6L8RhQhXshaQ2sf46etF3+M+m/as/I8PFBzqhqmbXkQ=;
        b=rgaTzmXGSeE2wEL/LzPyR7oyCjJSOkwF++P4UlJmw+DmXmwKY15g+rgcF3kI+fuDy7
         ESfSTO72p63TB9QONn7X0yarmkpwhytMnij+AbIoqI2hc806lFeM4uI8+lWWg8mgvwq2
         N28hYIUHb8BA8t4F4PBOLW/fdws1ZMOqJUhisLZ/3nuA5QzeAHHW3EDD34aTWePcZTVX
         qRDifVpemNo6QfwHJetbem/x8FPcXZWV8A1sLizbRJkHiZSIIJIkMWIU9SS97T7POPF9
         ueLigqSuvbTSE1+YxEsHDGwABNiBK4+OuPXMPWM/eUCntbgI7KGSWqxhZlrUH8Jtklfc
         vghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:openpgp:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=6L8RhQhXshaQ2sf46etF3+M+m/as/I8PFBzqhqmbXkQ=;
        b=VhRcdZu0jy5b2/0Sb7cML9wYJouJ7TuRLv94zZVRd0oEJLjkbnMRbuPE71iRUhjc31
         PWufbhbT8Gb4f6Arkxkz2AuUNwo0s3LEkNKGcyz1fWbsSmXYNYPKtDk443eeGhgERSY6
         KWLLoHAO9bwWi+Ong8MZIG9mjKY2tEdnG4/zxyXjS/L6cob/ZlfZyOUHYTYZTJVB0Nic
         jXb8plHNsO6zwFkYlkiNpvqA+N5l+YJ5XhPVjsEO5ZUxwNQzEKQ4msslOgdt0d7x516+
         iAticjsI2zSjZF+ODj6QyMz7LdgF1MI9S+stGTwxis312ruc16p6ypMJSgVHeGrN9PI5
         pcUQ==
X-Gm-Message-State: AOAM5330En49oLArYfIHo7Vq0K7v6KVcNByzZ4EcrrC4QfozxpjWLx9B
        aLQ2m6vRyH0vBuFnIPa6i9k=
X-Google-Smtp-Source: ABdhPJwg4tH8lmyXhSvdhgc1UD4n/yz1jo7guaD17gtsuZqkIeLk1Nm8qGcyt5CGW6hrXBFpuKHN3g==
X-Received: by 2002:a1c:6a05:: with SMTP id f5mr7266866wmc.75.1615456483375;
        Thu, 11 Mar 2021 01:54:43 -0800 (PST)
Received: from [192.168.178.32] (pd9e1c3b3.dip0.t-ipconnect.de. [217.225.195.179])
        by smtp.gmail.com with ESMTPSA id p12sm3010348wrx.28.2021.03.11.01.54.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Mar 2021 01:54:42 -0800 (PST)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <f6cd9386-8a58-ee52-4c7b-60d9bd14a51d@gmail.com>
 <xmqqblbqipeh.fsf@gitster.g>
From:   Ephrim Khong <dr.khong@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=dr.khong@gmail.com; keydata=
 mQENBF2KH3QBCACy66z3LoDOvFnn3Jl07bZvGy8IWXoClBLBEVQEDMgX6/2VskvAiDFYXjYY
 CBnpMZS7pkHyMj2nAuk8rfz8ofhTMxW1YthQGAGJt0eYMp9dymKG4O9c6Lzwlb54lwWet1AE
 x326ePst0QaBkvksN8HmoqNrTZVth2U+IiAI5y7RJB65ZsXmHoXBt4pfPEoQ01WFTXBrQ2ZR
 LHcweZQdU1uhwPjCB6JV9pNTclzFfQyqqga/JbbDbbplhL5XhA15VJq+3CJSM3Y0M1UGEOUv
 5dcWC15x65jlX4yDIrXUYkWq48byHlC8B75n9EnMAvmkFZ09ntSjwsRJmLILxr8cz9jtABEB
 AAG0J0JlcnRyYW0gRHJvc3QgPGJlcnRyYW0uZHJvc3RAbXZ0ZWMuY29tPokBVAQTAQgAPhYh
 BLWZoXdIkApCXec/7OxiOFtXzt5/BQJgAaaWAhsDBQkDw4IsBQsJCAcCBhUKCQgLAgQWAgMB
 Ah4BAheAAAoJEOxiOFtXzt5/k0MH/3G9nXfyfOiTQlANSQwQrXfpsvX+OJHCjLIpWgIUzMlN
 1LNacOn3fKxUWhiy/eXzNUAumL8lqRuLcjz6BcEhSIp7aWOYNqiQ0zSl7Qo3QxcL4k1tuAXz
 aOo1l9Kk9SzviPN7SGjCK4jrMKlEjBoA3G8OtxaJfk9XQRbkYVJFiIaTHh5puz2aoFgTCtB6
 qWpBfd59rmmYo16VbgK7qx0HaVijFQK6YyUFwnYVzCpGj4xCtrWs0awexbgzRmBUn3hEtD8P
 oMLbf/SaPqYhbH/iRUT8YAteWNi4teD9PQX436FOWXzFTR0DnURlNB9CfDj4YjGm9jeZ31i7
 8KdCEL+7/P25AQ0EXYofdAEIANMR2v+vHOPGHZUG/KrziIdliwF+VIUh58z92nIlvdrb+B2K
 QCVseYwkYvqMJkLaad5DbA2POwU1AofvXhGiNiNhiC02mwO+gHnX6Bz0SubfytdZd70SBcrD
 YNHsqJKHYPRS/AwWA5xRPTt7elsGrMkx7QU3QBeJhYPjEfjOjSAFNuPbSKKBw1oG8cZFihse
 D44MeDUJeODVWI7wl5VfIzW7cQ1HfmhPMC4I7cdz0D19RmTsvwDY5Er8uCiuKD/otnH/GeHp
 PYNSXxcAOjyuCbZOi/ps1BQp1UXJudIxS6w1Z9weJ3dgndd4ZmwcSPq+VHT2xcypM77Iff/g
 nvWK7zcAEQEAAYkBPAQYAQgAJhYhBLWZoXdIkApCXec/7OxiOFtXzt5/BQJdih90AhsMBQkD
 w4IsAAoJEOxiOFtXzt5/f58H/2tYnryojtNWwuVE1iJwBol1FJ+wg+NgqxQ+lgYu/JfoxNJY
 fDAPv5bNsfIoC7D6zJwZ+d6XFjb5tQITXT5fFJYgTaVKE9p+acsgXPoERLqF2NNK5hVHPz5K
 fENTojGN9aLElsyPDmFrnYZYqrvm1Ex4qcQ4mkIWI20CLfK84+Wi/6o/dE/uYu1chKNbfkZh
 B8krQZMfy1FAkrPbaIvuG6HgFd7gTWNmg2O4g7RRM/n+SgBFocnHY4bBc7WNgS+9h5imFeQk
 2Xy+Vjg5pJ+Q5b+6ULbGNUonKFhT9++RFH/FA2A4rYKoyEW3MbZKQAgqOVLDknad5HOaDFA7
 Mt212FU=
Subject: Re: [RFC PATCH] merge-recursive: create new files with O_EXCL
Message-ID: <cd7c6682-7409-f72c-8751-02b70a423f83@gmail.com>
Date:   Thu, 11 Mar 2021 10:54:41 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <xmqqblbqipeh.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11.03.2021 00:01, Junio C Hamano wrote:
> Ephrim Khong <dr.khong@gmail.com> writes:
> 
>> When re-writing the content of a file during a merge, the file
>> is first unlinked and then re-created. Since it is a new file
>> at the time of the open call, O_EXCL should be passed to clarify
>> that the file is expected to be new.
>
>                                          But the use of O_TRUNC has
> spread over time to other parts of the codebase, perhaps cargo
> culted.  If you look at hits from
> 
>     $ git grep -e O_TRUNC -e O_EXCL
> 
> you see the combination of CREAT/WRONLY/TRUNC used all over the
> place [*], especially in newer parts of the code.
> 
> So it becomes very curious why this one location needs to be so
> special and you are not patching other uses of O_TRUNC.

The main difference is that this is the only place where the file mode
matters, since we want the executable bit set for some files in the
working directory. All other locations create the files with mode 0600
or 0666 and are happy as long as the user has rw rights, which appears
to be the case even when running into my nfs-issue.

> I do not think we mind fixing the use of O_TRUNC with "remove and
> then create with O_EXCL", but we'd probably want to
> 
>  * understand why only this place matters, or perhaps other uses of
>    O_TRUNC needs the same fix to work "correctly" with your NFS
>    mounts, in which case we'd need all of them addressed in the same
>    series of patches, and

I'd say that is up to you. Personally I'd rather err on the side of
caution and leave the other code as is, especially since it is not
really required for the file mode issue as described above. But I'd
happily patch those places as well if you find that to be a better idea.
Maybe refactoring this (fstat - unlink - open) into a common function
would make sense then.

>  * understand why your NFS mount is broken and give a better
>    explanation as to why we need to have a workaround in our code.

I'll work on this, but unfortunately have no idea of how to properly
debug it. Since it is a company server without administrative rights and
the backend is some IBM storage system, the options are limited and
processes are slow. What I did find out so far is that it is not a race
condition with unlink. A simple openat() without O_EXCL already produces
the wrong file mode.

(I fully understand that this is not a bug on git's side, and I found no
documentation indicating that O_EXCL would be recommended or have any
effect in this way. Hopefully, others that run into similar issues would
benefit from this as well, there are a few reports online of people
running into "failed to refresh" errors.)

As a side-note, the strace on the affected file also shows that git
writes that file twice during the merge, with the same content. There
might be some potential to further optimize merges to avoid such
double-writes. A small example to reproduce, note how "b" is opened
twice during the merge:

  git init
  echo "foo" > a
  git add a
  git commit -m "Initial commit"

  git mv a b
  git commit -m "File moved"

  git checkout -b other_branch HEAD~
  touch c && git add c && git commit -m "Some other commit"
  strace -otrace git merge master -m "merge message"
  grep '"b"' trace

Thanks
- Eph

