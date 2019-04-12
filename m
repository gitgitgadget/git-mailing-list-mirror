Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3022D20248
	for <e@80x24.org>; Fri, 12 Apr 2019 01:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbfDLB2D (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 21:28:03 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34752 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbfDLB2D (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Apr 2019 21:28:03 -0400
Received: by mail-wm1-f68.google.com with SMTP id r186so3148490wmf.1
        for <git@vger.kernel.org>; Thu, 11 Apr 2019 18:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=NgfksYTldN/qaSTxqkzNaRHKpRVz6jJ/Q7mCKwOTsWo=;
        b=fAoAj0jcm0gtpgXBQkKswXtfAZhYENj5tvSls15SlnyfBOAzT+mGVobuM0sZ25SZkz
         FRSPhfDuLsei8GyxzR6lhcfZYU+en14r3N8wjhDEnkws/I+LzHO1kTFqIKRjtqaWmOK1
         zXWPhGovQ0GvZ2A/NtIMt/1h0lz3u3Wt9+2tel6oso6rhkTPkxrloCDOClmdTRHNg9PE
         0Wuc+EVdJ6OajNrkzCpx3/co7gN83M/4kd3MPF70TzDrsvU0TgaLm4jG7X5kQNF5Scgv
         x0TIQcilMbV1m0WplnrHY2QsogEi0o6HTTOwxJqb1/MqgZqaqoKtmeVeUqC1q4wGcYLs
         6k6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=NgfksYTldN/qaSTxqkzNaRHKpRVz6jJ/Q7mCKwOTsWo=;
        b=VGN986vISt9tTvD/m4uyifIE47ME7vWunAzue8kh2xl6W39L06RKTNfIbO2PPxTJOa
         bNT9Hic5O/qmurkVPu6e4hD1L1KaX5IaR6CCPy5P9O3UgPh41OzD3f6DPZ+jrKjm12BF
         oK6sadn9F6nXqseNJsrLlYP8PQ+iiiEXXxnawlUOeOOA1MsOGMgjmRZnLpUkyGnhhdKR
         YYjgjmtqpaMNcN1pv45s4T2CBESge2/tp8KrXSgoCTCB+0+EGeEnn8Pk3/dy6RAUpTj2
         FSqj+KEjob3RAmGINFC4DUdeP9oQB1Dsrn9PMau5CMG9GZcX70htajFf9C1bIIVJC6nr
         WPIQ==
X-Gm-Message-State: APjAAAXUKpK5BbYL/rlwQZaeL4x0JfX/A2/b6+dweUynS6Wql05+ayJS
        pKE6k9wuO0XkqWKhNYb1Pik=
X-Google-Smtp-Source: APXvYqw1ueqK2xLuc6gCtse9HAb5OvLTuDXRhXtlpm6a8ODHQBv7+2t3H4bh7tDpUr8BAFm5wEjcZw==
X-Received: by 2002:a1c:208c:: with SMTP id g134mr8840188wmg.70.1555032481690;
        Thu, 11 Apr 2019 18:28:01 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id z84sm7613909wmg.24.2019.04.11.18.28.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Apr 2019 18:28:01 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] Introduce "precious" file concept
References: <xmqqimvpb0bd.fsf@gitster-ct.c.googlers.com>
        <20190409102649.22115-1-pclouds@gmail.com>
        <xmqqh8b75s9l.fsf@gitster-ct.c.googlers.com>
        <CACsJy8Ct6A7a7FzzH7ZUv9R2+k=G6qhzZ8Yjq8GUDBdTr_QBQA@mail.gmail.com>
Date:   Fri, 12 Apr 2019 10:28:00 +0900
In-Reply-To: <CACsJy8Ct6A7a7FzzH7ZUv9R2+k=G6qhzZ8Yjq8GUDBdTr_QBQA@mail.gmail.com>
        (Duy Nguyen's message of "Wed, 10 Apr 2019 16:36:05 +0700")
Message-ID: <xmqqbm1c107z.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> But gitattributes.txt explicitly says that it's wrong. One would need
> to do "path/** precious" to achieve the same thing.
>
> So yeah maybe doing this before S_ISDIR() is wrong. The definition of
> `precious` also only says "... is set on _files_". Maybe best to
> ignore attributes on directories? At least it looks like that's how
> all other attributes do.

I could be persuaded in the other direction if there are widespread
uses (or misuses---but once it gets widespread in the wild and turns
out to be useful, it ceases to be misuses and becomes a feature) of
giving an attribute to a directory that affects the treatment of
that directory *itself*, but if there is none, I'd prefer to keep
the attribute "what's tracked only".

Whether it is a good idea to give an attribute to a directory to
affect the treatement of the directory *itself* (eh, rather,
especially if it were a good idea), I'd consider it a misuse as a
short-hand for giving all paths within it the same attribute, given
"path/**" is available, as that would make it impossible to say "I'd
want to affect this directory, but not any of the directories or
files in it".

And if that is not clear in the current documentation set that faces
our developers, perhaps we should make it so.

Thanks.
