Return-Path: <SRS0=m/64=4N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0FCEC4BA00
	for <git@archiver.kernel.org>; Tue, 25 Feb 2020 22:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 553F62176D
	for <git@archiver.kernel.org>; Tue, 25 Feb 2020 22:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LxMUADhN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgBYW0l (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Feb 2020 17:26:41 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59638 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgBYW0l (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Feb 2020 17:26:41 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 64C1AB1BE1;
        Tue, 25 Feb 2020 17:26:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ewicmpP/7/s3QdUsJJsKDFrCnhE=; b=LxMUAD
        hN16AqVzCL1mvDJjnGEDQbFGmuwqv3MONUjaBUS/k3VOGSPsnQQ43wqgu5PeQwXs
        5xioI0CnRjpaX5q6kb/nu+xKTujp8UQ9FKWslrVJv5mToBOXlc/Iw0O9UKt52ZKD
        HviWCHPWrfQehUBWjTZcPfE9fGS+KIsqElKyM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=H9XUW4VL1GKFXVj9HFgN+qFtq/P42l9y
        Jq0Iq2YzJ1VYjSSFvpSpK/F9ylYeIkp//Gy4Q5A/8nJPglYeTqLu9diWwqlbZrNW
        dionvVY4KNfTf1KSzZBDGNmhIjol7LJe4KoOuFcUcSckbpBT3iKnz4kCppTi8Whh
        Al7JlD7VVXI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5DF0FB1BE0;
        Tue, 25 Feb 2020 17:26:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 870FAB1BDF;
        Tue, 25 Feb 2020 17:26:36 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v8 07/15] bugreport: add git-remote-https version
References: <20200220015858.181086-1-emilyshaffer@google.com>
        <20200220015858.181086-8-emilyshaffer@google.com>
        <xmqqr1yp9eue.fsf@gitster-ct.c.googlers.com>
        <20200220232812.GH2447@google.com>
        <xmqqo8ts7gf5.fsf@gitster-ct.c.googlers.com>
        <20200225220838.GB212281@google.com>
Date:   Tue, 25 Feb 2020 14:26:34 -0800
In-Reply-To: <20200225220838.GB212281@google.com> (Emily Shaffer's message of
        "Tue, 25 Feb 2020 14:08:38 -0800")
Message-ID: <xmqqtv3el2w5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E281EE28-581D-11EA-8177-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> How about if I localize the bugreport template, headers, and formatted
> comments (e.g. "3745 local loose objects"), and include a tip in 'git
> help bugreport' suggesting that if it doesn't look right, maybe the user
> wants to run it with 'LANG= LANGUAGE= git bugreport' to ensure it
> actually gets generated?

I think that will be what is going to happen anyway in the real
world.  We'd spend a reasonable effort for localization (and I
personally am perfectly OK if the effort for the initial round is
"almost zero"), but make sure C-locale is left as an escape hatch.

> I had another thought, actually, that this is maybe semantically similar
> problem to the malformed config we discussed earlier in the review. Does
> it make sense to include some kind of --safemode flag to 'git' which
> asks it to not perform localization and not read configs?

I suspect that "git --safemode" would always end up being buggy than
running "git" under LANG=C LC_ALL=C GIT_CONFIG=/dev/null or something
like that ;-)

Wouldn't it defeat more than 30% of the value of the tool if we
do not read and report the contents of the configuration file(s)?
