Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE9C1494B9
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 22:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723673635; cv=none; b=ioHOsmSw4k+zZUFlZjdRWHG7+zhe1uqVfa58Pm+7z06TLV+phVopi6SQMslt4eKgQ/bA/L5wuYSVpfKj7q+cHkf71bv1r+2J8eqj0qxl/ScShXFfaOdXLZGfE0sW0JTVuEDrIzc/E0H++jvSmqiydk9mMC6WO8yfIeMmxwjkzvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723673635; c=relaxed/simple;
	bh=0jAO15f6zv8pM0PaQJ/cZL7f9sehZG+MtkOUzHMk4+o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cT7TwkStGDbs4EivogTVLzddp3ADnv1N7YjdyCyPF2f33gWwa8AsRtoZQZtLgajDT6Wu9uVDt+t8HFH/rri9ghYG65Y9M7jtFoRNV70eMHljupG5K80xys/Tbg0tmOlD7qyiWwCemIS7HjneAB5FQK3W+wogZOGQklpVQzKFs/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=XD8LIqUz; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XD8LIqUz"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 658F43F950;
	Wed, 14 Aug 2024 18:12:12 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=0jAO15f6zv8pM0PaQJ/cZL7f9sehZG+MtkOUzH
	Mk4+o=; b=XD8LIqUzhFZ524bbjt0vtT/QmxXwCVIr+ADpmcO15dV6Ujhse2s5f9
	85z+L5bSD5pqcmId5lpDaSukKWmwTbk+O907roZjZxceSnzBt+CihQzzr+3NRNc7
	2wecaXAUz0d/AjnXB8+686lBaUPKyTBTqgThs97qgf5Myspumwa2o=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 5E28A3F94F;
	Wed, 14 Aug 2024 18:12:12 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C77AC3F947;
	Wed, 14 Aug 2024 18:12:08 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Alex Galvin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Alex Galvin <agalvin@comqi.com>
Subject: Re: [PATCH v3] git-svn: mention `svn:global-ignores` in help+docs
In-Reply-To: <pull.1766.v3.git.git.1723665790460.gitgitgadget@gmail.com> (Alex
	Galvin via GitGitGadget's message of "Wed, 14 Aug 2024 20:03:10
	+0000")
References: <pull.1766.v2.git.git.1723578946962.gitgitgadget@gmail.com>
	<pull.1766.v3.git.git.1723665790460.gitgitgadget@gmail.com>
Date: Wed, 14 Aug 2024 15:12:07 -0700
Message-ID: <xmqqzfpewy88.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3F73CED0-5A8A-11EF-A7B5-BF444491E1BC-77302942!pb-smtp20.pobox.com

"Alex Galvin via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Alex Galvin <agalvin@comqi.com>
>
> Git-SVN was previously taught to use the svn:global-ignores property as
> well as svn:ignore when creating or showing .gitignore files from a
> Subversion repository. However, the documentation and help message still
> only mentioned svn:ignore. Update Git-SVN's documentation and help
> command to mention support for the new property. Also capitalize the
> help message for the 'mkdirs' command, for consistency.
>
> Signed-off-by: Alex Galvin <agalvin@comqi.com>
> ---
>     git-svn: mention svn:global-ignores in help+docs

Well written.  Also thanks for forcing the authorship with the
additional in-body From: header.  I totally missed it while reading
the last round.

Will queue.  Let's mark it for 'next' soonish.

> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1766%2Fav-gal%2Fgit-svn-doc-globalignores-v3
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1766/av-gal/git-svn-doc-globalignores-v3
> Pull-Request: https://github.com/git/git/pull/1766
>
> Range-diff vs v2:
>
>  1:  d0b5df150e9 ! 1:  a6d93512218 git-svn: mention `svn:global-ignores` in help+docs
>      @@
>        ## Metadata ##
>      -Author: Alex Galvin <alex.v.galvin@gmail.com>
>      +Author: Alex Galvin <agalvin@comqi.com>
>       
>        ## Commit message ##
>           git-svn: mention `svn:global-ignores` in help+docs
>       
>      -    Git-SVN was previously taught to use the svn:global-ignores attribute
>      -    as well as svn:ignore when creating or showing .gitignore files from a
>      -    Subversion repository. However, the documentation and help message
>      -    still only mentioned svn:ignore. This commit updates Git-SVN's
>      -    documentation and help command to mention support for the new attribute.
>      +    Git-SVN was previously taught to use the svn:global-ignores property as
>      +    well as svn:ignore when creating or showing .gitignore files from a
>      +    Subversion repository. However, the documentation and help message still
>      +    only mentioned svn:ignore. Update Git-SVN's documentation and help
>      +    command to mention support for the new property. Also capitalize the
>      +    help message for the 'mkdirs' command, for consistency.
>       
>           Signed-off-by: Alex Galvin <agalvin@comqi.com>
>       
>      @@ git-svn.perl: my %cmd = (
>        			{ 'stdin' => \$_stdin, %cmt_opts, %fc_opts, } ],
>        	'create-ignore' => [ \&cmd_create_ignore,
>       -			     'Create a .gitignore per svn:ignore',
>      -+			     "Create a .gitignore per directory with an SVN ignore property",
>      ++			     "Create a .gitignore per directory with SVN ignore properties",
>        			     { 'revision|r=i' => \$_revision
>        			     } ],
>        	'mkdirs' => [ \&cmd_mkdirs ,
>
>
>  Documentation/git-svn.txt | 14 +++++++-------
>  git-svn.perl              |  6 +++---
>  2 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
> index 43c68c2ec44..bcf7d84a87d 100644
> --- a/Documentation/git-svn.txt
> +++ b/Documentation/git-svn.txt
> @@ -431,14 +431,14 @@ Any other arguments are passed directly to 'git log'
>  	independently of 'git svn' functions.
>  
>  'create-ignore'::
> -	Recursively finds the svn:ignore property on directories and
> -	creates matching .gitignore files. The resulting files are staged to
> -	be committed, but are not committed. Use -r/--revision to refer to a
> -	specific revision.
> +	Recursively finds the svn:ignore and svn:global-ignores properties
> +	on directories and creates matching .gitignore files. The resulting
> +	files are staged to be committed, but are not committed. Use
> +	-r/--revision to refer to a specific revision.
>  
>  'show-ignore'::
> -	Recursively finds and lists the svn:ignore property on
> -	directories.  The output is suitable for appending to
> +	Recursively finds and lists the svn:ignore and svn:global-ignores
> +	properties on directories. The output is suitable for appending to
>  	the $GIT_DIR/info/exclude file.
>  
>  'mkdirs'::
> @@ -871,7 +871,7 @@ Tracking and contributing to the trunk of a Subversion-managed project
>  # Now commit your changes (that were committed previously using Git) to SVN,
>  # as well as automatically updating your working HEAD:
>  	git svn dcommit
> -# Append svn:ignore settings to the default Git exclude file:
> +# Append svn:ignore and svn:global-ignores settings to the default Git exclude file:
>  	git svn show-ignore >> .git/info/exclude
>  ------------------------------------------------------------------------
>  
> diff --git a/git-svn.perl b/git-svn.perl
> index a2a46608c9b..01e7a70de1c 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -219,11 +219,11 @@ my %cmd = (
>  	                "Set an SVN repository to a git tree-ish",
>  			{ 'stdin' => \$_stdin, %cmt_opts, %fc_opts, } ],
>  	'create-ignore' => [ \&cmd_create_ignore,
> -			     'Create a .gitignore per svn:ignore',
> +			     "Create a .gitignore per directory with SVN ignore properties",
>  			     { 'revision|r=i' => \$_revision
>  			     } ],
>  	'mkdirs' => [ \&cmd_mkdirs ,
> -	              "recreate empty directories after a checkout",
> +	              "Recreate empty directories after a checkout",
>  	              { 'revision|r=i' => \$_revision } ],
>          'propget' => [ \&cmd_propget,
>  		       'Print the value of a property on a file or directory',
> @@ -234,7 +234,7 @@ my %cmd = (
>          'proplist' => [ \&cmd_proplist,
>  		       'List all properties of a file or directory',
>  		       { 'revision|r=i' => \$_revision } ],
> -	'show-ignore' => [ \&cmd_show_ignore, "Show svn:ignore listings",
> +	'show-ignore' => [ \&cmd_show_ignore, "Show .gitignore patterns from SVN ignore properties",
>  			{ 'revision|r=i' => \$_revision
>  			} ],
>  	'show-externals' => [ \&cmd_show_externals, "Show svn:externals listings",
>
> base-commit: cabe67c0d1819fd1e33079e92615c6c7a3dc560d
