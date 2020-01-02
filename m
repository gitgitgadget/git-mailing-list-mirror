Return-Path: <SRS0=b7P8=2X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4409C3276C
	for <git@archiver.kernel.org>; Thu,  2 Jan 2020 21:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A92E720863
	for <git@archiver.kernel.org>; Thu,  2 Jan 2020 21:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="M72eQPwd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725872AbgABVoj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jan 2020 16:44:39 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53989 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgABVoj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jan 2020 16:44:39 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5AE23ADCCE;
        Thu,  2 Jan 2020 16:44:37 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TyBnTnt6E+yxN3oa7TvA5zh6P9A=; b=M72eQP
        wdSJk8+G3uX0PBCokhrmOX/s8N4muB8538iz765irtQrk7dBs0jrdCiGus3M9+kC
        OjV+RVKeoj89lpIA0PRl+xuaBNN54nv3z68SPk1mLGBPf+53v9VVVMUQWzYpUWXs
        LcL1mlSHT6stJFK91OMXXuHIpUh5+P0XV0SDs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Opa7MLaZh6i9Hdu1QLoGWZjTp9Zx7Mks
        j2nbnSZXjcDGJhMarzOwHGyPcXCic8krol4lrfe/AVlZ58WMjJdmD2bW8jT4i/NC
        7aOvBd2EezOqvSgpNkz519ooAP3mH3zpzq3mj3qeg/zVpYL5W8HlNAJhhmet+lRB
        sIHmD8RKa6c=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 537C8ADCCD;
        Thu,  2 Jan 2020 16:44:37 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7716AADCC8;
        Thu,  2 Jan 2020 16:44:34 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Keene <seraphire@gmail.com>
Cc:     Luke Diamand <luke@diamand.org>, Git Users <git@vger.kernel.org>,
        Ben Keene via GitGitGadget <gitgitgadget@gmail.com>
Subject: Re: [PATCH v5 0/4] git-p4: Usability enhancements
References: <pull.675.v4.git.git.1576245481.gitgitgadget@gmail.com>
        <pull.675.v5.git.git.1576504942.gitgitgadget@gmail.com>
        <xmqq8sncj991.fsf@gitster-ct.c.googlers.com>
        <CAE5ih7-ptmmb2UurBw+k+2ZjZQuOkLJ3c-eBoOXKrPX0CJeErA@mail.gmail.com>
        <xmqqh81omd5m.fsf@gitster-ct.c.googlers.com>
        <c95fe073-9bea-9dcf-4579-e9125cc55f39@gmail.com>
Date:   Thu, 02 Jan 2020 13:44:32 -0800
In-Reply-To: <c95fe073-9bea-9dcf-4579-e9125cc55f39@gmail.com> (Ben Keene's
        message of "Thu, 2 Jan 2020 08:50:50 -0500")
Message-ID: <xmqqblrledof.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 10EED5FE-2DA9-11EA-BEE4-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Keene <seraphire@gmail.com> writes:

>> Thanks.  Ben, let's keep the first two and discard the rest for now,
>> which can later be replaced with updated ones.
> That works for me. So, are there any changes that I should make at
> this time, or just let the rest die off?

I don't think of any, from this side.  You can of course spend time
on salvaging and polishing these remaining patches for resubmission
in future cycle(s).

Thanks.
