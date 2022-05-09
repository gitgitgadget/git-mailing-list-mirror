Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD91AC433EF
	for <git@archiver.kernel.org>; Mon,  9 May 2022 17:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239813AbiEIR4b (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 13:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239807AbiEIR4a (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 13:56:30 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56EF82BEFB7
        for <git@vger.kernel.org>; Mon,  9 May 2022 10:52:32 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5134C180F0D;
        Mon,  9 May 2022 13:52:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=t7wVPkNkQoKIyH97D3gFilmg6Sj1+fh3MBLst6
        d1tpk=; b=EXZiahWOMdY1kLEsc9d+WdzjFc6fss7B5gcB0TX0q+cSEnf3YAier/
        JOGTKl9h8dFXzQLf6o4NxZ7VosCriORkX262HYTojf+8KZQZJxI7f0pQYlCFFqI1
        ITTO24DX8oEJ/dEeoRYMv4zhbk30cuwN18wH3n4faOS9iCje6tdB8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 49F12180F0C;
        Mon,  9 May 2022 13:52:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E8AB1180F09;
        Mon,  9 May 2022 13:52:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Abhradeep Chakraborty via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Philip Oakley <philipoakley@iee.email>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH v4] builtin/remote.c: teach `-v` to list filters for
 promisor remotes
References: <pull.1227.v3.git.1651933221216.gitgitgadget@gmail.com>
        <pull.1227.v4.git.1652095969026.gitgitgadget@gmail.com>
        <Ynk0mADTSJU/xVUd@nand.local>
        <54aee42d-fe78-eef1-a371-7ca310a9319f@gmail.com>
Date:   Mon, 09 May 2022 10:52:26 -0700
In-Reply-To: <54aee42d-fe78-eef1-a371-7ca310a9319f@gmail.com> (Philippe
        Blain's message of "Mon, 9 May 2022 13:01:48 -0400")
Message-ID: <xmqqmtfqd25h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CA7FE1C8-CFC0-11EC-8763-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain <levraiphilippeblain@gmail.com> writes:

> Or, making 'git remote' act like 'git branch' and accept a second '-v', i.e.
> 'git remote -vv' would list filters (then I would just adjust my alias :P). 
> Then we can outright declare "the output of 'git remote -vv' is subject to 
> future changes to show more useful information", or similar, so we do not
> have to do the same dance the next time we want to add some other info.

Isn't it where we already are with "remote -v", though?  I am not
sure addition of excess information that may not be universally
useful is a very welcome change, even with "remote -v -v".  I am not
worried about showing the "list-object-filter", but I worry about
managing temptations of future developers to add other stuff.

> The downside of hiding such new features behing config values or additional flags
> is that it really, really limits their discoverability. This is something that I 
> often think about and think we should really do better in Git, in general. 
> For example, features like 'remote.pushDefault' or the 'diff=*' attribute
> for language-aware hunk headers (and funcname-limited log/blame etc) are immensely 
> useful, but often even experienced and long-time Git users do not even know they exist, 
> because they are not covered in "regular" Git tutorials...

Unfortunately, it is not exactly a solution for that to update the
tutorial, because experienced and long-time users rightly consider
themselves beyond tutorials and sometimes documentation.
