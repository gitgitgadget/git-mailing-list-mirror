Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E84B61F855
	for <e@80x24.org>; Fri, 29 Jul 2016 22:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752638AbcG2WDr (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 18:03:47 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60076 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751451AbcG2WDr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jul 2016 18:03:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DCEDD3259B;
	Fri, 29 Jul 2016 18:03:45 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=IZJq6/7w2KtJ
	jitJF4QdXzTWLHY=; b=kj/FW2vVDKFca4VZyHcg7UH1G9Hkh0+zb2wFkOIFVv1r
	SDQRW9ypMu0KzdxAk6fs7mO94kesRYSFTv968Z6PAphqhMAxsgKHi5KaOReeodmG
	JfVsFBpscI4FKm2sIBhJsUtpByv0+/i3aLaHkwWD18gaPuNLK8zPk5HP8Y/lgGU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=jabNJ5
	0SHI1g+7fHHwJ7nS8QX2GnbhEoESOfNVNbkhAsQk5jjmKfYjpqwlhodrDQAmMvsy
	+wpNsCY4Jr+86FKHb6cd6UnVov8ikeLo1AsWGPzXX5IY/ZbybeldjNBQPZgAyL5C
	85D66Z5aN0iiL9mrlC4krD+5gF4DqmsKl/VTg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D4A7B32599;
	Fri, 29 Jul 2016 18:03:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5450832598;
	Fri, 29 Jul 2016 18:03:45 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Ingo =?utf-8?Q?Br=C3=BCckl?= <ib@wupperonline.de>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH v2 2/3] Make test t3700-add.sh more robust
References: <579bc6ca.3f2601c7.bm001@wupperonline.de>
Date:	Fri, 29 Jul 2016 15:03:43 -0700
In-Reply-To: <579bc6ca.3f2601c7.bm001@wupperonline.de> ("Ingo =?utf-8?Q?Br?=
 =?utf-8?Q?=C3=BCckl=22's?=
	message of "Fri, 29 Jul 2016 23:11:36 +0200")
Message-ID: <xmqq1t2cm79c.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 51B6169E-55D8-11E6-B909-89D312518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Ingo Brückl <ib@wupperonline.de> writes:

> Subject: Re: [PATCH v2 2/3] Make test t3700-add.sh more robust

Please check output from "git shortlog --no-merges -100" to see how
your titles play well with others.  We typically prefix the title
with a specific area, a colon, and a sentence that does not begin in
a capital letter and does not end with a full-stop.

> Don't rely on chmod to work on the underlying platform (although it
> wouldn't harm the result of the '--chmod=-x' test). Directly check the
> result of the --chmod option.
>
> Add a test_mode_in_index helper function in order to check for success.

Hmph, I do not immediately see the point of having the helper in
test-lib-functions.sh, though.  This helper looks more or less
specific to this test script.

In any case, I think addition of the "test_mode_in_index" helper and
conversion from case/esac to the helper should be a separate patch
from what this patch wants to do, which is to merge two more-or-less
redundant tests into one.

Thanks.

