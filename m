Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D73C00140
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 20:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244909AbiHRUgv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 16:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbiHRUgu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 16:36:50 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7580BD2B04
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 13:36:47 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EDB7914E78C;
        Thu, 18 Aug 2022 16:36:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=csGg+d09owZdgb1AkkyTenK8CTzB1xcEery4I9
        iEj14=; b=LA/Xv5Rxn+r3T/AGYWts75Z4H3aCZkbc0LL7tNRYjBRY07fUXzAdhZ
        vpsFbfqi81BxRDj7tRQWEYBAP/DlUcrmIEhJfOT7MlL9pg/4fmOfG9nwDSBGPCpK
        KB/qg0bg47w70TLB9mhgH7oJb5gfpY3wVWUlRgKBvh3CiyHFSy7sA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E5FA014E78B;
        Thu, 18 Aug 2022 16:36:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 602EE14E78A;
        Thu, 18 Aug 2022 16:36:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael J Gruber <git@grubix.eu>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 4/4] po: adjust README to code
References: <09rn6r61-38qo-4s1q-q7qq-p5onp6p87o44@tzk.qr>
        <cover.1660828108.git.git@grubix.eu>
        <e163c87b3efc1571cb3657df6459583af92f9f2b.1660828108.git.git@grubix.eu>
Date:   Thu, 18 Aug 2022 13:36:42 -0700
In-Reply-To: <e163c87b3efc1571cb3657df6459583af92f9f2b.1660828108.git.git@grubix.eu>
        (Michael J. Gruber's message of "Thu, 18 Aug 2022 15:13:29 +0200")
Message-ID: <xmqqilmpnvad.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7885BB26-1F35-11ED-955B-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael J Gruber <git@grubix.eu> writes:

> When we talk about sequencer action names as such (as opposed to command
> names) we do translate the action name. Adjust the po README to reflect
> this and to match the code base.
>
> Signed-off-by: Michael J Gruber <git@grubix.eu>
> ---
>  po/README.md | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/po/README.md b/po/README.md
> index 3e4f897d93..90b8455401 100644
> --- a/po/README.md
> +++ b/po/README.md
> @@ -273,7 +273,7 @@ General advice:
>  
>    ```c
>    /* TRANSLATORS: %s will be "revert" or "cherry-pick" */
> -  die(_("%s: Unable to write new index file"), action_name(opts));
> +  die(_("%s: Unable to write new index file"), _(action_name(opts)));
>    ```

While "revert" and "cherry-pick" may have localized words in our po/
dictionary, the message uses "%s:" placeholder to identify the Git
operation that is reporting the problem, and the way the end-user
who is getting the message triggered the Git operation was by
running a subcommand of "git", isn't it?  

Isn't it confusing for a user who typed "git revert" to see an error
from _("revert")?  _("Unable to write new index file") is perfectly
fine, though.
