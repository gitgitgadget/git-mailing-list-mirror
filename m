Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18048C433EF
	for <git@archiver.kernel.org>; Wed, 20 Jul 2022 18:42:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbiGTSmm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jul 2022 14:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiGTSml (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jul 2022 14:42:41 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F51C564F4
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 11:42:40 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4B58F12FB36;
        Wed, 20 Jul 2022 14:42:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xKwcxQB0cogCGsJ+KAHbFVqY7pxw1f5CzZQaRm
        i89mE=; b=ZKW8ULynfdhL13lap9i+G+1NrZBw43KKL8rGugvpqI3h1lCvEWosGV
        BS73jVHW8XwDbBE6ZblPYFcWFi5cikc7ONc1iUx5RbJje4CYtYL4Qperdllc0mmz
        hfNn/HsobtWTH6N17hSCp5JA432ROiSjucEeVBiYmNEbJbFSLpzEY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 409AF12FB35;
        Wed, 20 Jul 2022 14:42:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 85F1E12FB34;
        Wed, 20 Jul 2022 14:42:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Moritz Baumann via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Tao Klerks <tao@klerks.biz>,
        "Baumann, Moritz" <moritz.baumann@sap.com>
Subject: Re: [PATCH v2] git-p4: fix CR LF handling for utf16 files
References: <pull.1294.git.git.1658294873702.gitgitgadget@gmail.com>
        <pull.1294.v2.git.git.1658341065221.gitgitgadget@gmail.com>
Date:   Wed, 20 Jul 2022 11:42:37 -0700
In-Reply-To: <pull.1294.v2.git.git.1658341065221.gitgitgadget@gmail.com>
        (Moritz Baumann via GitGitGadget's message of "Wed, 20 Jul 2022
        18:17:45 +0000")
Message-ID: <xmqq7d4739sy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BAB2E92E-085B-11ED-8B4F-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Moritz Baumann via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Moritz Baumann <moritz.baumann@sap.com>
>
> Perforce silently replaces LF with CR LF for "utf16" files if the client
> is a native Windows client. Since git's autocrlf logic does not undo
> this transformation for UTF-16 encoded files, git-p4 replaces CR LF with
> LF during the sync if the file type "utf16" is detected and the Perforce
> client platform indicates that this conversion is performed.
>
> Windows only runs on little-endian architectures, therefore the encoding
> of the byte stream received from the Perforce client is UTF-16-LE and
> the relevant byte sequence is 0D 00 0A 00.
>
> Signed-off-by: Moritz Baumann <moritz.baumann@sap.com>
> ---

Will queue.  Thanks.
