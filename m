Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB203C0015E
	for <git@archiver.kernel.org>; Wed,  9 Aug 2023 19:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbjHITn1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Aug 2023 15:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbjHITnZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2023 15:43:25 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BDE10DA
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 12:43:23 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5665F22B6C;
        Wed,  9 Aug 2023 15:43:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fy/ZmygHeKzjTQn7I91/k6ol9tmRnNddQW7GtZ
        Jsqo8=; b=E2pzp85gVCO8Dl+R/2fTKnwLM8Nyj07KMnErMklNodhBTpjI0U2MXh
        KE/PNsWf9Iyw+mdobPvqRj7/upaot+kswO1bOUmspFUWSR1hUIrASR28EguEkXQB
        hlbFcG9ED5HdJ02H6nTNp7kdd3pSz/yX51aN8MFNz/kPpwqiZQpHA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4F91622B6B;
        Wed,  9 Aug 2023 15:43:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D4DFC22B6A;
        Wed,  9 Aug 2023 15:43:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t9001: remove excessive GIT_SEND_EMAIL_NOTTY=1
References: <20230809171531.2564754-1-oswald.buddenhagen@gmx.de>
Date:   Wed, 09 Aug 2023 12:43:18 -0700
In-Reply-To: <20230809171531.2564754-1-oswald.buddenhagen@gmx.de> (Oswald
        Buddenhagen's message of "Wed, 9 Aug 2023 19:15:31 +0200")
Message-ID: <xmqq7cq4m27d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FE21DFCE-36EC-11EE-9B0D-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> This was added by 3ece9bf0f9 (send-email: clear the $message_id after
> validation, 2023-05-17) for no apparent reason, as this is required only
> in cases when git's stdin is (must be) redirected, which isn't the case
> here.
>
> Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>

Good eyes.  Thanks, will apply.


>
> ---
> Cc: Junio C Hamano <gitster@pobox.com>
> ---
>  t/t9001-send-email.sh | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> index 48bf0af2ee..c445859f73 100755
> --- a/t/t9001-send-email.sh
> +++ b/t/t9001-send-email.sh
> @@ -659,7 +659,6 @@ test_expect_success $PREREQ 'clear message-id before parsing a new message' '
>  	clean_fake_sendmail &&
>  	echo true | write_script my-hooks/sendemail-validate &&
>  	test_config core.hooksPath my-hooks &&
> -	GIT_SEND_EMAIL_NOTTY=1 \
>  	git send-email --validate --to=recipient@example.com \
>  		--smtp-server="$(pwd)/fake.sendmail" \
>  		$patches $threaded_patches &&
