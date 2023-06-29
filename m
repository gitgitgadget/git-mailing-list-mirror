Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7502FEB64D9
	for <git@archiver.kernel.org>; Thu, 29 Jun 2023 22:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjF2WW7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jun 2023 18:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjF2WW6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2023 18:22:58 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D722D62
        for <git@vger.kernel.org>; Thu, 29 Jun 2023 15:22:57 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 764EE21B1D;
        Thu, 29 Jun 2023 18:22:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fGnFlY3fzg27OWVqofWilNs62Q+QyP1mm1lH2q
        auUoU=; b=jElNbxsizp/uZZHLisZwfVBr/alX8q9ga6t0j+J8uvL5rkgBolpg4l
        nF6Qfh3sFjm+wp+kvBMZln5wTtvT1mQJXJBVgDtwKkiBgWaOdf/eDSIdV/IbXrP7
        spQIsyzVcd8tZEJ2H05UPrmSH4gyoH+tOmjZQ5v/T/m3PFk4e5H9Q=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6E01921B1C;
        Thu, 29 Jun 2023 18:22:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.233.135.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7C10721B1B;
        Thu, 29 Jun 2023 18:22:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Adam Majer <adamm@zombino.com>, git@vger.kernel.org
Subject: Re: SHA256 support not experimental, or?
References: <2f5de416-04ba-c23d-1e0b-83bb655829a7@zombino.com>
        <xmqqmt0iajww.fsf@gitster.g>
        <ZJ303bm+VAvp5nyV@tapette.crustytoothpaste.net>
Date:   Thu, 29 Jun 2023 15:22:51 -0700
In-Reply-To: <ZJ303bm+VAvp5nyV@tapette.crustytoothpaste.net> (brian
        m. carlson's message of "Thu, 29 Jun 2023 21:17:17 +0000")
Message-ID: <xmqqa5wh9adg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7D86E238-16CB-11EE-AB2A-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2023-06-29 at 05:59:11, Junio C Hamano wrote:
>> Adam Majer <adamm@zombino.com> writes:
>> 
>> > Is sha256 still considered experimental or can it be assumed to be stable?
>> 
>> I do not think we would officially label SHA-256 support as "stable"
>> until we have good interoperability with SHA-1 repositories, but the
>> expectation is that we will make reasonable effort to keep migration
>> path for the current SHA-256 repositories, even if it turns out that
>> its on-disk format need to be updated, to keep the end-user data safe.
>
> I don't think that's a good position to have.
> We desperately do want people to move away from SHA-1 to SHA-256, and as
> soon as there's tooling and forges to do so, we should encourage them to
> do so.

I agree that it is good to ensure that SHA-256 support is good
enough to start new projects with.

> Just because people can't interop existing SHA-1 repositories
> doesn't mean people can't or shouldn't build new SHA-256 repositories.

True, and our messaging should avoid scaring them away from doing
so.  But isn't the lack of interoperability one of the reasons why
GitHub and Gitlab do not yet offer choice of the hash?  There
certainly is a chicken-and-egg problem here.

