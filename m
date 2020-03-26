Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E972C43331
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 19:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE16420722
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 19:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TTuP03hR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbgCZTbl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 15:31:41 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53110 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgCZTbl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 15:31:41 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 26BBF53677;
        Thu, 26 Mar 2020 15:31:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=A1rs4oTI2CL+zNOqfC/StMSpI4o=; b=TTuP03
        hRdcALitEmKjsJ18IOWRXeS2uwsml2Aw7QVvGyWyYcXQXKTRqFU8JsRELgzjMxzt
        EEKrv3ug+fIVZ1mPK/MfvWMZHqHXazt0dNE0T07OI1Ltz9sNFrD03QlLBmPpMbFA
        C8ltFiXJ+ROfvY2smBVV9bD/Z3Bk5H+bXQ8do=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lBF4c9pZq2vA1eA7ACo/LVO4NfWvoDON
        umriqo3Kwj2RiBnpfdnfm0a0VyJrVHAb7N5sC/Crc8BZwNHVFdO1oWueWDP0Z3px
        TI5b5gr/BZpRIa6xSazAaFlsYhUT41lOw28JPAQQtj/bud/Taq69bS0zTCvo/MFx
        hkmNHg0ul38=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0C9D153676;
        Thu, 26 Mar 2020 15:31:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7E99653670;
        Thu, 26 Mar 2020 15:31:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 2/5] t/lib-gpg.sh: stop pretending to be a stand-alone script
References: <pull.728.git.git.1584968990.gitgitgadget@gmail.com>
        <pull.728.v2.git.git.1585114881.gitgitgadget@gmail.com>
        <c1811d54190a62e3d35505e2b806c89238b56de8.1585114881.git.gitgitgadget@gmail.com>
        <20200326082140.GC2200716@coredump.intra.peff.net>
Date:   Thu, 26 Mar 2020 12:31:38 -0700
In-Reply-To: <20200326082140.GC2200716@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 26 Mar 2020 04:21:40 -0400")
Message-ID: <xmqqzhc2j4kl.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6A2E9EC0-6F98-11EA-BF61-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I wondered if it might be useful to identify the file for editors, etc.
> But "*.sh" is quite sufficient, and we already stripped most of these
> out long ago in b54a31243b (t/lib-*.sh: drop executable bit,
> 2020-03-26).

That timestamp look too fresh to me ;-)

c74c7203 (test: replace shebangs with descriptions in shell
libraries, 2013-11-25) was described quite well.
