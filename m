Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DDE41F404
	for <e@80x24.org>; Tue, 10 Apr 2018 21:05:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752037AbeDJVE7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 17:04:59 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:55501 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751888AbeDJVE6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 17:04:58 -0400
Received: by mail-wm0-f52.google.com with SMTP id b127so29011338wmf.5
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 14:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=G5dos+DM6Qv9i57NL1tQQ7WfI9psZmK5Xatjne84oqE=;
        b=klEIzJfyUwN++D55X7b+fWkuAKtC14XHDF7a9Lcvb978cuj5cYJ1PicR3hLXnzgS/p
         Rt2G9rmi3PrNUf4gQAsS5a2piaoReIiBnUjhbw6fZ3gFk3bnp2RY3j1oWxcfyiu6n/xn
         15W9zUFRxx3hEjFrnD1Jd1Md42HRHQPIkzWTEBhZkBWIuwqAAaZGJcM6QKXW5TB+GWGx
         S7fHrU9gJ/fVz3iJSrLRfoW+axFaH5nzXP0ZlSAVg2Z034tTfUtGGn80hO6smvvJjXiO
         nILss/HAfJtW6F6kdabUFGUv4GX+kkqN/hffosfoZUf+bcAws/2ASm9gw76BUgk6XEzQ
         dCUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=G5dos+DM6Qv9i57NL1tQQ7WfI9psZmK5Xatjne84oqE=;
        b=fti5R9eyqXjBZGg7YphG9E/QLkofLgAFdOmJsb9xnoWaMBK5FBAjbbBCMJHEyT/2PT
         yaRzWL5GBtIJGULEOAmbPbsp10UBSNnrWnNrGu6wB8PIKBpvaa/aXXmIVcScUWC0lAoA
         wKT6fTHk3xrzfq2KzsvN8AbEOouwHpERtrWD1CRcNg9HnRKNOkgX6NLpXaAfZs5wBOLN
         TwB+N66Camegm2t9Hj57oYG0oOR+8CbzBsblAg+53ZrracW04J7+0QdBquxISqrD9w3U
         jkneIEiwOChNYmXXmgFyzu1AGNIBQyPYmt/y/4oc/qX5Z8F6NTnVYNFOcrQA1IlOX8Ea
         3lLw==
X-Gm-Message-State: ALQs6tAXgObuFvcBFLc/0TxnMMtlix/yioD91GrVqoyXToMgls72uFI9
        INFdP+C41DjWCv/ONTM+4yU=
X-Google-Smtp-Source: AIpwx48IVtkFQG0UF4PUttvfQsVroI0MrxtlxcoonC9+okTbrwrGcICcwEF4R9EUPYQ70k5oN2fKVg==
X-Received: by 10.28.172.135 with SMTP id v129mr633356wme.144.1523394296813;
        Tue, 10 Apr 2018 14:04:56 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id q81sm3292482wmg.8.2018.04.10.14.04.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Apr 2018 14:04:56 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Toews <mastahyeti@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 6/8] gpg-interface: find the last gpg signature line
References: <20180409204129.43537-1-mastahyeti@gmail.com>
        <20180409204129.43537-7-mastahyeti@gmail.com>
        <xmqqlgdv2y66.fsf@gitster-ct.c.googlers.com>
        <CAE=pOyFj+WZBB6Zp35d=mYNsxcJK-LwOxseWXSmY_hs+Lwugpg@mail.gmail.com>
Date:   Wed, 11 Apr 2018 06:04:55 +0900
In-Reply-To: <CAE=pOyFj+WZBB6Zp35d=mYNsxcJK-LwOxseWXSmY_hs+Lwugpg@mail.gmail.com>
        (Ben Toews's message of "Tue, 10 Apr 2018 08:47:39 -0600")
Message-ID: <xmqqbmeq3h8o.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Toews <mastahyeti@gmail.com> writes:

>> Hmmmm, what vintage of our codebase is this patch based on?  Did I
>> miss a patch that removes these lines
>>
>>
>>     printf '      ' >sigblanknonlfile
>>     get_tag_header blanknonlfile-signed-tag $commit commit $time >expect
>>     echo '-----BEGIN PGP SIGNATURE-----' >>expect
>>     test_expect_success GPG \
>>             'creating a signed tag with spaces and no newline should succeed' '
>>             git tag -s -F sigblanknonlfile blanknonlfile-signed-tag &&
>>             get_tag_msg blanknonlfile-signed-tag >actual &&
>>             test_cmp expect actual &&
>>             git tag -v signed-tag
>>     '
>>
>> which appear between the pre- and post- context of the lines you are
>> inserting?  They date back to 2007-2009.
>>
>
> That test was fixed a week ago:
> https://github.com/git/git/commit/a99d903f21d102a5768f19157085a9733aeb68dd

Well, you cannot expect any reviewer to know about a change that has
never been sent to the list and has never been part of even 'pu'
branch, no matter how old such a private "fix" is.  

What other unpublished things that are not even on 'pu' do these
patches depend on?
