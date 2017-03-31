Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 117111FAFB
	for <e@80x24.org>; Fri, 31 Mar 2017 19:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932666AbdCaTiV (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 15:38:21 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54396 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932356AbdCaTiU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 15:38:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8DCB07D5ED;
        Fri, 31 Mar 2017 15:38:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tuxksUnqRR2OQaqYQMCLaffU790=; b=UwGiGS
        SuVZn31QomPc21hvWeWSg3bI7E0rAwQBnAczBc7YVHZhZlKFNlySG9bLn22J39ze
        mCwaOT1ZaPOo3VHACMBbZZAb3rat3Jcpi1aV5HAd/WkQakNgSVxF6qGzbOP8Y2Bd
        svtrWyWcrMTSpOsMJVEiViPd6LyQoB1bCQr/U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=O5/uMxladBIOtzX2XO0GicToMZgbLEnt
        /n/GiGL+F9mnMj9YMITJJbGGa9dSE4oVb3tD1aJNemLsy5DwJh+koJsLxKC14ouv
        1jYh10Lflhgz+OfTlu0HcS5SLvVQgSywLTjKx7kkvaX6bIlcnSIBwhcZChz6DjUX
        9Wd7UoctjTo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 846717D5EC;
        Fri, 31 Mar 2017 15:38:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E6A737D5EB;
        Fri, 31 Mar 2017 15:38:18 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     jacob.keller@gmail.com, daveparrish@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH] failure with diff --submodule=diff with moved nested submodule HEAD
References: <CA+P7+xoqWCpySc17104zggLgwx1mc0T+JXybrgd8sQxoQFP-PQ@mail.gmail.com>
        <20170331175907.17400-1-sbeller@google.com>
Date:   Fri, 31 Mar 2017 12:38:17 -0700
In-Reply-To: <20170331175907.17400-1-sbeller@google.com> (Stefan Beller's
        message of "Fri, 31 Mar 2017 10:59:07 -0700")
Message-ID: <xmqqk275xmmu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 979448CA-1649-11E7-B057-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> This fails reliable for me.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---

I take it that this is a WIP for the testing half of the patch you
are working on (i.e. you are not just throwing a patch to document
known breakage to be fixed later, in which case these would have
been _expect_failure).

Thanks.

>  t/t4060-diff-submodule-option-diff-format.sh | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/t/t4060-diff-submodule-option-diff-format.sh b/t/t4060-diff-submodule-option-diff-format.sh
> index 7e23b55ea4..89bced3484 100755
> --- a/t/t4060-diff-submodule-option-diff-format.sh
> +++ b/t/t4060-diff-submodule-option-diff-format.sh
> @@ -746,4 +746,20 @@ test_expect_success 'diff --submodule=diff with .git file' '
>  	test_cmp expected actual
>  '
>  
> +test_expect_success 'setup nested submodule' '
> +	git submodule add -f ./sm2 &&
> +	git commit -a -m "add sm2" &&
> +	git -C sm2 submodule add ../sm2 &&
> +	git -C sm2 commit -a -m "nested sub"
> +'
> +
> +test_expect_success 'move nested submodule HEAD' '
> +	git -C sm2/sm2 commit --allow-empty -m "new HEAD"
> +'
> +
> +test_expect_success 'diff --submodule=diff with moved nested submodule HEAD' '
> +	git -C sm2 diff --submodule=diff >actual 2>err &&
> +	test_must_be_empty err
> +'
> +
>  test_done
