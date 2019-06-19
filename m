Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 307551F462
	for <e@80x24.org>; Wed, 19 Jun 2019 15:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfFSPVl (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 11:21:41 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63455 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfFSPVk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 11:21:40 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BDAB915E7B4;
        Wed, 19 Jun 2019 11:21:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YkF2PWw1uLoNmFBGUxMZsqNZPzs=; b=alUe8m
        JZshbjuINmHQ8sE9eUuFBJWMMchiXDKlbyCl76iI0uPcLFDh2kZvDMhzFq6mvxWx
        YiWHV7692bwfEiWEiB4lB4uk39rUVJO1MKd3SplBHE0Kz6ssZWDe4dX+j6M9uxSc
        VoQ/hEHqWzaBZQZ/fjuWR7c7SBJ35fPGrSWiA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=s//a7Vb7tSqrQ6PW4TVUyo1eC6NYhA8G
        jXi0tC4W/eZEGGB2XPD8UFt1QKe03YYF9c1/OJjWS56RfJYCVt/WC4/u+W7McSuG
        C2ZYwhLss+828fzJY6Rx+nJvkOFDGhXn+5Soj+64hWJoUa5VJ6mE0w20rRn8CLOv
        1DvKdjyGMNw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B434815E7B3;
        Wed, 19 Jun 2019 11:21:38 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 10F1115E7B1;
        Wed, 19 Jun 2019 11:21:37 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 03/17] cache-tree.c: avoid reusing the DEBUG constant
References: <pull.149.git.gitgitgadget@gmail.com>
        <486297ec8c146e0ed47cd1dd8fe8f6496c2b54c2.1560860634.git.gitgitgadget@gmail.com>
        <CAPig+cTXdz6s_cftPydKjtESz986s1xLQvwV8xPzYSR_xLK6Cg@mail.gmail.com>
Date:   Wed, 19 Jun 2019 08:21:36 -0700
In-Reply-To: <CAPig+cTXdz6s_cftPydKjtESz986s1xLQvwV8xPzYSR_xLK6Cg@mail.gmail.com>
        (Eric Sunshine's message of "Tue, 18 Jun 2019 19:14:14 -0400")
Message-ID: <xmqqzhmdppmn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EE8B2204-92A5-11E9-A6C7-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Tue, Jun 18, 2019 at 8:24 AM Jeff Hostetler via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> In MSVC, the DEBUG constant is set automatically whenever compiling with
>> debug information.
>>
>> This is clearly not what was intended in cache-tree.c, so let's use a less
>> ambiguous constant there.
>
> s/constant/macro name/ would be clearer.

It is closer to the standard-kosher terminology, I would think; if
somebody is in more pedantic mood, "C preprocessor macro" is
probably the phrase to use.
