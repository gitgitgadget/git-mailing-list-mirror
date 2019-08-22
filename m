Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,URIBL_SBL,
	URIBL_SBL_A shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4CA51F461
	for <e@80x24.org>; Thu, 22 Aug 2019 21:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389696AbfHVVgH (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Aug 2019 17:36:07 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63566 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732656AbfHVVgH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Aug 2019 17:36:07 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 59FA21677A1;
        Thu, 22 Aug 2019 17:36:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6dgcOYi2NV/jOVHcZUlB+M5rgE4=; b=ciHAnU
        QUbMmwUaobFpfqNCw7MgJTkKhLRtNXrIjjEDzr8UJ6LGpAJjPVm07WmK9p8ONBDq
        G5c6nVXPNbqb1a6kGGLS73ajXmhNiH0ajYRc4eVA2K+fE0G0V2onSZQYwL2lmVdM
        gwpo+zVCIWXSeXfF/zyC2+IJ60xqJHN0vFtb4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WooFqIhrIq5tYHihQ7vAtrokrmbZiN+G
        DO2hneFEpa9T5K9ZqVEC/vIN6G0VdO5BMcGXUGE03jmaFGt2YjZaf6bVOShXhTqt
        iX6AXUP9jxnHXXEzbcO+177w+HU3fsj239Ne/5XFnhGvMBeNm3w4sX3OWA8Rcf1c
        G8FsjOtCgy8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 511321677A0;
        Thu, 22 Aug 2019 17:36:05 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B2E6816779F;
        Thu, 22 Aug 2019 17:36:04 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     "Saravanan Shanmugham \(sarvi\)" <sarvi@cisco.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: First Git status takes 40+ minutes, when mounting fileystem/diskimage with 50G GIT repo + 900G of builds articles
References: <2303C0BB-C532-4560-8BCA-A05DAD97EB72@cisco.com>
        <b409d16f-c392-7f1f-79a0-e14e70148cad@kdbg.org>
        <xmqq4l29ov2k.fsf@gitster-ct.c.googlers.com>
        <dde804a6-5169-be17-40c3-2a89f93ace0d@kdbg.org>
Date:   Thu, 22 Aug 2019 14:36:03 -0700
In-Reply-To: <dde804a6-5169-be17-40c3-2a89f93ace0d@kdbg.org> (Johannes Sixt's
        message of "Thu, 22 Aug 2019 23:29:11 +0200")
Message-ID: <xmqq8srkopbw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D8275DA0-C524-11E9-9BD0-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Inode number would be stable, but st_dev may not be. But it looks like a
> default build does not use it anyway (I see that we do not define
> USE_STDEV), so my guess was most likely wrong.

Ahh, thanks.  I overlooked the device number, but I think the
default settings excludes st_dev because it was unstable on nfs and
friends.
