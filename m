Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA6FB1F428
	for <e@80x24.org>; Mon, 30 Apr 2018 00:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754563AbeD3Aiv (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Apr 2018 20:38:51 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55026 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754385AbeD3Aiu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Apr 2018 20:38:50 -0400
Received: by mail-wm0-f68.google.com with SMTP id f6so10515694wmc.4
        for <git@vger.kernel.org>; Sun, 29 Apr 2018 17:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ZHEmNT5xHe9qpiZxBVcqmIQxctnVRa8CGw/7g9Ni4EI=;
        b=F/KqPetsbihxUtNBLRnQ8+MEjGAHC+hMZOorPjOOB8QBpMugvJb9Jeli85oQP5PsS3
         A9p02afPI/fGy2Rr9axgehfYKeCuav+S+tBQNyZjPxWtBroHTF3FNhT83oB4Qrg2AWUZ
         kH6cyL9Qetn5KNeEYKKq398lEMMK93vAevpklupBb9e2Cyrr1UII4GVkKSA1q7GYHdxD
         UVaITCL3rsn84aHKQVb3SQK+jxLSn1/9ghfw3Bpprr8D5vYiKrOt+/PLRcY2MfA9GN5z
         ATovoRyLFPUH3Fw1N5CZf0csbZT71Oq3s7Jaua7804OMc67boZGBftgLm4g60UQe4RdP
         0d0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ZHEmNT5xHe9qpiZxBVcqmIQxctnVRa8CGw/7g9Ni4EI=;
        b=pQ9VmYCmmcqrcWLhvh1ASY6psmR+OIBnfbzy6vkt0DbD6wvJFQfyACwuNgkIf5k6JY
         /co+HarCjqEWt7NeDnZQz5AKuK49gZiQCHmZCfXmoLsRLcAPA22Z2WtpSV/MXJttz74X
         woV++MkqOnaZ2+Ij+0RGs70KHDFlX/h0a2LDopmhuV9K3DsfPw9AKpPNFCkfDbgYJn8d
         Wgc/EJZpbKm6cVwKikVxxUMttz+JYiUVab5FLV4zy2XK5z6QLdiNfYOuOSk2XPN2NeqE
         FXvan4QKiDTIGRJmTAASsGsksF3OIY2cp/KcWJ5JEhDtqAa7V/ZvU9SnyGbS9s5+jM7q
         nEXg==
X-Gm-Message-State: ALQs6tCyyI+9JVuRp+F+LG88XQzEbOkGwi077fSekNGB2+Mh0iwMBD0c
        epiE6KOs5GDcIHNv3rc6Dug=
X-Google-Smtp-Source: AB8JxZpWS5cZNCLmDoSFBj3wsacrs2RzapCGlnkDI+G564FYzF4wKQcEpzkq0PD5v/1f2RPKd3lt1g==
X-Received: by 10.28.131.80 with SMTP id f77mr1615148wmd.1.1525048729475;
        Sun, 29 Apr 2018 17:38:49 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id m134sm7815588wmg.4.2018.04.29.17.38.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Apr 2018 17:38:48 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] tests: introduce test_unset_prereq, for debugging
References: <b94af009c1bc9c9b96d977b1c5775ff73669138f.1524954814.git.johannes.schindelin@gmx.de>
Date:   Mon, 30 Apr 2018 09:38:47 +0900
In-Reply-To: <b94af009c1bc9c9b96d977b1c5775ff73669138f.1524954814.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Sun, 29 Apr 2018 00:33:36 +0200")
Message-ID: <xmqqd0yhzfxk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> While working on the --convert-graft-file test, I missed that I was
> relying on the GPG prereq, by using output of test cases that were only
> run under that prereq.
>
> For debugging, it was really convenient to force that prereq to be
> unmet, but there was no easy way to do that. So I came up with a way,
> and this patch reflects the cleaned-up version of that way.
>
> For convenience, the following two methods are now supported ways to
> pretend that a prereq is not met:
>
> 	test_set_prereq !GPG
>
> and
>
> 	test_unset_prereq GPG

Very nice new feature, and a great description ;-)

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> Published-As: https://github.com/dscho/git/releases/tag/test-unset-prereq-v1
> Fetch-It-Via: git fetch https://github.com/dscho/git test-unset-prereq-v1
>  t/test-lib-functions.sh | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 7d620bf2a9a..76cd6630f29 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -278,8 +278,20 @@ write_script () {
>  # The single parameter is the prerequisite tag (a simple word, in all
>  # capital letters by convention).
>  
> +test_unset_prereq () {
> +	! test_have_prereq "$1" ||
> +	satisfied_prereq="${satisfied_prereq% $1 *} ${satisfied_prereq#* $1 }"
> +}
> +
>  test_set_prereq () {
> -	satisfied_prereq="$satisfied_prereq$1 "
> +	case "$1" in
> +	!*)
> +		test_unset_prereq "${1#!}"
> +		;;
> +	*)
> +		satisfied_prereq="$satisfied_prereq$1 "
> +		;;
> +	esac
>  }
>  satisfied_prereq=" "
>  lazily_testable_prereq= lazily_tested_prereq=
>
> base-commit: 1f1cddd558b54bb0ce19c8ace353fd07b758510d
