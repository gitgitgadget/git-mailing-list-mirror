Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E73C433EF
	for <git@archiver.kernel.org>; Thu,  2 Jun 2022 16:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237327AbiFBQyG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jun 2022 12:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236085AbiFBQyE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jun 2022 12:54:04 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2252A68BB
        for <git@vger.kernel.org>; Thu,  2 Jun 2022 09:54:03 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 13F9C18F31A;
        Thu,  2 Jun 2022 12:54:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=BBCR3cwKjoss
        GgpO9JIctI7CxCIbHZhPYk/dzrOYlhE=; b=w0Josbst3hZN1p+Rm/DOEanxTV9o
        kEOJWagWS7bOpOFhcceUtMpwkYborCGf/inJqgg3Rsm4E+mA5Mn7hs7TY08Gv7po
        kAcO0x21eIejC3/O6QM9RcEMSk27io2xH6iHZdcPRGgJfZRs8mS+GZqwa1eqX6ZP
        REsqH2X54XzKWiA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0BD9018F318;
        Thu,  2 Jun 2022 12:54:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9DB1818F314;
        Thu,  2 Jun 2022 12:53:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v3 1/5] Documentation: define protected configuration
References: <pull.1261.v2.git.git.1652485058.gitgitgadget@gmail.com>
        <pull.1261.v3.git.git.1653685761.gitgitgadget@gmail.com>
        <575676c760d9a2ce4a59d50e93aa0f45d54620ab.1653685761.git.gitgitgadget@gmail.com>
        <xmqqh75a1rmd.fsf@gitster.g>
        <2ed00ece-f8bb-c84c-0684-494692a71da2@github.com>
Date:   Thu, 02 Jun 2022 09:53:58 -0700
In-Reply-To: <2ed00ece-f8bb-c84c-0684-494692a71da2@github.com> (Derrick
        Stolee's message of "Thu, 2 Jun 2022 08:42:30 -0400")
Message-ID: <xmqq35gnovkp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 994C92FE-E294-11EC-931F-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

>> It would make sense to give a rationale behind the seemingly
>> arbitrary choice of what is and what is not "protected".  Not
>> necessarily in the glossary, but in the proposed log message of the
>> commit that makes the decision.  The rationale must help readers to
>> be able to answer the following questions.
>>=20
>>  - The system level is "protected" because?  Is it because we do not
>>    even try to protect ourselves from those who can write anywhere
>>    in /etc/ or other system directories?
>>=20
>>  - The per-user config is "protected" because?  Is it because our
>>    primary interest in "protection" is to protect individual users
>>    from landmines laid in the filesystem by other users, and those
>>    who can already write into $HOME are not we try to guard against?
>
> I think the answers to these two questions is "yes", so they can
> be turned into an affirmative sentence:
>
> 	We do not event try to protect ourselves from those who can
> 	write anywhere...

s/event/even/.

>
>>  - The per-repo config is not "protected" (i.e. "trusted"), because?
>>    If we are not honoring a configuration in the repository, why are
>>    we working in that repository in the first place?
>
> This requires an example:
>
> 	Some workflows use repositories stored in shared directories,
> 	which are writable by multiple unprivileged users.

Hmph, "... and we do not trust these colleagues"?  It might be true,
but sounds a bit weak rationale, at least to me.  A natural reaction
coming form a devil's advocate na=C3=AFve me would be "well, then I would
not be directly interacting with such a repository; I'd work in a
clone of it of my own, and pull and push as needed".

Isn't the reason more like "users may go spelunking random places in
the filesystem, with PS1 settings and the like that causes some
"git" command invoked automatically in their current directory, and
we want to protect these users from getting harmed by a random
repository with hostile contents in their configuration and hooks
without even realizing they have wandered into such a repository"?

>>  - The per invocation config is not "protected" (i.e. "trusted"),
>>    because?  If we cannot trusting our own command line, what
>>    prevents an attacker from mucking with our command line to say
>>    "sudo whatever" using the same attack vector?
>
> With this argument, I agree that -c config can be considered
> protected. At the very least, it is visible to the user when they
> are running a command. This would unify our expectations with
> uploadPack.packObjectsHook, too.

Yup, that matches my understanding.

In any case, I'd prefer to see not just the definition but the
reasoning behind the decision that made some "protected" while
leaving others not-"protected" clearly documented to help users.

Thanks.
