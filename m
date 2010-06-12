From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH 1/4] gitweb: Move subroutines to Gitweb::Config module
Date: Sat, 12 Jun 2010 03:01:34 +0200
Message-ID: <201006120301.37931.jnareb@gmail.com>
References: <1275943844-24991-1-git-send-email-pavan.sss1991@gmail.com> <201006081446.22587.jnareb@gmail.com> <AANLkTimq-46ghYT6TqXn1AB0NQIobcDaufsSJ5AEFE5z@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Petr Baudis <pasky@ucw.cz>
To: =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 12 03:02:00 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONF6k-00021X-EE
	for gcvg-git-2@lo.gmane.org; Sat, 12 Jun 2010 03:01:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752225Ab0FLBBn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 11 Jun 2010 21:01:43 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:51150 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751593Ab0FLBBm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jun 2010 21:01:42 -0400
Received: by fg-out-1718.google.com with SMTP id d23so493370fga.1
        for <git@vger.kernel.org>; Fri, 11 Jun 2010 18:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=zagb7SQW2i3ADD2y1dqoRsYz3cMWBuzHTFNDBukVc6s=;
        b=MSIgWs+ABRmY17+KdmB1Mjf7xq8wIUDpIzI883ioGJGflEi3IDWPwwPcQj813Ba3Ua
         PSULnlSrkmAQJmxm6/9QNapCdLGaz4aXgR6Pln9kMFWaAlweskWvb+TLJFzFO6cHBft9
         oz3O4h+weSn/XGO6urLbNj7bhINNmYEnARH6c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=LmlDMDBgqcET1lYNdE59TeOglZE3u3NI+JJIDVIxKtDv553nUniKQ1iGtksDt+3Ze2
         qIvcTAorq8LilksvyYuxvA1IFRn8aQpd5EyKYmZbR6+HIM5msb1MGblmlrI/5lWP6RNi
         RoIh0V8JtH3Ep+Z7HToitZkmi21KT9LIX6V34=
Received: by 10.87.67.25 with SMTP id u25mr4528791fgk.32.1276304498767;
        Fri, 11 Jun 2010 18:01:38 -0700 (PDT)
Received: from [192.168.1.15] (abrz228.neoplus.adsl.tpnet.pl [83.8.119.228])
        by mx.google.com with ESMTPS id l12sm2634988fgb.7.2010.06.11.18.01.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 11 Jun 2010 18:01:37 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTimq-46ghYT6TqXn1AB0NQIobcDaufsSJ5AEFE5z@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148980>

On Tue, 8 June 2010, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> I haven't contributed to Gitweb, nor do I have to deal with it. But
> I've followed this series and reviewed most of the Perl code in
> Git. Take these with a grain of salt.
>=20
> It would be very useful for the future of our Perl code if we had a
> dual-life system in Git. I.e. a cpan/ directory where we could drop
> CPAN modules that should be shipped with Git.

The standard name for such directory is 'inc/', I think.

There is for example 'inc::latest' module (unfortunately in core only
since latest Perl, i.e. version 5.12), which uses modules bundled in
'inc/' if they are newer than installed ones.  It is in Module-Build
distribution.

BTW. it's a pity that PAR (Perl Archiving Toolkit, par.perl.org)
is not in core...

>=20
> We already do this in a less sophisticated way for Error.pm, is there
> any reason not to expand it to install more CPAN modules if they
> aren't present on the system? That'd allow us to use them, but still
> only depend on vanilla Perl.

Sidenote about Error.pm: from what I understand modern consensus is
that Error.pm was a failed approach, and currently recommended way to
use exceptions in Perl is via block form of eval, e.g. Try::Tiny or
TryCatch (this requires Moose and PPI), and not Error.

The Error documentation nowadays includes the following instructions:

  WARNING

  Using the "Error" module is no longer recommended due to the
  black-magical nature of its syntactic sugar, which often tends to
  break. Its maintainers have stopped actively writing code that uses
  it, and discourage people from doing so. See the "SEE ALSO" section
  below for better recommendations.

  [...]

  SEE ALSO

  See Exception::Class for a different module providing Object-Oriented
  exception handling, along with a convenient syntax for declaring
  hierarchies for them. It doesn't provide Error's syntactic sugar of
  'try { ... }, catch { ... }', etc. which may be a good thing or a bad
  thing based on what you want. (Because Error's syntactic sugar tends
  to break.)

  Error::Exception aims to combine Error and Exception::Class "with
  correct stringification".

  TryCatch and Try::Tiny are similar in concept to Error.pm only
  providing a syntax that hopefully breaks less.

>=20
> Then we could just use e.g. Config::General (~3k lines of code)
> instead of writing our own config system. There are probably lots of
> wheels that we're inventing (and are going to invent) that have been
> done better elsewhere, with more testing.

The problem with _optional_ Config::General config is that people
would have incompatibile gitweb config files, some using Config::Genera=
l
syntax, some current configuration in Perl.
=20
> Unlike Python or Java, Perl's policy is for core modules is to only
> include those required to better bootstrap the CPAN toolchain. So if
> we continue sticking to core Perl our code is only going to drift
> further away from Perl best practices.

Right.

Still, we don't want to require having half of CPAN in 'inc/' to
install gitweb.  Perhaps "no non-core dependencies" is too strict,
and should be replaced by "minimal non-core depencencies".

--=20
Jakub Narebski
Poland
