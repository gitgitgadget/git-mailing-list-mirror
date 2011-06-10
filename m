From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Remarks that tags need to be pushed explicitly
Date: Fri, 10 Jun 2011 14:24:31 -0700
Message-ID: <7vboy5wfao.fsf@alter.siamese.dyndns.org>
References: <20110610203943.GA50937@sherwood.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steffen Daode Nurpmeso <sdaoden@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 23:24:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QV9C9-0006Q2-IO
	for gcvg-git-2@lo.gmane.org; Fri, 10 Jun 2011 23:24:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757812Ab1FJVYk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jun 2011 17:24:40 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51059 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752259Ab1FJVYj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2011 17:24:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CB8744B30;
	Fri, 10 Jun 2011 17:26:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1QV6J4wDoInH+pLlKKs2BIm67xY=; b=rAuy2W
	gGz5hJkC6iprvENBQOTDxvkNLTJDr7PVMFmyvLuJhVM9hExv1n9leB3eoUeH/xW2
	BvIz7VjJ73GQVTqgfPl+Dn0FkoPG07a1DIATUOI8jmSa5Po812nEJnH2r2YtMamH
	9xXAdUpFj5v9IKWGazYbvgOW/cduV4wPWyijg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QDnKCKL8ndjHHWyCpWCQe53gfJpZeYlB
	z4XaP15gwFn6+2Q3ddd6gKFtzbogLS8zVqTEN7SlFpqBpRU2ep8Kw6mcxpZcajbV
	kcGtAUK3ruDN3CrUq8NAg32vVqkJQWX3czuGsqaDhPk6DAM3SFZ7IlnJbp2yROtQ
	VsX0kzfB5RQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A61FD4B2E;
	Fri, 10 Jun 2011 17:26:45 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6BC834B2D; Fri, 10 Jun 2011
 17:26:42 -0400 (EDT)
In-Reply-To: <20110610203943.GA50937@sherwood.local> (Steffen Daode
 Nurpmeso's message of "Fri, 10 Jun 2011 22:39:43 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 57AC9606-93A8-11E0-B992-C8CFB7AE1C3C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175628>

Steffen Daode Nurpmeso <sdaoden@googlemail.com> writes:

> (except for the term "branch-related <refspec>", but "any valid
> <refspec>" is a bit misleading since you will see nowhere that
> "ref/tags/*" is not a valid <refspec> unless you know this is
> a logical thing; heroes may know at a glance).

Sorry, I do not understand this paragraph, nor why the hunk in your patch
that corresponds to this comment, is a good change.

The current document says that any valid <refspec> can be configured as
the default to push for 'git push backup', so you could say

    [remote "backup"]
	url = /mnt/backup/my-project.git/
    	push = +refs/heads/*:refs/heads/*
        push = +refs/tags/*:refs/tags/*

in your configuration file, and "git push backup" would save the branches
and tags to your backup location.

Why should this paragraph discourage users to configure refspec that talk
about refs outside branch-related things?

> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
> index 88acfcd..e3af6da 100644
> --- a/Documentation/git-push.txt
> +++ b/Documentation/git-push.txt
> ...
> @@ -340,8 +340,8 @@ The default behavior of this command when no <refspec> is given can be
>  configured by setting the `push` option of the remote.
>  +
>  For example, to default to pushing only the current branch to `origin`
> -use `git config remote.origin.push HEAD`.  Any valid <refspec> (like
> -the ones in the examples below) can be configured as the default for
> +use `git config remote.origin.push HEAD`.  Any valid branch-related <refspec>
> +(like the ones in the examples below) can be configured as the default for
>  `git push origin`.


> @@ -371,6 +371,10 @@ git push origin HEAD:master::
>  	`origin` repository. This form is convenient to push the current
>  	branch without thinking about its local name.
>  
> +git push origin tag v1.5::
> +	Push the `v1.5` tag to the `origin` repository.
> +	Short hand for `git push origin refs/tags/v1.5:refs/tags/v1.5`.

Existing documentation seems to say either "shorthand" (22 occurrences) or
"short-hand" (12 occurrences).

> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> index f13a846..168e530 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -643,9 +643,9 @@ $ git tag stable-1 1b2e1d63ff
>  You can use stable-1 to refer to the commit 1b2e1d63ff.
>  
>  This creates a "lightweight" tag.  If you would also like to include a
> -comment with the tag, and possibly sign it cryptographically, then you
> -should create a tag object instead; see the linkgit:git-tag[1] man page
> -for details.
> +comment with the tag, possibly sign the tag cryptographically, or publish the
> +tag in a shared repository, then you should create a tag object instead; see
> +the linkgit:git-tag[1] man page for details.

Addition of "possibly sign" is a good change, but it is perfectly OK to
publish a lightweight tag by pushing it into a remote repository via "git
push", so "if you want to publish, you should create a tag object instead"
is a misguided suggestion.

Other than that, the patch looks Ok to me.

Thanks.
