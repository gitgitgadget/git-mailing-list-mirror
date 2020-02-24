Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C1DC38BE2
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 19:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78D5E20838
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 19:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fbx2s5Zp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgBXTSU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Feb 2020 14:18:20 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58427 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgBXTSU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Feb 2020 14:18:20 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0D624C95F0;
        Mon, 24 Feb 2020 14:18:20 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ouoygKsowx9C
        4V1AfYWQbmyqooo=; b=fbx2s5ZpngWqgPwX8TffcTyxBJ9xaRiC5vOLXbuNv8l5
        3wZ9lNB3MC8qEWfrcFLS6ntwZcf8uw8c2z6YuqzjLX0dVJ73mOmFZSMEYxTYPhP9
        CHiVZYYfnlQyTpgcoMtpKHkPT2bwt+RIAO50+yiVp+90FRvhyOm2jOf/wvnahl0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=LUbfq1
        CaOvH/+I2/hUJzwJiPVlKlhGYpJe+P/I9M9PAtpmhcdjzmZEYz59Thdj4poJdvAq
        yuhX22kworqXZJpXmSAOv738SwcHWqI6gFPHe+Utgb3JspthwFcgXrezB6D15dcx
        cQI/+QFaXVM5GeeIDp0Tg0sR9Rj/ADimjGyQA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 047ACC95EF;
        Mon, 24 Feb 2020 14:18:20 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2E686C95EE;
        Mon, 24 Feb 2020 14:18:17 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/3] t9810: drop debug `cat` call
References: <dde0f85e5e3dd99a61b83df1b6eb572be8a3ff51.1582447606.git.martin.agren@gmail.com>
        <ef45c9cabe7fe3f31d63edb872ba946ffbd951fe.1582447606.git.martin.agren@gmail.com>
Date:   Mon, 24 Feb 2020 11:18:13 -0800
In-Reply-To: <ef45c9cabe7fe3f31d63edb872ba946ffbd951fe.1582447606.git.martin.agren@gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Sun, 23 Feb 2020 09:48:35
 +0100")
Message-ID: <xmqqpne3pzey.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6925E4C8-573A-11EA-8802-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> We `cat` kwdelfile.c, but don't inspect or grab the contents in any way=
.
> This looks like a remnant from a debug session. Similar to the previous
> commit, one could argue that `cat`-ing the file verifies that it didn't
> disappear somehow. But because the very next thing we do after `cat`-in=
g
> the file is to `grep` in it, we can safely drop the call to `cat`.
>
> Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
> ---
>  t/t9810-git-p4-rcs.sh | 1 -
>  1 file changed, 1 deletion(-)

The change does make sense, but makes me wonder why we need to
single this one out in a separate patch.  Doesn't this fall into the
same category of fixes done in 3/3?  Exactly the same rationale as
above applies to the first one in 3/3 on t0021---we can safely lose
the cat because the file is immediately grepped for a string, so
missing file will be caught as an error either way.

Puzzled...

> diff --git a/t/t9810-git-p4-rcs.sh b/t/t9810-git-p4-rcs.sh
> index 57b533dc6f..e3836888ec 100755
> --- a/t/t9810-git-p4-rcs.sh
> +++ b/t/t9810-git-p4-rcs.sh
> @@ -294,7 +294,6 @@ test_expect_success 'cope with rcs keyword file del=
etion' '
>  		echo "\$Revision\$" >kwdelfile.c &&
>  		p4 add -t ktext kwdelfile.c &&
>  		p4 submit -d "Add file to be deleted" &&
> -		cat kwdelfile.c &&
>  		grep 1 kwdelfile.c
>  	) &&
>  	git p4 clone --dest=3D"$git" //depot &&
