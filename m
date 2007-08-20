From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] A more sensible error message why 'git rebase --continue' failed
Date: Sun, 19 Aug 2007 23:25:45 -0700
Message-ID: <7vzm0m90ye.fsf@gitster.siamese.dyndns.org>
References: <11875724181583-git-send-email-evan@fallingsnow.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Evan Phoenix <evan@fallingsnow.net>
X-From: git-owner@vger.kernel.org Mon Aug 20 08:26:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IN0iN-0001BS-RI
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 08:26:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948AbXHTGZv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 02:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750871AbXHTGZv
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 02:25:51 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:54100 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750877AbXHTGZu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 02:25:50 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 8EC75123238;
	Mon, 20 Aug 2007 02:26:09 -0400 (EDT)
In-Reply-To: <11875724181583-git-send-email-evan@fallingsnow.net> (Evan
	Phoenix's message of "Sun, 19 Aug 2007 18:13:38 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56176>

Evan Phoenix <evan@fallingsnow.net> writes:

> The current message is a bit cryptic, indicating that only
> changes which contained merge conflicts should be added to the
> index, but in fact, all outstanding changes must be.

That might be true, and we might want a better yet still concise
wording for the suggestion.


Your wording, however, would lead a new user to run "git add"
even before resolving the conflicts, and then make him complain
"why doesn't git do that for me", and then again complain "gaah,
I followed the suggestion and ended up committing garbage with
funny <<< === >>> lines in it".

So in that sense, I do not necessarily see _your_ new wording an
improvement.

> @@ -135,8 +135,12 @@ do
>  	case "$1" in
>  	--continue)
>  		git diff-files --quiet || {
> -			echo "You must edit all merge conflicts and then"
> -			echo "mark them as resolved using git add"
> +                        echo "Unable to continue rebase:"
> +                        echo "  All modified files must be added to index first."

Also I see whitespace breackages here --- did you intend to
replace tabs with spaces, and if so why?
