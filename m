Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07411215F6
	for <e@80x24.org>; Wed, 12 Oct 2016 22:48:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753562AbcJLWsL (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 18:48:11 -0400
Received: from mail-qt0-f179.google.com ([209.85.216.179]:36589 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752488AbcJLWsJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 18:48:09 -0400
Received: by mail-qt0-f179.google.com with SMTP id m5so27420501qtb.3
        for <git@vger.kernel.org>; Wed, 12 Oct 2016 15:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LPpSDzRkhwh4r9I2g317BapNRbGZBOETGrhL2Ady73Q=;
        b=ZV3NAX+OBkUY4TZ92cWrk9DdWOzO5M50ynYPX3eZn9CJTTpCX3LDHGNLHWLXzNLnI1
         Qxi6uelO648J8H1TY+v+AbOd38ZptIn+3c2+nEHVVa1LtPsNLLGRnIw/6yP7vikONeN2
         uL6gk2TqgoEFN3tp5vc+S3vEmDS1qnedaBKU1mTZMSakeiVFNkjJQOsM/Lb0xESMCxcR
         FYVOQe/jXyjXoQyJLGPXmgi69WlAiBN2DiTVoYvwj3BIPefTjs84YAA+1redRNseEH5n
         fKB13aXa6SKn09h3sJSrHXS1GIc5mKJgsg35C/Hs+JcTqEYgTx+gJ1ZvtH5/gPPOqwhy
         7ecw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LPpSDzRkhwh4r9I2g317BapNRbGZBOETGrhL2Ady73Q=;
        b=ALUjuu/dDcSZxehEMgDas0D1ciiGXMmjcxKE+KXpGIJbdvrY4FgsxlNilKZuDPvBk7
         DXkdEv0amwacUqWcz2yJH4pbh6NqDFIdOHBFl09aWnH0qbdNIX6vwDFOemKprdII3XzT
         If/RhikzY0h1YJls33dLj1b+qf9rCIXpxdt/qUCeXU7m5X9BGT7/TV49sDX7ItC0FKOn
         X7YPH3Ub03WYnmZ87w0b67wxB7u/hPE9HBovsf/7+imMAlkqtQLlFUhQgXz8e7yFzXZu
         5KiupuxwVZOi12JOMFuN7+h9bKlwV2BM24La7X0n9Qm51VrT8VQASozRcXF+8azu+fih
         ddeQ==
X-Gm-Message-State: AA6/9RlKAnWAHpnZi8awbfOCryNP+H1nMarDPlcViVszw5FzReqpQ04ik+AOmqKl16yXqP6pTQo6gl/M6ZUTIqJx
X-Received: by 10.200.34.145 with SMTP id f17mr3537536qta.149.1476308838075;
 Wed, 12 Oct 2016 14:47:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Wed, 12 Oct 2016 14:47:17 -0700 (PDT)
In-Reply-To: <CA+P7+xqBUT3jUsxciVydO+nRoR+iJygWG=y_ARpiQSs+-kcH2A@mail.gmail.com>
References: <20161011235951.8358-1-sbeller@google.com> <44c554b8-7ac1-047d-59f0-b4d5331ed496@kdbg.org>
 <CA+P7+xqBUT3jUsxciVydO+nRoR+iJygWG=y_ARpiQSs+-kcH2A@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 12 Oct 2016 14:47:17 -0700
Message-ID: <CAGZ79ka5qkDri0gCCLQQcUgqFpOi=np+jm-x046Foc9NOpE6NA@mail.gmail.com>
Subject: Re: [PATCHv2] attr: convert to new threadsafe API
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 12, 2016 at 2:45 PM, Jacob Keller <jacob.keller@gmail.com> wrot=
e:
> On Wed, Oct 12, 2016 at 1:07 PM, Johannes Sixt <j6t@kdbg.org> wrote:
>>
>> Sigh. DCLP, the Double Checked Locking Pattern. These days, it should be
>> common knowledge among professionals that this na=C3=AFve version _does_=
not_work_
>> [1]!
>>
>> I suggest you go without it, then measure, and only *then* optimize if i=
t is
>> a bottleneck. Did I read "we do not expect much contention" somewhere?
>>
>> [1] http://www.aristeia.com/Papers/DDJ_Jul_Aug_2004_revised.pdf C++ cent=
ric,
>> but applies to C just as well
>>
>> -- Hannes
>>
>
>
> You know, I always wondered why Linux Kernel code needed memory
> barriers but userspace programs didn't seem to use them.. turns out
> they actually *do* need them for the same exact types of problems...
>
> Thanks,
> Jake

In a former job I made use of them, too. So I am kinda embarrassed.
(I cannot claim I did not know about these patterns and memory
fencing, it just escaped my consciousness).
