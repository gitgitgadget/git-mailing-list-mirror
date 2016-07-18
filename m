Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D01E72018B
	for <e@80x24.org>; Mon, 18 Jul 2016 18:52:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752079AbcGRSwR (ORCPT <rfc822;e@80x24.org>);
	Mon, 18 Jul 2016 14:52:17 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57826 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751957AbcGRSwQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2016 14:52:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D60C32C82B;
	Mon, 18 Jul 2016 14:52:14 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=E4fJ+0DXjo3QAHiFXjT06Wqsp7s=; b=DkVCFr
	m7TWWKeN/XsMMqZ12T89mco2A7+mTUck12VBDug4UBSWE4dMl/cdBaFDnF/qJrZE
	AZq7pPaf0Y0pVaH5067FFtjCw08kHKWgpqJLK54yE9m1wIG9r1wn8ahJKHUIXI6J
	+VmfGt0IYA+m+b71Mtu9jVq4XkQnpiBY83qN4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rKflUEGTJ8Vop502RoVWEGHZAW+HeB/W
	12wAS39Ll7pGJEFBm4/9RShfuMSbd5EgzpjzW+yMtqlQMCV+9N8gZAdz6gZncQQw
	pX9PQXvXNiIycjW1Srtuk40rjIU4i/S0GjoavroN8nQtZVUaGm/EGD3GDsZoxLNa
	OnvQ7E7slQU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CCE862C82A;
	Mon, 18 Jul 2016 14:52:14 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5100B2C826;
	Mon, 18 Jul 2016 14:52:14 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Mike Hommey <mh@glandium.org>
Cc:	git@vger.kernel.org, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v3 2/2] t/t8003-blame-corner-cases.sh: Use here documents
References: <xmqqr3auli2x.fsf@gitster.mtv.corp.google.com>
	<20160715232346.12176-1-mh@glandium.org>
	<20160715232346.12176-2-mh@glandium.org>
Date:	Mon, 18 Jul 2016 11:52:12 -0700
In-Reply-To: <20160715232346.12176-2-mh@glandium.org> (Mike Hommey's message
	of "Sat, 16 Jul 2016 08:23:46 +0900")
Message-ID: <xmqq7fcikcdf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BDFD801C-4D18-11E6-8916-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Mike Hommey <mh@glandium.org> writes:

> Somehow, this test was using:
>
> {
> 	echo A
> 	echo B
> } > file
>
> block to feed file contents. This changes those to the form most common
> in git test scripts:
>
> cat >file <<-\EOF
> A
> B
> EOF
>
> Signed-off-by: Mike Hommey <mh@glandium.org>
> ---

It is not so strong a preference to ask you to re-roll, but for
future reference, I'd prefer to see this preparatory clean-up early
in the series, followed by the primary thing, IOW, I would have
liked more if the two patches were swapped.

Thanks.  Will queue.

>  t/t8003-blame-corner-cases.sh | 34 +++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)
>
> diff --git a/t/t8003-blame-corner-cases.sh b/t/t8003-blame-corner-cases.sh
> index eab2e28..e48370d 100755
> --- a/t/t8003-blame-corner-cases.sh
> +++ b/t/t8003-blame-corner-cases.sh
> @@ -41,12 +41,12 @@ test_expect_success setup '
>  	test_tick &&
>  	GIT_AUTHOR_NAME=Fourth git commit -m Fourth &&
>  
> -	{
> -		echo ABC
> -		echo DEF
> -		echo XXXX
> -		echo GHIJK
> -	} >cow &&
> +	cat >cow <<-\EOF &&
> +	ABC
> +	DEF
> +	XXXX
> +	GHIJK
> +	EOF
>  	git add cow &&
>  	test_tick &&
>  	GIT_AUTHOR_NAME=Fifth git commit -m Fifth
> @@ -115,11 +115,11 @@ test_expect_success 'append with -C -C -C' '
>  test_expect_success 'blame wholesale copy' '
>  
>  	git blame -f -C -C1 HEAD^ -- cow | sed -e "$pick_fc" >current &&
> -	{
> -		echo mouse-Initial
> -		echo mouse-Second
> -		echo mouse-Third
> -	} >expected &&
> +	cat >expected <<-\EOF &&
> +	mouse-Initial
> +	mouse-Second
> +	mouse-Third
> +	EOF
>  	test_cmp expected current
>  
>  '
> @@ -127,12 +127,12 @@ test_expect_success 'blame wholesale copy' '
>  test_expect_success 'blame wholesale copy and more' '
>  
>  	git blame -f -C -C1 HEAD -- cow | sed -e "$pick_fc" >current &&
> -	{
> -		echo mouse-Initial
> -		echo mouse-Second
> -		echo cow-Fifth
> -		echo mouse-Third
> -	} >expected &&
> +	cat >expected <<-\EOF &&
> +	mouse-Initial
> +	mouse-Second
> +	cow-Fifth
> +	mouse-Third
> +	EOF
>  	test_cmp expected current
>  
>  '
