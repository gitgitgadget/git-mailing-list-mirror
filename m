Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F27A1FD99
	for <e@80x24.org>; Tue, 16 Aug 2016 08:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753266AbcHPIZs (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 04:25:48 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:35416 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751057AbcHPIZr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 04:25:47 -0400
Received: by mail-wm0-f51.google.com with SMTP id f65so129004357wmi.0
        for <git@vger.kernel.org>; Tue, 16 Aug 2016 01:25:46 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fXtLxXc9aDwOTibpNTroP7DZ+++2lxDG51fR4Ldhp+0=;
        b=LAkhde4mHSrHOViLjpr/0NN3pq6DRJvGe2vD05F2anyEs65aPMLD3op+xHuqyXegCo
         Aobt97mDNRJMPwzfSMLKos62e1cd0FNo//4z+RRvnnacXKs1tpP2FSYuh2plzPxsxC6g
         oJT5HcbWT5XeVQ8DwxUaE/GBey0N+Y3AUYXX1sqMpX7T30UH8vQlwGh4qYaYRQFCLgq7
         nSaDsZU4e9TiUenByQC0FhVocDUqOR59J3/UuT4HF2M2YQi4/xJyTdlzWqISDVnZJvxk
         e+l7p6c2dNlMzlrWfUE5YE3iZz8kTnXlCIme8LnS8WB8dri/TfEOMjMUtfSSMY8GtuFE
         ww9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fXtLxXc9aDwOTibpNTroP7DZ+++2lxDG51fR4Ldhp+0=;
        b=N12xp2b4O/rYlEbZaGzokhOVjq2heKfw1bHXj+uDWqDcJA7+wOhaMnPdshb/cA6r+O
         MS7MRF3iXuHkqaOgqag+SDgiJRsp9+yYLQHjCFrfNeqbNofg7ecD/pTkmJwfpuiCx0Mf
         DcEkcwEOIvZk68v3EM/iqVncW5atNCLgV06RQsSIeat0jTFSZRJEX3CHHKcedOXgKaH3
         dQAzkeOpZ7ySij+BWxO5Gg3bSpUCdLkfPZ9EtjLcnfbenB5VW0GHM09q65an5IyYzv0L
         lmR8ev1YuOgsuZIN354n/rmbiznhI0eN21YPI7JL5UcEtLnzqoOBHSCv9QZ6eNIPOteC
         w9nQ==
X-Gm-Message-State: AEkoout0ri2XYtspEOETxhqELR0dxjfaWgfPCqzPm7VST15q1aOm56TlWMA2Ixq8U7Dr4woyz3kuHwlyCZpIVw==
X-Received: by 10.194.190.232 with SMTP id gt8mr36365494wjc.141.1471335945487;
 Tue, 16 Aug 2016 01:25:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.70.167 with HTTP; Tue, 16 Aug 2016 01:25:44 -0700 (PDT)
In-Reply-To: <20160816010309.zstrljqknc3vjziq@sigill.intra.peff.net>
References: <20160815195729.16826-1-chriscool@tuxfamily.org>
 <20160815195729.16826-4-chriscool@tuxfamily.org> <20160815204034.rrjn57wigxtjpgye@sigill.intra.peff.net>
 <xmqqr39pejhk.fsf@gitster.mtv.corp.google.com> <20160816010309.zstrljqknc3vjziq@sigill.intra.peff.net>
From:	Christian Couder <christian.couder@gmail.com>
Date:	Tue, 16 Aug 2016 10:25:44 +0200
Message-ID: <CAP8UFD2Bpp-gcxEQGNSFxvKyptkyeAsMtaHZaBebJO2XiF+W3g@mail.gmail.com>
Subject: Re: [RFC/PATCH 3/3] receive-pack: allow a maximum input size to be specified
To:	Jeff King <peff@peff.net>
Cc:	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 16, 2016 at 3:03 AM, Jeff King <peff@peff.net> wrote:
> On Mon, Aug 15, 2016 at 03:48:55PM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>>
>> > The simple fix is to call register_tempfile() in open_pack_file(), and
>> > just have index-pack clean up the file on its way out.
>> >
>> > But there are harder cases. For instance, imagine somebody pushes a
>> > 500MB file, and you have a pre-receive hook that says "too big; I won't
>> > accept this". And then they push in a loop, as before. You've accepted
>> > the incoming pack into the repository by the time the pre-receive runs.
>> > You can't just delete it, because you don't know if other simultaneous
>> > processes have started to depend on the objects.
>> >
>> > To solve that, I have patches that put incoming packfiles into a
>> > "quarantine" area, then run the connectivity check and pre-receive hooks
>> > with the quarantine accessible via GIT_ALTERNATE_OBJECT_DIRECTORIES. And
>> > then we either move the quarantine packs into the real repo, or blow
>> > away the tmpdir, depending on whether the hooks said the objects were
>> > OK.

Thanks Peff for the review and all these explanations and suggestions!

>> > Those are patches I plan to share upstream but just haven't gotten
>> > around to yet.

I would be happy to help if I can on these patches too!

>> I think these other patches can come later, independent from this
>> three-patch series resurrected from the archive, so I can take a
>> reroll of these once the integer-size issues you pointed out are
>> sorted out.

Ok, I just sent a non RFC reroll of the series with those issues
hopefully fixed.

> Yeah, definitely it's independent. I was mostly suggesting to Christian
> that he may want to look into the "easy" register_tempfile() case, as
> GitLab may find this is only half of the fix that they want.

Yeah, thanks again for this suggestion!

> Also a patch I may try to polish and share in the future, but not as
> high priority as some of the other stuff.

I can help polishing this patch if you want.

Thanks,
Christian.
