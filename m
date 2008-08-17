From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Improve error output of git-rebase without any arguments
Date: Sat, 16 Aug 2008 19:37:19 -0700
Message-ID: <7v1w0ocqow.fsf@gitster.siamese.dyndns.org>
References: <1218932781-30475-1-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Sun Aug 17 04:40:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUYBt-00006M-Cp
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 04:40:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbYHQCh3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Aug 2008 22:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbYHQCh3
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Aug 2008 22:37:29 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48479 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751100AbYHQCh2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Aug 2008 22:37:28 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1CA1364245;
	Sat, 16 Aug 2008 22:37:24 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 7B53964244; Sat, 16 Aug 2008 22:37:21 -0400 (EDT)
In-Reply-To: <1218932781-30475-1-git-send-email-s-beyer@gmx.net> (Stephan
 Beyer's message of "Sun, 17 Aug 2008 02:26:21 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6C7238C0-6C05-11DD-928F-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92563>

Stephan Beyer <s-beyer@gmx.net> writes:

> 	Stumbled across this today and looks for me like
> 	a patch for 1.6.0 :-)

Is presense of "$dotest" or "$GIT_DIR/rebase-apply" a _sure sign_ that
allows you to say "A rebase is in progress" with confidence?

> diff --git a/git-rebase.sh b/git-rebase.sh
> index 412e135..fe669ad 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -146,6 +146,12 @@ is_interactive () {
>  
>  is_interactive "$@" && exec git-rebase--interactive "$@"
>  
> +if test $# -eq 0
> +then
> +	test -d "$dotest" -o -d "$GIT_DIR"/rebase-apply || usage
> +	die 'A rebase is in progress, try --continue, --skip or --abort.'
> +fi
> +
>  while test $# != 0
>  do
>  	case "$1" in
