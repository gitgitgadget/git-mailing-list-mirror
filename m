Return-Path: <SRS0=cPh9=BE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF56C433E0
	for <git@archiver.kernel.org>; Sat, 25 Jul 2020 23:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2712520663
	for <git@archiver.kernel.org>; Sat, 25 Jul 2020 23:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dEroisiX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgGYXDp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Jul 2020 19:03:45 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62490 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbgGYXDp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Jul 2020 19:03:45 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 30FE4ED920;
        Sat, 25 Jul 2020 19:03:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UV8S5PHRe2OaSP0XfLRJs/RbP7A=; b=dErois
        iXVE+ykEEHAdO9RlFc/nyHk6zSsMZoob1xFpt56MdGjJcJax13CajEqgwt7wCt2a
        /THrrq/zmb6IVe2NBX0DSRV32v4HC+NmSmi3gQ+K8iN7Mz03RTrFgfyBELNQn4g9
        i4X1bgAQhJtdyu0g5v0RI1dKd/E+FnDFzExHU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iJvJPeU6RC9CfRzAOJmjTk6cxW+J4VxC
        qjSBZ5/WvkyK8pojlHcVm+IeWvUQEm+Jj+3hHvTVoPo6x23ZePMEab/9oUPSXsxc
        4bUSyLNyXLjpI4fRENmGwPs2b7G7j5Y25SfFtep8ERbPdLiCG8isc6ybU+P2SmI4
        xUBSWpk1yyU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 29292ED91F;
        Sat, 25 Jul 2020 19:03:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 700E6ED91E;
        Sat, 25 Jul 2020 19:03:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     mirucam@gmail.com, chriscool@tuxfamily.org, git@vger.kernel.org
Subject: Re: [PATCH v5 02/13] bisect--helper: use '-res' in 'cmd_bisect__helper' return
References: <20200725173118.GA614724@konoha>
Date:   Sat, 25 Jul 2020 16:03:38 -0700
In-Reply-To: <20200725173118.GA614724@konoha> (Shourya Shukla's message of
        "Sat, 25 Jul 2020 23:01:18 +0530")
Message-ID: <xmqqblk3i4dx.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 146F66C6-CECB-11EA-83B4-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shourya Shukla <shouryashukla.oo@gmail.com> writes:

>> Following 'enum bisect_error' vocabulary, return variable 'res' is
>> always non-positive.
>> Let's use '-res' instead of 'abs(res)' to make the code clearer.
>
>> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
>> Signed-off-by: Miriam Rubio <mirucam@gmail.com>
>> Helped-by: Junio C Hamano <gitster@pobox.com>
>
> Although there is no set rule for this, but I think that your sign-off
> goes at the last generally. This is what I have seen on various patches.

It is most natural to list these entries in chronological order.

Code was written while others helped, and the final seal on what
gets sent out is stamped by appending the author's sign-off at the
end.

Thanks.
