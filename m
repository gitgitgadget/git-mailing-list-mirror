Return-Path: <SRS0=yenB=DI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50233C4727E
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 20:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B82D3207DE
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 20:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="mMvlwb0K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730064AbgJAUHJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Oct 2020 16:07:09 -0400
Received: from avasout07.plus.net ([84.93.230.235]:37292 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbgJAUHJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Oct 2020 16:07:09 -0400
X-Greylist: delayed 450 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Oct 2020 16:07:08 EDT
Received: from [10.0.2.15] ([195.213.6.24])
        by smtp with ESMTPA
        id O4jbk2cHBoEd7O4jckMrgQ; Thu, 01 Oct 2020 20:59:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1601582377; bh=hZ4659M0VuVyaMJKN/pjev6bsXfVIRxGK3LPU4iheTo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=mMvlwb0K9erWYcMzv16zDsD7d4ELZA4ShaUDhQJFIB7vdM6Fm+qU4EuJa1bFxCCoW
         4GYeEk0fEeiwFIB4l+VrbjYjg3LJokVTAhbkXA346vPmdgNnns0UDfdqEF1qMqOqPB
         ekRqLANWDdh0lcfsZYmbongCNzlXokp4ysMHtrogtLmbNxny+o3G8Z1NQ0DijwCMMr
         uCB7729f8Sf06MnXaheBG+YY1JPZsDFbkzDKI0BJuhvG0wD2CE7SYwHWQnv6ml7dox
         JpkO48wuFKlXW5dls2f4fUrVkru0eIpsXSAM0moyQeGIoTR+z/CJyO9mUj7pI4CSCr
         uOz84oTLQALBw==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Kp/WJVeN c=1 sm=1 tr=0
 a=ZbLTZYmGBvpB9CrD5UJtoA==:117 a=ZbLTZYmGBvpB9CrD5UJtoA==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=A9qS8gIqAAAA:8
 a=EBOSESyhAAAA:8 a=MSYZ38bP7ew8aiJ8fLYA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=H28RkzuXznr5akrmL4QT:22 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v2 06/13] reftable: (de)serialization for the polymorphic
 record type.
To:     Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Jeff King <peff@peff.net>, Han-Wen Nienhuys <hanwenn@gmail.com>
References: <pull.847.git.git.1600283416.gitgitgadget@gmail.com>
 <pull.847.v2.git.git.1601568663.gitgitgadget@gmail.com>
 <8eb944ea9b1c0bdc4a3ebb4e79fd12187f6c988c.1601568663.git.gitgitgadget@gmail.com>
 <xmqqk0w9bvir.fsf@gitster.c.googlers.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <18bd6127-be72-b7b7-8e2a-17bbe7214a2e@ramsayjones.plus.com>
Date:   Thu, 1 Oct 2020 20:59:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <xmqqk0w9bvir.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfDg/XAyfclmw15ECuFM0cdEr/Raf2r04PsWGmWLMHNqp3RlGTJ4c5dppCjYxB70OqYuAyy+m3ZLex8kr0QDrY0CHH7uf0LnNutjT+Ym8zJTUrF8P+toX
 EezRg5ttumqEh4+8lDrg2yIVCUhXyI3F1RtA/v50oNWGj4aY+NDsFyImhIIA7IAS72ihrMvXISPKWA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 01/10/2020 20:23, Junio C Hamano wrote:
> "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> +struct reftable_record reftable_new_record(uint8_t typ)
>> +{
>> +	struct reftable_record rec = { NULL };
> 
> I can see a lot of "sparse" inspired work went into this, but we
> would want to take the previous discussion into account, as nothing
> has changed since then.
> 
> https://lore.kernel.org/git/41a60e60-d2c0-7d54-5456-e44d106548a4@kdbg.org/
> 
> https://lore.kernel.org/git/1df91aa4-dda5-64da-6ae3-5d65e50a55c5@ramsayjones.plus.com/

yep, sparse is equally happy with = { 0 }; here - at least any sparse
version after 'v0.6.1-246-g41f651b4'. ;-) So, as I said yesterday, the
last official release v0.6.2 should be fine, and I _think_ Debian Testing
has a suitable version. (or you could build from source).

> Unfortunately we didn't reach a clear consensus back then; I thought
> we saw a fix to make sparse silent when we use the "= { 0 }" idiom
> in recent versions of sparse, but the above threads do not have any
> mention of it, so either I am misremembering or there were other
> discussions on the same topic where it was also mentioned.

See commit 1c96642326 (sparse: allow '{ 0 }' to be used without warnings,
22-05-2020). We could actually remove that now, since '-Wno-universal-initializer'
is now the default (but it doesn't hurt).

ATB,
Ramsay Jones



