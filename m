Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 677FF1F4B5
	for <e@80x24.org>; Mon, 18 Nov 2019 04:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfKREpt (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Nov 2019 23:45:49 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51575 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfKREps (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Nov 2019 23:45:48 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 981DC350E1;
        Sun, 17 Nov 2019 23:45:46 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YPK/8jCnIzcFh2XuzE+ZB9Hna+g=; b=JSRRrI
        3P53nwtRXrRlIiU0meYJaIo1IfgRkxbZxHG+Pa1NBiIJOdEvROT55cQMvi7/ZtIi
        yBYGCDaXehDY1tzMSb+lFv2yUJ4Cy0/py4zXDzmwjQ7zPMW2CKnuNhgvEJ3Gr/CS
        jcCaSe4wkkeN+XZ1T28z+4UTJHUAyP6TU6FaE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pQ3QEmtqRXlI/jHxmkIlBmhB0j26kgn/
        qlotPa8zVMEFEmV8F3/WFLF/jfURGchqpcNpjzMUUNg68LH+ElTDXE/7pfh8+MZ3
        sj0QSbK8opB5heDAwgZfaaAXtFEMdhbU8zfvpvLimXbdhn5qnoFAt+iRFo/VubZz
        9aKdVPXUpdo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8DA87350DF;
        Sun, 17 Nov 2019 23:45:46 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D8889350DE;
        Sun, 17 Nov 2019 23:45:45 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Hans Jerry Illikainen <hji@dyntopia.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/1] Limit search for primary key fingerprint
References: <20191116180655.10988-1-hji@dyntopia.com>
        <20191116194945.GA244853@google.com>
Date:   Mon, 18 Nov 2019 13:45:44 +0900
In-Reply-To: <20191116194945.GA244853@google.com> (Jonathan Nieder's message
        of "Sat, 16 Nov 2019 11:49:45 -0800")
Message-ID: <xmqqzhgt23nr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 48DC6418-09BE-11EA-B5D2-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Hans Jerry Illikainen wrote:
>
>> As part of implementing signature verification for git clone, I decided
>> to refactor/unify the code for commit and merge verification to make it
>> reusable during clones.
>
> Thanks for writing this.
>
> Most of the text in this cover letter would be useful to have in the
> commit message.  From the commit message alone, I could see that you
> were fixing a bug, but I could not see the motivation or workflow it
> is part of.  If I were to later discover an issue triggered by this
> commit, I wouldn't have enough information to weigh tradeoffs about
> the right way to address such an issue.

After reading the proposed log message of [PATCH v1 1/1], I have to
disagree.  It does not matter if we will later see new code in the
clone codepath that would use the gpg-interface API.  Whether it
happens or not, this change to look for the key fingerprint only on
the same line is something we should consider independently.

On the other hand, why the author of this change thought that it may
be necessary thing to do is an excellent material to tell the story
behind the patch in the cover letter.

Thanks.
