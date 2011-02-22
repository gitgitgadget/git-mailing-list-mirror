From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: The future of gitweb (long term goals)
Date: Tue, 22 Feb 2011 19:17:54 +0100
Message-ID: <201102221917.57247.jnareb@gmail.com>
References: <201102142039.59416.jnareb@gmail.com> <AANLkTin9dWXkaxqLdiosx-=jA9gbEqoJ8aAFoZMU94ih@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, John Hawley <warthog9@kernel.org>
To: =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 22 19:18:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrwoS-0001UE-DB
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 19:18:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755013Ab1BVSSL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 13:18:11 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48008 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754989Ab1BVSSK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 13:18:10 -0500
Received: by fxm17 with SMTP id 17so3027095fxm.19
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 10:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=Y8naDCTrUqre9uTN/Kc6A6AT10L1tVVLh5ofurGbNvQ=;
        b=G9Dc9tYzAEuxHcxbCU0ljRhsC2JlmGkHk0tME1pgN+1+JInKuJucyUTgctvdjekIy7
         a3oq07RR2MzZ0aXXx49E7DQBd3+oLAG/JSO574XmenZHtCWVwss/Zp697iYn0UDcfwiE
         7cfs8KEYYIi4IhYWqSQy5kApLJ2R0TSJ8fMK8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=MgM76rb/3rRfNb28N0Kl1a79kV636Qtvkaax4C+c3bTID7S++fMlPtc+SeDuBUBF4f
         8T6FORokdAM7Ub2mJNHJNcqFxg+j6u2hq16kQ+tKpUO7E87uSRNu8X8PweaDU7CxCQQC
         4M1fJPFMrCVU+onhOGj/527r/EsilBiZmUa9w=
Received: by 10.223.36.220 with SMTP id u28mr3818034fad.11.1298398682908;
        Tue, 22 Feb 2011 10:18:02 -0800 (PST)
Received: from [192.168.1.13] (abwn36.neoplus.adsl.tpnet.pl [83.8.237.36])
        by mx.google.com with ESMTPS id a6sm5465fak.3.2011.02.22.10.17.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 10:18:00 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTin9dWXkaxqLdiosx-=jA9gbEqoJ8aAFoZMU94ih@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167569>

On Tue, 22 Feb 2011, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Mon, Feb 14, 2011 at 20:39, Jakub Narebski <jnareb@gmail.com> wrot=
e:

> > This means that we are not able to use web (micro)framework, or use
> > templating engine to create HTML instead of combination of CGI.pm
> > methods and handcrafted HTML (worrying about proper escaping), or j=
ust
> > use CGI::Cache or Plack::Middleware::Cache for adding output cachin=
g
> > to gitweb. =C2=A0Though if one wants web interface in Perl that use=
s web
> > framework (and is supposedly backwards-compatible with gitweb URLs)=
,
> > there is always Gitalist which uses Catalyst web framework.
> >
> > On the other hand requiring non-core Perl modules means that gitweb
> > installation would be harder. =C2=A0We can work around this issue i=
f there
> > are a few small such modules (e.g. using Exception::Class or
> > HTTP::Exception as base class for gitweb error handling) by putting
> > them in 'inc/' and installing local version if they are not present=
,
> > like Git.pm does with local Error.pm module. =C2=A0But for microfra=
mework,
> > or templating engine, or e.g. Plack (if we go the route to make git=
web
> > PSGI application) this would be rather out of question. =C2=A0Anywa=
y, in
> > any case gitweb would probably require more complicated build syste=
m
> > than current one... but moving to e.g. ExtUtils::MakeMaker shouldn'=
t
> > be that hard (see how Git.pm does it, only we can require Perl 5.8.=
3
> > which has new enough EU::MM that supports DESTDIR).
>=20
> Why do you think that if we use larger modules these things would get
> harder?

I mean here that while it makes sense to bundle some version of require=
d
modules in e.g. 'gitweb/inc/' (or 'perl/inc/') in gitweb sources if the=
re
are few small self-contained modules (like e.g. Try::Tiny, or
Capture::Tiny), I don't think that bloating git repository with Perl
dependencies would be a good idea.

Well, we could get them from CPAN during build if they are not present,
and/or download them and include in generated tarball...

> There's already applications on the CPAN which can do "fat
> packing". I.e. you could use Plack, Catalyst, Template and whatever
> else but run some make target to pack gitweb and all its dependencies
> into a single file.
>=20
> Obviously it would be really big, and probably slow unless you ran it
> as a fastcgi script. But that would be a tradeoff for making the
> source easier to maintain.

Well, I know of two such modules: App::FatPack and PAR... neither of wh=
ich
is in core.  But the issue is not with installing or bundling modules
when they are present, I think; we can always install modules alongside
gitweb in 'lib/' subdirectory, even if you don't have admin rights to
install those required modules system-wide.
=20
And there is also local::lib, though the problem is that it is web serv=
er
user account that has to have path to Perl modules set up correctly.

> But packing things like these is not a technical challange at all, an=
d
> probably way easier than reinventing the wheel each time you need som=
e
> small thing that's not in core, but is in a popular & well tested CPA=
N
> module.

Well, there already exists Gitalist, which is Perl web interface to git
repositories, which uses Catalyst MVC web framework (and which purposed=
ly
is backwards compatible with gitweb URLs, though I am not sure about=20
path_info-based ones).

There is a question of balance (minimal dependencies or not reinventing
the wheel) and choice (which of types of server to support: CGI, FastCG=
I,
mod_perl, PSGI; what templating engine to use: Template Toolkit,=20
Template::Xslate, Tenjin, Template::Declare / Markapl, Template::Semant=
ic
and HTML::Zoom, Template::Moustache; what framework or microframework
to use: Mojolicus, Dancer, Web::Simple, Catalyst, Jifty, CGI::Applicati=
on,
Mason, etc.).

--=20
Jakub Narebski
Poland
