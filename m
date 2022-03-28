Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F215C433F5
	for <git@archiver.kernel.org>; Mon, 28 Mar 2022 05:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236752AbiC1Fze (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 01:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbiC1Fzd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 01:55:33 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F1B10FD7
        for <git@vger.kernel.org>; Sun, 27 Mar 2022 22:53:53 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9D7B9129001;
        Mon, 28 Mar 2022 01:53:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vkrYzQj+RN2CYctmkNq8Ez0Ph+cbQrqkjjFdkk
        TMUig=; b=S4YyIrbW5ArSXqfPzrlzxKMaFZuOdROKOWglBLawAMHo8V3NCZJR3F
        6tgqM8K/Xy0Cxm7E/j5uxxw4cmBcfHVxgk0FM5AE4BtrHu96lbOp63yZGLu0VO6v
        o9NObMY11XHwkOLcqAVbOSjZEh2LuPKydTP0bTuiJ+8E7Ry3oDeTI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 95CD5129000;
        Mon, 28 Mar 2022 01:53:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 03EBB128FFF;
        Mon, 28 Mar 2022 01:53:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     PMEase <robin@pmease.com>
Cc:     git@vger.kernel.org
Subject: Re: How to get the original raw commit message without removing
 extra leading/trailing line breaks
References: <1BEBB3E1-0089-44CD-8D3B-3AA424C90E48@pmease.com>
Date:   Sun, 27 Mar 2022 22:53:50 -0700
In-Reply-To: <1BEBB3E1-0089-44CD-8D3B-3AA424C90E48@pmease.com> (PMEase's
        message of "Mon, 28 Mar 2022 13:42:18 +0800")
Message-ID: <xmqq5yny62s1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 720D34E0-AE5B-11EC-94A9-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PMEase <robin@pmease.com> writes:

[jc: wrapped overly long lines]

> I am using command "git show --format=raw <commit hash>" to get
> raw commit object in order to verify the GPG signature in my
> program to customize public key loading. However in the raw commit
> object, extra line breaks before and after the commit message is
> removed, which cause the signature verification failure as git
> generates the signature without removing those line breaks.

"git show --format=raw <commit object name>" will not give "raw
commit object" to begin with.  It indents the message by four
spaces.

"git cat-file commit <commit object name>" is what you want, I
think.
