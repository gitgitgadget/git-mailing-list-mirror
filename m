Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 641C4C433B4
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 20:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A8F761205
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 20:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbhDGUrr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 16:47:47 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55906 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhDGUro (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 16:47:44 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5162B1351AE;
        Wed,  7 Apr 2021 16:47:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZlNoIC8VPbHnrJNXxLE/W5aRKtc=; b=QBDDAn
        AMC21W4PJqiNihYilYSUok+YrE48ov5ZR5r898lS8MdQRZM6QZ8kO6e9YJ3U8MTt
        7+BF7Ygi8ZW2UOeyPndhvtayzkcvZ4wp3a8IpzDT37MAihn6n3etnMY+hfWna6DX
        +TGEw3hl23y92NYH/RpKPnQJwKbzHgWa0dXzw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sgEIwOs1CTjzYHHTggQSvPF4ZlxZQqlc
        j6+jGrWOV+SZOEo/+LzNm6c1fVkcZ2Te3wRNvZ5dlzC9bg85G4CsmfwuVzgCJqCz
        C+PXW6G5OXzocv3P/v5Fcnkl5XqHwGdpiGLuATCwx8sHUCYkAwZhW0e65HUulqbR
        WGi4lA9YoBg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 49E631351AD;
        Wed,  7 Apr 2021 16:47:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5ADFA1351A9;
        Wed,  7 Apr 2021 16:47:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Horst von Brand <vonbrand@inf.utfsm.cl>
Cc:     git@vger.kernel.org
Subject: Re: No error when overwriting ignored files
References: <2056254759.360640.1617825398727.JavaMail.zimbra@inf.utfsm.cl>
Date:   Wed, 07 Apr 2021 13:47:27 -0700
In-Reply-To: <2056254759.360640.1617825398727.JavaMail.zimbra@inf.utfsm.cl>
        (Horst von Brand's message of "Wed, 7 Apr 2021 15:56:38 -0400 (CLT)")
Message-ID: <xmqqzgy9yg80.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 77D6488E-97E2-11EB-89D6-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Horst von Brand <vonbrand@inf.utfsm.cl> writes:

> When pulling from a repository that tracks a file listed in
> `.gitignore` that would overwrite a local file, this is not
> reported.

Git has the notion of "not to be tracked (i.e. added to the index or
committed) and expendable files", and they are called "ignored"
files.  And ".gitignore" and .git/info/exclude mechanism is used to
mark these paths.

There is no notion of "not to be tracked but precious files" or
mechanism to mark paths as such.  So the behaviour you observed is
fully expected and working as designed.

Thanks.
