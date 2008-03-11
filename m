From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/5] git-submodule summary: show commit summary
Date: Tue, 11 Mar 2008 00:28:25 -0700
Message-ID: <7vod9ld8iu.fsf@gitster.siamese.dyndns.org>
References: <1205171657-16216-1-git-send-email-pkufranky@gmail.com>
 <1205171657-16216-2-git-send-email-pkufranky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 11 08:29:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYyvE-0004I1-DY
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 08:29:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbYCKH2i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 03:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbYCKH2i
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 03:28:38 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60751 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028AbYCKH2h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 03:28:37 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E3DDD268C;
	Tue, 11 Mar 2008 03:28:35 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 42D6F268B; Tue, 11 Mar 2008 03:28:33 -0400 (EDT)
In-Reply-To: <1205171657-16216-2-git-send-email-pkufranky@gmail.com> (Ping
 Yin's message of "Tue, 11 Mar 2008 01:54:14 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76805>

Ping Yin <pkufranky@gmail.com> writes:

> This patch does the hard work to show submodule commit summary.
> ...

I've spent considerable amount of time cleaning up your commit log
messages for the entire series from the last round when I queued them to
'pu', but you seem to have discarded all of them.  As I do not have time
to waste doing clean-ups only to have others to discard, and I do not have
infinite amount of time, I won't be replacing them with this series
tonight.

> Signed-off-by: Ping Yin <pkufranky@gmail.com>

And you did not describe anything about the improvements from the previous
round anywhere.  interdiff shows that this part is somewhat different:

> +		then
> +			case "$mod_dst" in
> +				160000)
> +				sha1_dst=$(GIT_DIR="$name/.git" git rev-parse HEAD)
> +				;;
> +				100644)
> +				sha1_dst=$(git hash-object $name)
> +				;;
> +			esac

Earlier, you were ignoring the one that is not checked out anymore, but
now you blindly assume "rev-parse HEAD" to give you a usable sha1_dst.
Why?

If a path that previously was a module is changed to a symlink, what
happens?  
