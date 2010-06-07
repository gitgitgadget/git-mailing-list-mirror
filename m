From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC] gitweb: Create Gitweb::Git module
Date: Mon, 7 Jun 2010 10:42:42 +0200
Message-ID: <201006071042.42908.jnareb@gmail.com>
References: <1275859451-21787-1-git-send-email-pavan.sss1991@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Petr Baudis <pasky@ucw.cz>
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 07 10:43:03 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLXvB-0006P3-2j
	for gcvg-git-2@lo.gmane.org; Mon, 07 Jun 2010 10:43:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753344Ab0FGImz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Jun 2010 04:42:55 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45158 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751567Ab0FGImz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jun 2010 04:42:55 -0400
Received: by fxm8 with SMTP id 8so1844463fxm.19
        for <git@vger.kernel.org>; Mon, 07 Jun 2010 01:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=WpUr25rtpLFmBXWAGAAE1MtbDI99KbM5LvkcNXAijoc=;
        b=Hkk6tjPT8mmo4obxd/Woh8RqpFUqGvVKiJCy/36zN31gePgcM3WP8MDdCXwto4/6Dc
         xPMghVwsn0A0/qdhflwtyH7/cFqmQX8MixOl0h46HvhGejCCW9Gn8SPXN2ncfBZ6xN0F
         bYXl6ghxMhMsmbllaWRwSrsFYwAU4ucvke8lY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=TWS0rHbsol4ysqK4zyizUJ6Z0lhhzTZ8VD9KUL4QxWImPfA1B/sUk9+nYQtihHwfuJ
         xUiAdiGyb8k+uVOmzaHskpzzdZen32QDeFOFtnwo4iis9erMikRD62Bs/YoM1UtL9bR+
         CCw45FTyVD5Ej5rvn5lV7zQ80fVuSlWAPdb4o=
Received: by 10.204.85.70 with SMTP id n6mr6433740bkl.189.1275900172988;
        Mon, 07 Jun 2010 01:42:52 -0700 (PDT)
Received: from [192.168.1.15] (abwb99.neoplus.adsl.tpnet.pl [83.8.225.99])
        by mx.google.com with ESMTPS id v2sm18707442bkz.19.2010.06.07.01.42.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 07 Jun 2010 01:42:51 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1275859451-21787-1-git-send-email-pavan.sss1991@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148586>

Summary: minor complaints, mainly about _descriptions_.

On Sun, 6 June 2010, Pavan Kumar Sunkara wrote:

> Subject: [PATCH/RFC] gitweb: Create Gitweb::Git module
>
> Create a Gitweb::Git module in 'gitweb/lib/Gitweb/Git.pm'
> to store essential git variables and subs regarding the
> gitweb.perl script

The pararaph above and the commit description (subject of this mail) do
not tell us what does this new module Gitweb::Git is for, what does it
contain.  The description of module in header comment is also a bit
lacking (see my comments below).

I know I suggested, among other forms, the above short form of commit
description, but I think that in this case it is too short.

Perhaps (this is only a proposal):

  gitweb: Create Gitweb::Git module, to run git commands

  Create a Gitweb::Git module in  'gitweb/lib/Gitweb/Git.pm'
  to deal with running git commands (and also processing output
  of git commands with external programs) from gitweb.

I think you should also write why $GIT variable is moved to Gitweb::Git=
,
even though it is variable which is configured during build, and one
might think that it belongs to Gitweb::Config.

Perhaps something like this (it is only a proposal):

  This module is intended as standalone module, which does not require
  (include) other gitweb' modules to avoid circular dependencies.  That
  is why it includes $GIT variable, even though this variable is
  configured during building gitweb.  On the other hand $GIT is more
  about git configuration, than gitweb configuration.

Or something like that.

>=20
> Subroutines moved:
> 	evaluate_git_version
> 	git_cmd
> 	quote_command
>=20
> Subroutines yet to move: (Contains not yet packaged subs & vars)
> 	None
>=20
> Update gitweb/Makefile to install gitweb modules alongside gitweb

It is not 'gitweb modules', but single gitweb module.

  Update gitweb/Makefile to install Gitweb::Git alongside gitweb.

>=20
> Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
> ---

> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index e95aaf7..59a65a8 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl

> -# core git executable to use
> -# this can just be "git" if your webserver has a sensible PATH
> -our $GIT =3D "++GIT_BINDIR++/git";
> +#only this variable has it's root in Gitweb::Git
> +$GIT =3D "++GIT_BINDIR++/git";

Hmmm... is this comment really needed?  It does not matter, at least no=
t
much, where given subroutine comes from.  Only lack of 'our' indication
that it is defined in other package.

Perhaps

  +# $GIT is from Gitweb::Git

or something like that?

> @@ -77,7 +75,6 @@ sub gitweb_get_feature {
>  		$feature{$name}{'override'},
>  		@{$feature{$name}{'default'}});
>  	# project specific override is possible only if we have project
> -	our $git_dir; # global variable, declared later
>  	if (!$override || !defined $git_dir) {
>  		return @defaults;
>  	}

Nice side-effect.

> @@ -197,13 +194,6 @@ sub get_loadavg {
>  	return 0;
>  }
> =20
> -# version of the core git binary
> -our $git_version;
> -sub evaluate_git_version {
> -	our $git_version =3D qx("$GIT" --version) =3D~ m/git version (.*)$/=
 ? $1 : "unknown";
> -	$number_of_git_cmds++;
> -}

I guess that evaluate_git_version and $number_of_git_cmds are moved to
Gitweb::Git because of technical reasons (for module to be self
contained, and to avoid circular dependencies), isn't it?

> @@ -492,10 +482,8 @@ sub evaluate_and_validate_params {
>  	}
>  }
> =20
> -# path to the current git repository
> -our $git_dir;
>  sub evaluate_git_dir {
> -	our $git_dir =3D "$projectroot/$project" if $project;
> +	$git_dir =3D "$projectroot/$project" if $project;
>  }

O.K.

> diff --git a/gitweb/lib/Gitweb/Git.pm b/gitweb/lib/Gitweb/Git.pm
> new file mode 100644
> index 0000000..9961e6d
> --- /dev/null
> +++ b/gitweb/lib/Gitweb/Git.pm
> @@ -0,0 +1,48 @@
> +#!/usr/bin/perl
> +#
> +# Gitweb::Git -- gitweb git package
> +#
> +# This program is licensed under the GPLv2

This description doesn't tell us much.  What does "git package" mean?
I would like to have description here what this package is for, and
whet it (should) include.

Perhaps (this is only a proposal):

  +# Gitweb::Git -- gitweb's package dealing with running git commands

or something like that.

> +
> +package Gitweb::Git;
> +
> +use strict;
> +use warnings;
> +use Exporter qw(import);
> +
> +our @EXPORT =3D qw($GIT $number_of_git_cmds $git_version $git_dir
> +                 git_cmd quote_command evaluate_git_version);
> +
> +# core git executable to use
> +# this can just be "git" if your webserver has a sensible PATH
> +our $GIT;

One could think that this should belong to Gitweb::Config, but it is
more about _git_ configuration than about _gitweb_ configuration.
And there are technical reasons for having it there.

> +
> +our $number_of_git_cmds =3D 0;

I guess that counting git commands belong there...

By the way, can anyone check if it is correctly reset, and is counting
number of git commands it took to process _a request_, also when runnin=
g
in FastCGI mode?

> +
> +# version of the core git binary
> +our $git_version;

Hmmm... wouldn't it be better to have this close to evaluate_git_versio=
n?

Also, does $git_version and evaluate_git_version belong in Gitweb::Git?

> +
> +# path to the current git repository
> +our $git_dir;
> +
> +# returns path to the core git executable and the --git-dir paramete=
r as list
> +sub git_cmd {
> +	$number_of_git_cmds++;
> +	return $GIT, '--git-dir=3D'.$git_dir;
> +}

O.K.

> +
> +# quote the given arguments for passing them to the shell
> +# quote_command("command", "arg 1", "arg with ' and ! characters")
> +# =3D> "'command' 'arg 1' 'arg with '\'' and '\!' characters'"
> +# Try to avoid using this function wherever possible.
> +sub quote_command {
> +	return join(' ',
> +		map { my $a =3D $_; $a =3D~ s/(['!])/'\\$1'/g; "'$a'" } @_ );
> +}

O.K.

> +
> +sub evaluate_git_version {
> +	$git_version =3D qx("$GIT" --version) =3D~ m/git version (.*)$/ ? $=
1 : "unknown";
> +	$number_of_git_cmds++;
> +}
> +
> +1;
> --=20

--=20
Jakub Nar=EAbski
Poland
