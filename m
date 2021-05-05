Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C41C433B4
	for <git@archiver.kernel.org>; Wed,  5 May 2021 00:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDDD260FE3
	for <git@archiver.kernel.org>; Wed,  5 May 2021 00:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbhEEAuQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 May 2021 20:50:16 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55623 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhEEAuP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 May 2021 20:50:15 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E5EBFCB460;
        Tue,  4 May 2021 20:49:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0lW0wpqq1cyQW09pYAc37hQIqGZPDfMLy3mflf
        mqjh4=; b=fTjjO8FuCE+oeuPCGSaHEzY3jID3FqXUx9Crk6TSq0k4RyMe4/ZtSO
        UaLi4K+webssDuaFjNKAiXeTvHhzIR+EfbH+tOKwek0OJGLZlwXli3NgNjrEV6DJ
        yIbA60Gjgx5rh5u+VmQkxr/ELs8MZmoIbJgFXFFPXDHX4rXfKhYLQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DDE40CB45F;
        Tue,  4 May 2021 20:49:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6B953CB45E;
        Tue,  4 May 2021 20:49:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>, git@vger.kernel.org
Subject: Re: Advise request on adding a new SSH variant
References: <043101d73aae$026409b0$072c1d10$@nexbridge.com>
        <fa8f81db-d470-130e-115d-7aef5e97e5a7@iee.email>
Date:   Wed, 05 May 2021 09:49:18 +0900
In-Reply-To: <fa8f81db-d470-130e-115d-7aef5e97e5a7@iee.email> (Philip Oakley's
        message of "Tue, 4 May 2021 15:45:00 +0100")
Message-ID: <xmqqlf8u57jl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B9AAD43C-AD3B-11EB-AB0D-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

> I was also thinking that the lack of replies maybe links to the "Pain
> points in Git's patch flow" thread <YHaIBvl6Mf7ztJB3@google.com> whereby
> it's all about the proposed patch, rather than thoughts about a
> potential patch.
> (Sort of like the philosophy of science [method] that ignores opinion,
> and demands evidence)

Actually, the initial message on this matter from Randall came in
the patch form <011e01d73dd0$ec141530$c43c3f90$@nexbridge.com>, so
if it were truly "it's all about the proposed patch, rather than
thoughts about a potential patch", it would have gained much more
responses.

Other than I didn't have time, the reason I didn't respond was that
the concept and notation used there were a bit too foreign to me to
decide from where to start asking questions.  It wasn't clear what
'$ZSSHX' meant (is it the value of an environment variable whose
name is ZSSHX, or is it literally a name with dollar in it and is
the issue being addressed that it is too cumbersome to quote it
properly in value of the GIT_SSH_COMMAND environment variable?) for
example.  And after reading the message you are responding to twice,
I do not quite get what problem we are trying to solve.  Especially
since

    No, it would be GIT_SSH_COMMAND='/G/system/zssh/sshoss -Z -Q -S
    $ZSSH0' and that does not work correctly in the current git code
    base.

in <012601d73ddf$3d0cf660$b726e320$@nexbridge.com> sounded like we
have a fairly clearly demonstratable problem (i.e. the handling of
the command line given via GIT_SSH_COMMAND is somehow broken). The
details of "does not work correctly in the current code base" is not
yet disclosed but it sounded like it would be possible to tease it
out and solve the issue in a more direct way.  But yet the solution
presented in the three-patch series looked like it was sidestepping
the entire issue and adding a special case for NonStop without
having to touch GIT_SSH_COMMAND at all (presumably leaving it still
"broken").
