From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] Teach "-m <msg>" and "-F <file>" to "git notes
 edit"
Date: Tue, 21 Apr 2009 02:53:30 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904210251220.10279@pacific.mpi-cbg.de>
References: <200904210239.21974.johan@herland.net> <200904210242.16050.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Apr 21 02:53:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lw4Ea-0004ea-BT
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 02:53:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754739AbZDUAvn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 20:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754699AbZDUAvn
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 20:51:43 -0400
Received: from mail.gmx.net ([213.165.64.20]:55940 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752603AbZDUAvm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 20:51:42 -0400
Received: (qmail invoked by alias); 21 Apr 2009 00:51:40 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp023) with SMTP; 21 Apr 2009 02:51:40 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/lhbZBKx7lDbvn6rmVuiTd1+iVH7TmJBDLU36snz
	oOilhsTChX/hrp
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <200904210242.16050.johan@herland.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117057>

Hi,

On Tue, 21 Apr 2009, Johan Herland wrote:

> The "-m" and "-F" options are already the established method
> (in both git-commit and git-tag) to specify a commit/tag message
> without invoking the editor. This patch teaches "git notes edit"
> to respect the same options for specifying a notes message without
> invoking the editor.
> 
> The patch also updates the "git notes" documentation and adds a
> couple of selftests for the new functionality.
> 
> Signed-off-by: Johan Herland <johan@herland.net>
> ---

Nice!

> +MESSAGE=
> +while test $# != 0
> +do
> +	case "$1" in
> +	-m)
> +		test "$ACTION" = "edit" || usage
> +		shift
> +		if test "$#" = "0"; then
> +			die "error: option -m needs an argument"
> +		else
> +			MESSAGE="$1"
> +			shift
> +		fi
> +		;;
> +	-F)
> +		test "$ACTION" = "edit" || usage
> +		shift
> +		if test "$#" = "0"; then
> +			die "error: option -F needs an argument"
> +		else
> +			MESSAGE="$(cat "$1")"
> +			shift
> +		fi
> +		;;
> +	-*)
> +		usage
> +		;;
> +	*)
> +		break
> +		;;
> +	esac
> +done

Well, either you forbid multiple -F/-m options, or you merge the messages, 
right?  AFAIR 'git commit -m A -m B' combines 'A' and 'B'...

> +	if [ -n "$MESSAGE" ]; then

Here's a chance for me to learn: I was under the impression that "! -z" is 
more portable than "-n".  Am I completely off the track?

Ciao,
Dscho
