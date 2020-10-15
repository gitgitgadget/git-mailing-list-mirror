Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE29C433E7
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 18:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FBC722227
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 18:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLoUhpgU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391222AbgJOS4Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 14:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391214AbgJOS4Z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 14:56:25 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6CAC061755
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 11:56:23 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id l85so4204758oih.10
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 11:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+RxHLBFtHQNHgkB2W6m0QHBnaxcDTdMWwhlULEgN974=;
        b=iLoUhpgUTM+fkwofRnsSFaEPVd1spTbX+h1412XMj8QgW6++GAFZsvcq5/tPcm1IdN
         NrDGppf349X/R9oDlhve4c5MiEG1bqGY4f3Nlh5NZS5n50RfnIaTmU0dXGJqgAi+crHf
         pUevB4nrtbWb7NF6xkuuKg4QOI/bTEmbNy2f9kYMzjmz8jk1ntnqagrU7dqNMpM6K5AI
         9ggH4c9vQWUcpuoM+1ZwdU4EAMRz8pbxxg0hy/OnG/2up057l0kVyLXGRIA2YvGuCmEx
         wbhFwPA8TFtd2QMEmRViOsBLYNMlJ50rWhJfsuWaJd+v8audMZjlw08izw0Z5K6APdhX
         JI7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+RxHLBFtHQNHgkB2W6m0QHBnaxcDTdMWwhlULEgN974=;
        b=V6Zj1Z7uFN/846ZKATsiK2WwwguuTLFG/wza7hG6pQekbwJ7C0PzL9BW4wm2Odu/b7
         PmiVcGW+J+OYNU6qe+u+x9x3I3GpHhGpYhIu8gOckOIFzCw3KkMWsTRJ+XSKAGzYSqgn
         dHfd5aM/M0zbuvpbSMvryVWkpAof9lBr5KkwUx7k1MmwF6I7/Ut+QWtefL2rT/azqkim
         XNhHW87tWvtJRdmNr4RFRiciZ4zPmDsovjfReYGwPaWHcjQXhjSV7eLY8HYQyqYTJHrp
         zr1GwDef7vWV8nzS6dYwgYqAUKlgOc7hGucoIQBdfegR7nUQesnL/NnxZFQMvYxfVpkg
         DdPw==
X-Gm-Message-State: AOAM531Scd9plUyG2jYUZR2wm+N8L7NJRAS6DDk5TA4ZyJ9hPlAI0hQk
        NN2EGCxJx6ZHXSKO4ZiXTTTT4zCOwB5Gff8UCyA=
X-Google-Smtp-Source: ABdhPJy0LkRa2AlSJUJiqBiukAH9QzTfhph2nDwHkihdRpPljireokONnEgY4QhP6+5+MmoNGDwVKl9eMyn7co7fUxI=
X-Received: by 2002:aca:5d08:: with SMTP id r8mr134393oib.163.1602788182674;
 Thu, 15 Oct 2020 11:56:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAPSFM5eK1RFTbdTbF8dHMzcRh1SnSfzqh_5re22qS=KFoVRNJg@mail.gmail.com>
 <CAP8UFD1m2zXUm1PXmJKW2MxA9XZVUOkBFA62jLP7jx6_DCYZGw@mail.gmail.com> <CAPSFM5cXN57z56Cvq-NX1H4raS7d8=qXEFDQqpypJfoYzbxcyA@mail.gmail.com>
In-Reply-To: <CAPSFM5cXN57z56Cvq-NX1H4raS7d8=qXEFDQqpypJfoYzbxcyA@mail.gmail.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Fri, 16 Oct 2020 00:26:11 +0530
Message-ID: <CAPSFM5dxuEsGkFNTjCF4tLE611n1zLt2z+2JU03dORHxSK1i6w@mail.gmail.com>
Subject: Re: [Outreachy] Introduction
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, phillip.wood123@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you Christian and also I apologise, since I forgot to cc the
mailing list on last reply .

I have submitted the patch[1] for the microproject "modernizing the
test scripts" and would be glad to have reviews from the community and
will work on updates required .

While working on the same , I got familiar with the mailing list ,
guidelines , workflow and also learned more about the git commands.
Next , I would also like to know how to proceed further and learn more
about code base.

[1]https://lore.kernel.org/git/20201015175709.20121-1-charvi077@gmail.com/

Thanks ,
Charvi


On Fri, 16 Oct 2020 at 00:15, Charvi Mendiratta <charvi077@gmail.com> wrote:
>
> Thank you Christian and also I apologise, since I forgot to cc the mailing list on last reply .
>
> I have submitted the patch[1] for the microproject "modernizing the test scripts" and would be glad to have reviews from the community and will work on updates required .
>
> While working on the same , I got familiar with the mailing list , guidelines , workflow and also learned more about the git commands. Next , I would also like to know how to proceed further and learn more about code base.
>
> [1]https://lore.kernel.org/git/20201015175709.20121-1-charvi077@gmail.com/
>
> Thanks ,
> Charvi
>
>
>
>
> On Sun, 11 Oct 2020 at 13:39, Christian Couder <christian.couder@gmail.com> wrote:
>>
>> Hi Charvi,
>>
>> On Sun, Oct 11, 2020 at 1:13 AM Charvi Mendiratta <charvi077@gmail.com> wrote:
>> >
>> > Hello everyone !
>> >
>> > I am Charvi Mendiratta, one of the outreachy applicant. I would like
>> > to work on the project "Improve droping and rewording commits in Git
>> > interactive rebase".
>>
>> Welcome to the Git project and its mailing list!
>>
>> > Till now I have installed and built the project and going through the
>> > guidelines of patch submission and project details .
>> >
>> > Also, getting on micro projects
>> > https://git.github.io/Outreachy-21-Microprojects/
>> > Firstly to get familiar and hands on with the patch based submission I
>> > am looking to start with one of the micro projects that is "Modernize
>> > a test script".
>>
>> Great!
>>
>> > These are test scripts  t7001,t7101,t7102 ,t7201 that require the same
>> > changes of styling . I would like to once confirm if anyone else is
>> > not working on the same ?
>>
>> Someone recently started working on modernizing t7001. You can see
>> that by searching the mailing list archive:
>>
>> https://public-inbox.org/git/?q=t7001
>>
>> You will find:
>>
>> https://public-inbox.org/git/20200925170256.11490-1-shubhunic@gmail.com/
>>
>> About t7101,t7102 and t7201, yeah, it looks like they could be
>> modernized a bit, and no one is working on that yet. So feel free to
>> do it!
>>
>> Best,
>> Christian.
