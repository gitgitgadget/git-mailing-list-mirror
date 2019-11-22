Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121CDC432C0
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 06:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8E50204FD
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 06:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="n53hFT0u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfKVGc1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 01:32:27 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57279 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbfKVGc1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 01:32:27 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 356A339C0D;
        Fri, 22 Nov 2019 01:32:25 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ltT8c9WyvWppPK/gIkiyj3f+Qhg=; b=n53hFT
        0u10Eue1CK33IUXgOotZpT4/G1YujidLWRRnudq3mFrQCQC4mWjtMPZXx19/JQ7N
        Lxsd2qYI/lR8U3bzj3UeAr+lXKIgPBNjX9Jk+mN/x+ZL++z5f5cLVrYcIemsoVMa
        SzV2h/0DIbBImqq/wtXyR6SzvMJbd04NrGAnY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JXLMNky1ReOjrSJJiVPHbnfzb5cWufDK
        +NqBJFd9nujnByGrIsbHxcJ+wVHYEI/lDFBHy6PMkosEXWvPMQgdWioNrc21S/t2
        L4kZN2jlgvQmZCTJ7Js2ikNwLr688Ww8IyE+j3fmxoToUsROEf8j7cEUysXC4r3E
        fjXBD9Gu0U8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1C5A039C0B;
        Fri, 22 Nov 2019 01:32:25 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6533139C0A;
        Fri, 22 Nov 2019 01:32:24 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        martin.agren@gmail.com, newren@gmail.com,
        phillip.wood123@gmail.com, t.gummerer@gmail.com
Subject: Re: [PATCH v5 0/6] rebase -i: support more options
References: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
        <20191101140003.13960-1-rohit.ashiwal265@gmail.com>
        <xmqqimnd92nv.fsf@gitster-ct.c.googlers.com>
        <36162d31-0463-5e21-fbf6-53667fffc000@gmail.com>
Date:   Fri, 22 Nov 2019 15:32:23 +0900
In-Reply-To: <36162d31-0463-5e21-fbf6-53667fffc000@gmail.com> (Alban Gruin's
        message of "Thu, 21 Nov 2019 09:17:49 +0100")
Message-ID: <xmqqlfs84e14.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D854E440-0CF1-11EA-B854-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

>> +		OPT_HIDDEN_BOOL(0, "ignore-date", &options.ignore_date,
>> +				N_("synonym of --reset-autohr-date")),
>
> There is a typo here.

Oops. I think you meant s/autohr/author/, so I've fixed it up
locally---if you spotted something else, please let me know.

Thanks.
