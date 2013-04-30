From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] git-svn: fix occasional "Failed to strip path" error on fetch next commit, try #3
Date: Tue, 30 Apr 2013 12:10:37 -0700
Message-ID: <7vobcvdec2.fsf@alter.siamese.dyndns.org>
References: <5180046b.6905700a.65c8.00b4@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git mailing list <git@vger.kernel.org>,
	Ray Chen <rchen@cs.umd.edu>, Eric Wong <normalperson@yhbt.net>
To: Ilya Basin <basinilya@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 21:10:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXFwu-0000tQ-TP
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 21:10:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932830Ab3D3TKo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 15:10:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42983 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932711Ab3D3TKn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 15:10:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 362D41A22B;
	Tue, 30 Apr 2013 19:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=g+bVI41jEK4osnQezzHJqQ7ieHc=; b=LpAhez
	8Psa7Gq2Uj1uOJmAs79KipOMm2FO+Px2NkiJglGezznHBco3yjXqdxN/gUHom5Ud
	yEOfizjepkMRfiqblS7gpHwnW8C3UVDYmIINqMKMxBDwg5yOROgivgcXgwTeilix
	eLCC0yDlFmbKtPyQ5pK6ItUgLGtVRAjQdbhjM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eIiz94rveFy2AipX8XlhHR5lghuWfl17
	JHRBXpVknOwFLUd7OSrK69opWiyn0ftrBNtVuG1AwE867qWQoNo1SbMzHwgCOd6u
	OgwrB7WjoGdQKiqstkphv15Buu102A8toEkV6ML5drCd5Yurxbne1+wrYEd6W+/X
	Dk0fVzHVw7w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C5191A22A;
	Tue, 30 Apr 2013 19:10:40 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6FEE91A229;
	Tue, 30 Apr 2013 19:10:39 +0000 (UTC)
In-Reply-To: <5180046b.6905700a.65c8.00b4@mx.google.com> (Ilya Basin's message
	of "Mon, 29 Apr 2013 00:10:35 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A551B8D2-B1C9-11E2-A277-A3355732AFBB-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222991>

Ilya Basin <basinilya@gmail.com> writes:

    [PATCH 1/5] git-svn: fix occasional "Failed to strip path" error on fetch next commit, try #3

Please make it like this.

    [PATCH v3 1/5] git-svn: fix occasional "Failed to strip path" error on fetch next commit

    > When --stdlayout and --preserve-empty-dirs flags are used and a
    > directory becomes empty, two things happen:
    >
    > Sometimes find_empty_directories() returns empty list and no empty dir
    > placeholder file created. This happens, because find_empty_directories()
    > marks all directories as non-empty, if at least one updated directory is
    > non-empty.
    >
    > Sometimes git-svn dies with "Failed to strip path" error. This happens,
    > because find_empty_directories() returns git paths and
    > add_placeholder_file() expects svn paths

Enumeration is easier to read if you did

    ... two things happen:

      * Thing one.

      * Thing two.

The above is a good description of the problem and your diagnosis,
and readers may be able to guess a few approaches to fix them.

Here, after the description of the problem and before the three-dash
line, is the place to summarize the approach you took to fix it,
followed by an empty line followed by your Signed-off-by: line.

    > ---

Here is a place to summarize what changed since the earlier
iterations of the patch you sent (a single liner e.g. "with better
log messages", "corrected an off-by-one error in function X in the
previous round", is often sufficient).

    >  perl/Git/SVN/Fetcher.pm                | 12 ++++++++----
    >  t/t9160-git-svn-preserve-empty-dirs.sh | 18 +++++++++++++-----
    >  2 files changed, 21 insertions(+), 9 deletions(-)

>
> diff --git a/perl/Git/SVN/Fetcher.pm b/perl/Git/SVN/Fetcher.pm
> index 046a7a2..4f96076 100644
> --- a/perl/Git/SVN/Fetcher.pm
> +++ b/perl/Git/SVN/Fetcher.pm
> @@ -129,6 +129,7 @@ sub is_path_ignored {
>  
>  sub set_path_strip {
>  	my ($self, $path) = @_;
> +	$self->{pathprefix_strip} = length $path ? ($path . "/") : "";
>  	$self->{path_strip} = qr/^\Q$path\E(\/|$)/ if length $path;

The name of the field (should I call it an instance variable?) feels
somewhat strange.  This is later used to be _added_ as a prefix to
the files in the directory denoted by the $path. The only thing this
is related to "strip" is because you have to prefix it because these
files have their prefix stripped earlier, no?

>  }
>  
> @@ -458,9 +459,12 @@ sub find_empty_directories {
>  		my $skip_added = 0;
>  		foreach my $t (qw/dir_prop file_prop/) {
>  			foreach my $path (keys %{ $self->{$t} }) {
> -				if (exists $self->{$t}->{dirname($path)}) {
> -					$skip_added = 1;
> -					last;
> +				if (length $self->git_path($path)) {
> +					$path = dirname($path);
> +					if ($dir eq $self->git_path($path) && exists $self->{$t}->{$path}) {
> +						$skip_added = 1;
> +						last;
> +					}

I am reading that this is a solution for your second issue (use
git_path() to convert $path).  An empty $path would be a top-level
and skipping it corresponds to the "next if $dir eq '.'" at the
beginning of the loop, I guess.

When "$dir ne $self->git_path(dirname($path))", what should happen?

>  				}
>  			}
>  			last if $skip_added;
> @@ -477,7 +481,7 @@ sub find_empty_directories {
>  		delete $files{$_} foreach (@deleted_gpath);
>  
>  		# Report the directory if there are no filenames left.
> -		push @empty_dirs, $dir unless (scalar %files);
> +		push @empty_dirs, ($self->{pathprefix_strip} . $dir) unless (scalar %files);

This makes me think "path_prefix" would be a better name.

>  	}
>  	@empty_dirs;
>  }
> diff --git a/t/t9160-git-svn-preserve-empty-dirs.sh b/t/t9160-git-svn-preserve-empty-dirs.sh
> index b4a4434..1b5a286 100755
> --- a/t/t9160-git-svn-preserve-empty-dirs.sh
> +++ b/t/t9160-git-svn-preserve-empty-dirs.sh
> @@ -51,13 +51,21 @@ test_expect_success 'initialize source svn repo containing empty dirs' '
>  		echo "Conflict file" > 5/.placeholder &&
>  		mkdir 6/.placeholder &&
>  		svn_cmd add 5/.placeholder 6/.placeholder &&
> -		svn_cmd commit -m "Placeholder Namespace conflict"
> +		svn_cmd commit -m "Placeholder Namespace conflict" &&
> +
> +		echo x > fil.txt &&

Not a new problem but we prefer to write this as

		echo x >fil.txt &&

That is, a SP before a redirection operator, but no SP before the
redirection target.

> +		svn_cmd add fil.txt &&
> +		svn_cmd commit -m "this commit should not kill git-svn"
>  	) &&
>  	rm -rf "$SVN_TREE"
>  '
>  
> -test_expect_success 'clone svn repo with --preserve-empty-dirs' '
> -	git svn clone "$svnrepo"/trunk --preserve-empty-dirs "$GIT_REPO"
> +test_expect_success 'clone svn repo with --preserve-empty-dirs --stdlayout' '
> +	git svn clone "$svnrepo" --preserve-empty-dirs --stdlayout "$GIT_REPO" || (
> +		cd "$GIT_REPO"
> +		git svn fetch # fetch the rest can succeed even if clone failed
> +		false # this test still failed
> +	)
>  '
>  
>  # "$GIT_REPO"/1 should only contain the placeholder file.
> @@ -81,11 +89,11 @@ test_expect_success 'add entry to previously empty directory' '
>  	test -f "$GIT_REPO"/4/a/b/c/foo
>  '
>  
> -# The HEAD~2 commit should not have introduced .gitignore placeholder files.
> +# The HEAD~3 commit should not have introduced .gitignore placeholder files.
>  test_expect_success 'remove non-last entry from directory' '
>  	(
>  		cd "$GIT_REPO" &&
> -		git checkout HEAD~2
> +		git checkout HEAD~3
>  	) &&
>  	test_must_fail test -f "$GIT_REPO"/2/.gitignore &&
>  	test_must_fail test -f "$GIT_REPO"/3/.gitignore
