From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 4/8] bash: Add space after unique command name is completed.
Date: Sun, 04 Feb 2007 00:08:38 -0800
Message-ID: <7vr6t6xs3d.fsf@assigned-by-dhcp.cox.net>
References: <20070204073827.GD17603@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Feb 04 09:08:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDcQd-0003PD-AQ
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 09:08:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752159AbXBDIIk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Feb 2007 03:08:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752161AbXBDIIk
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Feb 2007 03:08:40 -0500
Received: from fed1rmmtai20.cox.net ([68.230.241.39]:58126 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752159AbXBDIIj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Feb 2007 03:08:39 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070204080840.LSDN1306.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Sun, 4 Feb 2007 03:08:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id KL8e1W00E1kojtg0000000; Sun, 04 Feb 2007 03:08:39 -0500
In-Reply-To: <20070204073827.GD17603@spearce.org> (Shawn O. Pearce's message
	of "Sun, 4 Feb 2007 02:38:27 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38665>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> +__gitcomp ()
> +{
> +	local all c s=$'\n' IFS=' '$'\t'$'\n'
> +	for c in $1; do
> +		case "$c" in
> +		--*=*) all="$all$c$s" ;;
> +		*)     all="$all$c $s" ;;
> +		esac
> +	done
> +	IFS=$s
> +	COMPREPLY=($(compgen -W "$all" -- "${COMP_WORDS[COMP_CWORD]}"))
> +	return
> +}
> +

I do not understand what is going on here.  Care to explain?

 (1) "for c in $1": because $1 is not dquoted, it is split into
     word with IFS -- which IFS applies to this splitting?  The
     local one you hand-define to the typical " \t\n" value?

 (2) when this function returns, what IFS value does the caller
     would have?  Is the "local" used to avoid screwing up the
     caller?
