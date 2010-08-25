From: Daniel Pfeiffer <occitan@t-online.de>
Subject: Re: Compiling git with makepp patch
Date: Wed, 25 Aug 2010 22:58:03 +0200
Message-ID: <4C7583DB.6010001@t-online.de>
References: <84FD9808A65CDF4C959FDB41FC3D134CBCF306D6@MSSRVS4.atlas.de>	<4C71A53F.2020108@t-online.de> <AANLkTinbTph=cggp4V=avorzrf9BT7vPtpanDtDtXm=q@mail.gmail.com>
Reply-To: occitan@esperanto.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: occitan@esperanto.org, git@vger.kernel.org,
	John 'Warthog9' Hawley <warthog9@kernel.org>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 25 22:58:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoN36-0003dw-GF
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 22:58:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753685Ab0HYU6Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Aug 2010 16:58:16 -0400
Received: from mailout02.t-online.de ([194.25.134.17]:48883 "EHLO
	mailout02.t-online.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752507Ab0HYU6O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Aug 2010 16:58:14 -0400
Received: from fwd07.aul.t-online.de (fwd07.aul.t-online.de )
	by mailout02.t-online.de with smtp 
	id 1OoN2y-0008Vt-DA; Wed, 25 Aug 2010 22:58:12 +0200
Received: from [192.168.0.10] (bVwS44ZCrh1DXlanVHcY7PklwWAoyEEf-oeace+Z-8eQuBZrpMHQ8U2aEDweIChZ0W@[84.177.184.117]) by fwd07.aul.t-online.de
	with esmtp id 1OoN2r-0mRdDM0; Wed, 25 Aug 2010 22:58:05 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.4) Gecko/20100608 Mnenhy/0.8.3 Thunderbird/3.1
In-Reply-To: <AANLkTinbTph=cggp4V=avorzrf9BT7vPtpanDtDtXm=q@mail.gmail.com>
X-ID: bVwS44ZCrh1DXlanVHcY7PklwWAoyEEf-oeace+Z-8eQuBZrpMHQ8U2aEDweIChZ0W
X-TOI-MSGID: 6775b493-6b56-48bf-898c-f69e5983268b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154474>

  la 08/23/2010 10:27 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason skribis=
:
> On Sun, Aug 22, 2010 at 22:31, Daniel Pfeiffer<occitan@t-online.de>  =
wrote:
>
>> Git has been giving our promise of Gnu make compatibility a hard
>> time.
> Aside from our bugs you can't make that promise if projects like Git
> need patches to work with makepp :)
Just two little things in your big makefiles.  The compatibility is jus=
t an=20
added bonus, we have many other real strengths in makepp.

>> The other thing caused me quite a headache before I understood:
>>
>> PERL_PATH_SQ  =3D $(subst ','\'',$(PERL_PATH))#'
>>
>> I suppose you added the comment for Emacs' syntax highlighting, to h=
ave an
>> even number of unescaped quotes.
> That was added by John 'Warthog9' Hawley, I wonder if that also came
> with a M-x report-emacs-bug, e.g. cperl-mode deals with that case,
> sounds like an easy-to-fix bug in makefile-gmake-mode.
Hardly, if you look at my example below!

>> The problem is makepp parses this line
>> just like Emacs, so it doesn't find the comment, adding in the #' at=
 the
>> point of use, which completely screws the sed command.  (You might w=
ant to
>> apply my fix to a few other makefiles, which have SQ variables, albe=
it
>> without the syntax highlighting workaround, so they are only visuall=
y
>> defect.)
> The reason Emacs has issues is because it uses an ad-hoc regexp based
> parser that favours speed above correctness for syntax
> highlighting.
Well, gmake rules are very twisted:  a and b don't do the same thing, b=
ecause=20
file functions shall respect quoting (though to my mind that should the=
n be=20
only one funny file name, which gmake gets wrong, splitting it up anywa=
y), and=20
c causes gmake to choke:

all: a b
a:
     echo : $(dir 'a # b/c/d') :

B =3D 'a # b/c/d'
b:
     echo : $(dir $B) :

C =3D $(dir 'a # b/c/d')
c:
     echo : $C :

> I'm surprised you've gotten this far with makepp if you don't tokeniz=
e
> comments and throw their contents away.
There are a few subtle differences, which mostly don't hurt.

coralament / best Gr=C3=B6tens / liebe Gr=C3=BC=C3=9Fe / best regards /=
 elkorajn salutojn
Daniel Pfeiffer

--=20
lerne / learn / apprends / l=C3=A4r dig / ucz si=C4=99    Esperanto:
                     http://lernu.net  /  http://ikurso.net
