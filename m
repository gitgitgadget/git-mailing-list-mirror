Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE78C1F453
	for <e@80x24.org>; Tue, 16 Oct 2018 07:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbeJPPGx (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 11:06:53 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43855 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbeJPPGw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 11:06:52 -0400
Received: by mail-ed1-f68.google.com with SMTP id y20-v6so20240481eds.10
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 00:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EY3HXxMrr93KTLyckT53iJltqdCVWjoOUMFz2lWtrgs=;
        b=Lj1OZbbneUGIepn061w0OECrf9VIl4xjsY/1BBafynzIHeWwWRd5jfIigv+WVf/nY0
         DdhGckuyDJBMjXG5rlyp3wUto/3mpErsC5XBrBgm7Vs+n7WA7I7bsgIT4enIXdyPggwI
         P4EYS6QT6lOzmLxcPdS4B4BJk4n8C6DzGXueQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EY3HXxMrr93KTLyckT53iJltqdCVWjoOUMFz2lWtrgs=;
        b=pf3N8TxvXeB5ETo21T1f/7VxC7ZYHNo2PFTrP9q1JBOA/oJor//W5Bqw7dE38hGQqg
         vJSu+iKC3MtJ/4fm6fgjDw3wIhtRPG2Ai0bUNODoB+ykMmvhS3pUQ4MqwIEKG3yVuRoo
         Wc2CUraoS58MwmTP89q7z8OfGxkEYSrmpwZksNyJoLQbxRKjiZpQtBOKwn+8aTLiucNB
         xvsBKEftSyjQIB/pKiljL/J2ssQNHoAbuiKnqhnZHgUrSG3t/J/Fwhd2NOMI3x+MrbnE
         GLrxDHlf1grV/RLB2qvnvm+Q6gESzWd9ckt2MXTbMTTZ8cRQpWxz16a0Xqubh+ST9F2Y
         zzXA==
X-Gm-Message-State: ABuFfojaqi8Z/TTOba2DuimPge5OuKlY8iupTnG5vOp4C/1a8zsrEFnl
        HlihZ4JByteF/xLsPln336efc9ZUZQ8=
X-Google-Smtp-Source: ACcGV62+ow7CTJguh722SySnORQNCqSaraixnUN/GYVBWVAf4xfIVn6zxgx4CFn/ZtXc8CuJ4v5UjQ==
X-Received: by 2002:aa7:d804:: with SMTP id v4-v6mr28561009edq.255.1539674268606;
        Tue, 16 Oct 2018 00:17:48 -0700 (PDT)
Received: from [172.26.255.55] ([193.47.71.171])
        by smtp.gmail.com with ESMTPSA id z7-v6sm4730203edd.71.2018.10.16.00.17.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 00:17:48 -0700 (PDT)
Subject: Re: [PATCH 3/3] send-email: also pick up cc addresses from -by
 trailers
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Joe Perches <joe@perches.com>
References: <20181010111351.5045-1-rv@rasmusvillemoes.dk>
 <20181010111351.5045-4-rv@rasmusvillemoes.dk>
 <xmqqd0shgg66.fsf@gitster-ct.c.googlers.com>
 <5651069a-4879-096d-082d-58d8f0158958@rasmusvillemoes.dk>
 <xmqqo9buzb67.fsf@gitster-ct.c.googlers.com>
From:   Rasmus Villemoes <rv@rasmusvillemoes.dk>
Message-ID: <ef80210d-f440-06c5-a1eb-7b3737f73adb@rasmusvillemoes.dk>
Date:   Tue, 16 Oct 2018 09:17:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <xmqqo9buzb67.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-10-16 07:57, Junio C Hamano wrote:
> Rasmus Villemoes <rv@rasmusvillemoes.dk> writes:
> 
>>> I wonder if it would make it easier to grok if we made the logic
>>> inside out, i.e.
>>>
>>> 	if ($sc eq $sender) {
>>> 		...
>>> 	} else {
>>> 		if ($what =~ /^Signed-off-by$/i) {
>>> 			next if $suppress_cc{'sob'};
>>> 		} elsif ($what =~ /-by$/i) {
>>> 			next if $suppress_cc{'misc'};
>>> 		} elsif ($what =~ /^Cc$/i) {
>>> 			next if $suppress_cc{'bodycc'};> 		}
>>
>> ...yes, that's probably more readable.
> 
> OK, unless there is more comments and suggestions for improvements,
> can you send in a final version sometime not in so distant future so
> that we won't forget?

Will do, I was just waiting for more comments to come in.

 It may be surprising to existing users that
> the command now suddenly adds more addresses the user did not think
> would be added, but it would probably be easy enough for them to
> work around. 

Yeah, I thought about that, but unfortunately the whole auto-cc business
is not built around some config options where we can add a new and
default false. Also note that there are also cases currently where the
user sends off a patch series and is surprised that lots of intended
recipients were not cc'ed (that's how I picked this subject up again; I
had a long series where I had put specific Cc's in each patch, at v2,
some of those had given a Reviewed-by, so I changed the tags, and a
--dry-run told me they wouldn't get the new version).

I suppose one could make use of -by addresses dependent on a new opt-in
config option, but that's not very elegant. Another option is, for a
release or two, to make a little (more) noise when picking up a -by
address - something like setting a flag in the ($what =~ /-by/) branch,
and testing that flag somewhere in send_message(). But I suppose the
message printed when needs_confirm eq "inform" is generic enough.

Rasmus
