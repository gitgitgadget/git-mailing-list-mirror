Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27404C6FD18
	for <git@archiver.kernel.org>; Wed, 29 Mar 2023 21:48:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjC2Vsi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Mar 2023 17:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjC2Vsf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2023 17:48:35 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F114EC3
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 14:48:33 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id a16so15363203pjs.4
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 14:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680126513;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JUVLx+geZN6AoAKHtU3Y6ydNmEhLR+lnwzplqaujVYY=;
        b=i6Q52QU9uXzpNcN9uev+LGKnzs49EvQ2RAQ2a4M1gPBvZvyeDjJYjAh343PQoHrRyp
         YCfpV/doMFdHswRi/5iJbsblQXOJyWDepYrs7FAlFN+tJf00Q/uTZY6vw/PjynCKLIAY
         kdjIrulZ42WjgCev2TvGQ57KO89uw+ej+bh5NXqJRkqw0TxQGg+WnV8MtVC8bhE6klag
         0BulbBweER4IuxEs7APhMU0SMeJBMsWYKj2nx591+MNZ8v+rJ63iDPLk4td+ComGSLJs
         vR9l/bSrxQ5Gt4NsQ3XH8GSCELlbL9kmhchLLS2A/Kaqng+YInLAwPkIiVvmkw1prSyZ
         TbmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680126513;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JUVLx+geZN6AoAKHtU3Y6ydNmEhLR+lnwzplqaujVYY=;
        b=rJ3pKsHIlA4P6Cp95xCS9AI4jJH/Cww74RfbkLN2fnxGMkptZfvFixhsRHuRzHIiOG
         vkqS38tl6GsF5Frok3TRqIaEnkWPoiMkAgiuL8bAkA2FmIXMhD8KIk0W/tpIDOM+5vgw
         F8X8JNxsKKZsluSll4PQG3RHh8A7XiBzjIAlsBue39sz8i7UFIo4x85U1ae1Hw11G3PZ
         BmHdbUwzl5+UBNUveq0uSibVWViUNitwoyX++mVHl3UkVNJMh2awGoU0qdezzUaIdBcj
         Tqz/t1xNR40+my52L32hN2BaEEtX38KkzbrOYVC+4AnjCzON+37MTckqkL1XqcbVgQfX
         60FA==
X-Gm-Message-State: AO0yUKUOuinK+6mCPI3vNlvr0kesfY3nUcoXo+LkkOCxqaz7ItmupXPK
        G7oVd49obDXLWqM9WwwbZJU=
X-Google-Smtp-Source: AK7set8yeICSIMe6Msln89g8RwzH+z7xxw3WpXuzuwTXGDm9NWcUxC9bA27JA3Bj1OIQk/HkbUs6zQ==
X-Received: by 2002:a05:6a20:4913:b0:d9:c60b:a6de with SMTP id ft19-20020a056a20491300b000d9c60ba6demr18162220pzb.11.1680126512904;
        Wed, 29 Mar 2023 14:48:32 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id k2-20020a632402000000b005136b93f8e9sm4722462pgk.14.2023.03.29.14.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 14:48:32 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, git@vger.kernel.org, sunshine@sunshineco.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v7 3/4] notes.c: introduce
 '--separator=<paragraph-break>' option
References: <xmqq5yakhoo9.fsf@gitster.g>
        <20230329141559.14244-1-tenglong.tl@alibaba-inc.com>
Date:   Wed, 29 Mar 2023 14:48:32 -0700
In-Reply-To: <20230329141559.14244-1-tenglong.tl@alibaba-inc.com> (Teng Long's
        message of "Wed, 29 Mar 2023 22:15:59 +0800")
Message-ID: <xmqqy1nf8c0f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long <dyroneteng@gmail.com> writes:

>> > diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
>> > index 3288aaec..716192b5 100755
>> > --- a/t/t3301-notes.sh
>> > +++ b/t/t3301-notes.sh
>> > @@ -5,6 +5,7 @@
>> >
>> >  test_description='Test commit notes'
>> >
>> > +TEST_PASSES_SANITIZE_LEAK=true
>> >  . ./test-lib.sh
>>
>> This is a strange commit to add this.  If the test and the code
>> involved in the test were leak-sanitizer clean before this commit,
>> then you should have been able to insert this without any other
>> change, and we should do it that way in a separate commit.  If we
>> are fixing an existing leak that the sanitizer complains, then that
>> is a different matter.  If that is the case, it makes perfect sense
>> to have this here, but the proposed commit log message should
>> explain that it is what is happening.
>
> Will fix.

Thanks.

Just FYI, it seems that it is indeed premature to declare that this
one to be leak-free.  With this topic merged to 'seen', the leak
checker CI job seems to choke on t3301 (in addition, it also barfs
on t3307).

https://github.com/git/git/actions/runs/4557669485/jobs/8039614419#step:4:1817

