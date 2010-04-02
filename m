From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv5 3/6] Gitweb: add autoconfigure support for minifiers
Date: Sat, 3 Apr 2010 00:08:42 +0200
Message-ID: <201004030008.43513.jnareb@gmail.com>
References: <4BB430D9.1090900@mailservices.uwaterloo.ca> <CBD7C6CF-01CB-4525-8AAB-B1E8086CA06E@mailservices.uwaterloo.ca> <4BB6294A.7020800@mailservices.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Mark Rada <marada@uwaterloo.ca>
X-From: git-owner@vger.kernel.org Sat Apr 03 00:09:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nxp38-0005vs-QS
	for gcvg-git-2@lo.gmane.org; Sat, 03 Apr 2010 00:09:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755280Ab0DBWI4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Apr 2010 18:08:56 -0400
Received: from mail-qy0-f173.google.com ([209.85.221.173]:54989 "EHLO
	mail-qy0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755028Ab0DBWIy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Apr 2010 18:08:54 -0400
Received: by qyk4 with SMTP id 4so2998811qyk.24
        for <git@vger.kernel.org>; Fri, 02 Apr 2010 15:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=g1seTCAW8w58hFMUWNNPm3h9KwDPczBy6pxfCeaw65o=;
        b=ApNEIS16IIZakfS+RY7OOovlj9RFKvCfdT1+d9Ry2FOoEPlb1FxkX1njRYZoWE++kI
         UsaAlJ28VDPNy/H9TekienObpDRWA9qERvdqSydAo4CckrkhksM3Z1M1/wKZP6LoRlkH
         fxIt1Oh4/THXR98CFl/pURzanXYB1z76d13XA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=UWB52Mn+nFFBelNL+CSgBNa5R/+MRWxbIw20QjRBdy/qAs72LxoHc9ZXIUkgpugX+m
         kFcXpSbjvByzlYsSy4J1zv2TvDg5PwAZBU08sWG5tduNeUT22fAhovf0pzTEPeLH3fmU
         UW7gF0b5mqzKX0zVUjQh0vPIiDWWTRaIh5Mgs=
Received: by 10.229.226.1 with SMTP id iu1mr4321063qcb.19.1270246133539;
        Fri, 02 Apr 2010 15:08:53 -0700 (PDT)
Received: from [192.168.1.13] ([72.14.241.36])
        by mx.google.com with ESMTPS id v26sm1536032qce.13.2010.04.02.15.08.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 02 Apr 2010 15:08:52 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4BB6294A.7020800@mailservices.uwaterloo.ca>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143856>

Mark Rada wrote:

>>> Makefile        |    4 ----
>>> configure.ac    |   20 ++++++++++++++++++++
>>> gitweb/Makefile |   14 ++------------
>>> 3 files changed, 22 insertions(+), 16 deletions(-)
>>
>> Why there is no change to config.mak.in?  I would thought that it
>> would contain JSMIN=3D@JSMIN@ etc.
>>
>> But see also below: perhaps current version is a better version.
> =20
> I don't understand what you mean by this. Are you saying that the
> patch is good as is?

Yes, I think that while it could be improved a bit, it is good as
it is now.

I'm sorry for causing confusion: at first I was wondering why you do=20
not use JSMIN=3D@JSMIN@ etc. in config.mak.in, but then I noticed that
other existing configuration uses "add to config.mak.append" trick.

[...]
>>> +# Define option to enable CSS minification
>>> +AC_ARG_ENABLE([cssmin],
>>> + [AS_HELP_STRING([--enable-cssmin=3DARG],
>>> +   [ARG is the value to pass to make to enable CSS minification.])=
],
>>> + [
>>> +   CSSMIN=3D$enableval;
>>> +   AC_MSG_NOTICE([Setting CSSMIN to '$CSSMIN' to enable CSS minify=
ing])
>>> +   GIT_CONF_APPEND_LINE(CSSMIN=3D$enableval);
>>> + ])
>>> +
>>
>> Why not follow the code as it was done e.g. for iconv (--without-ico=
nv
>> and --with-iconv=3Dpath); this would require JSMIN=3D@JSMIN@ in=20
>> config.mak.in (and respectively for CSSMIN).

This is about alternate solution; please discard this question.

>> Alternatively, if you decide on appending to config.mak.autogen (by =
the
>> way of config.mak.append) instead of filling config.mak.in, why not =
use
>> ready macro GIT_PARSE_WITH_SET_MAKE_VAR?
> =20
> I think this is what I am really not understanding here. Are you sayi=
ng
> that you think it would be better to use =97with-OPT=3DPATH instead o=
f
> =97enable-OPT=3DPATH?=20
>=20
> Is this just a preference? I'm not seeing the problem with =97enable-=
OPT..
> This is confusing me a bit...

Well, I haven't noticed that GIT_PARSE_WITH_SET_MAKE_VAR uses=20
=97with-OPT=3DPATH and not =97enable-OPT=3DPATH.

What would be nice to have is GIT_PARSE_ENABLE_SET_MAKE_VAR macro... bu=
t
for only two callsites it might be overkill.

--=20
Jakub Narebski
Poland
