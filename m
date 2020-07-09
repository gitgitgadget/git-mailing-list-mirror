Return-Path: <SRS0=1oE7=AU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BEC4C433E0
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 18:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 655AF20775
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 18:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PbFN0c9/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbgGISgT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 14:36:19 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62046 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbgGISgT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jul 2020 14:36:19 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 82CEFE6AB5;
        Thu,  9 Jul 2020 14:36:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=bXfL1ir3HmqZ
        mLrCdYq8IaF77S0=; b=PbFN0c9/sDfLx5Lka9lz9mZV+fg5ZFIiR8py/n4NpH7J
        7RhePA3fZPxFI2IkX5g6Xkk3cgBzRoV2gMlrhCZlKbonhCZIn0UTZcmWz6fnPG6x
        KmzdPM+gOtP2ZAMoqR8P/e8cu4L+r7/vdVAvyLd49rlT1CzSx0I5RVyO2Ookf8o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=U5Qmd2
        hsq+lExYzdINMbAI8NTDR3YfB6QEIHFZPjwXpJTNw8NuMIKpVMIRBmlqwU3MOIYj
        MzyJMxTiPZ+VMyjoZf+qiVlkwb0bzD9T8toJs/zuVA9983k14aodHN1HoNDlAjlo
        JEyX8jc88RYxapgaGU2J2X/b4lUmSOINwpWgM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7A488E6AB4;
        Thu,  9 Jul 2020 14:36:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C3986E6AB3;
        Thu,  9 Jul 2020 14:36:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] git-rebase.txt: fix description list separator
References: <20200709182438.17355-1-martin.agren@gmail.com>
Date:   Thu, 09 Jul 2020 11:36:13 -0700
In-Reply-To: <20200709182438.17355-1-martin.agren@gmail.com> ("Martin
 =?utf-8?Q?=C3=85gren=22's?=
        message of "Thu, 9 Jul 2020 20:24:38 +0200")
Message-ID: <xmqqwo3cwn6q.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 11DE6228-C213-11EA-986B-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> We don't give a "::" for the list separator, but just a single ":". Thi=
s
> ends up rendering literally, "--apply: Use applying strategies ...". As
> a follow-on error, the list continuation, "+", also ends up rendering
> literally (because we don't have a list).
>
> This was introduced in 52eb738d6b ("rebase: add an --am option",
> 2020-02-15) and survived the rename in 10cdb9f38a ("rebase: rename the
> two primary rebase backends", 2020-02-15).
>
> Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
> ---
>  See, e.g., https://git-scm.com/docs/git-rebase/en#Documentation/git-re=
base.txt---quit
>
>  Documentation/git-rebase.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.tx=
t
> index f7a6033607..9acea055d7 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -258,7 +258,7 @@ See also INCOMPATIBLE OPTIONS below.
>  	original branch. The index and working tree are also left
>  	unchanged as a result.
> =20
> ---apply:
> +--apply::

Obviously correct.  Thanks.

>  	Use applying strategies to rebase (calling `git-am`
>  	internally).  This option may become a no-op in the future
>  	once the merge backend handles everything the apply one does.
