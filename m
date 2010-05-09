From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/2] gitweb: Add support for running gitweb as FastCGI script
Date: Sun, 9 May 2010 14:39:23 +0200
Message-ID: <201005091439.26310.jnareb@gmail.com>
References: <1273236845-6523-1-git-send-email-jnareb@gmail.com> <201005090041.11864.jnareb@gmail.com> <20100509093100.GA7641@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Sam Vilain <sam.vilain@catalyst.net.nz>,
	Juan Jose Comellas <juanjo@comellas.org>,
	Peter Vereshagin <peter@vereshagin.org>,
	John Goerzen <jgoerzen@complete.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun May 09 14:39:52 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OB5nT-0005OZ-C8
	for gcvg-git-2@lo.gmane.org; Sun, 09 May 2010 14:39:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135Ab0EIMjh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 May 2010 08:39:37 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53905 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750899Ab0EIMjg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 May 2010 08:39:36 -0400
Received: by fxm10 with SMTP id 10so1700455fxm.19
        for <git@vger.kernel.org>; Sun, 09 May 2010 05:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=bRmrN8IyWAV0lDnVqoe6EVzc2g8Ub1L379NiyW1QEGs=;
        b=hPs/zKMt+TOc/WoeK8wVqPlm2sCvOxcxJgJlHNvvjUyzvClYyyi+HGDuanMRCE0HPb
         tOYDUdxQ/PCe7r4Zb/AQG7nybUAPwC9OerGb1WdYVFeOM0ky7veXr2KHYc/pu1K9WAG+
         rOkOGbUPTKb9+RM7qoa/CFlmXj/oclNd9dcLs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=R1RbxIgRnh/d3RnXZw5YnPSpsH+jqMP0uiEqy4G/FXRB0q9mHB/znymiH8iUIcOjf6
         SNY/dQBnWgD69zVxw8aCiLK69t4shjvqNl27FeGVkJARsgCh8xqsVpQRFwsjykupD3H/
         brrnJTAhVO5FDlgFosTg1MtLSwEXHvX18Y8gg=
Received: by 10.223.21.22 with SMTP id h22mr2652058fab.106.1273408774677;
        Sun, 09 May 2010 05:39:34 -0700 (PDT)
Received: from [192.168.1.13] (abwi51.neoplus.adsl.tpnet.pl [83.8.232.51])
        by mx.google.com with ESMTPS id j23sm16355218faa.14.2010.05.09.05.39.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 09 May 2010 05:39:33 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20100509093100.GA7641@dcvr.yhbt.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146723>

On Sun, 9 May 2010, Eric Wong wrote:
> Jakub Narebski <jnareb@gmail.com> wrote:
>> On Fri, 7 May 2010, Jakub Narebski wrote:
>>=20
>>> The alternate solution would be to add gitweb.fcgi wrapper, like e.=
g.:
>>> in the following patch by Eric Wong
>>>=20
>>> =A0 "[PATCH 1/2] gitweb: add a simple wrapper for FCGI support"
>>> =A0 http://thread.gmane.org/gmane.comp.version-control.git/35920/fo=
cus=3D35921
>>>=20
>>> which was part of the "[0/2 PATCH] FastCGI and nginx support for gi=
tweb"
>>> series. =A0(Note that the patch does 'do $gitweb_cgi;' without chec=
king for
>>> errors, see the bottom of `perldoc -f do` documentation on how it s=
hould
>>> be done).
>>=20
>> I think a better solution here would be to use CGI::Compile instead
>> of 'do $gitweb_cgi;'.
>=20
> Possibly, now that CGI::Compile exists.  Can that be used with a
> standalone Perl HTTP server?

Yes, it can.  CGI::Compile is used for example by CGI::Emulate::PSGI,
and you can run PSGI app on standalone Perl web server (pure Perl
HTTP::Server::PSGI, or HTTP::Server::Simple::PSGI which in turn uses
HTTP::Server::Simple, or Starman, or Twiggy, or Perlbal).  CGI::Compile
just compiles given CGI script into a subroutine, which can be called
many times in a persistent web environment like FastCGI.

>=20
> It's 2010 now and I have long abandoned FastCGI in favor of using HTT=
P
> to the application backends.  In my experience, having only one
> plain-text protocol for both frontend web serving and backend
> application RPC makes development/monitoring/testing much easier.

Do you mean here standalone web server in the language of web applicati=
on?

>
> I just use Ruby WEBrick nowadays for any instaweb instances I run to
> share with a few cow-orkers.  I do a reasonable amount of development=
 in
> Ruby, so it's always installed and ready for me.  It would be nice if
> there were something standalone and as ubiquitous as WEBrick in the P=
erl
> world.

Modern Perl has PSGI/Plack (http://plackperl.org), which was inspired b=
y
Python's WSGI and Ruby's Rack.  The Plack reference implementation incl=
udes
'plackup' tool (inspired by Ruby's 'rackup'), which can be used to run
a PSGI application on any supported web server (with Plackup's adapter)=
,
like HTTP::Server::PSGI, HTTP::Server::Simple::PSGI, etc.

PSGI/Plack goal is to be THE superglue interface between perl web=20
application frameworks and web servers.


P.S. BTW, I use the following wrapper for gitweb.cgi (in gitweb.psgi)

-- 8< --
#!/usr/bin/env plackup

# gitweb - simple web interface to track changes in git repositories
#          PSGI wrapper (see http://plackperl.org)

use strict;
use warnings;

use Plack::Builder;
use Plack::App::WrapCGI;
use CGI::Emulate::PSGI 0.07; # minimum version required to work

use File::Spec;
# __DIR__ is taken from Dir::Self __DIR__ fragment
sub __DIR__ () {
	File::Spec->rel2abs(join '', (File::Spec->splitpath(__FILE__))[0, 1]);
}

builder {
	enable 'Static',
		path =3D> sub { m!\.(js|css|png)$! && s!^/gitweb/!! }, root =3D> __DI=
R__."/";
	Plack::App::WrapCGI->new(script =3D> __DIR__."/gitweb.cgi")->to_app;
}

__END__
-- >8 --

Thanks to the she-bang line (I don't have plackup installed globally,=20
but it is in my $PATH) I can just run ./gitweb.psgi to start server
(http://0:5000/) with gitweb running.

--=20
Jakub Narebski
Poland
