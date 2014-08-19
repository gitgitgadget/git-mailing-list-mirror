From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Allow the user to change the temporary file name for mergetool
Date: Tue, 19 Aug 2014 10:02:47 -0700
Message-ID: <xmqqa970wgy0.fsf@gitster.dls.corp.google.com>
References: <53F3489E.9050302@atlas-elektronik.com>
	<1408460112-6206-1-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 19:03:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJmoO-0004AV-Ja
	for gcvg-git-2@plane.gmane.org; Tue, 19 Aug 2014 19:03:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753750AbaHSRDA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 13:03:00 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56147 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753353AbaHSRC7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 13:02:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8B50032277;
	Tue, 19 Aug 2014 13:02:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cdSZwJjJBjkcQZ6YQ1vwWzLYfMM=; b=xvSqIm
	nOlFsfDzoge5YnvSk0HesRXjOrFdvpJZgBT01sjWFdkcX2fVQwI5XDjGT6IihVbz
	Tcnv/95hGmcRwqmfz29VY9pLBTn+un4MmJIgRjfa9uNqh8MHpR3mBe9h1JoHsY9f
	zW7ciASbjqWgI8+PbfVAEpVWvarMRBVZgJTCM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vYNZrSJmJUTTv0CB/evz9nLSxxia5/71
	/2b1IUorIF7PYMvflDKWMryd9hVVyxbgLTKJ21Dwvp2Tq0QFrph45JEDsRypOGCC
	qHf7a8OrOsssA7pJ83SHuImYCCKpXHuJIj44U7hxPkFEGt7DyIgGxxO2f0dqMZ9W
	vHRtjMym9PY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 80E4632276;
	Tue, 19 Aug 2014 13:02:58 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BD86C3226D;
	Tue, 19 Aug 2014 13:02:49 -0400 (EDT)
In-Reply-To: <1408460112-6206-1-git-send-email-robin.rosenberg@dewire.com>
	(Robin Rosenberg's message of "Tue, 19 Aug 2014 16:55:12 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A6764C62-27C2-11E4-A519-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255502>

Robin Rosenberg <robin.rosenberg@dewire.com> writes:

> Using the original filename suffix for the temporary input files to
> the merge tool confuses IDEs like Eclipse. This patch introduces
> a configurtion option, mergetool.tmpsuffix, which get appended to
> the temporary file name. That way the user can choose to use a
> suffix like ".tmp", which does not cause confusion.
>
> Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
> ---
>  Documentation/git-mergetool.txt |  7 +++++++
>  git-mergetool.sh                | 10 ++++++----
>  2 files changed, 13 insertions(+), 4 deletions(-)

No updates to Documentation/config.txt to describe the new variable?

>
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
>  GIT
>  ---
>  Part of the linkgit:git[1] suite
> diff --git a/git-mergetool.sh b/git-mergetool.sh
> index 9a046b7..d7cc76c 100755
> --- a/git-mergetool.sh
> +++ b/git-mergetool.sh
> @@ -214,6 +214,8 @@ checkout_staged_file () {
>  }
>  
>  merge_file () {
> +	tmpsuffix=$(git config mergetool.tmpsuffix || true)
> +
>  	MERGED="$1"
>  
>  	f=$(git ls-files -u -- "$MERGED")
> @@ -229,10 +231,10 @@ merge_file () {
>  	fi
>  
>  	ext="$$$(expr "$MERGED" : '.*\(\.[^/]*\)$')"
> -	BACKUP="./$MERGED.BACKUP.$ext"
> -	LOCAL="./$MERGED.LOCAL.$ext"
> -	REMOTE="./$MERGED.REMOTE.$ext"
> -	BASE="./$MERGED.BASE.$ext"
> +	BACKUP="./$MERGED.BACKUP.$ext$tmpsuffix"
> +	LOCAL="./$MERGED.LOCAL.$ext$tmpsuffix"
> +	REMOTE="./$MERGED.REMOTE.$ext$tmpsuffix"
> +	BASE="./$MERGED.BASE.$ext$tmpsuffix"
>  
>  	base_mode=$(git ls-files -u -- "$MERGED" | awk '{if ($3==1) print $1;}')
>  	local_mode=$(git ls-files -u -- "$MERGED" | awk '{if ($3==2) print $1;}')
