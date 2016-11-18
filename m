Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7355B1FF40
	for <e@80x24.org>; Fri, 18 Nov 2016 04:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751520AbcKREr6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Nov 2016 23:47:58 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58778 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751021AbcKREr5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2016 23:47:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C2CC050F99;
        Thu, 17 Nov 2016 23:47:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=19A/WKAPjoDXfShX1esX49iHFYc=; b=kcx+VC
        WkJ5woclAACNDTRwrBGGOr3XOsqnml6AUYS/b3h2TYJnOrPnrdR9oEtrCeueT7FW
        oThIcuD2TKFODeqdDp32Z89zvI7c3P5PXW+OoxSGVxr0OCa3zQY7D/iTYHT4sufk
        SsLpGLX9hkDnJh3MIbHirAFSkSH2VMx664AhM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LdUFjsnGafihEXxPwSgBkBEc9XElkDZB
        BU9cfAQtn8Au+/+0VblaIpwE9xu3KXthbynIy7VnyqxcI2AXrm4JHhngv9xb1Vpl
        2EyKLK48KqnSoAFDAFIfUCRfHdrB41G0OPQZBbGKBqF69lEvaF+21jGA+oTFvLEO
        CDDVGB6Q0Us=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B9D2150F98;
        Thu, 17 Nov 2016 23:47:55 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 33C4F50F97;
        Thu, 17 Nov 2016 23:47:55 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Turner <dturner@twosigma.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH] submodules: allow empty working-tree dirs in merge/cherry-pick
References: <1478543491-6286-1-git-send-email-dturner@twosigma.com>
Date:   Thu, 17 Nov 2016 20:47:54 -0800
In-Reply-To: <1478543491-6286-1-git-send-email-dturner@twosigma.com> (David
        Turner's message of "Mon, 7 Nov 2016 13:31:31 -0500")
Message-ID: <xmqqwpg1mm11.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2B9CEF5E-AD4A-11E6-94B5-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Turner <dturner@twosigma.com> writes:

> diff --git a/t/t3030-merge-recursive.sh b/t/t3030-merge-recursive.sh
> index 470f334..be074a1 100755
> --- a/t/t3030-merge-recursive.sh
> +++ b/t/t3030-merge-recursive.sh
> @@ -575,13 +575,13 @@ test_expect_success 'merge removes empty directories' '
>  	test_must_fail test -d d
>  '
>  
> -test_expect_failure 'merge-recursive simple w/submodule' '
> +test_expect_success 'merge-recursive simple w/submodule' '
>  
>  	git checkout submod &&
>  	git merge remove
>  '
>  
> -test_expect_failure 'merge-recursive simple w/submodule result' '
> +test_expect_sucess 'merge-recursive simple w/submodule result' '

Here is a typo.  I wonder if we want to do "set -e" at the end of
test-lib.sh to catch a breakage like this.  I only caught it by
being lucky (I was staring "make test" output as it flew by).

I've already amended the copy I have, but in case you are going to
reroll in the future, please do not forget to update your copy.
