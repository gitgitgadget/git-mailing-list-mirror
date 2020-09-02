Return-Path: <SRS0=xf+W=CL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E119AC433E2
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 19:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 964C82083B
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 19:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Zlmw2t+7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbgIBTMh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Sep 2020 15:12:37 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54990 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgIBTMg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Sep 2020 15:12:36 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2DBF6E2F26;
        Wed,  2 Sep 2020 15:12:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oAtUbxccbVWVxx58XQ3ycj4pEos=; b=Zlmw2t
        +7K0ewa65XWqG36Fz5BY4WyYIVc0bDWLEZquldT+L2WUg6kLxgeE0f7hvQgc0z1G
        U8drgC3mMA1LEBDhCP6/gRZbZk2Mn3mgnk4Wz6Tqk3Qu2TZFyyDRD2wdwFRhsRs3
        XlNcuVBXLQjItLOLHlENbUWvJLcRuJppqBSTQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ORYOhr/8f7jVvj1qjGvEm9Z1YlkLWbZ3
        2hXei1rr/vTE8sR5XDVc+q7/ajg6ARQnKSHHdH0i0fVcyiLTG1hO19YC37rUdnw8
        1HRb6RTkzXdwFa84ACNpy0eGwTw1Me2kiXGRolEfzro+hrenklpCnd/+Ec9BmpaQ
        79+0D2SPcyY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 28657E2F25;
        Wed,  2 Sep 2020 15:12:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2952AE2F22;
        Wed,  2 Sep 2020 15:12:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Sep 2020, #01; Tue, 1)
References: <xmqqblipchk6.fsf@gitster.c.googlers.com>
        <CAPig+cTUhLoPvs+ygnc0Y4Ez3M3tfGncPzON0ejb=xEOMBixHQ@mail.gmail.com>
        <xmqq7dtcceka.fsf@gitster.c.googlers.com>
        <CAPig+cTGspJAGxRu+vqdko1ntkBonVaoStYde3+P5UxPxrCs7g@mail.gmail.com>
        <xmqqwo1caw2y.fsf@gitster.c.googlers.com>
        <CAPig+cRn3e=A4Bd5h7+y9NgOws7Pif86vdW8M1RwQaP_q-Es5Q@mail.gmail.com>
Date:   Wed, 02 Sep 2020 12:12:29 -0700
In-Reply-To: <CAPig+cRn3e=A4Bd5h7+y9NgOws7Pif86vdW8M1RwQaP_q-Es5Q@mail.gmail.com>
        (Eric Sunshine's message of "Wed, 2 Sep 2020 14:17:08 -0400")
Message-ID: <xmqqsgc0at7m.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3FCD86D8-ED50-11EA-BF3A-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> Okay. In that case, perhaps a slight modification of your wording would work?
>
>     "git worktree" gained a "repair" subcommand to help users recover
>     after moving the worktrees or repository manually without telling
>     Git.  Also, "git init --separate-git-dir" no longer corrupts
>     administrative data related to linked worktrees.

Perfect.
