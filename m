Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A90FDC38145
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 20:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbiIGU6E convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 7 Sep 2022 16:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiIGU55 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 16:57:57 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD087A00C0
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 13:57:51 -0700 (PDT)
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 287KvemD063551
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 7 Sep 2022 16:57:41 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>
Cc:     "'Adam Dinwoodie'" <adam@dinwoodie.org>,
        "'Git Mailing List'" <git@vger.kernel.org>,
        "=?UTF-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>,
        =?UTF-8?B?J8SQb8OgbiBUcuG6p24gQ8O0bmcgRGFuaCc=?= 
        <congdanhqx@gmail.com>, "'Emily Shaffer'" <emilyshaffer@google.com>
References: <20220901173942.abolcr4aa5gixncm@lucy.dinwoodie.org>        <4s7o04s9-3052-rqq6-584n-978p9758p580@tzk.qr> <xmqqy1uusyez.fsf@gitster.g>
In-Reply-To: <xmqqy1uusyez.fsf@gitster.g>
Subject: RE: [PATCH] t1800: correct test to handle Cygwin
Date:   Wed, 7 Sep 2022 16:57:35 -0400
Organization: Nexbridge Inc.
Message-ID: <001301d8c2fc$78dc4bc0$6a94e340$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKd6Br1tbcI/e22m/Ii9JrYIDCjcwH3fzugAoyX5xSsJgdrMA==
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On September 7, 2022 4:49 PM, Junio C Hamano wrote:
>Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>>> @@ -159,7 +159,7 @@ test_expect_success 'git hook run a hook with a bad
>shebang' '
>>>  	# TODO: We should emit the same (or at least a more similar)
>>>  	# error on Windows and !Windows. See the OS-specific code in
>>>  	# start_command()
>>> -	if test_have_prereq !WINDOWS
>>> +	if test_have_prereq !MINGW
>>
>> ... this to be `test_have_prereq !WINDOWS || test_have_prereq CYGWIN`
>> instead.
>
>My understanding is that there are CYGWIN and MINGW prereqs that are
>mutually exclusive (if you are on MINGW you cannot be on CYGWIN and vice
>versa), and WINDOWS is a short-hand for "we are either on MINGW or CYGWIN",
>and I am not sure if it clarifies anything to rewrite "we do not want to be on
>MINGW to run these tests" to "anything non Windows is fine, by the way,
>CYGWIN is also OK".
>
>If we are planning to add another variant that falls into umbrella WINDOWS that is
>not CYGWIN, and that new variant falls short of the requirement of the tests in
>this script just like MINGW does, then the suggested rewrite does make quite a lot
>of sense.  There would be not just two but more variants in Windows family, and if
>Cygwin is the odd man out, then the rewritten one would convey that more
>clearly.  But with only two, as long as everybody understands what MINGW is, I
>think "this part does not work on MINGW" is more concise and clear.
>
>As Đoàn Trần Công Danh pointed out, the TODO: comment may need to be
>updated.  For future-proofing, perhaps "a more similar) error on all platforms."
>would be appropriate.

I think this is the same as I reported under [BUG] t1800: Fails for error text comparison, which somehow Outlook associated with a different thread. NonStop has the same issue with error messages not being consistent across platforms.

-Randall

