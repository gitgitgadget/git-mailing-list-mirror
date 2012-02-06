From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] commit: introduce a config key to allow as-is commit
 with i-t-a entries
Date: Mon, 06 Feb 2012 11:50:41 -0800
Message-ID: <7vhaz37nce.fsf@alter.siamese.dyndns.org>
References: <1328525855-2547-1-git-send-email-pclouds@gmail.com>
 <1328525855-2547-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 06 20:50:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuUaT-0008I2-7L
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 20:50:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754541Ab2BFTup convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Feb 2012 14:50:45 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49879 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753145Ab2BFTuo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Feb 2012 14:50:44 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AD60366D2;
	Mon,  6 Feb 2012 14:50:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=rOjNwZQOE+nn
	wV0RRtcqRG+AiEI=; b=jP+TFKlLy4qU40oI1HJAaMqKtBnJx6dmk3CrWdVfTlMz
	IJfdGABkVggG0zG3CpAUkKfoZQw3/44S7TcgWQAyY3bz4iDPScZoLh9w6JEboyHd
	LVTY4nFhynX+o86G34tJjnOuQNs1eV25qbI5N/Sk2Ce+miCl6KD8DbZMLs2MIHE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=xWOwnv
	lvyuy2nCrGgftSNzoeA1+ol5T3z5vFl/6ix8vn2kPU5l7ZK+Rj606W0OIOHEpGUy
	9z17JdBSCgFoA3xuWlccceruTzyX6ECr7dSbcG8eGxk8QV5pMvepVLG2uKUchOWU
	PDATV+bkwQvc9Nf42jxQw2hhJE302TTQNVtkE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A42C666CD;
	Mon,  6 Feb 2012 14:50:43 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0DEFD66CB; Mon,  6 Feb 2012
 14:50:42 -0500 (EST)
In-Reply-To: <1328525855-2547-3-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 6 Feb
 2012 17:57:33 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DA804D00-50FB-11E1-92E9-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190090>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> +commit.ignoreIntentToAdd::
> +	Allow to commit the index as-is even if there are
> +	intent-to-add entries (see option `-N` in linkgit:git-add[1])
> +	in index. Set to `false` to disallow commit in this acase, or `true=
`
> +	to allow it.
> ++
> +By default, `git commit` refuses to commit as-is when you have inten=
t-to-add
> +entries. This will change in 1.8.0, where `git commit` allows it. If=
 you
> +prefer current behavior, please set it to `false`.

s/acase/case/;

More importantly, if we allow it, what would be included and what would=
 be
omitted from the final commit?  What happens if we allow it is much mor=
e
important information than "we allow it even if there are".

	When set to `true`, prevent `git commit` from creating a commit
	from an index that has entries that were added with `git add -N`
	but have not been updated with real contents, as the user may have
	forgotten to tell the final contents for these entries.  Setting
	this to `false` makes `git commit` pretend as if these entries do
	not exist in the index.

	The default for this variable is `false`, but it will change to
	`true` in later releases of git (perhaps 1.8.0). To ease the
	transition, you may want to set it to `true` now and get used to
	the new behaviour early, or you may want to set it to `false` to
	keep the old behaviour a bit longer. We however expect to support
	setting this to `false` (to keep the current behaviour) only for a
	limited time after the default is changed to `true`.

Now, I removed the "intent to add" jargon from the above paragraph, the
description below can lose it as well.

> diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
> index 9c1d395..ec548ea 100644
> --- a/Documentation/git-add.txt
> +++ b/Documentation/git-add.txt
> @@ -123,8 +123,16 @@ subdirectories.
>  	Record only the fact that the path will be added later. An entry
>  	for the path is placed in the index with no content. This is
>  	useful for, among other things, showing the unstaged content of
> -	such files with `git diff` and committing them with `git commit
> -	-a`.
> +	such files with `git diff`.
> ++
> +Paths added with this option have intent-to-add flag in index. The
> +flag is removed once real content is added or updated. By default yo=
u
> +cannot commit the index as-is from until this flag is removed from a=
ll
> +entries (i.e. all entries have real content). See commit.ignoreInten=
tToAdd
> +regardless the flag.

I cannot understand "regardlessthe flag" in the last sentence.

> ++
> +Committing with `git commit -a` or with selected paths works
> +regardless the config key and the flag.

Just an aside, not suggesting to change anything to the final text.

This is interesting in that the reason why "selected paths" works is a =
bit
subtle.  You may have entries added with `-N` that are covered by the
pathspec, and those that are not covered by the pathspec.  For the form=
er
(i.e. those the user said "I'll decide the final contents later" but ar=
e
covered by pathspec), the user is telling the final contents to be in t=
he
commit, so we know the final contents for them.  For the latter (i.e.
those outside the pathspec), they are excluded and made to match the
version in the HEAD commit, so we know the final contents for them, too=
=2E

> +			if (i < active_nr)
> +				warning(_("You are committing as-is with intent-to-add entries a=
s the result of\n"
> +					  "\"git add -N\". Git currently forbids this case.

Can we phrase this a bit better?

It is not like "forbids", but is "giving up because you didn't tell me
what content to include in the commit, even though you said you will te=
ll
me later".
