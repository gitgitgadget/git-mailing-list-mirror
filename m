Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 215F0C433EF
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 16:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353583AbiFUQCL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 12:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353586AbiFUQBs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 12:01:48 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5442E688
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 09:00:55 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 34EB61983F0;
        Tue, 21 Jun 2022 12:00:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=VKhNBOCKffSs
        RjHZpdz/215BhCWNX9kDegYmaFV9P9w=; b=mevz148gnjOAZwFBKUdajUloJYI+
        XJg8LU700S/GK8fh4cYPxKqW4JMtFDIzIjCB61NvbrTGKASWZrzmgTGTUvNijs9M
        6Ant5OEBYHZD4F5WTX/m+MrsfnO/yM2ZGcYm8ynixKo1cVdPNDCayupn/NUhgRuB
        Y1bGLb9Z+u6NBjg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2D6161983EF;
        Tue, 21 Jun 2022 12:00:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BFE021983ED;
        Tue, 21 Jun 2022 12:00:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Stewart Smith <trawets@amazon.com>, git@vger.kernel.org,
        Todd Zullinger <tmz@pobox.com>
Subject: Re: [PATCH] git-send-email: Add --no-validate-email option
References: <20220620004427.3586240-1-trawets@amazon.com>
        <YrEMq+slLOHqw/hz@camp.crustytoothpaste.net>
Date:   Tue, 21 Jun 2022 09:00:49 -0700
In-Reply-To: <YrEMq+slLOHqw/hz@camp.crustytoothpaste.net> (brian m. carlson's
        message of "Tue, 21 Jun 2022 00:11:23 +0000")
Message-ID: <xmqqr13ihuq6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 52706586-F17B-11EC-AAB1-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2022-06-20 at 00:44:27, Stewart Smith wrote:
>> The perl Email::Valid module gets things right, but this may not alway=
s
>> be what you want, as can be seen in
>> https://bugzilla.redhat.com/show_bug.cgi?id=3D2046203
>
> You should explain this in the body of the message, since we generally
> want to know the rationale behind the change even if RedHat moves away
> from Bugzilla in the future.
>
> You could say something like this:
>
>   The Perl Email::Valid module correctly checks whether an email addres=
s
>   is syntactically valid.  However, in some cases, people have email
>   addresses which are not syntactically valid, such as those where the
>   local-part is more than 64 octets, and would like to use those
>   addresses despite that fact.
>
>> So, add a --validate-email (default, current behavior) and
>> the inverse --no-validate-email option to be able to skip the check
>> while still having the Email::Valid perl module installed.
>>=20
>> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D2046203
>
> I don't believe we generally include Fixes headers for external bugs.

All good comments; I have nothing to add here.

>> +	# Email::Valid isn't always correct, so support a way to bypass
>> +	# See https://bugzilla.redhat.com/show_bug.cgi?id=3D2046203
>
> Email::Valid is in fact correct.  However, the email which you want to
> use doesn't conform to the RFC and isn't valid.  So this should probabl=
y
> say something like, "Allow people to use an email address which is not
> valid according to the RFCs if the server accepts it."

I had exactly the same reaction.  Again, I have nothing to add here.

Thanks.

>
> I think this patch would be fine as it stands with those changes. Unlik=
e
> =C3=86var, I don't think we should get rid of Email::Valid, just like I=
 don't
> think we should get rid of the transfer encoding checks.  I support
> warning people before sending invalid emails, especially since I believ=
e
> the address in question would not be deliverable through some mail
> servers (such as mine).
