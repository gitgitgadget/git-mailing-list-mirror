From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: push.default applies to all remotes
Date: Mon, 23 Mar 2009 16:32:28 -0700
Message-ID: <7v7i2f6cj7.fsf@gitster.siamese.dyndns.org>
References: <1237850318-3671-1-git-send-email-santi@agolina.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Santi =?utf-8?Q?B=C3=A9jar?= <santi@agolina.net>
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Tue Mar 24 00:34:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lltek-0005FC-G8
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 00:34:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752370AbZCWXck convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Mar 2009 19:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752133AbZCWXck
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 19:32:40 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59381 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751398AbZCWXck convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Mar 2009 19:32:40 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2079DA4592;
	Mon, 23 Mar 2009 19:32:38 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C86B9A4590; Mon,
 23 Mar 2009 19:32:30 -0400 (EDT)
In-Reply-To: <1237850318-3671-1-git-send-email-santi@agolina.net> (Santi
 =?utf-8?Q?B=C3=A9jar's?= message of "Tue, 24 Mar 2009 00:18:38 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E360D60E-1802-11DE-9E94-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114362>

Santi B=C3=A9jar <santi@agolina.net> writes:

> push.default is not only for the current remote but setting the defau=
lt
> behavior for all remotes.
>
> Signed-off-by: Santi B=C3=A9jar <santi@agolina.net>
> ---
> Hi,
>
>   this applies on top of next.
>
>  Documentation/config.txt |   11 +++--------
>  1 files changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 089569a..7f5fe43 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1215,19 +1215,14 @@ push.default::
>  	Defines the action git push should take if no refspec is given
>  	on the command line, no refspec is configured in the remote, and
>  	no refspec is implied by any of the options given on the command
> -	line.
> -+
> -The term `current remote` means the remote configured for the curren=
t
> -branch, or `origin` if no remote is configured. `origin` is also use=
d
> -if you are not on any branch. Possible values are:
> +	line. Possible values are:
>  +
>  * `nothing` do not push anything.
> -* `matching` push all matching branches to the current remote.
> +* `matching` push all matching branches.
>    All branches having the same name in both ends are considered to b=
e
>    matching. This is the current default value.
>  * `tracking` push the current branch to the branch it is tracking.
> -* `current` push the current branch to a branch of the same name on =
the
> -  current remote.
> +* `current` push the current branch to a branch of the same name.
> =20
>  rebase.stat::
>  	Whether to show a diffstat of what changed upstream since the last

This makes sense; I can understand why "same name" wanted to be qualifi=
ed
with "on the current remote", but the sentence reads just fine without =
it.
It is clear that the "same name" compares the set of branches the local
repository has with the set of branches in the other repository we are
pushing into.

If we want to explain that a "git push" that does not say where-to deci=
des
where to push by looking at branch.<name>.remote configuration and fall=
ing
back to origin, push.default is not the place to explain it.  This
configuration variable is not involved in that decision in any way.

The description for branch.<name>.remote can be updated to say it is us=
ed
for both fetch and push.
