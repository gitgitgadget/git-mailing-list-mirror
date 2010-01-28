From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] bash: support 'git notes' and its subcommands
Date: Thu, 28 Jan 2010 02:23:35 +0100
Message-ID: <201001280223.35625.johan@herland.net>
References: <1264640755-22447-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>
To: SZEDER =?utf-8?q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Jan 28 02:23:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaJ6k-0001WK-Ub
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jan 2010 02:23:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755829Ab0A1BXi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Jan 2010 20:23:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754429Ab0A1BXi
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 20:23:38 -0500
Received: from smtp.getmail.no ([84.208.15.66]:61379 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754587Ab0A1BXh convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2010 20:23:37 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWX005B4NVCNGC0@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 28 Jan 2010 02:23:36 +0100 (MET)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWX00AKENVBNP30@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 28 Jan 2010 02:23:36 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.1.28.11217
User-Agent: KMail/1.12.4 (Linux/2.6.32-ARCH; KDE/4.3.4; x86_64; ; )
In-reply-to: <1264640755-22447-1-git-send-email-szeder@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138217>

On Thursday 28 January 2010, SZEDER G=C3=A1bor wrote:
> ... and it will offer refs unless after -m or -F, because these two
> options require a non-ref argument.

Maybe-NAK.

The patch is probably good in itself, and the intent is certainly good,=
 but=20
we're currently discussing deprecating the -m/-F options to "git notes =
edit"=20
(see http://article.gmane.org/gmane.comp.version-control.git/138215), a=
nd if=20
that's where we go, there's no point "encouraging" their use by adding =
bash-
completions for them...


=2E..Johan

>=20
> Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
> ---
>  contrib/completion/git-completion.bash |   19 +++++++++++++++++++
>  1 files changed, 19 insertions(+), 0 deletions(-)
>=20
> diff --git a/contrib/completion/git-completion.bash
>  b/contrib/completion/git-completion.bash index 9651720..8b56c34 1007=
55
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1306,6 +1306,24 @@ _git_name_rev ()
>  	__gitcomp "--tags --all --stdin"
>  }
>=20
> +_git_notes ()
> +{
> +	local subcommands=3D"edit show"
> +	if [ -z "$(__git_find_on_cmdline "$subcommands")" ]; then
> +		__gitcomp "$subcommands"
> +		return
> +	fi
> +
> +	case "${COMP_WORDS[COMP_CWORD-1]}" in
> +	-m|-F)
> +		COMPREPLY=3D()
> +		;;
> +	*)
> +		__gitcomp "$(__git_refs)"
> +		;;
> +	esac
> +}
> +
>  _git_pull ()
>  {
>  	__git_complete_strategy && return
> @@ -2218,6 +2236,7 @@ _git ()
>  	merge-base)  _git_merge_base ;;
>  	mv)          _git_mv ;;
>  	name-rev)    _git_name_rev ;;
> +	notes)       _git_notes ;;
>  	pull)        _git_pull ;;
>  	push)        _git_push ;;
>  	rebase)      _git_rebase ;;
>=20


--=20
Johan Herland, <johan@herland.net>
www.herland.net
