Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A49101F4F8
	for <e@80x24.org>; Fri, 30 Sep 2016 09:33:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932254AbcI3Jdf (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Sep 2016 05:33:35 -0400
Received: from [195.159.176.226] ([195.159.176.226]:58330 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S932088AbcI3Jde (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2016 05:33:34 -0400
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <gcvg-git-2@m.gmane.org>)
        id 1bpuC2-0001WH-Hf
        for git@vger.kernel.org; Fri, 30 Sep 2016 11:33:22 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH v2] gpg-interface: use more status letters
Date:   Fri, 30 Sep 2016 11:33:05 +0200
Message-ID: <f167f869-ca31-efed-b9a6-1d9cde8d68ef@drmicha.warpmail.net>
References: <xmqqk2dxp84i.fsf@gitster.mtv.corp.google.com>
 <c4777ef68059034d7ad4697a06bba3cabbdc9265.1475053649.git.git@drmicha.warpmail.net>
 <xmqqshsjiyn4.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@blaine.gmane.org
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
Cc:     git@vger.kernel.org, Alex <agrambot@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <xmqqshsjiyn4.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano venit, vidit, dixit 28.09.2016 21:59:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> - Use GNUPGHOME="$HOME/gnupg-home-not-used" just like in other tests (lib).
> 
> If you are not using /dev/null, I expected you to do
> 
> 	. ./test-lib.sh
> 	GNUPGHOME_saved=$GNPGHOME
>         . "$TEST_DIRECTORY/lib-gpg.sh"
> 
> and then use
> 
> 	GNUPGHOME="$GNUPGHOME_saved" git log -1 ...
> 
> in the test.
> 
> Otherwise, you are not futureproofing your use and only adding to
> maintenance burden.  The gnupg-home-not-used hack may turn out to be
> a problematic and test-lib.sh may update to point to somewhere else,
> which will leave your copy still pointing at the old problematic
> place).

Well, I understood you told me to do what test-lib.sh does.

You obviously wanted me to piggy-bak on test-lib.sh's behavior instead.

I don't know what's more likely to break - the latter relies on
test-lib.sh's setting GNUPGHOME to a non existing gpg home, which is
something funny to do if you don't even plan to use gpg.

>> - Do not parse for signer UID in the ERRSIG case (and test that we do not).
> 
> Good.
> 
>> - Retreat "rather" addition from the doc: good/valid are terms that we use
>>   differently from gpg anyways.
> 
> OK.
> 
>> +  "X" for a good expired signature, or good signature made by an expired key,
> 
> As an attempt to clarify that we cover both EXPSIG and EXPKEYSIG
> cases, I think this is good enough.  I may have phrased the former
> slightly differently, though: "a good signature that has expired".
> 
> I have no strong opinion if we want to stress that we cover both
> cases, though, which is I think what Ramsay's comment was about.

I'll comment in the reply to his 2nd e-mail....

Michael


