Return-Path: <SRS0=E3tc=7P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 711F8C433E0
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 21:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 226F6206C3
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 21:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RJe+S+sB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbgFBVMo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Jun 2020 17:12:44 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63956 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgFBVMn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jun 2020 17:12:43 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CEA88CEA6C;
        Tue,  2 Jun 2020 17:12:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+jcai/qDC5YgL2cTv2fQqEdOwf4=; b=RJe+S+
        sB16S9afK1PiqMzYe0asOpk0oU0JeBu2AcZdhqxHgBeE9pS1I2zNm0VBe5PMme84
        /hU0QOQcwOk6B7VgL5MF6jBtHouci/oWUXpPF5a8MSsZHfFgjVYGiCYeck2+Wqvd
        lkJIeAz9qRUftiJJGpExTaqOltT7+v9ns/Ogg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HRPauSOKFsZg0RxKW3G2cSGyiYSwNPO9
        Zapfj8rdml4UfDnhA6zdia8e3gg67TpDPiMenQgwsMpccZC2YUw2GJtNOdJmSjs3
        F0noBLItQZRcfwSnX+QiX4eHhdlY5ILEPScTPEyY9eVP6ru4nReZNBGok78DswSp
        ExbcLinOL74=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C6F7ECEA6B;
        Tue,  2 Jun 2020 17:12:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 16219CEA6A;
        Tue,  2 Jun 2020 17:12:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Laurent Arnoud <laurent@spkdev.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] format-patch: generate valid patch with diff.noprefix config
References: <20200602204924.GA1853335@spk-laptop>
Date:   Tue, 02 Jun 2020 14:12:37 -0700
In-Reply-To: <20200602204924.GA1853335@spk-laptop> (Laurent Arnoud's message
        of "Tue, 2 Jun 2020 22:49:24 +0200")
Message-ID: <xmqqpnahrx2y.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CA0E9018-A515-11EA-86E4-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Laurent Arnoud <laurent@spkdev.net> writes:

> With diff.noprefix enabled the patch generated with format-patch does not
> include prefix a/ and b/ so not applicable with `git am`.

Some projects (not this one) do not want to see a/ and b/ prefix in
their patches, and noprefix is an option for those who needs to give
patches to such projects.  As "am" can be told with -p<num> to accept
such a patch just fine, I do not think this change is appropriate.

> Solution is to force a_prefix and b_prefix on diffopt.

Sorry, I do not think there is any problem to be solved here ;-)


