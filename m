Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49646EE8015
	for <git@archiver.kernel.org>; Fri,  8 Sep 2023 16:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244954AbjIHQOK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Sep 2023 12:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbjIHQOJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2023 12:14:09 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF69FCFA
        for <git@vger.kernel.org>; Fri,  8 Sep 2023 09:14:05 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6CD711A548B;
        Fri,  8 Sep 2023 12:14:04 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=IkcaZLsk2Md6c7XRqAucvU8tuzun925FGWO58qC
        kERE=; b=S3L7Dd9youd4a9YaL+FVIo96tz2w0eD33U1CyKic18+U8psbWJ482HJ
        VpNis6FIY1LiaM9wEbRcNU63dpHdHuu1IPGDdBCLxcidtlh9LZeqJI+Qk5IPLhmU
        PeXYOwrf1rEhIK2kaHGkC5JMuPj2VVDyzr4Qhnp8XX4dMK09aPNk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2C4781A548A;
        Fri,  8 Sep 2023 12:14:04 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [108.15.224.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 485C51A5489;
        Fri,  8 Sep 2023 12:14:03 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Date:   Fri, 8 Sep 2023 12:14:01 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] completion(switch/checkout): treat --track and -t the
 same
Message-ID: <ZPtISYVufU0MazO_@pobox.com>
References: <pull.1584.git.1694176123471.gitgitgadget@gmail.com>
 <xmqq1qf8vf1e.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1qf8vf1e.fsf@gitster.g>
X-Pobox-Relay-ID: BA3FFFF6-4E62-11EE-94F3-25B3960A682E-09356542!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
>> index 8835e16e811..df8bc44c285 100755
>> --- a/t/t9902-completion.sh
>> +++ b/t/t9902-completion.sh
>> @@ -1622,14 +1622,22 @@ test_expect_success 'git checkout - with -d, complete only references' '
>>  '
>>  
>>  test_expect_success 'git switch - with --track, complete only remote branches' '
>> -	test_completion "git switch --track " <<-\EOF
>> +:	test_completion "git switch --track " <<-\EOF &&

Is this new leading ":" intended?  It looks out of place
(though perhaps I just don't unerstand the context well
enough).

>> +	other/branch-in-other Z
>> +	other/main-in-other Z
>> +	EOF
>> +	test_completion "git switch -t " <<-\EOF
>>  	other/branch-in-other Z
>>  	other/main-in-other Z
>>  	EOF
>>  '
> 
> So, this demonstrates that '-t' behaves the same way as '--track'.

-- 
Todd
