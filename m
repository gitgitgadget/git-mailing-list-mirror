Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC8351F42D
	for <e@80x24.org>; Thu, 10 May 2018 10:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934263AbeEJKXQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 06:23:16 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38820 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756660AbeEJKXP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 06:23:15 -0400
Received: by mail-wm0-f66.google.com with SMTP id y189-v6so3410909wmc.3
        for <git@vger.kernel.org>; Thu, 10 May 2018 03:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=K84wYJlTwjuqVobqMkgjePfvHuf3Kfvg2782PKLOTlI=;
        b=BSf4eB7EKsvRphTwnXSaWXzMnFmqDZSIXaEJFGVxymeCCruDQCTnuBvfzedu1nR+k8
         +8BHjUPuPGI4yzO2rflCxlM8rxflmA0GsC/cNAzxKDuinXIRYJyPD0+yTgIIrrvtxxA5
         ni0qnymuey2PoFlIisa7tjuqg0f2jRkXGz4RL1DhjsKyKYrtFQ+9/ijcm0tegVQNia7W
         qMs2aJD1aO1Kf3zJbZL9v2DNygILO+xmDqWr08bUZJkFu6nSIrl3fGzC0FE41GmUk3Ja
         mk1Wke38l2nSaO6nW8qzppX6eniLndQrBmPCsjfTYM7xsrEgDzG+GBuj46c+le7v4Eov
         bD8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=K84wYJlTwjuqVobqMkgjePfvHuf3Kfvg2782PKLOTlI=;
        b=qE7ZwHkSdP5CK4HjTirL+IWk4PV9Euw96FihMpoSt0r5s/XOBXgRnoTVKVBORr12cj
         P53wJpoq0f01UAz9WuyiTU4gQ/D9lhIcBlUF1uODC84tC4ngWS5qQzu3rz6bxFlXONN1
         UhSWTpE/cJAI4DlYQPaqFS7NPpsQ2j88z+scAneGfCzFw+gQMpZIzMQVwAn5IK/NRq6J
         LAa4iUGMJiY4nzUf59nH8ulXhCYZcKPAUUn3Q3eEwh2VRaGR7E6ipBc9yihpWF5TtERG
         n3/T0NKNcePRKt5tRBmG8rr/jRyee9sP6I86hEmBOST0gyOkfkGjVXgpOW8kqwJNHc6p
         quxA==
X-Gm-Message-State: ALKqPwdYQt9edjQRHuPz/eV3uOMHc+eG1vLXHihSlSZxrrG0NDOeWkBX
        kqUrfIKamc009hetpzZ4hF8=
X-Google-Smtp-Source: AB8JxZoD9Xn0Hqlyjc55wTSA7vZ/Wkzv7Hd16IMOfY/qhlAoxK/400DA49jWkwiTyWveJVGc56SxJA==
X-Received: by 2002:a1c:16ca:: with SMTP id 193-v6mr810808wmw.37.1525947794454;
        Thu, 10 May 2018 03:23:14 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id e7-v6sm750295wrn.88.2018.05.10.03.23.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 May 2018 03:23:13 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] replace-object.c: remove the_repository from prepare_replace_object
References: <20180509234059.52156-1-sbeller@google.com>
        <20180509234059.52156-2-sbeller@google.com>
Date:   Thu, 10 May 2018 19:23:13 +0900
In-Reply-To: <20180509234059.52156-2-sbeller@google.com> (Stefan Beller's
        message of "Wed, 9 May 2018 16:40:59 -0700")
Message-ID: <xmqqtvrfizce.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> This was missed in 5982da9d2ce (replace-object: allow
> prepare_replace_object to handle arbitrary repositories, 2018-04-11)
>
> Technically the code works correctly as the replace_map is the same
> size in different repositories, however it is hard to read. So convert
> the code to the familiar pattern of dereferencing the pointer that we
> assign in the sizeof itself.

;-)

We say

	ptr = xmalloc(sizeof(*ptr))

is better because 

	ptr = xmalloc(sizeof(typeof(*ptr)))

is easy to go stale unless we actually use typeof and instead say a
concrete type like "struct oidmap".

This one was doing

	ptr = xmalloc(sizeof(*another_ptr))

and it was OK because ptr and another_ptr happened to be of the same
type.  I wonder if we are making it safer, or making it more obscure
to seasoned C programmers, if we introduced a pair of helper macros,
perhaps like these:

	#define ALLOCATE(ptr) (ptr) = xmalloc(sizeof(*(ptr)))
	#define CALLOCATE(ptr,cnt) (ptr) = xcalloc((cnt), sizeof(*(ptr)))

The change looks obviously good.  Will queue.

Thanks.
