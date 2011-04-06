From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] git-svn: Add a svn-remote.<name>.pushurl config key
Date: Wed, 06 Apr 2011 17:22:02 +0200
Message-ID: <4D9C851A.7070801@drmicha.warpmail.net>
References: <4D9B7A9E.6040902@mit.edu> <1302102336-8800-1-git-send-email-asedeno@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>,
	James Y Knight <jknight@itasoftware.com>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?IkFsZWphbmRybyBSLiBTZWRlw7FvIg==?= <asedeno@mit.edu>
X-From: git-owner@vger.kernel.org Wed Apr 06 17:25:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7Uc6-0002lP-2Z
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 17:25:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756494Ab1DFPZj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Apr 2011 11:25:39 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:47631 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756203Ab1DFPZi (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Apr 2011 11:25:38 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.messagingengine.com (Postfix) with ESMTP id D3A882094F;
	Wed,  6 Apr 2011 11:25:37 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute4.internal (MEProxy); Wed, 06 Apr 2011 11:25:37 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=hFbG+FVGvmp/B+Fu6pIV6jHvH1E=; b=pJwppsUQxoZeVIXpKcCgV50eenno7Viy6J6z23SA21/sn6xyYYwD1CN/W2icfNzQ9DdlGYpagO3tvNidYJePZFvoJOnmbYrTejD6Cz7EQvh3oulaGkm4Hwt67oHF2mn80vKWD5fU3XXH8Crd/Jyyho/gYdMv8j6si2seH3Kz9vw=
X-Sasl-enc: Gal6bbazwS7rLwjYMME3cvahjBiG8z/F6uJqgVE2EcGO 1302103537
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id AF12844368A;
	Wed,  6 Apr 2011 11:25:36 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <1302102336-8800-1-git-send-email-asedeno@mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170980>

Alejandro R. Sede=C3=B1o venit, vidit, dixit 06.04.2011 17:05:
> Similar to the 'remote.<name>.pushurl' config key for git remotes,
> 'pushurl' is designed to be used in cases where 'url' points to an SV=
N
> repository via a read-only transport, to provide an alternate
> read/write transport. It is assumed that both keys point to the same
> repository.
>=20
> The 'pushurl' key is distinct from the 'commiturl' key in that
> 'commiturl' is a full svn path while 'pushurl' (like 'url') is a base
> path. 'commiturl' takes precendece over 'pushurl' in cases where
> either might be used.
>=20
> The 'pushurl' is used by git-svn's dcommit and branch commands.
>=20

Thanks, very clear now.

> Signed-off-by: Alejandro R. Sede=C3=B1o <asedeno@mit.edu>
> Reviewed-off-by: James Y Knight <jknight@itasoftware.com>

:) So, if that review is off, that means...

> ---
>  Documentation/git-svn.txt |   10 ++++++++++
>  git-svn.perl              |   18 +++++++++++++++---
>  2 files changed, 25 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
> index ea8fafd..4aa6404 100644
> --- a/Documentation/git-svn.txt
> +++ b/Documentation/git-svn.txt
> @@ -648,6 +648,16 @@ svn-remote.<name>.rewriteUUID::
>  	where the original UUID is not available via either useSvmProps
>  	or useSvnsyncProps.
> =20
> +svn-remote.<name>.pushurl::
> +
> +	Similar to git's 'remote.<name>.pushurl', this key is designed
> +	to be used in cases where 'url' points to an SVN repository
> +	via a read-only transport, to provide an alternate read/write
> +	transport. It is assumed that both keys point to the same
> +	repository. Unlike 'commiturl', 'pushurl' is a base path. If
> +	either 'commiturl' or 'pushurl' could be used, 'commiturl'
> +	takes precedence.
> +
>  svn.brokenSymlinkWorkaround::
>  	This disables potentially expensive checks to workaround
>  	broken symlinks checked into SVN by broken clients.  Set this
> diff --git a/git-svn.perl b/git-svn.perl
> index fa8cd07..184442a 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -531,7 +531,7 @@ sub cmd_dcommit {
>  		$url =3D eval { command_oneline('config', '--get',
>  			      "svn-remote.$gs->{repo_id}.commiturl") };
>  		if (!$url) {
> -			$url =3D $gs->full_url
> +			$url =3D $gs->full_pushurl

Wouldn't we want to do the same $gs->full_pushurl || $gs->full_url fall
back here as below, or is fullpush_url always set? OK, I see it always =
is.

>  		}
>  	}
> =20
> @@ -679,7 +679,7 @@ sub cmd_branch {
>  	$head ||=3D 'HEAD';
> =20
>  	my (undef, $rev, undef, $gs) =3D working_head_info($head);
> -	my $src =3D $gs->full_url;
> +	my $src =3D $gs->full_pushurl;

Same here.

> =20
>  	my $remote =3D Git::SVN::read_all_remotes()->{$gs->{repo_id}};
>  	my $allglobs =3D $remote->{ $_tag ? 'tags' : 'branches' };
> @@ -730,7 +730,7 @@ sub cmd_branch {
>  		$url =3D eval { command_oneline('config', '--get',
>  			"svn-remote.$gs->{repo_id}.commiturl") };
>  		if (!$url) {
> -			$url =3D $remote->{url};
> +			$url =3D $remote->{pushurl} || $remote->{url};
>  		}
>  	}
>  	my $dst =3D join '/', $url, $lft, $branch_name, ($rgt || ());
> @@ -1834,6 +1834,8 @@ sub read_all_remotes {
>  			$r->{$1}->{svm} =3D {};
>  		} elsif (m!^(.+)\.url=3D\s*(.*)\s*$!) {
>  			$r->{$1}->{url} =3D $2;
> +		} elsif (m!^(.+)\.pushurl=3D\s*(.*)\s*$!) {
> +			$r->{$1}->{pushurl} =3D $2;
>  		} elsif (m!^(.+)\.(branches|tags)=3D$svn_refspec$!) {
>  			my ($remote, $t, $local_ref, $remote_ref) =3D
>  			                                     ($1, $2, $3, $4);
> @@ -2071,6 +2073,8 @@ sub new {
>  	$self->{url} =3D command_oneline('config', '--get',
>  	                               "svn-remote.$repo_id.url") or
>                    die "Failed to read \"svn-remote.$repo_id.url\" in=
 config\n";
> +	$self->{pushurl} =3D eval { command_oneline('config', '--get',
> +	                          "svn-remote.$repo_id.pushurl") };

Why eval? We don't do it for url either.

>  	$self->rebuild;
>  	$self;
>  }
> @@ -2548,6 +2552,14 @@ sub full_url {
>  	$self->{url} . (length $self->{path} ? '/' . $self->{path} : '');
>  }
> =20
> +sub full_pushurl {
> +	my ($self) =3D @_;

Isn't that a noop?

> +	if ($self->{pushurl}) {
> +		return $self->{pushurl} . (length $self->{path} ? '/' . $self->{pa=
th} : '');
> +	} else {
> +		return $self->full_url;
> +	}
> +}
> =20
>  sub set_commit_header_env {
>  	my ($log_entry) =3D @_;
