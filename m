Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69C4C433F5
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 10:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347021AbiCOKZI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Mar 2022 06:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346998AbiCOKZH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Mar 2022 06:25:07 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F084344D7
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 03:23:55 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4813110F49B;
        Tue, 15 Mar 2022 06:23:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=8aplNAspwHS54o0+bg6ut+CjWai9LUTyBeCkBkcUaYY=; b=suW/
        86An+CGn6TwbveK24NQ5XPWIaWzM5rFmRqxNKVGLv2OoHGwK7rUHhiPJUiRWpyGY
        hHUhvjM3pgMcmcWBfd1OFTDTdxesDhZSquqpS9M8MP9CXK7/WNUaIi/9CNN8zdHp
        qyOG4eT/wCemDnIs6YZr8JzG5ZRMcKeWhHwlHZ8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 400AF10F49A;
        Tue, 15 Mar 2022 06:23:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A8BBA10F495;
        Tue, 15 Mar 2022 06:23:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Cantrell <david@cantrell.org.uk>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] tab completion of filenames for 'git restore'
References: <pull.1227.git.git.1647032857097.gitgitgadget@gmail.com>
        <xmqqlexel59r.fsf@gitster.g>
        <2ae04989-156c-63a2-c191-67f97bb6c7b9@cantrell.org.uk>
Date:   Tue, 15 Mar 2022 03:23:51 -0700
Message-ID: <xmqqk0cvh5u0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0308B9C2-A44A-11EC-BB99-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Cantrell <david@cantrell.org.uk> writes:

>>> @@ -2883,14 +2883,21 @@ _git_restore ()
>>>   	case "$cur" in
>>>   	--conflict=*)
>>>   		__gitcomp "diff3 merge zdiff3" "" "${cur##--conflict=}"
>>> +		return
>>>   		;;
>>>   	--source=*)
>>>   		__git_complete_refs --cur="${cur##--source=}"
>>> +		return
>>>   		;;
>>> ...
>> Do you need to sprinkle return's?  Instead you could just add
>> another case arm, like
>> +	*)
>> +		... whatever you want to do when
>> +		... $cur is not a --dashed-option
>> +		;;
>
> Liberal sprinkling of return like that seems to be the norm for the
> rest of the file so I stuck with it.

An existing bad practice is not a good excuse to spread it even
more, though.

