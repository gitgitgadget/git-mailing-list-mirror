Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834AAC433ED
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 09:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 448A4610A5
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 09:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234888AbhDBJlH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Apr 2021 05:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234901AbhDBJlG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Apr 2021 05:41:06 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AC5C0613E6
        for <git@vger.kernel.org>; Fri,  2 Apr 2021 02:41:05 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id l18so4891653edc.9
        for <git@vger.kernel.org>; Fri, 02 Apr 2021 02:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=SNpod0bg3/c1h1OE0QOaa/q8ij505wbMgbPQ0AHMSFM=;
        b=G/nRs+3rJL6+dZ4BejPv0y6/UhU93njpN4I/rsxKquYLok0Y4DCDWjRn0UruB8sEOD
         HQp4a0NVBQhv5Ab+ZZOYXE3io8MrgL1muYZLNLLdnk+f+0e/PjqlFZ0nmVCva8hW38zY
         TLFnf/I+IKr9aYq/vxMxvk4KqvNRfGXut2E9gIS/qi6AdWYt1Lt1/lmEHCc5W5nU0qU4
         oZW8VMYl0FzueKflDMnc6Q+NqTua49rNxnLB23t5ixYRX8395syL3Ts3Nb4ZlR2mAPIK
         4NofjiQAKOV1z+KeATMSoIKmsxY4wofVPgBUKHk4vlFNKRmSS8q4+Nm1IvaeYOdRg5d9
         R1Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=SNpod0bg3/c1h1OE0QOaa/q8ij505wbMgbPQ0AHMSFM=;
        b=gt5PnqDbmsSCkccrK0VR8txW4a/JNjU5Ga6IfzD1UM3CDPUtu9VkLnUwjk9fH4Un6C
         MpqGbv7MctevcIiNG107TedlT7d0mfXtwRxcPrYd4OvFd5C7mPaBEXx6f6apBAkmQ+3C
         KZPjA05IIIMO69u8FT3CFPY0XDr99nlxJ1I9SjIfa6xxwj8hUgpsXQ8obbuf1INY9RrT
         9Vf+1HxLLbMXDhHA6e4eRF80nFrwyKN2DEeyGJIsN76zuf1nZkPYzYjVFkI0CTD+8hph
         UmNcVLwZQvffD3Xwuc6yIZ/FIzEsM0IoFPD90+O984zHvUHc/MnUVaSLWYrRMWmdxZKY
         NUqA==
X-Gm-Message-State: AOAM533kQeIaFVZ2aTiSZP6I3669SLyV9Eg4nZjRwToGhNcpi7QI5OWR
        72GJ/mzLQVgAzeXE59NkYXE=
X-Google-Smtp-Source: ABdhPJx8Pbctj8l2tFu43ylaS3BY5XM9ZfNqUlX1Xh0bG1RkI4Xzd3eXfeM6BHKt5ksRBeRU3/98tA==
X-Received: by 2002:aa7:cd0e:: with SMTP id b14mr14898106edw.354.1617356464251;
        Fri, 02 Apr 2021 02:41:04 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id yk8sm4036202ejb.123.2021.04.02.02.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 02:41:03 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v5 16/18] tree-walk.h API: add a get_tree_entry_path()
 function
References: <87o8fcqrg8.fsf@evledraar.gmail.com>
 <cover-00.19-00000000000-20210331T190531Z-avarab@gmail.com>
 <patch-16.19-3ba77fd3a47-20210331T190531Z-avarab@gmail.com>
 <xmqqzgyh20vn.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <xmqqzgyh20vn.fsf@gitster.g>
Date:   Fri, 02 Apr 2021 11:41:02 +0200
Message-ID: <875z15kor5.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 01 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> -		if (get_tree_entry_mode(r, hash2, del_prefix, shifted, &mode))
>> +		if (get_tree_entry_path(r, hash2, del_prefix, shifted))
>>  			die("cannot find path %s in tree %s",
>>  			    del_prefix, oid_to_hex(hash2));
>
> The observation that many "get_tree_entry()" users do not need the
> mode bits and the code can be simplified by taking advantage of
> that fact is good.
>
> It does not automatically follow that it is a good implementation of
> that simplification to introduce a variant that does not take the
> mode pointer.  The original function could have just been taught to
> accept NULL in the field the caller is not interested in, as in many
> other functions do.
>
> Besides, get_tree_entry_mode() vs get_tree_entry_path() does not
> make any sense as pair of functions with contrasting names.  If it
> were that unlike the former that returns mode, the latter returns
> path instead, it would have made sense, but that is not what is
> going on.  The former returns object name and mode, the latter only
> returns object name without mode.
>
> In any case, at this point in the series, it is highly dubious that
> an extra function is an improvement.  Teaching get_tree_entry() (do
> not even rename it) to take NULL in *mode pointer would make a lot
> more sense.

Thanks. Yes that makes a lot more sense.

This whole path of introducing multiple functions is an oversight of
mine. I did it because in 7146e66f086 (tree-walk: finally switch over
tree descriptors to contain a pre-parsed entry, 2014-02-06) we removed
canon_mode() from the inline function to make it trivially inline-able.

So I assumed without testing that introducing conditionals in that
function would matter to a compiler, and wanted to not introduce any
performance regressions (however small) in this series.

But looking at the generated *.s code under GCC -O3 it makes no
difference if you've got an "if (ptr) *ptr =3D xyz" there. The compiler
sees that and produces the same machine code.

So I'll re-roll this to do as you suggested, thanks.
