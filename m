From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Sep 2011, #06; Wed, 21)
Date: Fri, 23 Sep 2011 11:00:26 -0700
Message-ID: <7vvcsjuojp.fsf@alter.siamese.dyndns.org>
References: <7vaa9xyxpf.fsf@alter.siamese.dyndns.org>
 <CAP2yMaL3rewYZSXQFxkSLkiNbaBAP8r707x2dScVK1zeVr8hXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 23 20:00:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7A38-0008K7-VR
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 20:00:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776Ab1IWSAa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Sep 2011 14:00:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51594 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750717Ab1IWSA3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2011 14:00:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BA0966296;
	Fri, 23 Sep 2011 14:00:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=B5PMbzbX/8v9lSliHnaC2d3M6Tw=; b=ug8s97
	typAMnGHMoN4bZ8VhaoRhnNnyf9h0bjmTHfBzDV8V421qegFVi0QtLzJYo5bnnWR
	fm+U/ne279FXEvjMKZxxVxKFQP0dvo3iPGCoIkcggH5S106y2HJfBDyfeeQ0KakD
	SoEn2HydNvPhAverndkuwbx0wxm1ke60Y3WIA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PN/pABFsbTkthPpyuU66byPxDiz8wkk/
	vu+OD8b4j4oKuLlURxq/0NBxlltvRez7aCBxFeLQXCK/qVsNAEcFKWgL7QDs65L1
	7bK1cBPMdV5qyh/K9Dx508NfguPIhL/YSzPkwjY+ktMrISz+8kEl9IwFe5YzvcUm
	/2Ld2I4Xtxs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B267E6295;
	Fri, 23 Sep 2011 14:00:28 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1A3906294; Fri, 23 Sep 2011
 14:00:28 -0400 (EDT)
In-Reply-To: <CAP2yMaL3rewYZSXQFxkSLkiNbaBAP8r707x2dScVK1zeVr8hXQ@mail.gmail.com> (Scott
 Chacon's message of "Fri, 23 Sep 2011 07:44:13 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EB810F58-E60D-11E0-BE04-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181981>

Scott Chacon <schacon@gmail.com> writes:

> It appears that you're no longer pushing the 'html' branch to the
> GitHub repo,...

It is not even "no longer".

Unlike the other public mirrors that are designed to mimic what my
repository at k.org looks like, https://github.com/gitster/git is
primarily meant to mirror my internal development repository, with the
full set of topic branches.

As I do not have 'html' as a branch in my development repository, the
result "git push --mirror" there never had refs/heads/html, either.

My workflow used to be:

 - push 4 integration branches from the development repository to k.org,
   and have its update hook update html and man branches there;
 - optionally push todo from a different private repository to k.org;
 - fetch back refs/heads/* from k.org to refs/remotes/ko/*;
 - verify that my refs/heads/* and refs/remotes/ko/* match for 4 integration
   branches;
 - push stuff under refs/remotes/ko/* to public mirrors (sourceforge does
   not get next and pu);
 - push --mirror to https://github.com/gitster/git.

Now the interim workflow, until k.org comes back, is tentatively:

 - in a separate local "formatting" repository, pull 'master' from my
   development repository, build html and man there, and push them back
   to refs/docs/{html,man} to my development repository;
 - push refs/heads/{master,maint,next,pu} and refs/docs/{html,man} to
   public mirrors (sourceforge does not get next and pu);
 - push --mirror to https://github.com/gitster/git.

I am hoping that I do not have to keep doing this and refs/docs/ can
eventually go away. I specifically do _not_ want the administrative
non-source branches html/man/todo to be my local branches.

> Since the k.org hosting of the man pages is down, I was working on
> putting them on git-scm.com, where you could select which version of
> the docs you want to see and could search through them and whatnot.

What is the expected the end-user page-flow?

Would people come to https://github.com/gitster/git first, find "doc" link
there, and start browsing the html version of the documentation?

Or do people come to http://github.com/, find a link "documentation for
the scm this site supports", your machinery kicks in and serves the blobs
from https://github.com/gitster/git under the hood, without letting users
know where the pages they are looking at really come from?

What I am getting at is that if these users do not need to know about my
repository, then you do not _need_ to see html branch in my repository,
either. You only need to find it _somewhere_, and that somewhere does not
have to be https://github.com/gitster/git repository.

You may think you could use refs/docs/html but I would rather want to
avoid letting you guys rely on refs/docs/ I started using just a few days
ago as an interim measure. I may later change my mind and get rid of that
from my development repository, but that would break your machinery to
show preformatted documentation pages.

I could add a _separate_ repository at github, and treat it just like
other public mirrors like repo.or.cz, so that you can find html branch
there. That would be consistent with my wish to use "push --mirror" to at
least one place (https://github.com/gitster/git), and would be easier to
manage for me.

Would that work?
