Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 190361F5CB
	for <e@80x24.org>; Mon, 22 Apr 2019 06:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbfDVGLg (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 02:11:36 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:43940 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfDVGLf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Apr 2019 02:11:35 -0400
Received: by mail-wr1-f47.google.com with SMTP id k17so14639834wrx.10
        for <git@vger.kernel.org>; Sun, 21 Apr 2019 23:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Ti8WRpX7UuheT0EkW7N3YsS3r3qhgRD6LkQl3K1KJQQ=;
        b=eY4yqWLf+wpZM3H+zQOlKdfDcGzk39wQBcglAGfceG0RQkLuhWw7z6lihORHVPCljL
         g8cFzmGTypH+SqPpjFL60nn+LQpxDd27EFjxIPM4sp49QrdhiTE1kpyrLmrVLxMncnxa
         CL5N2vjm6fp3XHhrpMql5Y9IaaIbgxv9hX2RNhzr8u8UaXSodwyJ+iewUcGIzq5IIEc1
         gpp5+ZcyT7aDWYMq4UpotSZxYZZ7j/YYFTPmd1XN13Nop5lJIO2H0fh8vzSDFDQfD/pN
         /rAdnMVc0luF+EFc18IZjNEcw/P3/Nl1uE8UgDhgUIn61i8/h6/Dym6/R8P5Gn2fzUrY
         cJsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Ti8WRpX7UuheT0EkW7N3YsS3r3qhgRD6LkQl3K1KJQQ=;
        b=Y8dGYg274U/He7Djay5Gl8eCsN+GJt/UBQhTLTQz1faEYJIknSlr7/xDPgixbshW+T
         1wbxZW4HDHCQA9B7KIXPn71iiIRU8v6jA+juN5SWQkYpISPEvGXNZaU4D838HZ1LszTM
         W9ZiNPOVVqJDKc6C3r4pPzcD0KAkCSCtg9m9VeorWmxfi/E87SFpi2pSacDaHBJ/vDc7
         zHHMLxotQCzSTzSsdSfis+gzAVY+tyk2YabS3iXXiCxhuaZeTvoDxzApEyyE5l2FihAF
         e05vgU0wG9n7IiCTsGKmKMOiyj92pTK5H+HcGVAq/aiZr/+8ERuflGtkweNSOdMhZeJj
         HpZg==
X-Gm-Message-State: APjAAAUqdJMRbiSyAYFVAJ6ckMnjac8BGJsDvvkMVKNpWD69M5/TVbde
        V5oHMvMfsUc1QQ/afEME6wg=
X-Google-Smtp-Source: APXvYqzjKZsLrZFgVuXUyUmEyYhFA3xnsvAdFqPN+wyFhVuBUdiwswimz4JRxTIxs+i96CAgVXapPA==
X-Received: by 2002:a05:6000:12c8:: with SMTP id l8mr11283809wrx.80.1555913493664;
        Sun, 21 Apr 2019 23:11:33 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id o15sm14856753wrj.59.2019.04.21.23.11.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Apr 2019 23:11:33 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH/RFC] Makefile: dedup list of files obtained from ls-files
References: <xmqqy343a43b.fsf@gitster-ct.c.googlers.com>
        <CAPig+cR5yMtdBA0HgLZ6k-j3NeMS+4UeEKgRiEpZ0YGrW_L0cg@mail.gmail.com>
Date:   Mon, 22 Apr 2019 15:11:32 +0900
In-Reply-To: <CAPig+cR5yMtdBA0HgLZ6k-j3NeMS+4UeEKgRiEpZ0YGrW_L0cg@mail.gmail.com>
        (Eric Sunshine's message of "Sun, 21 Apr 2019 23:23:54 -0400")
Message-ID: <xmqq8sw28t7v.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Sun, Apr 21, 2019 at 9:19 AM Junio C Hamano <gitster@pobox.com> wrote:
>> diff --git a/Makefile b/Makefile
>> @@ -822,12 +822,12 @@ VCSSVN_LIB = vcs-svn/lib.a
>> -LIB_H := $(shell git ls-files '*.h' ':!t/' ':!Documentation/' 2>/dev/null || \
>> +LIB_H := $(shell (git ls-files '*.h' ':!t/' ':!Documentation/' 2>/dev/null || \
>>         $(FIND) . \
>>         -name .git -prune -o \
>>         -name t -prune -o \
>>         -name Documentation -prune -o \
>> -       -name '*.h' -print)
>> +       -name '*.h' -print) | sort -u)
>
> GNU make's "sort" function also de-dups, so an alternative is:
>
>     LIB_H := $(sort $(shell ...))

That is a much better solution.  Let me use that.

Thanks.
