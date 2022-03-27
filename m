Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFA1C433EF
	for <git@archiver.kernel.org>; Sun, 27 Mar 2022 21:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234241AbiC0Vpe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Mar 2022 17:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiC0Vpe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Mar 2022 17:45:34 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A34BF70
        for <git@vger.kernel.org>; Sun, 27 Mar 2022 14:43:54 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 926B3187C3B;
        Sun, 27 Mar 2022 17:43:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fVMEH5Z5dqVUiDT3MAvJNFPFVB/FkPAOscVHwM
        SSoQs=; b=CFJSBZKS6Y56wkc4L60qCfSxAIh1QkARNETXWIRWfoCgl/2TBMYIRt
        YdykNzQKS795HK5NdFD24cnk2/Ffqcm6pQhaO2LZovnE37TXAfCy4wZd5U3ejxfY
        HC/Ro8XoNeyx8qniq0rBP0wgtTQZqznqO0Ie0R/KfLd0GSLhj7/Q8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8A81F187C3A;
        Sun, 27 Mar 2022 17:43:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id F022E187C37;
        Sun, 27 Mar 2022 17:43:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Fernando Ramos <greenfoo@u92.eu>
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        git@vger.kernel.org, davvid@gmail.com, sunshine@sunshineco.com,
        seth@eseth.com, rogi@skylittlesystem.org
Subject: Re: [PATCH v6 3/3] vimdiff: add tool documentation
References: <20220327112307.151044-1-greenfoo@u92.eu>
        <20220327112307.151044-4-greenfoo@u92.eu>
        <001d3ecd-e1bd-39f4-5123-4a8b1bd1b5a8@gmail.com>
        <YkDS3CJEPYpzRoVG@zacax395.localdomain>
Date:   Sun, 27 Mar 2022 14:43:51 -0700
In-Reply-To: <YkDS3CJEPYpzRoVG@zacax395.localdomain> (Fernando Ramos's message
        of "Sun, 27 Mar 2022 23:10:52 +0200")
Message-ID: <xmqqmthb5aw8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FE43A574-AE16-11EC-8698-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fernando Ramos <greenfoo@u92.eu> writes:

> Good call. I tried this:
>
>     mergetool.{n,g,}vimdiff.layout::

It is not like we have infinite variants of these.  Spelling them
out like

	mergetool.vimdiff.layout::
	mergetool.gvimdiff.layout::
	mergetool.nvimdiff.layout::

would probably be a better idea.


>     	The vimdiff backend uses this variable to control how its split
>     	windows look like.  See BACKEND SPECIFIC HINTS section
>     ifndef::git-mergetool[] 
>     	(on linkgit:git-mergetool[1])
>     endif::[]
>     	for details.
>
> ...does it look good?
>
> I'm asking because I ran "make doc" and the generated man page always contains
> the extra piece. When are those asciidoc directives processed? Should two
> versions of the same man page be generated?

Are you signalling the above part that it is (or isn't) included in
git-mergetool.txt by defining

	:git-mergetool: 1

before the piece gets included with

	include::config/mergetool.txt

See for example how git-rev-list.txt tweaks what gets included from
rev-list-description.txt by doing:

    'git rev-list' [<options>] <commit>... [[--] <path>...]

    DESCRIPTION
    -----------

    :git-rev-list: 1
    include::rev-list-description.txt[]

    'rev-list' is a very essential Git command, since it

