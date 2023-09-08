Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE44EE8015
	for <git@archiver.kernel.org>; Fri,  8 Sep 2023 16:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245096AbjIHQ0O (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Sep 2023 12:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241714AbjIHQ0N (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2023 12:26:13 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED0F1FE4
        for <git@vger.kernel.org>; Fri,  8 Sep 2023 09:25:52 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8A94F39029;
        Fri,  8 Sep 2023 12:25:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=59ImrdDVer5c/sFzwaWGaiHcTyMPFI7NwHFgD+
        3UWVc=; b=Ei8E6jQntsVnWP9LBc73jf2S5uzHQxaGD5sNUuGQdj6MhPahp6zH8P
        85fhByrHbamDv9DOxSlZfxVPQUcuz/Hz+iqgSqssjnwYP35IOFryz0u/s4oWlmUC
        kqSOeZBjT2uK2m2Qum86l09J4MieMx25YZ8q1zTs3gGQ3s3GjUtMw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8392A39028;
        Fri,  8 Sep 2023 12:25:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.59])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3156739027;
        Fri,  8 Sep 2023 12:25:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] completion(switch/checkout): treat --track and -t the same
In-Reply-To: <ZPtISYVufU0MazO_@pobox.com> (Todd Zullinger's message of "Fri, 8
        Sep 2023 12:14:01 -0400")
References: <pull.1584.git.1694176123471.gitgitgadget@gmail.com>
        <xmqq1qf8vf1e.fsf@gitster.g> <ZPtISYVufU0MazO_@pobox.com>
Date:   Fri, 08 Sep 2023 09:25:48 -0700
Message-ID: <xmqqil8ktywj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5EF9DEDA-4E64-11EE-9FC2-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Todd Zullinger <tmz@pobox.com> writes:

> Junio C Hamano wrote:
>> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
>> writes:
>>> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
>>> index 8835e16e811..df8bc44c285 100755
>>> --- a/t/t9902-completion.sh
>>> +++ b/t/t9902-completion.sh
>>> @@ -1622,14 +1622,22 @@ test_expect_success 'git checkout - with -d, complete only references' '
>>>  '
>>>  
>>>  test_expect_success 'git switch - with --track, complete only remote branches' '
>>> -	test_completion "git switch --track " <<-\EOF
>>> +:	test_completion "git switch --track " <<-\EOF &&
>
> Is this new leading ":" intended?  It looks out of place
> (though perhaps I just don't unerstand the context well
> enough).

Good eyes.  It makes it an expensive no-op ;-)
