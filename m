Return-Path: <SRS0=H/u6=4H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E52C34047
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 17:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BA6B20801
	for <git@archiver.kernel.org>; Wed, 19 Feb 2020 17:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MRRJRNg9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgBSRbL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Feb 2020 12:31:11 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60089 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbgBSRbL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Feb 2020 12:31:11 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 658063C888;
        Wed, 19 Feb 2020 12:31:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0zlM78DmIjZ1p3azrLdKbN+nzTg=; b=MRRJRN
        g9248iNJt0l7tXDmtUp9WJcTyh6srSPyXs7/ZQJROplhvH1DF8u/UpAuZD+K7toV
        hZqrtgVbsjottBZYSSpUf8kTMnPXC+fucHDYyIhPP1lQtQNHlW4LQIDqZqncTmEJ
        MY5PRHixwcvhS6lHEEwjPXQOxNJsD3U/WAwVY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LBVpFWrOhnmS9ChePGIy+dk1Ld/0qIj5
        2xvWhG5H2kVUVMxWSZxycyL3NNTTXyKNADJPzigPQQnO9j8cZXwoe/WkzCp1ua99
        rNTNLc+ajionoSsDsZ79a+s5lAYiHCwmCP42rLACM/RCbIGoceEQSf8Kq7RR4/p1
        K5ligM4bCfk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3C4563C887;
        Wed, 19 Feb 2020 12:31:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 495B63C883;
        Wed, 19 Feb 2020 12:31:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Abhishek Kumar <abhishekkumar8222@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [GSoC Patch 5/5] t4202: use lib-log-graph functions
References: <20200216134750.18947-1-abhishekkumar8222@gmail.com>
        <20200216134750.18947-5-abhishekkumar8222@gmail.com>
Date:   Wed, 19 Feb 2020 09:31:06 -0800
In-Reply-To: <20200216134750.18947-5-abhishekkumar8222@gmail.com> (Abhishek
        Kumar's message of "Sun, 16 Feb 2020 19:17:50 +0530")
Message-ID: <xmqqlfoyfpr9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9D33ADA0-533D-11EA-A6C7-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Abhishek Kumar <abhishekkumar8222@gmail.com> writes:

> Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Abhishek Kumar <abhishekkumar8222@gmail.com>
> ---
>  t/t4202-log.sh | 49 ++++++++++---------------------------------------
>  1 file changed, 10 insertions(+), 39 deletions(-)
>
> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
> index 192347a3e1..403d88bb33 100755
> --- a/t/t4202-log.sh
> +++ b/t/t4202-log.sh
> @@ -5,6 +5,7 @@ test_description='git log'
>  . ./test-lib.sh
>  . "$TEST_DIRECTORY/lib-gpg.sh"
>  . "$TEST_DIRECTORY/lib-terminal.sh"
> +. "$TEST_DIRECTORY/lib-log-graph.sh"
>  
>  test_expect_success setup '
>  
> @@ -452,8 +453,7 @@ cat > expect <<EOF
>  EOF
>  
>  test_expect_success 'simple log --graph' '
> -	git log --graph --pretty=tformat:%s >actual &&
> -	test_cmp expect actual
> +	test_cmp_graph_file --pretty=tformat:%s
>  '
>  
>  cat > expect <<EOF
> @@ -467,8 +467,7 @@ cat > expect <<EOF
>  EOF
>  
>  test_expect_success 'simple log --graph --line-prefix="123 "' '
> -	git log --graph --line-prefix="123 " --pretty=tformat:%s >actual &&
> -	test_cmp expect actual
> +	test_cmp_graph_file --line-prefix="123 " --pretty=tformat:%s
>  '

Like [4/5], and unlike [2/5] and [3/5], this step also does seem
like an improvement.
