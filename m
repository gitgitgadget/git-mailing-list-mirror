Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F15CE7AFC
	for <git@archiver.kernel.org>; Thu, 28 Sep 2023 18:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjI1SQh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Sep 2023 14:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbjI1SQg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2023 14:16:36 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F75899
        for <git@vger.kernel.org>; Thu, 28 Sep 2023 11:16:35 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D002F3C506;
        Thu, 28 Sep 2023 14:16:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=dn1DcTBiFj6Io5UGzyLD8iv+yA6/Kz0JJCuncV
        /EnqY=; b=Zr+CzPHj1p+swhCJc96lg13hc6t58vGnxd5embDOpl0hOVNNE1BqEa
        tZUcfmtiQTL5TVsoHtDmZMAs8/E4zH7hkJ728jFZ0t1J4BA+RgxVx+U5cCKEwiCx
        QesJOtgsOPEswU0lTqvAqNqlZxE99ZkvDwKYFLJ65Vb50fW5jKmaU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C9D333C505;
        Thu, 28 Sep 2023 14:16:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0E5933C504;
        Thu, 28 Sep 2023 14:16:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Joanna Wang <jojwang@chromium.org>
Cc:     git@vger.kernel.org
Subject: Re: Supporting `git add -a <exclude submodules>`
In-Reply-To: <xmqqsf6yjhhm.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        28 Sep 2023 11:11:01 -0700")
References: <CAL-HyEbxGqxid3vsvDk3Z0Gd3swbNP4qcXhApadu8ZgvRkr3WA@mail.gmail.com>
        <xmqqsf6yjhhm.fsf@gitster.g>
Date:   Thu, 28 Sep 2023 11:16:29 -0700
Message-ID: <xmqqmsx6jh8i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2617833E-5E2B-11EE-AA93-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> (It looks like `git commit -a` does not work with pathspec.
>
> You should be able to do something like 
>
>     $ git commit . ':(exclude)t/'
>
> I think.

Correction.  You would need the "-i(nclude)" option if you do the
above, as the default is "-o(nly)", which will deliberately ignore
what has been added to the index.
