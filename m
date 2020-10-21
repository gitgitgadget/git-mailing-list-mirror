Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525D7C4363A
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 22:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC47B241A6
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 22:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Xe256Hke"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506696AbgJUW1L (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 18:27:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55220 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2506646AbgJUW1L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 18:27:11 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 59789806C8;
        Wed, 21 Oct 2020 18:27:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NhTGZSE3Wus9z65DkgEYCbuTHhc=; b=Xe256H
        kerQ73qtCkfZODgPBQsij7bP9URgxhGLwVph4RdR0lZnRhs71D9s71o3Qf/4Xe1o
        v9vt6/CDj+zB4oXcXCnXXgBhtOSG0pJsjBIUAohMneq+sOzv56/SkId/FYXbxQNG
        jAtd44+6GWyZoIrJSQYilliOZkldElD5+7QEU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=sMkH5u37uz1bIrXl9mizBi00TZzCdVCP
        mmcBBtRwvVl6nB0GtDjVCSxYmr/oT9Qo271IniCCUwHQinIjyldIlvnvAVtaCAeY
        RGCGdGw71GJ2A/znOb3IuiXSXrcmNAeLNBgeELwXu82QFLIMhLKBnYTxIf9907wz
        qQMSGHWuHag=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5195F806C7;
        Wed, 21 Oct 2020 18:27:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D8160806C6;
        Wed, 21 Oct 2020 18:27:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 05/10] t6200: adjust suppression pattern to also match
 "main"
References: <pull.758.git.1603135902.gitgitgadget@gmail.com>
        <7860d8d7df43075ad5424d8210d6f6e17c2042db.1603135903.git.gitgitgadget@gmail.com>
Date:   Wed, 21 Oct 2020 15:27:08 -0700
In-Reply-To: <7860d8d7df43075ad5424d8210d6f6e17c2042db.1603135903.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Mon, 19 Oct 2020
        19:31:36 +0000")
Message-ID: <xmqqpn5b43lv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8E8234DC-13EC-11EB-B83C-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> -	git -c merge.suppressDest="ma??er" fmt-merge-msg <.git/FETCH_HEAD >full.3 &&
> +	git -c merge.suppressDest="ma*" fmt-merge-msg <.git/FETCH_HEAD >full.3 &&

Cute.  IIRC, the point of this test was to ensure that a glob
pattern works, so we can do a bit better to avoid colliding with
another common name 'maint' by tightening the pattern to something
like "ma?*[rn]".

