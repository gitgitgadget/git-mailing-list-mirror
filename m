Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 311F91FF6D
	for <e@80x24.org>; Thu, 22 Dec 2016 21:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938782AbcLVVXe (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Dec 2016 16:23:34 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57904 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933582AbcLVVXe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Dec 2016 16:23:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 32A2059E4D;
        Thu, 22 Dec 2016 16:23:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hstyRbE+7BeXMA4uE4IXo3PIZao=; b=LIqi8x
        34xNLXtDn6olQdNcZsOmYrMzarZ29KjJJIxBr/YpUjyIe8CwLGM31dxbNko6jUqH
        xEZ9j79X7AuOjCnPtQoBEYViLEBy4jNm9uz3nhx4p+gb5QUU0MkBkdp4O+Cd7NTv
        3a3mKgtY0Avt2NDZvqFSJGtjsCBKKuAi/68gI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bbD5cJ/XeiYbEkbeWM0wfCPCUNfuncaW
        HK4I36NTnVRLTptcNyP6mZaHZ1Prp/ObuzgU8psW/CQzCUgPEA2oifhaWNalO7Vw
        qe5Cr6qJEBNgy5+J8/b9hivexX3TE2Thx0hYLDy1C31d+IhF0ipSkK3gWN6xiV1A
        4JFpx7hM07c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2A8E859E48;
        Thu, 22 Dec 2016 16:23:32 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 942EC59E46;
        Thu, 22 Dec 2016 16:23:31 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Luke Diamand <luke@diamand.org>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [PATCH v1] git-p4: fix git-p4.pathEncoding for removed files
References: <20161218175153.92336-1-larsxschneider@gmail.com>
        <xmqq37hjobf6.fsf@gitster.mtv.corp.google.com>
        <CAE5ih7-=bD_ZoL5pFYfD2Qvy-XE24V_cgge0XoAvuoTK02EDfg@mail.gmail.com>
Date:   Thu, 22 Dec 2016 13:23:30 -0800
In-Reply-To: <CAE5ih7-=bD_ZoL5pFYfD2Qvy-XE24V_cgge0XoAvuoTK02EDfg@mail.gmail.com>
        (Luke Diamand's message of "Tue, 20 Dec 2016 11:01:23 +0000")
Message-ID: <xmqqeg0zfyjx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E35343C0-C88C-11E6-8188-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Luke Diamand <luke@diamand.org> writes:

> The change puts the logic into stripRepoPath() instead, which is
> indeed called from both of those functions (good), but also from
> splitFilesIntoBranches(), but only if self.useClientSpec is set. That
> function only gets used if we're doing the automatic branch detection
> logic, so it's possible that this code might now be broken and we
> wouldn't know.
>
> Lars, what do you think? Other than the above, the change looks good,
> so it may all be fine.
>
> (As an aside, this is the heart of the code that's going to need some
> careful rework if/when we ever move to Python3).

Thanks.  

I'll merge this as-is to 'next', expecting that further refinement
can be done incrementally.

