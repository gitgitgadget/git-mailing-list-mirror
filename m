From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv2/RFC] gitweb: Prepare for splitting gitweb
Date: Wed, 7 Jul 2010 22:05:12 +0200
Message-ID: <201007072205.14345.jnareb@gmail.com>
References: <1278496676-26575-1-git-send-email-jnareb@gmail.com> <AANLkTinxDSS2G60_nQ12UqZpSJCvg_kfWYKzmTqJU7Ox@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Petr Baudis <pasky@ucw.cz>,
	Christian Couder <chriscool@tuxfamily.org>
To: =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 07 22:05:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWas8-0004zH-Bw
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 22:05:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757376Ab0GGUF0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Jul 2010 16:05:26 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:33094 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755354Ab0GGUFZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jul 2010 16:05:25 -0400
Received: by fxm14 with SMTP id 14so13798fxm.19
        for <git@vger.kernel.org>; Wed, 07 Jul 2010 13:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=+JQ6yXb+CNJH865F3b7oDVpXc4UpqUTYs8Vlw8q4P4M=;
        b=tluCuY6C0BXfTJXsGKdT7WpZV3KT47+vqDmq/PN2oFlJgz7pxI3JAdET/aMxBd2JA1
         SsVM9oU2tV84MNrsPCnGSUAvDVd00BPHFXu0JibQjAT10/4VDL5/LzLpUhItxJ9mjciT
         DKGxJg262bwFIMnDNfKfDa08raIDIeYoJ82U8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=BJp+yl7tLmW2T4fE7Fp7xqGcRiUHKAkzhzmMRvzA4fLlbqJOrmFhlfI72DuCIVf9g6
         96ihJqpFUHMysHQ/3XXMgrwGmEIENgUjehm3MVpgmQM0FZcIAA8Tdv3+BQoDixH5KAJJ
         rOjOdgDBkRTLP+RknR0x5vjw6ro6ioSlK7/5c=
Received: by 10.86.52.2 with SMTP id z2mr5397702fgz.72.1278533124237;
        Wed, 07 Jul 2010 13:05:24 -0700 (PDT)
Received: from [192.168.1.15] (abvr9.neoplus.adsl.tpnet.pl [83.8.215.9])
        by mx.google.com with ESMTPS id 26sm5375502fax.7.2010.07.07.13.05.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 07 Jul 2010 13:05:22 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTinxDSS2G60_nQ12UqZpSJCvg_kfWYKzmTqJU7Ox@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150497>

On Wed, 7 Jul 2010, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason napisa=C5=82=
:
> On Wed, Jul 7, 2010 at 09:57, Jakub Narebski <jnareb@gmail.com> wrote=
:
> > [...]
> > =C2=A0use strict;
> > =C2=A0use warnings;
> > +
> > +use File::Spec;
> > +# __DIR__ is taken from Dir::Self __DIR__ fragment
> > +sub __DIR__ () {
> > + =C2=A0 =C2=A0 =C2=A0 File::Spec->rel2abs(join '', (File::Spec->sp=
litpath(__FILE__))[0, 1]);
> > +}
> > +use lib __DIR__ . '/lib';
> > +
>=20
> What was the result of the discussion about using __DIR__ again? You
> only need to use that method when you call a perl program whith *then=
*
> includes a module. If you just need to add the lib/ directory relativ=
e
> to the script you're invoking you can use FindBin:
>=20
>     use FindBin qw($Bin);
>     use lib "$Bin/lib";

It's

      use lib "$Bin/../lib";

(I don't like this ../lib here, but that's my personal preference).

But you might be right that I am overly cautious in avoiding FindBin.
It is nowadays not recommended solution (on #perl, for example), but
it is perhaps true that the conditions where it fails are not fulfilled
for the case of gitweb.

Or perhaps not:

  KNOWN ISSUES

  If there are two modules using FindBin from different directories
  under the same interpreter, this won't work. Since FindBin uses a
  BEGIN block, it'll be executed only once, and only the first caller
  will get it right. This is a problem under **mod_perl** and other
  persistent Perl environments, where you shouldn't use this module.

Gitweb can be used under mod_perl (to be more exact ModPerl::Registry).

> > =C2=A0use CGI qw(:standard :escapeHTML -nosticky);
> > =C2=A0use CGI::Util qw(unescape);
> > =C2=A0use CGI::Carp qw(fatalsToBrowser set_message);
> > @@ -16,6 +24,7 @@ use Encode;
> > =C2=A0use Fcntl ':mode';
> > =C2=A0use File::Find qw();
> > =C2=A0use File::Basename qw(basename);
> > +
> > =C2=A0binmode STDOUT, ':utf8';
>=20
> The whitespace change distracts from the real patch a bit.

Ooops, I'm sorry.

I'll fix it in resend, if required.
--=20
Jakub Narebski
Poland
