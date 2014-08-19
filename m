From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Allow the user to change the temporary file name for mergetool
Date: Tue, 19 Aug 2014 11:01:59 -0700
Message-ID: <xmqqwqa4uzmw.fsf@gitster.dls.corp.google.com>
References: <xmqqa970wgy0.fsf@gitster.dls.corp.google.com>
	<1408468545-6879-1-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 20:02:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJnjd-00037W-KX
	for gcvg-git-2@plane.gmane.org; Tue, 19 Aug 2014 20:02:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753397AbaHSSCM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 14:02:12 -0400
Received: from smtp.pobox.com ([208.72.237.35]:65333 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752237AbaHSSCL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 14:02:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4F3A02F5C3;
	Tue, 19 Aug 2014 14:02:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7QOYeM+h8DbCPB4OXzAJibbyBq4=; b=dxCSbO
	haVHvymm49BuaqnswRr5SMseaoD869vkvLsw9lATyjjKKWvBnnuJ5roj4Fa16uzI
	TwCurToZE/YQdaUTBr2UFvgRl2Ij0KWBj/1U1QGQUYmNpypUrPA2eGRuL0KmS1HF
	7zHCTm/XanH51hwvgZ5N40BWhhdTDH+JXcxMg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=n6G9kdhNoSujPe10ftgLMAP2bps4d8wL
	Fwid7Cj7EVvrLnqcOrzEQsoNMrOCAuOXBIVj4lHuNO1SaLVWCI9O17kSFoPUXKx1
	L71qXK7mkdYdJA4OTI7IusFvnAEqnME0OwbaQapa72YBzMaDCwzxUjgJxoTbiLoj
	j+7RauaHN+M=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 45B272F5C1;
	Tue, 19 Aug 2014 14:02:10 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 45CAF2F5B4;
	Tue, 19 Aug 2014 14:02:02 -0400 (EDT)
In-Reply-To: <1408468545-6879-1-git-send-email-robin.rosenberg@dewire.com>
	(Robin Rosenberg's message of "Tue, 19 Aug 2014 19:15:45 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: EBED79C0-27CA-11E4-936A-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255506>

Robin Rosenberg <robin.rosenberg@dewire.com> writes:

> Using the original filename suffix for the temporary input files to
> the merge tool confuses IDEs like Eclipse. This patch introduces
> a configurtion option, mergetool.tmpsuffix, which get appended to
> the temporary file name. That way the user can choose to use a
> suffix like ".tmp", which does not cause confusion.
>
> Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
> ---
>  Documentation/config.txt        |  5 +++++
>  Documentation/git-mergetool.txt |  7 +++++++
>  git-mergetool.sh                | 10 ++++++----
>  3 files changed, 18 insertions(+), 4 deletions(-)

Thanks for a quick turn-around.

>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index c55c22a..0e15800 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1778,6 +1778,11 @@ notes.displayRef::
>  	several times.  A warning will be issued for refs that do not
>  	exist, but a glob that does not match any refs is silently
>  	ignored.
> +
> +mergetool.tmpsuffix::
> +	A string to append the names of the temporary files mergetool
> +	creates in the worktree as input to a custom merge tool. The
> +	primary use is to avoid confusion in IDEs during merge.
>  +
>  This setting can be overridden with the `GIT_NOTES_DISPLAY_REF`
>  environment variable, which must be a colon separated list of refs or

I smell that the new paragraph is inserted at a wrong place.  What
does notes-display-ref environment have anything to do with this
variable?

Also, could you phrase this in a way to hint that the users are
likely to want to begin the value for this variable with a dot (or
some other special character)?  Your 'suffix like ".tmp"' in the
proposed log message does it very nicely [*1*], and I'd like to see the
same done for the end users who do not have access to our log
message but do have access to our documentation pages.

Same comment applies to the new paragraph in the documentation of
git-mergetool itself.

> diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
> index e846c2e..80a0526 100644
> --- a/Documentation/git-mergetool.txt
> +++ b/Documentation/git-mergetool.txt
> @@ -89,6 +89,13 @@ Setting the `mergetool.keepBackup` configuration variable to `false`
>  causes `git mergetool` to automatically remove the backup as files
>  are successfully merged.
>  
> +`git mergetool` may also create other temporary files for the
> +different versions involved in the merge. By default these files have
> +the same filename suffix as the file being merged. This may confuse
> +other tools in use during a long merge operation. The user can set
> +`mergetool.tmpsuffix` to be used as an extra suffix, which will be
> +appened to the temporary filename to lessen that problem.
> +

[Footnote]

*1* To anybody remotely intelligent (like me), it hints that a
temporary file would have a name like "hello.rbtmp" if it is set to
"tmp", to let them make a natural inference that they are better off
using something like ".tmp", "~tmp", "+tmp", etc.
