Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54AA1207D2
	for <e@80x24.org>; Fri, 23 Jun 2017 20:59:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753946AbdFWU7l (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 16:59:41 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33721 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753900AbdFWU7k (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 16:59:40 -0400
Received: by mail-pg0-f65.google.com with SMTP id u62so7484752pgb.0
        for <git@vger.kernel.org>; Fri, 23 Jun 2017 13:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=7xtiNaAnEGVM0K7K5CM4+u5sMc2nIt8Ml3ek2zD6/dI=;
        b=X3yCykoJRDLWOLox/QXTaHk6pxhvaCRW8GCAWQlsZGYrOfTEqp5VDAB/z3jhAe9YS5
         SUx6xM0O/GGmR5SpCODtOMWf9tO1OfYNmzqpi6TtyLSDVhOL2ewR311ciVRVdMB0HG6D
         1blolwb8H/TVy2NNkdCyCnmGfpOW/VUgbcY0Tr5UsEX2+REd4NBsdCaD+jRwDBeP7v8p
         U9Oy9eHQleXh5cLcsUi8KKa7urb11fcasUubKHIAWBItJY6g7DaPtCWSw4+eJbJVXGuR
         kPN1emkjxhpVVYpFnTv3K530/ieZpJL4UJan6MyFKLPn1EGe3CAoUBmDoItd5ZeTyFWu
         VOFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=7xtiNaAnEGVM0K7K5CM4+u5sMc2nIt8Ml3ek2zD6/dI=;
        b=X3hSwI4PURmOiiyAvirzgF0smQS3/nHOt4t2xGTBJi88MyVCy+SDVEzpo8lp/GDPdu
         GNpWfNiGKN1EEcqUvZrWbWWgR7AboUoJL/YZ3bCHFBIcuGpPbFo51mwK7Wr8JI/oppRp
         Zn7Uf4d1zS2PaRr8q3Wao2GAveEg39fA3sZtdz/njqvbUgRmi9ZAoeZTaPgXy4nLXrxG
         JAwgWkdJMp1o633KgBiE/gAXSIYUbhxc/oyJ/az6CkCVpEUIVxVNoRs45pnyalmY9DbR
         OO7sCzJOBq1j9O/Lh9Dz2CWRtKLApOy6qzI0qv+zGq4rIt8RjbM/Dk0NFKPKB4PXIGvr
         PcAA==
X-Gm-Message-State: AKS2vOyEghB0OM20Pord84C38aEIpJyQXpauS0Zlm/wJhFdwz20mTDBp
        RXOzZzDKo4YtBQ==
X-Received: by 10.84.218.5 with SMTP id q5mr11112325pli.295.1498251579615;
        Fri, 23 Jun 2017 13:59:39 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:4cd0:d6d2:1e09:4052])
        by smtp.gmail.com with ESMTPSA id t82sm11787202pfe.88.2017.06.23.13.59.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 23 Jun 2017 13:59:38 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Emily Xie <emilyxxie@gmail.com>, git@vger.kernel.org,
        David Turner <novalis@novalis.org>
Subject: Re: [PATCH] pathspec: die on empty strings as pathspec
References: <20170607033308.33550-1-emilyxxie@gmail.com>
        <xmqqfuf82xr5.fsf@gitster.mtv.corp.google.com>
        <CAAin2ARfUCYM95L_k3fSQ--reQD3uMG72ah=Xg1xvvgKcU+QkQ@mail.gmail.com>
        <xmqqefubgxa3.fsf@gitster.mtv.corp.google.com>
        <xmqq60fngvky.fsf@gitster.mtv.corp.google.com>
        <xmqqzicyeg2p.fsf@gitster.mtv.corp.google.com>
        <802ccd37-c09a-8343-63fe-a42c682a8311@web.de>
Date:   Fri, 23 Jun 2017 13:59:38 -0700
In-Reply-To: <802ccd37-c09a-8343-63fe-a42c682a8311@web.de> ("Torsten
        =?utf-8?Q?B=C3=B6gershausen=22's?= message of "Fri, 23 Jun 2017 22:52:44
 +0200")
Message-ID: <xmqqr2yactdx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten Bögershausen <tboegi@web.de> writes:

> On 23/06/17 20:04, Junio C Hamano wrote:
>...
>> At this point in the test sequence, there is no modified path that
>> need to be further added before committing; the working tree is
>> empty except for .gitattributes which was just added to the index.
>> So we could instead pass no pathspec, but this is a conversion more
>> faithful to the original.
>>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>   t/t0027-auto-crlf.sh | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
>> index 93725895a4..e41c9b3bb2 100755
>> --- a/t/t0027-auto-crlf.sh
>> +++ b/t/t0027-auto-crlf.sh
>> @@ -322,7 +322,7 @@ test_expect_success 'setup master' '
>>   	echo >.gitattributes &&
>>   	git checkout -b master &&
>>   	git add .gitattributes &&
>> -	git commit -m "add .gitattributes" "" &&
>> +	git commit -m "add .gitattributes" . &&
>
> Reading the context here, there shouldn't be a "pathspec" at all,
> as .gitattributes had been added just one line above.
>
> The line should have been from the very beginning:
> 	git commit -m "add .gitattributes"  &&
>
> # What do you think ?

See above ;-)

And to be more explicit, it is not a fault of your earlier change,
either, that we didn't notice this problem since we started "warning".

We need to see if we can update our test framework to help us
better; I really think the test framework could and should have
helped us to notice this soon after we went into "keep behaving as
before but warn" stage.
