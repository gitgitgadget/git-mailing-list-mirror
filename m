From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] 'add -u' doesn't work from untracked subdir
Date: Thu, 10 Sep 2009 12:53:40 -0700
Message-ID: <7vmy527f0b.fsf@alter.siamese.dyndns.org>
References: <20090902080305.GA11549@neumann>
 <20090902081917.GA5447@coredump.intra.peff.net>
 <20090904070216.GA3996@darc.dnsalias.org>
 <20090905061804.GB29863@coredump.intra.peff.net>
 <7v8wgt98ms.fsf@alter.siamese.dyndns.org>
 <20090905072017.GA5152@coredump.intra.peff.net>
 <7v3a717rgl.fsf@alter.siamese.dyndns.org>
 <20090905080249.GA8801@coredump.intra.peff.net>
 <7vy6ot4x61.fsf@alter.siamese.dyndns.org>
 <20090910084653.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Clemens Buchacher <drizzd@aon.at>,
	SZEDER Gbor <szeder@ira.uka.de>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Thu Sep 10 21:54:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlpiV-0008Gz-8I
	for gcvg-git-2@lo.gmane.org; Thu, 10 Sep 2009 21:54:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753334AbZIJTxy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2009 15:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753185AbZIJTxy
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Sep 2009 15:53:54 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:62605 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753134AbZIJTxx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2009 15:53:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C27C2DF96;
	Thu, 10 Sep 2009 15:53:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=hzVs3ESe4nuoscDqrJX5Kq//wTA=; b=oSqB40zzTVb/t+L0dP2WZnO
	iOx6j9qaiSWUzrcCdwHGI/ALfFPZgJF1bD7egKKjX6btzHqHZg1e3hweDfa9opf2
	9QqWYBaYC79NhxD9PJH9sh80qmHGb5DcUywfNlDhw+VFUkdjuxuM/F1Z4GISHEM/
	MjojVfqanTRm1EEvx0bo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=X6BGcPPQ5ug+pm2q1LRYrDWJo3c50pZqIjE1dHLPvfOC428Fs
	SWTJKj1zTFcA9QwpodlNydxAaQMbP3gmp63eRotC+KqNThuy/rBETU88KwvGPHaR
	dveC4YbFEieBKnEbyJJzHRiN21Y6OH/zpdOGLN7GUVOVdi1rz7X94VjJ/0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BB9292DF95;
	Thu, 10 Sep 2009 15:53:49 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7E0822DF8A; Thu, 10 Sep
 2009 15:53:41 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A8AA0D38-9E43-11DE-9527-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128138>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Quoting Junio C Hamano <gitster@pobox.com>
>
>> We could probably declare "In 1.X.0 everything will be relative to the
>> root and you have to give an explicit '.' if you mean the cwd".
>>
>> Three questions:
>>
>>  #1 What are the commands that will be affected, other than "add -u" and
>>     "grep"?  Are there others?
>>
>>  #2 Do all the commands in the answer to #1 currently behave exactly the
>>     same when run without any path parameter and when run with a single
>>     '.'?
>
> 'git-archive' behaves relative to your current directory.
>
>   http://thread.gmane.org/gmane.comp.version-control.git/41300/focus=44125
>
> You can limit it to the current directory with a dot.

Thanks.

If you want to make a tarball of the Documentation directory from your
work tree, you do this:

    $ cd Documentation
    $ tar cf - . >/tmp/docs.tar

If you want to do the same but from your committed content, you do this:

    $ cd Documentation
    $ git archive HEAD >/tmp/docs.tar

and you do not have to say:

    $ cd Documentation
    $ git archive HEAD . >/tmp/docs.tar

So in that sense it does make sense to archive the current directory.  It
matches what the users expect from their archivers.

The traditional archivers may not default to "." but we do.  That is about
giving a sensible default [*1*].  Perhaps defaulting to the cwd behaviour
for one command may seem a sensible thing when looking at that particular
command alone; archive and grep fall into that category.

But as this "add -u" discussion showed us [*2*], people may expect
different "sensible default", and as a suite of commands as the whole, it
becomes messy.  People have to remember which ones obey cwd, and to some
people the choice is not intuitive.

To avoid confusion, I am beginning to agree with people who said in the
thread that it is a good idea to consistently default to the root of the
contents.  When we use "everything" as the default due to lack of command
line pathspec, we would use "everything from root" no matter where you
are, regardless of what command we are talking about.  That would make the
rule easier to remember [*3*].

This changes the way how "git (add -u|grep|clean|archive)" without
pathspec and "git (add -u|grep|clean|archive) ." with an explicit dot
work.  The former (adds all changed files in, finds hits in, removes
untracked paths in, creates a tarball for) the whole tree, while the
latter limits the operation explicitly to the current directory.

If this were going to happen as a list concensus, I am very tempted to
suggest that we at least _consider_ applying the same rule even to
ls-files and ls-tree.  That would impact scripts, so we need to be extra
careful, though.

Also this takes us to a tangent.

If we try to give a sensible default to make it easier for the user,
perhaps we should also default to HEAD when the user did not specify which
tree-ish to archive from.  This is a topic in a separate thread.

[Footnote]

*1* Actually we don't allow "git archive HEAD ..", which I think is a
bug.  Also we do not have --full-tree workaround, which makes it slightly
cumbersome to use.

*2* And the thread you quoted shows us that the argument applies equally
to "git archive" as well; you see me complaining that it is unintuitive
for me to care about "archive", and the counterargument was that ls-tree
does so.  I however think it is more important for archive to behave in a
way that is easier for the users to understand, than mimick the historical
mistake in a plumbing command.

*3* Command line pathspec of course should honor cwd as before.  When you
say "git distim Makefile" inside t/ directory, we distim t/Makefile, not
the toplevel Makefile.  This discussion is only about the case where the
user didn't give us any pathspec.
