Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BC651F462
	for <e@80x24.org>; Wed,  5 Jun 2019 20:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfFEUMM (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jun 2019 16:12:12 -0400
Received: from smtp-o-3.desy.de ([131.169.56.156]:44731 "EHLO smtp-o-3.desy.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726502AbfFEUMM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jun 2019 16:12:12 -0400
Received: from smtp-buf-3.desy.de (smtp-buf-3.desy.de [IPv6:2001:638:700:1038::1:a6])
        by smtp-o-3.desy.de (Postfix) with ESMTP id 8C3F66022F
        for <git@vger.kernel.org>; Wed,  5 Jun 2019 22:12:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-3.desy.de 8C3F66022F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
        t=1559765529; bh=nW7ZZrxbSBEnd2imMNYCw2PQ5lbeKTZeFZIheC+ObiM=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=QU/5ZWGjEunVloiD3L02dpxz4Urtyv16X+dqhvvlN27WfMMlaiU5JAU23WOGvnCgs
         kfzRfIslHwV0E50GOeyGMpHXlngr8nidrrocc/mrceriN3AE8xncjs2VP51roKu4Ym
         vzwVh5SJqLp9QyI5ZS5ffFBQyRgArRUsDvtM8gIY=
Received: from smtp-m-3.desy.de (smtp-m-3.desy.de [131.169.56.131])
        by smtp-buf-3.desy.de (Postfix) with ESMTP id 857CEA0077;
        Wed,  5 Jun 2019 22:12:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at desy.de
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
        by smtp-intra-3.desy.de (Postfix) with ESMTP id 55CB78003E;
        Wed,  5 Jun 2019 22:12:09 +0200 (CEST)
Date:   Wed, 5 Jun 2019 22:12:09 +0200 (CEST)
From:   "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Message-ID: <1933659713.10490718.1559765529240.JavaMail.zimbra@desy.de>
In-Reply-To: <xmqqv9xkroc5.fsf@gitster-ct.c.googlers.com>
References: <139144069.10140489.1559664262817.JavaMail.zimbra@desy.de> <20190605155300.26506-1-tigran.mkrtchyan@desy.de> <xmqqv9xkroc5.fsf@gitster-ct.c.googlers.com>
Subject: Re: [PATCH v3] tag: add tag.gpgSign config option to force all tags
 be GPG-signed
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.10_GA_3781 (ZimbraWebClient - FF67 (Linux)/8.8.10_GA_3786)
Thread-Topic: add tag.gpgSign config option to force all tags be GPG-signed
Thread-Index: QvJm2IgH9hUTScKef/SxJ5TKG2caiA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



----- Original Message -----
> From: "Junio C Hamano" <gitster@pobox.com>
> To: "Tigran Mkrtchyan" <tigran.mkrtchyan@desy.de>
> Cc: "git" <git@vger.kernel.org>, "Jonathan Nieder" <jrnieder@gmail.com>, "Johannes Schindelin"
> <Johannes.Schindelin@gmx.de>
> Sent: Wednesday, June 5, 2019 6:25:46 PM
> Subject: Re: [PATCH v3] tag: add tag.gpgSign config option to force all tags be GPG-signed

> Tigran Mkrtchyan <tigran.mkrtchyan@desy.de> writes:
> 
>> As many CI/CD tools don't allow to control command line options when
>> executing `git tag` command, a default value in the configuration file
>> will allow to enforce tag signing if required.

Must of them blindly execute git commands with some hard-coded combination of
options. It's clear to me, that they are the source of the problem, but
git can be the solution.

> 
> Hmm.  Would these "many" tools still allow arbigrary configuration
> set to affect their operation?  It sounds like a bigger issue but it
> is a separate one.
> 
>> The new config-file option tag.gpgSign enforces signed tags. Additional
>> ...
>> will skip the signing step.
> 
> This paragraph is well written.
> 
>> The combination of -u <key-id> and --no-sign not allowed.
> 
> This sentence lacks a verb.  Perhaps s/not allowed/is &/.
> 

Jup. Sorry.

> But more importantly, I think we should justify why this "not
> allowed" makes sense as the design of the feature. A plausible
> alternative design would simply follow the "last one wins" paradigm,
> where
> 
>    git tag -u key # "-u key" implies "-s"
> 
>    git tag -u key --no-sign # "--no-sign' trumps the implied "-s"
> 
>    git tag --no-sign -u key # "-u key"'s implication of "-s" trumps the
>			     # earlier "--no-sign"
> 
> and having "[tag] gpgsign" simply adds to the implication early in
> the chain to be overridden by later command line options.
> 
> Let's explain why "you cannot give -u <key> and --no-sign at the
> same time" is better than "the last one wins".

This is matter of convention. I never pay attention to the order of options
on the git command line, but I don't put conflicting options either, I hope.
Does git already have position depended options? If yes, then fine with me.
Otherwise, I don't want to introduce ambiguity. Yes, less ambiguity is my
answer to why it's better than "the last one wins".


> 
>> diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
>> index a74e7b926d..2e5599a67f 100644
>> --- a/Documentation/git-tag.txt
>> +++ b/Documentation/git-tag.txt
>> @@ -64,6 +64,13 @@ OPTIONS
>>  -s::
>>  --sign::
>>  	Make a GPG-signed tag, using the default e-mail address's key.
>> +	The default behavior of tag GPG-signing is controlled by `tag.gpgSign`
>> +	configuration variable if it exists, or disabled oder otherwise.
>> +	See linkgit:git-config[1].
>> +
>> +--no-sign::
>> +	Override `tag.gpgSign` configuration variable that is
>> +	set to force each and every tag to be signed.
>>  
>>  -u <keyid>::
>>  --local-user=<keyid>::
> 
> If we justify "-u and --no-sign do not mix", that design needs to be
> explained to the end users in the documentation, not just in the
> proposed log messsage.

Make sense.

Thanks,
   Tigran.
