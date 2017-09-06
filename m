Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0C281F4DD
	for <e@80x24.org>; Wed,  6 Sep 2017 20:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752265AbdIFUGT (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Sep 2017 16:06:19 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:37114 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752058AbdIFUGS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2017 16:06:18 -0400
Received: by mail-wm0-f47.google.com with SMTP id u26so34964470wma.0
        for <git@vger.kernel.org>; Wed, 06 Sep 2017 13:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=d3XJ4wPY/aQXZ4C5ZDtIjK6FB6bc8POmbwYdvdLAYJA=;
        b=mCqwpx4RbO1eRxzTluWaJ7g2tYhARD7ROm/fiQ5FWhyGUwRr4iK3NOPVL5E53T8mBx
         Sy167yvUY9jWvHEXC0zKVgn7aRbCaqIXdZBwvsjA1UYvqieIl/qnV4MUe7SSpQA+88KO
         Zj2kh0QWNvMmmOY6SZ69P1QoIgHCgmS/xiOIQtLAwnw8oYCKWCWXZWgQbAOvc/RD7oLu
         q4cn2aUwsgojmev38AALV8CQy7kpJa8Prg4iNoFmV+ElrxG/O5xh/LOAayi36mQfTFl4
         KeMQNJBLVtQyar6TAqPyDOyrXRzg6YNYTc2nsl80GL1AOKePMRzRz3lK8ILjqlXy3R9Z
         pkhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=d3XJ4wPY/aQXZ4C5ZDtIjK6FB6bc8POmbwYdvdLAYJA=;
        b=ctjOaNqGuCGrl85BWiWxaaUjTux0TeGGC/iDPTKqeNW5APc3K0DFK9ujLyRK0zScNo
         T+8RYgoiTo3Gu/dSW5hVFkAwVRGNBUo6TgMRnUGsvyLF+w8uU/vlJKmUQBAIJG2FJAAy
         uuO8AAW4BMN9AOcPg8aS9aA3+bVVrDmujBJO2nxZn10nNbeVmK89WaExxu7TGPYV2rJG
         rbmznAWI/Tbba84EcQPAA1HLh+3TMWC/vcsjW4CivTsDI1ZYEZ1dCoL+JT33Et2x+gzG
         mVEpH7hxBAVhU8nF0j5hkVEBFjQeGaw75QtboKkHTZWQbZQpTrZUuDkXr0CaTku+3Owx
         jyJQ==
X-Gm-Message-State: AHPjjUjIjeaZwAi6oSraP0TiS/JVcE2v/uJSTsNf24Vl/6p8UWqFng9z
        C0x2amJapFJ/0GRXUpf1PunNY7FpYENz
X-Google-Smtp-Source: ADKCNb6zX4ugzL6He+8kn4O/Vs9RJqNuNZxeeF2nLS8BI7eMWd/mugZQQEtOQr0Ow4Ngmqg3UxY08Go4J9B+q8DuJ6o=
X-Received: by 10.80.206.68 with SMTP id k4mr682872edj.48.1504728377418; Wed,
 06 Sep 2017 13:06:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.135.130 with HTTP; Wed, 6 Sep 2017 13:06:16 -0700 (PDT)
In-Reply-To: <SN1PR21MB001457E4DD1AE17D041C6C77B7960@SN1PR21MB0014.namprd21.prod.outlook.com>
References: <20170904225807.22139-1-t.gummerer@gmail.com> <SN1PR21MB001457E4DD1AE17D041C6C77B7960@SN1PR21MB0014.namprd21.prod.outlook.com>
From:   Thomas Gummerer <t.gummerer@gmail.com>
Date:   Wed, 6 Sep 2017 21:06:16 +0100
Message-ID: <CALgYhfNYgmCJqptNQLKaQpCs9mAgqZHUrDS3BVEqCv_f+WX-qg@mail.gmail.com>
Subject: Re: [PATCH] read-cache: fix index corruption with index v4
To:     Kevin Willford <kewillf@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 5, 2017 at 8:37 PM, Kevin Willford <kewillf@microsoft.com> wrote:
>> From: Thomas Gummerer [mailto:t.gummerer@gmail.com]
>> Sent: Monday, September 4, 2017 4:58 PM

[..]

>> I unfortunately didn't have more time to dig so
>>
>> > As ce->name is however not nul terminated
>>
>> just comes from my memory and from the patch below actually fixing the
>> corruption, so it's really the most likely cause.  Would be great if
>> someone who can remember more about the index could confirm that this
>> is indeed the case.
>>
>
> Digging into this and ce->name IS nul terminated.  The issue comes in when
> the CE_STRIP_NAME is set, which is only set when using a split index.
> This sets the ce->ce_namelen = 0 without changing the actual ce->name buffer.
> When writing the entry for the split index version 4 it was using the first character
> in the ce->name buffer because of the + 1, which obviously isn't correct.    Before
> it was using a newly allocated name buffer from the ondisk struct which was
> allocated based on the ce_namelen of zero.

Thank you very much for digging into this.  That also explains why
only t1700 was
affected, but none of the other tests.  Will update the commit message.

>>  read-cache.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/read-cache.c b/read-cache.c
>> index 40da87ea71..80830ddcfc 100644
>> --- a/read-cache.c
>> +++ b/read-cache.c
>> @@ -2103,7 +2103,9 @@ static int ce_write_entry(git_SHA_CTX *c, int fd, struct
>> cache_entry *ce,
>>               if (!result)
>>                       result = ce_write(c, fd, to_remove_vi, prefix_size);
>>               if (!result)
>> -                     result = ce_write(c, fd, ce->name + common,
>> ce_namelen(ce) - common + 1);
>> +                     result = ce_write(c, fd, ce->name + common,
>> ce_namelen(ce) - common);
>> +             if (!result)
>> +                     result = ce_write(c, fd, "\0", 1);
>
> You could use the padding variable here as well which is used in the < version 4
> ce_write.

Thanks, will do that.

>>
>>               strbuf_splice(previous_name, common, to_remove,
>>                             ce->name + common, ce_namelen(ce) - common);
>> --
>> 2.14.1.480.gb18f417b89
>
> While looking at the code I was wondering if we could get around the
> whole setting ce->ce_namelen to zero bit but that would be much bigger
> patch and possibly introduce other bugs so this seems the appropriate
> fix for now.
>
> Thanks for finding this!

Thanks for the review! Will send an updated patch in a bit.

> Kevin
