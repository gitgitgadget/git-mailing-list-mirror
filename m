Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27C3F1FF40
	for <e@80x24.org>; Mon, 20 Jun 2016 01:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751879AbcFTBKG (ORCPT <rfc822;e@80x24.org>);
	Sun, 19 Jun 2016 21:10:06 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:36220 "EHLO
	mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751535AbcFTBKE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2016 21:10:04 -0400
Received: by mail-qk0-f182.google.com with SMTP id p10so144144825qke.3
        for <git@vger.kernel.org>; Sun, 19 Jun 2016 18:09:29 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RP5R4NLQVUrGcmosxLDT+KeBQlfVmVnJGhe8HH7OWhM=;
        b=A8BkWA+ZW2xYEIJdyqQ0nfyjfarldluDLJ+Cd1dpBkEFC9sAdEMANqE8xo5Z84/UIr
         SQcop5XOaZVGw4RlCtdLHVjiKmq9hH9TX1CQokxfmcylFIxq5zqBt18d+j4xBVvP/Juw
         0OyzXQwT+qpFTA3d8T0tJsgKec25x+BDVpGu5F9tFgarQr5Nxm0VixmEhtYIXHiOvrYG
         uCRJWl4+B1+8L9MzWxzos98znEW6WpQ0zdYAA+qDAjHYLLRpGbQSUJ+hfYGGjoRK278b
         l6O/eMQqvUtcKMj90LiF2dPkhuoHK7bp+4QeQZrypqP6Esg29+O51wH/WRCvOnSiKW4c
         /t+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RP5R4NLQVUrGcmosxLDT+KeBQlfVmVnJGhe8HH7OWhM=;
        b=b2+o/cKK7LG3iSKx8hm3tyt7jSXuMI2e32olirUAjZYS8h/VQz7FbrQIwa8B7qhwvw
         twNswPhCNjaC9bpP089wAO7Fb/XY718GB7ItkSOjt+ryF1MZI6jFeRtMGOaPZNCs5vud
         x6YMvUxy3eqghjOz6iKD+gb+PLEAf/poTgtaONsFxFy7+0P8YBkn+6yY+q78vmjRYDJB
         GeBFV5EmiRFjttMbjIHtAdqCViDcCKVbxE6DX5D2+i5npjUk6y3V7o5apiFAJ2E3TZzS
         PabF8w/pswsxajhiY3yLSCyEtY+LioNSm7I0DGmm7jy5bbI2wg2ZBKYx1LU+DKjZJB4e
         ZD0w==
X-Gm-Message-State: ALyK8tKxRTmjLhe1DB2HEqzDN3I/bVncD4IzUxBByhPyYzmcpyORRbhA3WEWlxbl7RMQw+m2Q6+TcfnvisaHLNtv
X-Received: by 10.55.146.193 with SMTP id u184mr17643788qkd.13.1466384968495;
 Sun, 19 Jun 2016 18:09:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.237.42.226 with HTTP; Sun, 19 Jun 2016 18:09:28 -0700 (PDT)
In-Reply-To: <20160620001332.GA10101@sigill.intra.peff.net>
References: <OFC76C15DC.FC882C57-ONC2257FD7.00261552-C2257FD7.002660FC@LocalDomain>
 <OFE09D48F2.D1D14F49-ONC2257FD7.00280736-C2257FD7.0028245A@notes.na.collabserv.com>
 <20160619100051.GA14584@sigill.intra.peff.net> <xmqq7fdkx5oz.fsf@gitster.mtv.corp.google.com>
 <20160620001332.GA10101@sigill.intra.peff.net>
From:	Stefan Beller <sbeller@google.com>
Date:	Sun, 19 Jun 2016 18:09:28 -0700
Message-ID: <CAGZ79kZ9NF57EyEZ4PgOhJw50ujt=QmHs+w1ZNFeDO4zitksVQ@mail.gmail.com>
Subject: Re: [BUG REPORT] git 2.9.0 clone --recursive fails on cloning a submodule
To:	Jeff King <peff@peff.net>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Vadim Eisenberg <VADIME@il.ibm.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sun, Jun 19, 2016 at 5:13 PM, Jeff King <peff@peff.net> wrote:
> On Sun, Jun 19, 2016 at 01:51:56PM -0700, Junio C Hamano wrote:
>
>> Yup, something like this on top of d22eb04 to be merged before
>> v2.9.1 for the maintenance track would be necessary.
>>
>> -- >8 --
>> Subject: clone: do not let --depth imply --shallow-submodules
>>
>> In v2.9.0, we prematurely flipped the default to force cloning
>> submodules shallowly, when the superproject is getting cloned
>> shallowly.  This is likely to fail when the upstream repositories
>> submodules are cloned from a repository that is not prepared to
>> serve histories that ends at a commit that is not at the tip of a
>> branch, and we know the world is not yet ready.
>>
>> Use a safer default to clone the submodules fully, unless the user
>> tells us that she knows that the upstream repository of the
>> submodules are willing to cooperate with "--shallow-submodules"
>> option.
>
> Yeah, this looks good. To minor comments:

I agree, but I find the second concern a bit more than just minor.

>
>> @@ -730,8 +730,7 @@ static int checkout(void)
>>               struct argv_array args = ARGV_ARRAY_INIT;
>>               argv_array_pushl(&args, "submodule", "update", "--init", "--recursive", NULL);
>>
>> -             if (option_shallow_submodules == 1
>> -                 || (option_shallow_submodules == -1 && option_depth))
>> +             if (option_shallow_submodules == 1)
>>                       argv_array_push(&args, "--depth=1");
>
> I hadn't paid much attention to this topic originally, but was surprised
> that "--depth 10" in the clone implies "--depth 1" in the submodule.
> This is not really related to your patch (in fact, your patch makes the
> logic go away). But maybe something to consider if it's ever resurrected
> (or possibly if somebody runs "--shallow-submodules --depth 5" we should
> pass --depth=1; I dunno).

How often do we see a depth != 1 in practice?
I have the impression (and no data to back up my claim) that a binary
switch for nonshallow or depth 1 would serve us just as good, which is why
I did not want to ad complexity to the submodule depth.
(What if you want submodule A with depth 2 and B with 5? In that
case get them all shallow and deepen as appropriate, would be my answer)

>
>> -test_expect_success 'shallow clone implies shallow submodule' '
>> +test_expect_success 'shallow clone does not imply shallow submodule' '
>>       test_when_finished "rm -rf super_clone" &&
>> -     git clone --recurse-submodules --depth 2 "file://$pwd/." super_clone &&
>> +     git clone --recurse-submodules --depth 2 --shallow-submodules "file://$pwd/." super_clone &&
>>       (
>>               cd super_clone &&
>>               git log --oneline >lines &&
>
> We are not really testing "does not imply" here, but "passing
> --shallow-submodules works". The "does not imply" test would be cloning
> without the option and checking that the resulting submodules are not
> shallow.

In case we want to be sure that it works for 2.9.1, i.e. we treat it
as a regression,
we need to test the "does not imply" a bit more I would think. I can send that
test on top tomorrow if you'd like to.

Thanks,
Stefan

>
> -Peff
