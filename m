Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50648C433EF
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 18:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349390AbiCHSK6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 13:10:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244244AbiCHSK5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 13:10:57 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745F552E42
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 10:10:00 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id d10so41041079eje.10
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 10:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V3jd36OsjURe0f2t1xaGmxP6L586q1I/7SMQs4Vqzn0=;
        b=AOMNeGZFn9NRlPbOAygDfXDz4LhqGceZZbttxLHVUTVG3xWm+o1nHZT1k+/W4EQIv+
         RBmmIgJA3N64tw+lFNibA6EUaerd9JdsSWaaGO2CSrX9sB27H05cHD65+QNEDmnrOZFM
         KgNiQMtJo9794tUKu+l5PzrXKSdc7mAsoyKGw5hjXI9R1hGkF45EaqqtWVpUFqooi45Z
         FBfJdAyX2y5If1ON/yO+Q8oTZXLLrruQukUFdf6q0P0U0BeOvxnXl2qtKkVz50DrIsqz
         DMGiUQNZ5yJjEKwRl8CRX2yaMrUPaOIC15BX7BH0kFeUBOgZREQsowzBQuwjG86/qHXY
         3mIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V3jd36OsjURe0f2t1xaGmxP6L586q1I/7SMQs4Vqzn0=;
        b=jayTR4RGHOUjSw4+TAHRaEVZPoQKlRtVaZZilUrjxYSK7Y1IjpCmtxRPlrhOMBkBZZ
         bCsBAq63OZ2TUn3JxtX1vHXoo4N5vgdPnl+hBl2zg5s3iVypO3dOiiSJXq6e9Be6d8v6
         eTcifsbKk9EOGVRiaCPK5ljhPLvlvDK/oZ7y8LODAQh7Ees3jJS0tbzvN3vqnSAKl8MC
         lX4jHn92SH3gaQ2eyMRWImNnA4rq8Wk6LLcRSnAHns3jAXgOvoD8kBX/xsZTzdSf6Yk4
         C9V631REsC7Qh3w8TnBg80RNpmsBTVSNrCxr9Hy1euqIwoHoBTEJj/qtWi4+w94G0YJ1
         juug==
X-Gm-Message-State: AOAM532/GvweQcp6jv7CUi/WlBXfj9xy53L+vv3Oyx1WHwVmkM+EXXTd
        ke9WUr7KYip/xcyL3qm5W2mF215nAM4=
X-Google-Smtp-Source: ABdhPJzodWb29OcSC21mi9AVvd/1132D4zAeMqO2rSWv7cFOBdADJnF4YNSCJxyP/5nligKTI6i25Q==
X-Received: by 2002:a17:906:4c4b:b0:6da:a5d9:7af9 with SMTP id d11-20020a1709064c4b00b006daa5d97af9mr14385580ejw.336.1646762998833;
        Tue, 08 Mar 2022 10:09:58 -0800 (PST)
Received: from [10.37.129.2] (guest-pat-13-128.njit.edu. [128.235.13.128])
        by smtp.gmail.com with ESMTPSA id d1-20020a17090694c100b006da91d57e93sm6096296ejy.207.2022.03.08.10.09.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Mar 2022 10:09:58 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     =?utf-8?b?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v4 1/3] stash: add tests to ensure reflog --rewrite --updatref behavior
Date:   Tue, 08 Mar 2022 13:09:52 -0500
X-Mailer: MailMate (1.14r5852)
Message-ID: <A8BDCB7C-5F16-4EDE-B8B7-0B73C93B68D2@gmail.com>
In-Reply-To: <34452e16-cf8e-8d23-671e-3c24cdf4e6a4@gmail.com>
References: <pull.1218.v3.git.git.1645817452.gitgitgadget@gmail.com>
 <pull.1218.v4.git.git.1646260044.gitgitgadget@gmail.com>
 <08bb8d3a9b9cd75c8b2aed11db9456baef6f415b.1646260044.git.gitgitgadget@gmail.com>
 <xmqqlexsexse.fsf@gitster.g> <20334a5e-52b8-12a4-de93-a8baa5313858@gmail.com>
 <220303.86a6e72d1g.gmgdl@evledraar.gmail.com>
 <d73db784-c09b-a889-3d19-d41be7748e66@gmail.com>
 <F383C357-FEC3-4E1E-A0B7-97EDE05035FD@gmail.com>
 <34452e16-cf8e-8d23-671e-3c24cdf4e6a4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On 8 Mar 2022, at 5:39, Phillip Wood wrote:

> Hi John
>
> On 03/03/2022 19:12, John Cai wrote:
>> Hi Phillip,
>>
>> On 3 Mar 2022, at 12:28, Phillip Wood wrote:
>>
>>> On 03/03/2022 16:52, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>>>
>>>> On Thu, Mar 03 2022, Phillip Wood wrote:
>>>>
>>>>> On 02/03/2022 23:32, Junio C Hamano wrote:
>>>>>> "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>>>>> [...]
>>>>>>> +test_expect_success REFFILES 'drop stash reflog updates refs/sta=
sh with rewrite' '
>>>>>>> +	git init repo &&
>>>>>>> +	(
>>>>>>> +		cd repo &&
>>>>>>> +		setup_stash
>>>>>>> +	) &&
>>>>>> Hmph, so this is done inside the subdirectory.  The implementation=

>>>>>> of the helper in this iteration does look cleaner than in the
>>>>>> previous iteration.
>>>>>> But these many references to "repo/" and "-C repo" we see below
>>>>>> makes me wonder why we do not put the whole thing inside the
>>>>>> subshell we started earlier.
>>>>>> i.e.
>>>>>> 	git init repo &&
>>>>>> 	(
>>>>>> 		cd repo &&
>>>>>> 		setup_stash_test &&
>>>>>> 		echo 9 >file &&
>>>>>> 		old=3D$(git rev-parse stash@{0}) &&
>>>>>> 		git stash &&
>>>>>> 		new=3D$(git rev-parse stash@{0}) &&
>>>>>> 		...
>>>>>> 		test_cmp expect actual
>>>>>> 	)
>>>>>>
>>>>>
>>>>> I wonder if we could avoid the subshell entirely and avoid relying =
on
>>>>> REFFILES (assuming we're not trying to test the implementation deta=
ils
>>>>> of that refs backend) by doing something like
>>>>>
>>>>> test_expect_success 'drop stash reflog updates refs/stash with rewr=
ite' '
>>>>> 	old=3D$(git rev-parse stash@{0}) &&
>>>>> 	setup_stash_test &&
>>>>> 	git rev-list -g stash >tmp &&
>>>>> 	sed /$old/d tmp >expect &&
>>>>> 	git rev-list -g stash >actual &&
>>>>> 	test_cmp expect actual
>>>>> '
>>>>
>>>> Unless I'm missing something that "rev-list -g" will emit only the R=
HS
>>>> of the stash logs, i.e. no "0000..." etc.
>>>>
>>>> And if we only look at that the difference with specifying the flag
>>>> isn't visible, no?
>>>
>>> Maybe I'm missing what this test is actually needs to do. I thought i=
t just needed to check that the deleted stash is removed from the reflog =
and the others are unchanged. You're right that it wont show the LHS and =
if that is important then you need to read the log file directly.
>>
>> We had discussed this briefly in [1], but the --rewrite option for ref=
log delete will rewrite the LHS, which is not visible to normal ref API u=
sers. So the only way to test that this happened is to reach inside of th=
e file.
>>
>> 1. https://lore.kernel.org/git/xmqqczjdp2g8.fsf@gitster.g/
>
> Thanks for the pointer, that was useful context that could maybe be add=
ed to the commit message to explain why the test needs to check the lhs o=
f the reflog if you reroll.

Good point. that would be helpful context since it took me a while to fig=
ure it out myself--will re-roll, thanks!

>
> Best Wishes
>
> Phillip
>
>>>
>>> Best Wishes
>>>
>>> Phillip
>>
>> thanks,
>> John
>>
>>>
>>>
>>>>>>> +	echo 9 >repo/file &&
>>>>>>> +
>>>>>>> +	old_oid=3D"$(git -C repo rev-parse stash@{0})" &&
>>>>>>> +	git -C repo stash &&
>>>>>>> +	new_oid=3D"$(git -C repo rev-parse stash@{0})" &&
>>>>>>> +
>>>>>>> +	cat >expect <<-EOF &&
>>>>>>> +	$(test_oid zero) $old_oid
>>>>>>> +	$old_oid $new_oid
>>>>>>> +	EOF
>>>>>>> +	cut -d" " -f1-2 repo/.git/logs/refs/stash >actual &&
>>>>>>> +	test_cmp expect actual &&
>>>>>>> +
>>>>>>> +	git -C repo stash drop stash@{1} &&
>>>>>>> +	cut -d" " -f1-2 repo/.git/logs/refs/stash >actual &&
>>>>>>> +	cat >expect <<-EOF &&
>>>>>>> +	$(test_oid zero) $new_oid
>>>>>>> +	EOF
>>>>>>> +	test_cmp expect actual
>>>>>>> +'
>>>>>>> +
>>>>>>>     test_expect_success 'stash pop' '
>>>>>>>     	git reset --hard &&
>>>>>>>     	git stash pop &&
>>>>
