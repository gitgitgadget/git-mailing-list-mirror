From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 6/6] Documentation: Describe 'submodule update' modes in detail
Date: Thu, 16 Jan 2014 12:21:04 -0800
Message-ID: <xmqqeh47znin.fsf@gitster.dls.corp.google.com>
References: <20140114224246.GA13271@book.hvoigt.net>
	<4a8dca477ed5b190767d6a4619c593a83f86f082.1389837412.git.wking@tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>, Jens Lehmann <Jens.Lehmann@web.de>,
	Francesco Pretto <ceztko@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Thu Jan 16 21:21:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3tRC-0001SG-BE
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jan 2014 21:21:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751587AbaAPUVK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Jan 2014 15:21:10 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62016 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751574AbaAPUVI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Jan 2014 15:21:08 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 620B76209C;
	Thu, 16 Jan 2014 15:21:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Pq3RF4I7Ohf0
	5Phv2s/y2N/0eng=; b=PBmludzcwTEWAF7r8g5M/i6w04mxyza0YPvqsceIhd/R
	VZUQA/WSP1wmoT3wZMQzHGgrkLCwAWBcILbiRcjDqwC49e9kkg2lpj8zV62GqeBZ
	V3OaTKfejYg5vd0g0IT+oMuA7zUUUTwdd7vUeG4hr3qK6arG6vYUoG743Ronl3A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ICc2Gb
	+1xoPch9u1iTPZtUzauBLPXTUPStN2POoRPxQ8wEM2kqcLxwXhxtc/A+kUdA8iOe
	vTvmJuVruTW26ost+ZhpZpUyZOo4M2p/CAwaQVCi+hi7EabZM2SiWkOmaVAcVPGL
	AGJLu+yExpl72XtW3DSV1XYCL4iDtdEfUHJ2s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 501256209B;
	Thu, 16 Jan 2014 15:21:07 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6CE6E6209A;
	Thu, 16 Jan 2014 15:21:06 -0500 (EST)
In-Reply-To: <4a8dca477ed5b190767d6a4619c593a83f86f082.1389837412.git.wking@tremily.us>
	(W. Trevor King's message of "Wed, 15 Jan 2014 20:10:27 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BA9DBF34-7EEB-11E3-91FD-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240529>

"W. Trevor King" <wking@tremily.us> writes:

> The old documentation did not distinguish between cloning and
> non-cloning updates and lacked clarity on which operations would lead
> to detached HEADs, and which would not.  The new documentation
> addresses these issues while updating the docs to reflect the changes
> introduced by this branch's explicit local branch creation in
> module_clone.
>
> I also add '--checkout' to the usage summary and group the update-mod=
e
> options into a single set.
>
> Signed-off-by: W. Trevor King <wking@tremily.us>
> ---
>  Documentation/git-submodule.txt | 36 +++++++++++++++++++++++++++----=
-----
>  Documentation/gitmodules.txt    |  4 ++++
>  2 files changed, 31 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/git-submodule.txt b/Documentation/git-subm=
odule.txt
> index bfef8a0..02500b4 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -15,8 +15,8 @@ SYNOPSIS
>  'git submodule' [--quiet] init [--] [<path>...]
>  'git submodule' [--quiet] deinit [-f|--force] [--] <path>...
>  'git submodule' [--quiet] update [--init] [--remote] [-N|--no-fetch]
> -	      [-f|--force] [--rebase] [--reference <repository>] [--depth <=
depth>]
> -	      [--merge] [--recursive] [--] [<path>...]
> +	      [-f|--force] [--rebase|--merge|--checkout] [--reference <repo=
sitory>]
> +	      [--depth <depth>] [--recursive] [--] [<path>...]
>  'git submodule' [--quiet] summary [--cached|--files] [(-n|--summary-=
limit) <n>]
>  	      [commit] [--] [<path>...]
>  'git submodule' [--quiet] foreach [--recursive] <command>
> @@ -155,13 +155,31 @@ it contains local modifications.
> =20
>  update::
>  	Update the registered submodules, i.e. clone missing submodules and
> -	checkout the commit specified in the index of the containing reposi=
tory.
> -	This will make the submodules HEAD be detached unless `--rebase` or
> -	`--merge` is specified or the key `submodule.$name.update` is set t=
o
> -	`rebase`, `merge` or `none`. `none` can be overridden by specifying
> -	`--checkout`. Setting the key `submodule.$name.update` to `!command=
`
> -	will cause `command` to be run. `command` can be any arbitrary shel=
l
> -	command that takes a single argument, namely the sha1 to update to.
> +	checkout the commit specified in the index of the containing
> +	repository.  The update mode defaults to 'checkout', but be
> +	configured with the 'submodule.<name>.update' setting or the
> +	'--rebase', '--merge', or 'checkout' options.

Not '--checkout'?

Other than that, the updated text above is far easier to
understand.  Good job.

> ++
> +For updates that clone missing submodules, checkout-mode updates wil=
l
> +create submodules with detached HEADs; all other modes will create
> +submodules with a local branch named after 'submodule.<path>.branch'=
=2E
> ++
> +For updates that do not clone missing submodules, the submodule's HE=
AD

That is, updates that update submodules that are already checked out?

> +is only touched when the remote reference does not match the
> +submodule's HEAD (for none-mode updates, the submodule is never
> +touched).  The remote reference is usually the gitlinked commit from
> +the superproject's tree, but with '--remote' it is the upstream
> +subproject's 'submodule.<name>.branch'.  This remote reference is
> +integrated with the submodule's HEAD using the specified update mode=
=2E

I think copying some motivation from the log message of 06b1abb5
(submodule update: add --remote for submodule's upstream changes,
2012-12-19) would help the readers here.  A na=C3=AFve expectation from=
 a
casual reader of the above would be "The superproject's tree ought
to point at the same commit as the tip of the branch used in the
submodule (modulo mirroring delays and somesuch), if the repository
of the superproject and submodules are maintained properly", which
would lead to "when would any sane person need to use --remote in
the first place???".

If I am reading 06b1abb5 correctly, the primary motivation behind
"--remote" seems to be that it is exactly to help the person who
wants to update superproject to satisify the "... are maintained
properly" part by fetching the latest in each of the submodules in
his superproject in preparation to 'git add .' them.  I still do not
think "--remote" was a better way than the "foreach", but that is a
separate topic.

If the person who works in the superproject does not control the
progress of, and/or does not care what development is happening in,
the submodules, he can push the superproject tree out without even
bothering to update the commits in the submodules bound to his
superproject tree, and the consumers of such a superproject could
catch up with the advancement of submodule by using --remote
individually to bring themselves up to date.  But I do not think
that is what you envisioned as the best recommended practice when
you wrote 06b1abb5.

> +For checkout-mode updates, that will result in a detached HEAD.  For
> +rebase- and merge-mode updates, the commit referenced by the
> +submodule's HEAD may change, but the symbolic reference will remain
> +unchanged (i.e. checked-out branches will still be checked-out
> +branches, and detached HEADs will still be detached HEADs).  If none
> +of the builtin modes fit your needs, set 'submodule.<name>.update' t=
o
> +'!command' to configure a custom integration command.  'command' can
> +be any arbitrary shell command that takes a single argument, namely
> +the sha1 to update to.
>  +
>  If the submodule is not yet initialized, and you just want to use th=
e
>  setting as stored in .gitmodules, you can automatically initialize t=
he
> diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.=
txt
> index f7be93f..36e5447 100644
> --- a/Documentation/gitmodules.txt
> +++ b/Documentation/gitmodules.txt
> @@ -53,6 +53,10 @@ submodule.<name>.branch::
>  	A remote branch name for tracking updates in the upstream submodule=
=2E
>  	If the option is not specified, it defaults to 'master'.  See the
>  	`--remote` documentation in linkgit:git-submodule[1] for details.
> ++
> +This branch name is also used for the local branch created by
> +non-checkout cloning updates.  See the 'update' documentation in
> +linkgit:git-submodule[1] for details.
> =20
>  submodule.<name>.fetchRecurseSubmodules::
>  	This option can be used to control recursive fetching of this

Other than the above minor nits, the updated text was very
readable.  Thanks.
