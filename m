Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E5BD1F405
	for <e@80x24.org>; Thu,  9 Aug 2018 10:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729880AbeHIMa0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 08:30:26 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:5883 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727371AbeHIMa0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 08:30:26 -0400
Received: from [192.168.2.201] ([92.22.29.155])
        by smtp.talktalk.net with SMTP
        id nhpffl53koI6Lnhpgf1mxj; Thu, 09 Aug 2018 11:06:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1533809177;
        bh=wR5duzEuSkh/QdTLGCb07jVSsHsarTW+feptifZft/0=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=CtJVmJk7fz/dZ90tFeS+3IWHdx4VwCHtYamLdxWVIBHovmGR8fVTuWYkLgF41HKdX
         /VVHJfvVor4KReoenglWp5V74KYSxjw6pkTZus1zIiqVfnQtcKb9RNZYAZAw4tqYWz
         lirdbSJ+6yVoVL5KCqvUL1hbVwgkB4PpO6hz02mo=
X-Originating-IP: [92.22.29.155]
X-Spam: 0
X-OAuthority: v=2.3 cv=FOE1Odgs c=1 sm=1 tr=0 a=yeAZMs3+wWQh+Rh+YWy7CA==:117
 a=yeAZMs3+wWQh+Rh+YWy7CA==:17 a=IkcTkHD0fZMA:10 a=BCjA09oAAAAA:8
 a=CoZVvUGnYQpkJ-dY8nQA:9 a=QEXdDO2ut3YA:10 a=jYKBPJSq9nmHKCndOPe9:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 2/2] sequencer: fix quoting in write_author_script
To:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20180731073331.40007-1-sunshine@sunshineco.com>
 <20180807093452.22524-1-phillip.wood@talktalk.net>
 <20180807093452.22524-3-phillip.wood@talktalk.net>
 <CAPig+cQkY1_qDu=fdbA0gVPH88B47bM5BpgbYY8ivsj1Y0QHTw@mail.gmail.com>
 <753b860e-c922-fd70-9d2d-0581976a6f37@talktalk.net>
 <CAPig+cQdH+Xiunej1E6EnA6btFzZJTPo27cFY_UdaFZF7J7t-w@mail.gmail.com>
 <xmqqr2j8j194.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <8d2da302-cf48-cc03-6300-a80bd3d67bab@talktalk.net>
Date:   Thu, 9 Aug 2018 11:06:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <xmqqr2j8j194.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfJ8RhZKzlSF/R0l3z/rAByoX2StWwew+dMBWjenUSSr+iTA7RJiXogwo2r8PXuf/4N+m4xpICCrVE8+asK02EBJIxWamXR0lwnqesV7gDXBoxPXhBdRe
 psSzAAuBM2D1ErfosSAIwVJVC0Zwdn6xY0DwAiQ9AsVGzdMOoVgTEdfL8XI/k5NyfdjjKURKGnYJynkgGOM1BKG2YWgIXXPrYk+AHGYHbiRiL6wkotUhzrKZ
 PO+dErrHDeu3UHFNdfLrvLNaD4YWSkNru94aTjo2Ulu5fz0XbzaKPn4I9CcFaEBrafvpT/MlzMX14RYBOO3Apw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio
On 08/08/18 17:01, Junio C Hamano wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> 
>> What does concern me is that read_env_script() doesn't seem to care
>> about such a malformed file; it doesn't do any validation at all.
>> Contrast that with read_author_ident() which is pretty strict about
>> the content it expects to find in the file. So, it might make sense to
>> upgrade read_env_script() to do some sort of validation on each line
>> (though that shouldn't be in this patch, and doesn't even need to be
>> in this series).
> 
> I do not think it is within the scope of these bugfix patches, but I
> tend to agree that in the longer term it would be a good idea to
> unify these two helpers that read exactly the same file stored at
> rebase_path_author_script(), and make the result stricter, rather
> than tightening two helpers independently.

That's my longer term goal, ideally sharing code with am.

Best Wishes

Phillip
