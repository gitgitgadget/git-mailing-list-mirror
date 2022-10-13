Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5046C4332F
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 23:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiJMXZ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 19:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJMXZ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 19:25:27 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604D086831
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 16:25:26 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8E8AD1BD88E;
        Thu, 13 Oct 2022 19:25:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=APRi67IJRLHuZZ1B3i4coGprRpdIInPdW+JdHT
        kFTi8=; b=V3IOGoOu6jKl3sLH3tezhTq3cPoreD3n6hQRrEnz146FNR+qEumWou
        CoTTqYUfkVix8G/x4k5PHu66mFOwthEdj8xUPBvosxF9R42eCCMXZ8noYwa1v/LJ
        MRfnbMNN2OqDFEYWBVDJUGvUVQytuV/8tkRQ9IbuYi4pAB4mrUVu4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 866FE1BD88D;
        Thu, 13 Oct 2022 19:25:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B8D351BD88C;
        Thu, 13 Oct 2022 19:25:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v3 4/8] rebase: store orig_head as a commit
References: <pull.1323.v2.git.1662561470.gitgitgadget@gmail.com>
        <pull.1323.v3.git.1665650564.gitgitgadget@gmail.com>
        <dc056b13ed5c62729f97bd2cedbe769c531f4bc4.1665650564.git.gitgitgadget@gmail.com>
        <xmqqilknhed6.fsf@gitster.g>
        <3a234ed2-5540-2109-80d7-dd48fc420841@dunelm.org.uk>
Date:   Thu, 13 Oct 2022 16:25:21 -0700
In-Reply-To: <3a234ed2-5540-2109-80d7-dd48fc420841@dunelm.org.uk> (Phillip
        Wood's message of "Thu, 13 Oct 2022 21:49:44 +0100")
Message-ID: <xmqqa65zcnmm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4F43F4B8-4B4E-11ED-8C89-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> I was wasn't convinced that the tag dereferencing was the only
> difference between lookup_commit_reference() and
> lookup_commit(). lookup_commit() calls lookup_object() and if the
> object is not in the parsed objects hash table it creates a new commit
> object with the given oid without checking if the object
> exists. lookup_commit_reference() calls parse_object() which handles
> replacement objects and checks the object actually exists.

Yes, I agree that both parse_object() and lookup_commit() are
needed, and the combo is preferred over lookup_commit_reference().

THanks.
