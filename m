From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Revert "gitweb: Time::HiRes is in core for Perl 5.8"
Date: Fri, 27 Jan 2012 12:44:31 -0800
Message-ID: <7vty3gzxhs.fsf@alter.siamese.dyndns.org>
References: <hbf.20120123rqzg@bombur.uio.no>
 <CACBZZX4cjcY5d3mPJAV+rbSTqCEUOrF=_dd3ny_jSM++G-Bg1Q@mail.gmail.com>
 <201201271845.39576.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 27 21:44:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rqsf2-0005uR-EQ
	for gcvg-git-2@lo.gmane.org; Fri, 27 Jan 2012 21:44:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753988Ab2A0Uof convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Jan 2012 15:44:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50002 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753954Ab2A0Uoe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Jan 2012 15:44:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 87586653B;
	Fri, 27 Jan 2012 15:44:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=3htr5U3iczjv
	Aew7Sal3oMCQs/0=; b=r5qChMETRqSRTMamvLCQHXpU/qoDxPZtDyxHwUkG/FY+
	m/6bTzItV72cMe5pJwZXtKMaFdaIb6x0coJwbdcm3+Qbe2JW3KYOPXhpoW9F0QZb
	yv2tXKlPw6oJMVM5D6lZdIh07jLoo87CPaP0EOcqv1ZYUhwE7WHOfI5CjzXBIcg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=BoUkVk
	h8zuusqoY/HQKnSYlr/iuU+ZLsm1RqH3KlnIerFsDhw1VjEUM4vLdOlBSgiF5WWU
	qCNmrfAzz0JV+aWP0Y6RVeslC4+yuPalglPdPzDWlh+6cvgOvWXfqeVfqoWLx+qN
	Qk5DqQzDeByMvm3Fecy3RwONLD96LywlKK42I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7E904653A;
	Fri, 27 Jan 2012 15:44:33 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E5AB76538; Fri, 27 Jan 2012
 15:44:32 -0500 (EST)
In-Reply-To: <201201271845.39576.jnareb@gmail.com> (Jakub Narebski's message
 of "Fri, 27 Jan 2012 18:45:38 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B78800E4-4927-11E1-8C9B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189231>

Jakub Narebski <jnareb@gmail.com> writes:

> Though Time::HiRes is a core Perl module, it doesn't necessarily mean
> that it is included in 'perl' package, and that it is installed if
> Perl is installed.

I do not think we have seen the end of Redhat/Fedora Perl saga.  I am
hoping that either one of the two things to happen:

 (1) Redhat/Fedora distrubution reconsiders the situation and fix their
     packages so that by default when its users ask for "Perl" they get
     what the upstream distributes as "Perl" in full, while still allow=
ing
     people who know what they are doing to install a minimum subset
     "perl-base"; or

 (2) Many applications that use and rely on Perl like we do are hit by
     this issue, and Redhat/Fedora users are trained to install the
     perl-full (or whatever it is called) package when applications wan=
t
     "Perl".

In other words, I am hoping that "it doesn't necessarily mean" will not
stay true for a long time.  So please hold onto this patch until the du=
st
settles, and resend it if (1) does not look to be happening in say 3
months.


> For example RedHat has split it out to a separate RPM perl-Time-HiRes=
=2E
>
> Noticed-by: Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no>
> Suggested-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.co=
m>
> Signed-off-by: Jakub Nar=C4=99bski <jnareb@gmail.com>
> ---
>  gitweb/gitweb.perl |   12 +++++++-----
>  1 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index abb5a79..c86224a 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -17,10 +17,12 @@ use Encode;
>  use Fcntl ':mode';
>  use File::Find qw();
>  use File::Basename qw(basename);
> -use Time::HiRes qw(gettimeofday tv_interval);
>  binmode STDOUT, ':utf8';
> =20
> -our $t0 =3D [ gettimeofday() ];
> +our $t0;
> +if (eval { require Time::HiRes; 1; }) {
> +	$t0 =3D [Time::HiRes::gettimeofday()];
> +}
>  our $number_of_git_cmds =3D 0;

Why should these even be initialized here?  Doesn't reset_timer gets
called at the beginning of run_request()?
> =20
>  BEGIN {
> @@ -1142,7 +1144,7 @@ sub dispatch {
>  }
> =20
>  sub reset_timer {
> -	our $t0 =3D [ gettimeofday() ]
> +	our $t0 =3D [Time::HiRes::gettimeofday()]
>  		if defined $t0;
>  	our $number_of_git_cmds =3D 0;

The statement modifier look ugly.

More importantly, if you are not profiling, i.e. if we didn't initializ=
e
$t0 at the beginning, do you need to reset $number_of_git_cmds at all?

I also think this should take gitweb_check_feature('timed') into
account, perhaps like this:

	sub reset_timer {
        	return unless gitweb_check_feature('timed');
                our $t0 =3D ...
                our $number_of_git_cmds =3D 0;
	}

Then all the other

	if (defined $t0 && gitweb_check_feature('timed'))

can become

	if (defined $t0)

If you go this route, even though tee-zero, the beginning of the time, =
is
a good name for the variable, you may want to rename it to avoid confus=
ing
readers who might take it as a temporary variable #0.
