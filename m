Return-Path: <SRS0=xqrk=6B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F0BC38A2B
	for <git@archiver.kernel.org>; Fri, 17 Apr 2020 17:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CE9220776
	for <git@archiver.kernel.org>; Fri, 17 Apr 2020 17:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="J+ocNaF5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbgDQRa5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Apr 2020 13:30:57 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59759 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728602AbgDQRa5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Apr 2020 13:30:57 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1AB235CBD7;
        Fri, 17 Apr 2020 13:30:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=L1kan5SAPPWpEsOtPiDocVG6wNQ=; b=J+ocNa
        F5qIbsHx1/Zj36dtVZMC1FfLDDQhlkXLAtCLYGndIaAgCTHscRggppQTz6i4/7Kp
        G9vIB4yzSpoK+B7XWPJ1IbkL1Mq4M2PGdkS5zgUgv3ez5aT6gW4cLN5XZ4aMXR6c
        1EdLVLfXLQaN7UgaWh/eOhJBZxPPGg1YLJwtQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YnRiyOsSvibZscFCfqxvdL48puqAMAWf
        Y85RH27p2a6xOlqC5+QsKWFmfIrDoKPOY9zPE+tL9UBDLIYA0rKQwAgoMKBZOZ53
        7Hay+WZp7EcO3K+iEquxbWJopO36dvWLM5sjrsN/r6dxQepOX9xJwdKyblKYhRPU
        pVWhbkJCEgE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 092B95CBD6;
        Fri, 17 Apr 2020 13:30:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7CB1B5CBD5;
        Fri, 17 Apr 2020 13:30:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Damien Robert <damien.olivier.robert@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2020, #01; Wed, 15)
References: <xmqqr1wo4alb.fsf@gitster.c.googlers.com>
        <20200416211208.xqnnrkvcl2jw3ejr@doriath>
        <20200416213009.GA1721147@coredump.intra.peff.net>
        <xmqqh7xjxeew.fsf@gitster.c.googlers.com>
        <20200416224708.zr4dlrz4hpaqsz2s@doriath>
        <20200416230554.bhk2yfycjwjpxggy@doriath>
        <xmqq4ktjxawx.fsf@gitster.c.googlers.com>
        <20200417125415.6o5avmae3cyvq4fy@feanor>
Date:   Fri, 17 Apr 2020 10:30:53 -0700
In-Reply-To: <20200417125415.6o5avmae3cyvq4fy@feanor> (Damien Robert's message
        of "Fri, 17 Apr 2020 14:54:15 +0200")
Message-ID: <xmqq1romvx2q.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 30E8E158-80D1-11EA-8DB6-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Damien Robert <damien.olivier.robert@gmail.com> writes:

> The reason I sent it as is, as outlined by my cover letter, was that I
> found it quite surprising that a pushRemote without remote was not
> considered by 'git push' as a triangular workflow. Technically a triangular
> workflow is when the push remote is different from the fetch remote, and we
> could argue when there is no fetch remote it is indeed the case (I know
> that was what I was expecting). So I was wondering if we should not change
> this logic in git push instead.

If somebody can easily misunderstand how "push" makes decision about
"triangular" (I presume builtin/push.c::is_workflow_triangular() is
where that happens?) and changes what gets pushed and to where based
on it, and writes a logic that is different when reporting what
would happen when it is pushed out, there probably is a value in
documenting the subtlety in a separate patch, just like you did in
the follow-up fix below.

As long as the fixed-up version is correct or is easily made more
correct, that is.  If the direction the initial patch tried to go
was completely wrong and the follow-up needs to take a totally
different approach, then it may be worth replacing wholesale.

I am not getting an impression that the overall direction was
wrong, though.

> diff --git a/remote.c b/remote.c
> index 7c99469598..18a190198a 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -1636,9 +1636,12 @@ static const char *tracking_for_push_dest(struct remote *remote,
>  
>  static int is_workflow_triangular(struct branch *branch)
>  {
> -	struct remote *fetch_remote = remote_get(remote_for_branch(branch, NULL));
> -	struct remote *push_remote = remote_get(pushremote_for_branch(branch, NULL));
> -	return (fetch_remote && push_remote && fetch_remote != push_remote);
> +	int explicit;
> +	struct remote *fetch_remote = remote_get(remote_for_branch(branch, &explicit));
> +	if (!explicit || !fetch_remote)
> +		return 0;
> +	struct remote *push_remote = remote_get(pushremote_for_branch(branch, &explicit));
> +	return (explicit && push_remote && fetch_remote != push_remote);
>  }

There is -Wdecl-after-statement error in this function to be
corrected, but what the updated logic tries to do seems sensible,
that is

 - given the "branch" we receive, we ask what remote is associated
   with it, and if it is explicitly configured or just the fallback
   value.  If it is not configured, we declare the workflow is not
   triangular regardless of what pushremote is.

 - otherwise, i.e. when we do have an explicitly configured remote,
   we see what pushremote is configured for the branch.  If it is
   not configured, or is the same as the remote for fetching, it is
   not triangular.

Seeing the logic in builtin/push.c::is_workflow_triangular(), it is
implemented quite differently, but I suspect it largely is because
the actual logic "git push" uses can rely on the fact that it only
needs to deal with the current branch.  It does

        static int is_workflow_triangular(struct remote *remote)
        {
                struct remote *fetch_remote = remote_get(NULL);
                return (fetch_remote && fetch_remote != remote);
        }

where "remote" is given by the caller, which is trying to push to
the given "remote".  We need to make sure the logic they decide what
remote to push matches what you have above by checking what the
caller does, but assuming that the "remote" the caller gives is the
same as the push_remote you compute above, let's see if the
fetch_remote they get is the same as what you compute in fetch_remote.

They use remote.c::remote_get(NULL), which is a thin wrapper around
remote.c::remote_get_1() and uses remote.c::remote_for_branch() on
the current branch.  Whether branch.*.remote is configured or not,
what happens in remote_get_1() is mostly the same (it only affects
if the url alias processing is done, but the only thing the two
implementations of is_workflow_triangular() are interested in is the
identity of the struct remote, which is not affected).  The only
case, as far as I can see, when their fetch_remote is NULL is when
the remote they found did not have any URL for fetching (i.e. when
valid_remote() check fails, remote_get_1() returns NULL).  So, yes,
when we are not fetching from the remote, which would be pushed to
when on the branch, it is not triangular.  But in determining it,
they did not care if branch.*.remote is explicitly configured.

But your updated version cares.  Would that introduce behaviour
difference, or is it a safe difference that does not matter?

Now, where does the remote parameter in their implementation, which
corresponds to push_remote computed in your version, come from?  The
caller of is_workflow_triangular() gets it from its caller:

        static void setup_default_push_refspecs(struct remote *remote)
        {
                struct branch *branch = branch_get(NULL);
                int triangular = is_workflow_triangular(remote);

And its sole caller is builtin/push.c::do_push(), which in turn got
it from its caller builtin/push.c::cmd_push().

I think for the purposes of formatting %(push), we should behave as
if the branch we are formatting it for is the current branch and our
"git push" does not say "where to", so what we want to see is what
their version does where "git push" with no other arguments pushes
to the current branch.  cmd_push() asks remote.c::pushremote_get(NULL)
and let remote_get_1() to use the "current_branch", but our code
cannot afford to rely on that.  We need to tell what branch we are
interested in instead.

Yours ask pushremote_for_branch() on the branch to obtain a remote,
and then feed it to remote_get().  That's quite the same as what
happens in the earlier part of remote_get_1().  One thing I notice
is that pushremote_for_branch() depends on remote.c::pushremote_name
file-scope static variable correctly read, but that is done at an
early part of remote_get_1() by calling read_config(), so I think
you are getting the same remote as do_push() is getting.

But I do not see why the explicit bit matters here.  Wasn't the goal
to replicate what "git push" would do?  Or is there anything more
subtle going on?

Puzzled.  

With the attached stripped-down configuration in a test repository,
running "git push" while on 'master' seems to think the workflow is
triangular, as builtin/push.c::is_workflow_triangular() sees
remote->name == "publish" and fetch_remote->name == "origin" (it is
easy to see that in a debugger).

If you drop remote.origin.url from the configuration and run the
same experiment, fetch_remote will be NULL, as valid_remote() check
in remote_get_1() declares that the remote "origin", which is
created by default, is invalid without any URL.

So, are you sure that "lack of branch.*.remote makes the workflow
triangular in push but not your %(push)" is correct?  Is there
something else going on?

Thanks.

---- ---- ---- ---- ---- ---- ---- ---- ---- ---- 
[branch "master"]
	pushremote = publish

[remote "publish"]
	url = .

[remote "origin"]
	url = ../somewhere-else
---- ---- ---- ---- ---- ---- ---- ---- ---- ---- 
