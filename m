Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.0 required=5.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B48620179
	for <e@80x24.org>; Fri, 17 Jun 2016 17:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753570AbcFQRiG (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 13:38:06 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50209 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752316AbcFQRiF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 13:38:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 994BF2568D;
	Fri, 17 Jun 2016 13:38:03 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1iIp3tPTr3hOVtxijjzCX6qweRs=; b=w6qc6o
	nCHkjKckoxBVQMd4RQSrc5LWP9qXpXCrfsfsGiz0ePDhh1liO1Lfnkh/K9u/TRpX
	KMHx9LE3icj8AklvWEKj34mgLgDBVvldGNM0mkfByu6jpPc5Cmjy0+KMH4sW/06W
	UvA6BLfUAg9qASRCM3Q+YZpglaQkWf8AaAwiE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oZx72OVqGvW/rAAIP43xVUqF5KsxWq6e
	Oc3zV0fCVX2Y94lWfPh4AzjfGggg8ufFXSGAQDTFIEYTksY63iSQG1hDZzO0Rt7Y
	r5JWVebkZvf7LQ/PsEPT/0ckTjsXQ6lWO1rn1Y3NUJfTzrRHjuWqmvBQ9KWXXIC2
	+WzYax0kDzw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9216C2568C;
	Fri, 17 Jun 2016 13:38:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 19FC32568A;
	Fri, 17 Jun 2016 13:38:03 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Michael J Gruber <git@drmicha.warpmail.net>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH 0/5] Documentation/technical: describe signature formats
References: <cover.1466148698.git.git@drmicha.warpmail.net>
Date:	Fri, 17 Jun 2016 10:38:01 -0700
In-Reply-To: <cover.1466148698.git.git@drmicha.warpmail.net> (Michael
	J. Gruber's message of "Fri, 17 Jun 2016 09:46:07 +0200")
Message-ID: <xmqqeg7v1zt2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3E0BEFCA-34B2-11E6-8B30-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Michael J Gruber <git@drmicha.warpmail.net> writes:

> - We don't support verifying push certificates, although they fit in with
>   git verify-tag. Patch has been submitted, and this series documents the
>   result already (git verify-tag --blob).
>
> - We don' support verifying signed merge tags other than by using log/show,
>   which is not quite fit for scripting.

Both true and are good things to tackle, I would think.

It would be ideal if we can unify the latter with verification of
signed commits.

> - We have signature parsing code all over the place, including places that
>   should probably abstract more, such as tag.c and log-tree.c.

Looking forward to see the result of that new abstraction.

> - We may want to give more support for deciding about the trustworthiness
>   of signatures, the same way we export information to receive hooks
>   in the presence of push certificates. (Give information, don't decide.)

Again, true.

Thanks for starting this.

> Michael J Gruber (5):
>   Documentation/technical: describe signature formats
>   Documentation/technical: signed tag format
>   Documentation/technical: signed commit format
>   Documentation/technical: signed merge tag format
>   Documentation/technical: push certificate format
>
>  Documentation/Makefile                       |   1 +
>  Documentation/technical/signature-format.txt | 242 +++++++++++++++++++++++++++
>  2 files changed, 243 insertions(+)
>  create mode 100644 Documentation/technical/signature-format.txt
