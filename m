Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89032C433EF
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 22:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233348AbhKSWx3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 17:53:29 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65516 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbhKSWx2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 17:53:28 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A4EFA10BDF6;
        Fri, 19 Nov 2021 17:50:25 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3zubT8PE5w95BMISx+JXFOh5bUP/UclDzVvL3/
        e/eCk=; b=Nr2Giol7vdW3RnJNAAFfnI1r2iURLmIle90xG5dGfgfQi3R6YaB/CG
        7Nt+t/eH5RSMkSi66e/LU66Wq0iEz08QvDPciFN5nIxHY0beO2zjR/xoEK+WpwJa
        hMdG5hd3lZor7Vg6zP4b1ElCm65qgwvTkq64jB3yv9r7OE3LKs62k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9A4A910BDF5;
        Fri, 19 Nov 2021 17:50:25 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 08DC610BDF4;
        Fri, 19 Nov 2021 17:50:24 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Aleen via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Aleen =?utf-8?B?5b6Q5rKb5paH?= <pwxu@coremail.cn>,
        Aleen <aleen42@vip.qq.com>
Subject: Re: [PATCH v7 2/2] am: support --empty=<option> to handle empty
 patches
References: <pull.1076.v6.git.1637232636.gitgitgadget@gmail.com>
        <pull.1076.v7.git.1637298298.gitgitgadget@gmail.com>
        <9e60e77c041bca28a50d706c865eb776e5fe2ec2.1637298299.git.gitgitgadget@gmail.com>
Date:   Fri, 19 Nov 2021 14:50:23 -0800
In-Reply-To: <9e60e77c041bca28a50d706c865eb776e5fe2ec2.1637298299.git.gitgitgadget@gmail.com>
        (Aleen via GitGitGadget's message of "Fri, 19 Nov 2021 05:04:58
        +0000")
Message-ID: <xmqqtug7oj4g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 156F38A8-498B-11EC-A41A-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Aleen via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Aleen <aleen42@vip.qq.com>
>
> Since that the command 'git-format-patch' can include patches of
> commits that emit no changes, the 'git-am' command should also
> support an option, named as '--empty', to specify how to handle
> those empty patches. In this commit, we have implemented three
> valid options ('die', 'drop' and 'keep').
>
> Signed-off-by: Aleen <aleen42@vip.qq.com>
> ---
>  Documentation/git-am.txt |  8 ++++++
>  builtin/am.c             | 55 ++++++++++++++++++++++++++++++++++++----
>  t/t4150-am.sh            | 49 +++++++++++++++++++++++++++++++++++

>  po/bg.po                 |  2 +-
>  po/ca.po                 |  2 +-
>  po/de.po                 |  2 +-
>  po/el.po                 |  2 +-
>  po/es.po                 |  2 +-
>  po/fr.po                 |  2 +-
>  po/git.pot               |  2 +-
>  po/id.po                 |  2 +-
>  po/it.po                 |  2 +-
>  po/ko.po                 |  2 +-
>  po/pl.po                 |  2 +-
>  po/pt_PT.po              |  8 +++---
>  po/ru.po                 |  4 +--
>  po/sv.po                 |  2 +-
>  po/tr.po                 |  2 +-
>  po/vi.po                 |  2 +-
>  po/zh_CN.po              |  9 +++++--
>  po/zh_TW.po              |  7 ++++-

Please do not touch these po/ files.  They will be updated when i18n
coordinator decides to update the translation.

