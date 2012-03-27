From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Definition of working directory
Date: Tue, 27 Mar 2012 10:10:01 -0700
Message-ID: <7vd37yj7h2.fsf@alter.siamese.dyndns.org>
References: <BLU0-SMTP1958653CC391F120060F8B6B14A0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Anjib Mulepati <anjibcs@hotmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 27 19:10:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCZuO-00005v-Pk
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 19:10:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755131Ab2C0RKG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 13:10:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47494 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754935Ab2C0RKF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 13:10:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CB3A158F5;
	Tue, 27 Mar 2012 13:10:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MKLHKayJYD6iVssgd4pL0RbpFWo=; b=dJcpt1
	suBZFHA6bsJ3clt272hFaoBavHYJiI+oEzcxeniFprY2tHPkzDfuumf1gQzIcPUI
	dO0k0oewV3BqX1r9jYWKdnPtsE80XD63l4IhgEeNfaEsVuMg1ODw1+qaSNUrR2CS
	eYFwMEqsbkKdVtYIb1WJYhEkxm8YgGYSAtMkE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BSOe2Oc6Al4j5QP+Vb6FgNRVdUp4Db+O
	7QToTCpyStqmaq4SErOrhDp3twYNMvizsggQdxQIjyTtsrS7jtIKZ6/sm+ZhEwOZ
	iKgUOzRZmyWXj2kba8RbLf167KPLFvftDf4NFZ91TyXxDHnGbm7doWDYNvR043EN
	7ukJ1zi0yp8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C36D058F4;
	Tue, 27 Mar 2012 13:10:04 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4226958F1; Tue, 27 Mar 2012
 13:10:03 -0400 (EDT)
In-Reply-To: <BLU0-SMTP1958653CC391F120060F8B6B14A0@phx.gbl> (Anjib
 Mulepati's message of "Tue, 27 Mar 2012 12:12:45 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B1652D54-782F-11E1-B0DC-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194058>

Anjib Mulepati <anjibcs@hotmail.com> writes:

> I was reading Git Community Book and came across following definition
> for working directory
>
> The Working Directory
>
> The Git 'working directory' is the directory that holds the current
> checkout of the files you are working on. Files in this directory are
> often removed or replaced by Git as you switch branches - this is
> normal. All your history is stored in the Git Directory; the working
> directory is simply a temporary checkout place where you can modify
> the files until your next commit.
>
> What does it mean by this " Files in this directory are often removed
> or replaced by Git as you switch branches"?

I think the common terminology for the concept the above describes is "the
working tree".

> And does working directory is just a directory we get with $pwd ?

After you clone, you have one directory that contains all the files from
one specific version in it.  The files may be organized into directory
hierarchy, but there is a single top-level directory.

That is the "working tree".  When we want to be absolutely clear, we may
even say "the top of the working tree", even though it may be redundant.

If you are at such a directory, $(pwd) may match it.  If you chdir to a
subdirectory from there, e.g. "cd Documentation", $(pwd) and the top of
the working tree will of course disagree.

The files checked out in the working tree represent the contents of the
version that was checked out, plus modifications you make locally.  When
you check out a different branch (people coming from svn background may
say "switch branch", but it is the same thing), the working tree will need
to represent the contents of the version at the tip of that different
branch.  If you have a file in the current branch but not in that
different branch you are checking out, that file has to go away.  If you
do not have a file in the current branch but not in that different branch
you are checking out, that file needs to be created in the working tree.
If the contents of a file is different between your current branch and the
branch you are checking out, the file in the working tree needs to be
updated to match that of the branch you are checking out. That is what the
"... are often removed or replaced" part is talking about.
