From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 9/9] Documentation: git stash branch now tolerates
 non-stash references.
Date: Thu, 12 Aug 2010 17:49:50 -0700
Message-ID: <7vr5i3mj4h.fsf@alter.siamese.dyndns.org>
References: <1281242771-24764-1-git-send-email-jon.seymour@gmail.com>
 <1281398688-21008-10-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, j6t@kdbg.org
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 13 02:50:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjiTN-00057m-OL
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 02:50:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761258Ab0HMAuE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Aug 2010 20:50:04 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53058 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761245Ab0HMAuC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Aug 2010 20:50:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0379DCD61D;
	Thu, 12 Aug 2010 20:50:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=KxEaQvA/FrqotAgtY6sbxnASUOs=; b=YAgWKEkXFuRHqTzhAOsmFqX
	Ft7EliajUYMk4DPw9x3/c3GiuHqilPPQpbxaS71sccta6vnZECmQLTkXoIok1qCm
	HaliyhUNtOAx0EY7mWb/fob1IET6vQPdGoKuv/WjA0U2ImLql2KwEK1DIcYnoy8o
	jp25EaFiVkTMMQBvpcLE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=l44j8tfatcwa0plUX5fO5qxMPHpEa2i+YxzuVTIVIob8quhH5
	oQXHana3G5bNh+uDBaTmtfZFHKU4dN5viFNtBvPcry4VSM1Kd5sVuL5pYqxPVI4l
	zp5FHZ9m+LWLSqKwRJl4gOHAUnXMFwm0Wv4O1GmeJt9LsEzj63B9BP1p80=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D108CD618;
	Thu, 12 Aug 2010 20:49:56 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E3F92CD616; Thu, 12 Aug
 2010 20:49:51 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B0FCEA84-A674-11DF-817B-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153447>

Jon Seymour <jon.seymour@gmail.com> writes:

> Update the documentation to indicate that git stash branch only attempts
> to drop the specified stash if it looks like stash reference.
>
> Also changed the synopsis to more clearly indicate which commands require
> a stash entry reference as opposed to merely a stash-like commit.
>
> Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
> ---
>  Documentation/git-stash.txt |   37 ++++++++++++++++++++-----------------
>  1 files changed, 20 insertions(+), 17 deletions(-)
>
> diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
> index 473889a..499ac48 100644
> --- a/Documentation/git-stash.txt
> +++ b/Documentation/git-stash.txt
> @@ -9,10 +9,11 @@ SYNOPSIS
>  --------
>  [verse]
>  'git stash' list [<options>]
> -'git stash' show [<stash>]
> -'git stash' drop [-q|--quiet] [<stash>]
> -'git stash' ( pop | apply ) [--index] [-q|--quiet] [<stash>]
> -'git stash' branch <branchname> [<stash>]
> +'git stash' show [<stash-like>]
> +'git stash' drop [-q|--quiet] [<stash-entry>]
> +'git stash' pop [--index] [-q|--quiet] [<stash-entry>]
> +'git stash' apply [--index] [-q|--quiet] [<stash-like>]
> +'git stash' branch <branchname> [<stash-like>]
>  'git stash' [save [--patch] [-k|--[no-]keep-index] [-q|--quiet] [<message>]]
>  'git stash' clear
>  'git stash' create
> @@ -80,15 +81,15 @@ stash@{1}: On master: 9cc0589... Add git-stash
>  The command takes options applicable to the 'git log'
>  command to control what is shown and how. See linkgit:git-log[1].
>  
> -show [<stash>]::
> +show [<stash-like>]::
>  
>  	Show the changes recorded in the stash as a diff between the
> -	stashed state and its original parent. When no `<stash>` is given,
> +	stashed state and its original parent. When no `<stash-like>` is given,
>  	shows the latest one. By default, the command shows the diffstat, but
>  	it will accept any format known to 'git diff' (e.g., `git stash show
>  	-p stash@\{1}` to view the second most recent stash in patch form).

Hmm.

Is there anything that describes how <stash-like>, <stash-entry> and
<stash> relate to each other?  I do not think a regular reader can answer
by reading the description after the patch these questions:

 - Is a <stash-entry> a <stash-like>?
 - Is the opposite true?

etc...

Perhaps we can simply call these two-parent merge commits a <stash>,
define that these commands as working on a <stash>, add notes to certain
subcommands that the <stash> they take must be on the stash ref (as
opposed to a freestanding one you can create with "stash create"), and be
done with it?

Also what is the error condition?  I am assuming that your <stash-entry>
is a <stash-like> that is on the reflog of refs/stash, but if you give a
<stash-like> that is not a <stash-entry> (iow a freestanding <stash>) to a
subcommand that wants to see <stash-entry>, what happens, and does the
document describe it as an error?

> -pop [--index] [-q|--quiet] [<stash>]::
> +pop [--index] [-q|--quiet] [<stash-entry>]::
>  
>  	Remove a single stashed state from the stash list and apply it
>  	on top of the current working tree state, i.e., do the inverse
