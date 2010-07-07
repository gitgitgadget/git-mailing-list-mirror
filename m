From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] git-cvsserver: implement script based pserver auth
Date: Tue, 06 Jul 2010 22:28:34 -0700
Message-ID: <7v39vv273x.fsf@alter.siamese.dyndns.org>
References: <449772932078145114@unknownmsgid>
 <AANLkTilguZZVVstmJvEDudhRP5Ko6m-ajtn9d7nIl3UR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	=?utf-8?B?TMOhc3psw7Mgw4FTSElO?= <laszlo.ashin@neti.hu>
To: =?utf-8?B?w4FzaGluIEzDoXN6bMOz?= <ashinlaszlo@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 07 07:28:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWNBk-0008Vx-DY
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 07:28:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752127Ab0GGF2r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Jul 2010 01:28:47 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41427 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751877Ab0GGF2q convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Jul 2010 01:28:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9279BC2431;
	Wed,  7 Jul 2010 01:28:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=Z3iUy0ZQJIz/gSYlqWvvdStvi
	jo=; b=RyyNeR+tDUtKxffjXr28iWMbCYKdZozHF9nX6gavSYiGTpSeexRB4YRE/
	uCiUr5fxkiUpavQqmcUapSL1PWCMo/1gJbowDtgx+lc+iJ6qkcy6wDluZBh9vcAe
	XjJUPBpEQfiZALU4zr2NnO7jZCIYxKYCSreHCkWcVJPUfzOT3c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=ryy3p6A5zNhDVpmn6OQ
	P+lTEOd0gYwS8iYHuCEY9h/YcE5EWCFx2iPiJWgcF7G/+2OvaY7fb3P2fBdrAL5F
	xYJr1U6yYpJInaG27nb1HfdDrLvfYf1gULdeHivDmySXlzQey+qf3agKI2jP15z4
	umJdk7xx6JGsq7myu0ends9M=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5056EC242F;
	Wed,  7 Jul 2010 01:28:41 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 14D05C2427; Wed,  7 Jul
 2010 01:28:35 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 80BFD358-8988-11DF-98EB-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150449>

=C3=81shin L=C3=A1szl=C3=B3 <ashinlaszlo@gmail.com> writes:

> ---

Sign-off?

>  Documentation/git-cvsserver.txt |   42 +++++++++++++++++++++++++++--=
-
>  git-cvsserver.perl              |   34 ++++++++++++++++++++++++
>  t/t9400-git-cvsserver-server.sh |   55 +++++++++++++++++++++++++++++=
++++++++++
>  3 files changed, 127 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvss=
erver.txt
> index 7004dd2..59c8e5d 100644
> --- a/Documentation/git-cvsserver.txt
> +++ b/Documentation/git-cvsserver.txt
> @@ -100,10 +100,44 @@ looks like
>  ------
>
>  Only anonymous access is provided by pserve by default. To commit yo=
u

It is ok to squash 5/5 here, as that is so trivial.

> -will have to create pserver accounts, simply add a gitcvs.authdb
> -setting in the config file of the repositories you want the cvsserve=
r
> -to allow writes to, for example:
> +will have to specify an authentication option in the config file.
> +Currently there are two options are available for authentication thr=
ough

s/options are/options/;

> +pserver in git-cvsserver: one through an authenticator script and an=
 other
> +through a textual authentication database.
> +
> +  a. To use the authentication script based method, simply add a
> +     gitcvs.authscript setting in the config file of the repositorie=
s you want
> +     the cvsserver to allow writes to, for example:

Why "simply"?  Adding that word does not make the procedure nor the
explanation any simpler than it is.  Just drop it.

More importantly, you should explicitly say what _value_ the variable
should be set to, and what it means.  E.g.

	...method, set the gitcvs.authscript variable to the path of your
        custom authentication script in the repository.

You already said that the user needs to specify an auth option to allow
write access, so there is no need to repeat "you want ... to allow writ=
es
to" here.

> +The file specified here must be executable by the user the git-cvsse=
rver runs
> +under. The script will receive two lines on standard input, the firs=
t is the

s/under/as/; s/standard input/the &/;

> +username and the second is the password. It should return 0 if the u=
ser was
> +successfully authenticated, and a non-zero value if not.
> +Here is an example for an authentication script which checks the use=
rs against
> +active directory:
> +------
> +#!/bin/sh
> +# /usr/local/bin/cvsserver-auth.sh
>
> +read username
> +read password
> +
> +wbinfo -a "${username}%${password}"

Exposing username/password pair on a command line looks like a not-so-g=
ood
example.  Also it is a bit disturbing to see that wbinfo(1) says:

       -a username%password
              Attempt to authenticate a user via winbindd.  This  check=
s
              both
              authenticaion methods and reports its results.

              Note

              Do  not  be tempted to use this functionality for
              authentication
              in third-party applications. Instead use ntlm_auth(1).

> +  b. To use the authentication database based method, simply add a
> +     gitcvs.authdb setting in the config file of the repositories yo=
u want the
> +     cvsserver to allow writes to, for example:

Likewise.

> diff --git a/git-cvsserver.perl b/git-cvsserver.perl
> index e9f3037..c89d999 100755
> --- a/git-cvsserver.perl
> +++ b/git-cvsserver.perl
> @@ -197,6 +197,40 @@ if ($state->{method} eq 'pserver') {
>         }
>
>         # Fall through to LOVE
> +    } elsif (exists $cfg->{gitcvs}->{authscript} and
> +             exists $cfg->{gitcvs}->{authdb}) {
> +        print "E Ambiguous configuration of authentication methods. =
" .
> +            "Only one authentication method can be enabled at once\n=
";
> +        print "I HATE YOU\n";
> +        exit 1;

Hmph.  It is not unconceivable that you would want to use an authscript
that gives company or group wide user database, augmented with an authd=
b
that is for the particular repository...  Of course if we do that we wo=
uld
need a way to specify which one wins when both knows about the user.

> +    } elsif (exists $cfg->{gitcvs}->{authscript}) {
> +        my $authscript =3D $cfg->{gitcvs}->{authscript};
> +
> +        unless (-x $authscript) {
> +            print "E The authentication script specified in " .
> +                "[gitcvs.authscript] cannot be executed\n";
> +            print "I HATE YOU\n";
> +            exit 1;
> +        }
> +
> +        open my $script_fd, '|-', "'$authscript'"
> +            or die "Couldn't open authentication script '$authscript=
': $!";
> +
> +        if (length($password) > 0) {
> +            $password =3D descramble($password);
> +        }
> +
> +        print $script_fd "$user\n";
> +        print $script_fd "$password\n";
> +        close $script_fd;

Don't you need to check the return value of "close" here, even if you w=
ill
also check the value of $? next?

> +        unless ($? =3D=3D 0) {
> +            print "E External script authentication failed.\n";
> +            print "I HATE YOU\n";

I don't think this "E" is necessary nor desirable.  Does the existing
password database authenticator codepath say "authentication failed" li=
ke
this, when it gets a wrong password?

> @@ -134,6 +144,51 @@ test_expect_success 'pserver authentication
> failure (login/non-anonymous user)'

Corrupt patch.
