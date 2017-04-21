Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 312FD207BD
	for <e@80x24.org>; Fri, 21 Apr 2017 03:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034959AbdDUDdP (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 23:33:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65503 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1034929AbdDUDdP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 23:33:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4743D7CA0A;
        Thu, 20 Apr 2017 23:33:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=oTxRKKhQDW0y
        hn+DjnDo8z9xvyI=; b=rQFB+SpnG5oKjjkbLyW++BiWLKMgpVfFJrMh4rGJyRcN
        9TWGqeVTuIjWI1YvO5PWWn/X1KpOLHOzd9AFZbAz6GQpBcrSx7+tKuIo5hFUfK8I
        HGkR8DGuU/lXy98AI6Vn+ZiwRD1dqR6WOfPio2F/R5UVlhC/3NFfjtIBh4ZWhuE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=j5TU8g
        IcZwsdCelgRnJaDOttlUaVkzRozC/aB0pE2oTNt6z9gB/bF8jpcw3ms8URaM9jxg
        fRjafpDgym1bUP+lGZarByjoz1vbGHzXWBvJGoQ3J4uYmgbmxHaJrfQs8Gecu5zD
        /Hmd8kJUO8b4XIyTeiRu2g6qx4o/bbxoi4VgU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3FD9D7CA09;
        Thu, 20 Apr 2017 23:33:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A11667CA08;
        Thu, 20 Apr 2017 23:33:12 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 6/6] worktree remove: new command
References: <20170420101024.7593-1-pclouds@gmail.com>
        <20170420101024.7593-7-pclouds@gmail.com>
Date:   Thu, 20 Apr 2017 20:33:11 -0700
In-Reply-To: <20170420101024.7593-7-pclouds@gmail.com> (=?utf-8?B?Ik5ndXk=?=
 =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?=
        Duy"'s message of "Thu, 20 Apr 2017 17:10:24 +0700")
Message-ID: <xmqqo9vq5tag.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3F6B17B4-2643-11E7-98B1-E680B56B9B0B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> +	worktrees =3D get_worktrees(0);
> +	wt =3D find_worktree(worktrees, prefix, av[0]);
> +	if (!wt)
> +		die(_("'%s' is not a working directory"), av[0]);
> +	if (is_main_worktree(wt))
> +		die(_("'%s' is a main working directory"), av[0]);

The same comment as 3/6 applies here.

> +	reason =3D is_worktree_locked(wt);
> +	if (reason) {
> +		if (*reason)
> +			die(_("already locked, reason: %s"), reason);
> +		die(_("already locked, no reason"));
> +	}

The same comment as 3/6 applies here, too.

This is shared with 3/6 but I wonder if "--force" should be usable
as a way to bust this refusal.  There is an "unlock" operation, so
probably such a short-cut is not necessary---if you want to repair
your repository by moving or removing a working tree and if you
cannot do so due to an outstanding lock, you can do a two-step dance
"unlock followed by move or remove".  So I am OK with "--force" that
does not bust the lock.

> +	if (validate_worktree(wt, 0))
> +		return -1;
> +
> +	if (!force) {
> +		struct argv_array child_env =3D ARGV_ARRAY_INIT;
> +		struct child_process cp;
> +		char buf[1];
> +
> +		argv_array_pushf(&child_env, "%s=3D%s/.git",
> +				 GIT_DIR_ENVIRONMENT, wt->path);
> +		argv_array_pushf(&child_env, "%s=3D%s",
> +				 GIT_WORK_TREE_ENVIRONMENT, wt->path);
> +		memset(&cp, 0, sizeof(cp));
> +		argv_array_pushl(&cp.args, "status", "--porcelain", NULL);
> +		cp.env =3D child_env.argv;
> +		cp.git_cmd =3D 1;
> +		cp.dir =3D wt->path;
> +		cp.out =3D -1;
> +		ret =3D start_command(&cp);
> +		if (ret)
> +			die_errno(_("failed to run git-status on '%s', code %d"),
> +				  av[0], ret);

Do we return "code" from start_command() that is usable like this?

Is this "git status --porcelain" call affected by settings like
"submodule.*.ignore"?  If so, is that a good thing?

Oh, submodules.  Unlike "move" that may make their .git files
pointing at strange places after the operation finishes, "remove"
does not have to worry about them, because they are going to
disappear--I think that is OK, but I could be missing some cases
where a working tree that is not dirty may still want to be kept.
I dunno.

> +		ret =3D xread(cp.out, buf, sizeof(buf));
> +		if (ret)
> +			die(_("'%s' is dirty, use --force to delete it"), av[0]);
> +		close(cp.out);
> +		ret =3D finish_command(&cp);
> +		if (ret)
> +			die_errno(_("failed to run git-status on '%s', code %d"),
> +				  av[0], ret);
> +	}
> +	strbuf_addstr(&sb, wt->path);
> +	if (remove_dir_recursively(&sb, 0)) {

Oh, submodules.  If this working tree has submodules that are not
yet absorbed, wouldn't this go into their ".git" recursively and
end up losing everything?

> +		error_errno(_("failed to delete '%s'"), sb.buf);
> +		ret =3D -1;
> +	}
> +	strbuf_reset(&sb);
> +	strbuf_addstr(&sb, git_common_path("worktrees/%s", wt->id));
> +	if (remove_dir_recursively(&sb, 0)) {
> +		error_errno(_("failed to delete '%s'"), sb.buf);
> +		ret =3D -1;
> +	}
