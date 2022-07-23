Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF8CC433EF
	for <git@archiver.kernel.org>; Sat, 23 Jul 2022 04:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236660AbiGWEol (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jul 2022 00:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGWEok (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jul 2022 00:44:40 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358C285F80
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 21:44:38 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6CBF019E787;
        Sat, 23 Jul 2022 00:44:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wTY5IxkQ8u9tuChuYWk7obeusrT4SlGU4jk7c7
        IgEWY=; b=ltcEyHA8djdoOZH2VX1FXzcyiJ3UucFlLCZr3TPnOgrKsfNwheyP2y
        PV0sdSgppLYNrGRyzhymTjiYyLIL1wsbXb/MHxL7DAgdKS3YMG6HaBxDeu9tNLr2
        ZnVx8In+5YdRD62X6RSWKNg01D0RFsXCD8ZUr5eofPGqC7EWNr0EI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5984619E785;
        Sat, 23 Jul 2022 00:44:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EDE4819E783;
        Sat, 23 Jul 2022 00:44:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/2] cat-file: support NUL-delimited input with `-z`
References: <cover.1658532524.git.me@ttaylorr.com>
Date:   Fri, 22 Jul 2022 21:44:32 -0700
In-Reply-To: <cover.1658532524.git.me@ttaylorr.com> (Taylor Blau's message of
        "Fri, 22 Jul 2022 19:28:54 -0400")
Message-ID: <xmqqczdwbfpr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 25FE3B4C-0A42-11ED-8B95-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> This short patch series implements a `-z` mode that is compatible with
> the `--batch`, `--batch-check`, and new `--batch-command` options in
> `cat-file`.

It's a shame that we forgot that people use strange "object name"
like "<tree>:<path>", when we originally intended to only take
simple object names, like fully-spelled hexadecimal.  And if we were
prepared to take <path>, we should have make sure we use the usual
cquote convention.

