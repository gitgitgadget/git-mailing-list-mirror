From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: fixes to gitweb feature check code
Date: Wed, 3 Dec 2008 02:21:30 +0100
Message-ID: <200812030221.31180.jnareb@gmail.com>
References: <Message-ID: <cb7bb73a0811291731g7f8770f7p89e924c00d2ab004@mail.gmail.com> <200812020253.09430.jnareb@gmail.com> <7v4p1mp7hx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 02:22:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7gRU-0002qN-SK
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 02:22:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752315AbYLCBUy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Dec 2008 20:20:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752643AbYLCBUy
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 20:20:54 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:21323 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752212AbYLCBUx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2008 20:20:53 -0500
Received: by nf-out-0910.google.com with SMTP id d3so1737482nfc.21
        for <git@vger.kernel.org>; Tue, 02 Dec 2008 17:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=SufARBGADkCq0myg4Yr7Hr4Dx3k18Bhq/VdlzPaIB2w=;
        b=nQlu0qa/eb5EPbXW6n1miCpFZqcDLikBloMCxzQWaYu5dMoAglfxNsSN1y0EsubUlB
         2diaJXKmYINzdfS89d/0BAmfIlz/h1rGG0AkFvK1W0rIFfMc6EHXTIxcgjYR56kFD218
         pwmKJtLhVG31I9BhDS2oyrQaGFs9lUeMScr3o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=N8eF0umSR4SBJAsk1AmxjXbh8V3LUXwRHj3NYLVVD1AOA+VrTgfFJ5nMl49PPr4+fH
         3Lkr3XnZnWARc3ZcWLgIdE7ufkXGFnyJaxSnU8OKhcavBTZcjMqKf60v79I2lXhrunqX
         PcsD1me4izb7ThA5XODZIJO2L6yAF5d0jaxfk=
Received: by 10.210.90.10 with SMTP id n10mr14798333ebb.56.1228267251127;
        Tue, 02 Dec 2008 17:20:51 -0800 (PST)
Received: from ?192.168.1.11? (abvk204.neoplus.adsl.tpnet.pl [83.8.208.204])
        by mx.google.com with ESMTPS id 7sm6000446eyb.44.2008.12.02.17.20.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 02 Dec 2008 17:20:50 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7v4p1mp7hx.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102196>

Dnia wtorek 2. grudnia 2008 22:55, Junio C Hamano napisa=B3:
> Jakub Narebski <jnareb@gmail.com> writes:
>=20
> > What I like about having all this, i.e. fix, futureproof and style
> > correction in one single patch is the fact that fix doesn't introdu=
ce
> > strange looking (gitweb_check_feature('bool_feat'))[0]... well, exc=
ept
> > encapsulated in a subroutine.
> >
> > From all possible splits of this feature into series of up to three
> > patches I think I like the one with pure subroutine rename from *ch=
eck*
> > to *get* least...
>=20
> Well, I have to say that you have a strange taste, sense of prioritie=
s,
> and perhaps aversion to logical progression.  Let's explain one more
> time.
>=20
> The case we had at hand was that a callee has a less-than-ideal calli=
ng
> convention that has caused a few bugs by callers because they did not
> understand the calling convention.  You can argue it is not entirely
> caller's fault that they failed to follow the calling convention, but=
 the
> fact remains that there are bugs taken as a whole.
>=20
> First we fix the callers, because existing bugs get highest priority.
> This is a pure bugfix patch that could even go to maintenance "bugfix
> only" branch.

I agree here.

> Then we fix the calling convention because we all know that the calli=
ng
> convention was less-than-ideal.  A large part of the reason the calli=
ng
> convention was confusing was because the wording "check" implied it w=
as a
> boolean function.  Logically, s/check/get/ would be a major part of f=
ixing
> that.

And here I slightly disagree. The lone change s/check/get/ doesn't
actually do anything. Splitting wrongly named 'check' into checking
if feature is enabled and actual getting config does. And it is IMVHO
quote obvious which calls are to be to new semantic of 'check':
  my ($var) =3D gitweb_check_feature('feature');
and
  (gitweb_check_feature('feature'))[0]

and which are to be renamed to 'get':
  my ($a, $b) =3D gitweb_check_feature('feature');
and
  my @a  =3D gitweb_check_feature('feature');

Perhaps it is more clear from the point of view of reviewing individual
pieces...

--=20
Jakub Narebski
Poland
