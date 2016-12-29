Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64AC01FCA5
	for <e@80x24.org>; Thu, 29 Dec 2016 22:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753315AbcL2Wnx (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Dec 2016 17:43:53 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62670 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753154AbcL2Wnu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Dec 2016 17:43:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C469A5D0E8;
        Thu, 29 Dec 2016 17:43:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mIZlBDoahwabiQgR6TGZz9Xz1io=; b=f5FXrM
        6RNx7MNKbNABHEARITdw2MDQKn8At8xwMJcYqmwjeomi9JpQr7tu3xA4/fcGW3wX
        xTNvt4JrFEy5kUt6nNkJrzvABJM9RGbJTy9fSp90ID8uEAqytGEyXZ6CkvuatOdI
        9q1BaC8SgG4Gpj7bHOdgSwPpntVRQOI0LePP8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HcqHkTepvH0jdcOzon9vByTVEILQWBP9
        MFsUuslFfohJiN6E8K5+OvA13mqrk33wsEdHSKKhT7LeNk7nlOvslIE/RumBzdi4
        GrwJ2nf0kROclJMlwfFSs2GqWmy/AT1eJD6E2zTc2Q430KrmnnioNiS9hDI7nTz6
        KfZsXRwW+6s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BCBB25D0E7;
        Thu, 29 Dec 2016 17:43:48 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 328955D0E6;
        Thu, 29 Dec 2016 17:43:48 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Eric Wong <e@80x24.org>, Eduardo Habkost <ehabkost@redhat.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH] am: add am.signoff add config variable
References: <1482946838-28779-1-git-send-email-ehabkost@redhat.com>
        <20161229084701.GA3643@starla>
        <xmqqtw9m5s5m.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kaAbCTsY_SddVMKMsLV0xyXNBFvxQ=J-20Cwdz31v4OwA@mail.gmail.com>
Date:   Thu, 29 Dec 2016 14:43:47 -0800
In-Reply-To: <CAGZ79kaAbCTsY_SddVMKMsLV0xyXNBFvxQ=J-20Cwdz31v4OwA@mail.gmail.com>
        (Stefan Beller's message of "Thu, 29 Dec 2016 14:18:48 -0800")
Message-ID: <xmqqpoka5pb0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 432B9EEC-CE18-11E6-B2B8-06F112518317-77302942!pb-smtp1.pobox.com
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com;
 h=from:to:cc:subject:references:date:in-reply-to:message-id:mime-version:content-type; s=2016-12.pbsmtp; bh=mIZlBDoahwabiQgR6TGZz9Xz1io=; b=ZOod0HTp4DlOEwRu3iaQZMKSYdluZ9kLAI/e5jZjxKApkHlS79T/SyzNPtfibVTns+iR+cHB475la2bX+BY+DWM1M7cLBXUdSvIeD0FTOgxZZ/X11Lx7TXP0QhGBBDcjijVWofLHMcQQYlJoUO6q8r87CE7/kDBBPbVH6kKHcw0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> IANAL either, but we have been striving to keep output of
>>
>>    $ git grep '\.signoff' Documentation
>
>>
>> empty to keep Sign-off meaningful.
>
> Try again with -i ;)
> and you'll find format.signOff

Mistakes happen.  Finding an old mistake is not an excuse for you to
make the same one again.  It is an opportunity to come up with a way
to correct it without hurting existing users by designing a smooth
transition path.

