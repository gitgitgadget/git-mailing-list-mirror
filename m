Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7173A1F859
	for <e@80x24.org>; Fri, 12 Aug 2016 16:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752805AbcHLQsX (ORCPT <rfc822;e@80x24.org>);
	Fri, 12 Aug 2016 12:48:23 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:35066 "EHLO
	mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752301AbcHLQsW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2016 12:48:22 -0400
Received: by mail-it0-f53.google.com with SMTP id u186so16269587ita.0
        for <git@vger.kernel.org>; Fri, 12 Aug 2016 09:48:22 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=grQ23fBWXz9GxpwnzHjuWlZKAp2brPlUeTAgQoUGHLY=;
        b=RJ+pBUVdosTQEbm/qU8vJRLz1TifsRhSRZPOR0UXMmJGh7/y6c7+mS5EuMSGLCmkpY
         fhIccRktajx7xWwguTj3UJK0HokaDDeDxF0mr5Py7yStV+K9vM2yi9gN0TNFUz5Y3IOI
         FitMR96VYWlWTnOa8T+OfR5bLOMw5WMwqNOCMIxAXGZQCchgWed9CEl5b5nLB71VgbAg
         CJdMxxlq0L7yVmC8t55KE316wPw2+6Z5nUATDb+A9W6Jvi+i4pBxrATqrgKb15nZRwOB
         Oy08YnOHKonCP+6PuKH5mYCphaAad+4WTZWUBX/+uhbgZwroE+MhCSuRW0dol7AbMJEY
         DCfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=grQ23fBWXz9GxpwnzHjuWlZKAp2brPlUeTAgQoUGHLY=;
        b=OF9VwGiX5Vpt5p3YCNUE/tQSP3yP1mRZK/Km589QIM+9n5gktpjg6pLW6iGolnW2Uf
         pOxgiSspp3lGXeaCpBjqIGXen6ekZtNTlzAlBq1QOS2HwF9tDp2ACZJS7bDClB6eVPCs
         ADHfd1P5WgoGmTijXpIgKholHc+fKnlUGytD476Hr5j4O0vsomEZDoK/yzxKbRJcAF+J
         53uxaXRjM3GYq/7GTzQguF+s4ylsF9bKa2Wyd9nL3jn8qqK3RCZRpETGHiCgGu34xP84
         uqzmQqMpZdiLKz6wmHIzue6vLtxZ5AQOn06MdiVntERoTzsY5nXr+n7UNAVgZkAt2dPf
         56yA==
X-Gm-Message-State: AEkoouuGwa8WL08B9q27j4R6Vo806Oh0/ARmytIMcOc7JWZT7a1PAnCNdaP3G9occ5I8tpEw1NVWEfI+Zuni/0S8
X-Received: by 10.36.92.206 with SMTP id q197mr4659306itb.46.1471020501605;
 Fri, 12 Aug 2016 09:48:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Fri, 12 Aug 2016 09:48:21 -0700 (PDT)
In-Reply-To: <20160812163809.3wdkuqegxfjam2yn@sigill.intra.peff.net>
References: <20160803164225.46355-1-larsxschneider@gmail.com/>
 <20160810130411.12419-1-larsxschneider@gmail.com> <20160810130411.12419-15-larsxschneider@gmail.com>
 <CAGZ79kboxgBRHSa2s7CKZ1Uo=13WT=rT8VHCNJNj_Q9jQzZAYw@mail.gmail.com> <20160812163809.3wdkuqegxfjam2yn@sigill.intra.peff.net>
From:	Stefan Beller <sbeller@google.com>
Date:	Fri, 12 Aug 2016 09:48:21 -0700
Message-ID: <CAGZ79kaRKROUganF838w29rCkJ592sZvu+q9fo+h4a4sPeDXMQ@mail.gmail.com>
Subject: Re: [PATCH v5 14/15] convert: add filter.<driver>.process option
To:	Jeff King <peff@peff.net>
Cc:	Lars Schneider <larsxschneider@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	mlbright@gmail.com, Eric Wong <e@80x24.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, ben@wijen.net
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Aug 12, 2016 at 9:38 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Aug 12, 2016 at 09:33:18AM -0700, Stefan Beller wrote:
>
>> > If the result content is empty then the filter is expected to respond
>> > with a success status and an empty list.
>> > ------------------------
>> > packet:          git< status=success\n
>> > packet:          git< 0000
>> > packet:          git< 0000  # empty content!
>> > packet:          git< 0000  # empty list!
>> > ------------------------
>>
>> Why do we need the last flush packet? We'd expect as many successes
>> as we send out contents? Do we plan on interleaving operation, i.e.
>> Git sends out 10 files but the filter process is not as fast as Git sending
>> out and the answers trickle in slowly?
>
> There was prior discussion in the thread, but basically, it is there to
> be able to signal an error that is encountered midway through sending
> the file (i.e., to say "status=error"). If you do not have a final
> flush, then you would send nothing, and the receiver would be left
> wondering if you were successful, or if it simply did not get your error
> report yet.

    I did not follow the prior discussion, so I approached this review with
    no prior knowledge from prior reviews, but instead read through and
    was asking a lot of questions that came up immediately. In case my
    questions are too dumb just omit them, but I thought they were good
    material to answer in a commit message ("Why did we do it this way
    and not differently").

Thanks for the explanation. So this is similar as the situation below
that we wait for the flush and then an error/success report?

>
>> > If the filter experiences an error during processing, then it can
>> > send the status "error". Depending on the `filter.<driver>.required`
>> > flag Git will interpret that as error but it will not stop or restart
>> > the filter process.
>> > ------------------------
>> > packet:          git< status=success\n
>>
>> So the first success is meaningless essentially?
>> Would it make sense to move the sucess behind the content sending
>> in all cases?
>
> No, the first success says "good so far, here's the file content". The
> second says "I succeeded in sending you the file content".
>
> You _can_ drop the first one, but it may be more convenient for the
> receiver to know up-front that there was a failure.


If there was a failure upfront, it would become

packet:          git< 0000
# no content is encapsulated here
packet:          git< 0000
packet:          git< status=error\n
packet:          git< 0000

so from a protocol side I'd claim it doesn't look bad.
I assume with convenient you mean the implementation
side of things?

If we do the success first and then error out halfway, we
still have to clean up, so I do not see how this impacts
implementation?

Thanks,
Stefan
