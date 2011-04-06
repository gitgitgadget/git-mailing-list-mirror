From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] git-svn: Add a svn-remote.<name>.pushurl config key
Date: Wed, 06 Apr 2011 14:44:19 +0200
Message-ID: <4D9C6023.6040305@drmicha.warpmail.net>
References: <4D9B310A.9020203@mit.edu> <1302034509-8842-1-git-send-email-asedeno@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>,
	James Y Knight <jknight@itasoftware.com>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?IkFsZWphbmRybyBSLiBTZWRlw7FvIg==?= <asedeno@mit.edu>
X-From: git-owner@vger.kernel.org Wed Apr 06 14:48:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7S9S-0004HX-0R
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 14:48:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755915Ab1DFMr4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Apr 2011 08:47:56 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:47083 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755763Ab1DFMr4 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Apr 2011 08:47:56 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 76EA920866;
	Wed,  6 Apr 2011 08:47:55 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Wed, 06 Apr 2011 08:47:55 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=XhYcaVv5PaQq75n7jDmtny+GSjk=; b=nW8Xo+tZpqTqklFo5OWIN3TopjZGuF8ymSFEKNfoVQd7Btq8di0U0+u6balIj4FkiNSCvwm/b33I4/V8nU5o1mbNiSr322tCIf/pWpLshmrtX8Z60r9mblWHRfmlYcYifgqhJVY+nbLlEMv6pSbAjVtJDivM+PIGnkNhXBwP8RY=
X-Sasl-enc: w69m3rdBpemkFy88XpuEHTzi0JAN8rAU1oQzo5epqDgR 1302094075
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 86735446A23;
	Wed,  6 Apr 2011 08:47:54 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <1302034509-8842-1-git-send-email-asedeno@mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170968>

Alejandro R. Sede=C3=B1o venit, vidit, dixit 05.04.2011 22:15:
> Similar to the 'remote.<name>.pushurl' config key for git remotes, th=
e
> 'pushurl' key is treated the same as the 'url' key. This is distinct
> from the 'commiturl' key, which is defined to be a full svn path.
>=20
> This is necessary if you want to be able to commit to multiple branch=
es.

Maybe one can understand this remark after reading the whole thread, bu=
t
reading it as a commit message I'm wondering: Huh? How can I have been
doing it then without pushurl?

Also, "treated the same as the url" makes a reader wonder why we have
two names for the same.

The point of pushurl is that you can use a passwordless transport for
fetches and another transport for pushes. The standing assumption is
that both urls point in fact at the same repo. Weird things can happen
if not. Is that assumption the same for your svn pushurl?

>=20
> Signed-off-by: Alejandro R. Sede=C3=B1o <asedeno@mit.edu>
> Reviewed-off-by: James Y Knight <jknight@itasoftware.com>
> ---
>  Documentation/git-svn.txt |    6 ++++++
>  git-svn.perl              |   14 ++++++++++++--
>  2 files changed, 18 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
> index ea8fafd..94f7497 100644
> --- a/Documentation/git-svn.txt
> +++ b/Documentation/git-svn.txt
> @@ -648,6 +648,12 @@ svn-remote.<name>.rewriteUUID::
>  	where the original UUID is not available via either useSvmProps
>  	or useSvnsyncProps.
> =20
> +svn-remote.<name>.pushurl::
> +	Similar to git's remote.<name>.pushurl, this is useful in
> +	cases where the SVN repository url is read-only. Unlike
> +	'commiturl', 'pushurl' is a base path. This key is overridden
> +	by the 'commiturl' config key.
> +

Exactly :)

>  svn.brokenSymlinkWorkaround::
>  	This disables potentially expensive checks to workaround
>  	broken symlinks checked into SVN by broken clients.  Set this
> diff --git a/git-svn.perl b/git-svn.perl
> index fa8cd07..8372606 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -531,7 +531,13 @@ sub cmd_dcommit {
>  		$url =3D eval { command_oneline('config', '--get',
>  			      "svn-remote.$gs->{repo_id}.commiturl") };
>  		if (!$url) {
> -			$url =3D $gs->full_url
> +			$url =3D eval { command_oneline('config', '--get',
> +				      "svn-remote.$gs->{repo_id}.pushurl") };
> +			if ($url) {
> +				$url .=3D (length $gs->{path} ? '/' . $gs->{path} : '');
> +			} else {
> +				$url =3D $gs->full_url
> +			}
>  		}
>  	}
> =20
> @@ -730,7 +736,11 @@ sub cmd_branch {
>  		$url =3D eval { command_oneline('config', '--get',
>  			"svn-remote.$gs->{repo_id}.commiturl") };
>  		if (!$url) {
> -			$url =3D $remote->{url};
> +			$url =3D eval { command_oneline('config', '--get',
> +				      "svn-remote.$gs->{repo_id}.pushurl") };
> +			if (!$url) {
> +				$url =3D $remote->{url};
> +			}
>  		}
>  	}
>  	my $dst =3D join '/', $url, $lft, $branch_name, ($rgt || ());
