From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: Re: [PATCH] compat/mingw.c: MSVC build must use ANSI Win32 API's
Date: Tue, 22 Sep 2009 11:40:15 +0200
Message-ID: <4AB89B7F.3050902@gmail.com>
References: <d2e97e800909212110w423e3b2fm85ac6f76439e0591@mail.gmail.com> 	<4AB869EE.1020200@viscovery.net> <4AB87B6B.1070808@gmail.com> <d2e97e800909220217y5bda4698pc286711a3535f87d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Michael Wookey <michaelwookey@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 22 11:40:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mq1rO-0005XW-4e
	for gcvg-git-2@lo.gmane.org; Tue, 22 Sep 2009 11:40:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755734AbZIVJkZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Sep 2009 05:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755554AbZIVJkY
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Sep 2009 05:40:24 -0400
Received: from mail-ew0-f211.google.com ([209.85.219.211]:43297 "EHLO
	mail-ew0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751084AbZIVJkY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2009 05:40:24 -0400
Received: by ewy7 with SMTP id 7so223785ewy.17
        for <git@vger.kernel.org>; Tue, 22 Sep 2009 02:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=5ns+5vwrgrWzSarDNSLReb0mQ/X9rCxr3OTLefXWU+8=;
        b=MjHNbCcoLEBpNW9w7ogQlTPT6Z/U8Ps4iqEREau/d+NRdPgv2eNtSj3w0T66RuMof8
         PAvn08jsToosv33C3Dj00t1ZYb++4uXFiVSHyyN7vpsdfEnoLa7cU+4YC+usZ6ftGT2A
         cmfI6RzXmZ5w3Mm3tCFenHHgIpT6/WYtRvUgU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=OcAQHLatVG2oCKZuwUF49wa/C57Bz1WDGGefwhXiZ3cPalibMb7Xt/o8+sloO4w5EH
         W7y4qUqpKvB3koU+a4bmCaRkN9Z0myD8Nz0gNiCSeQ4gKk2fzE+fiCeOWgmgkr3eUYGl
         exg63UwjoxdKozix4FWKjOkkDWGAMXYcUgg8Y=
Received: by 10.211.146.18 with SMTP id y18mr4176632ebn.55.1253612427183;
        Tue, 22 Sep 2009 02:40:27 -0700 (PDT)
Received: from ?172.24.90.95? ([62.70.27.104])
        by mx.google.com with ESMTPS id 28sm302398eye.38.2009.09.22.02.40.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 22 Sep 2009 02:40:26 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090812 Lightning/0.9 Thunderbird/2.0.0.23 ThunderGit/0.1a Mnenhy/0.7.6.666
In-Reply-To: <d2e97e800909220217y5bda4698pc286711a3535f87d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128927>

Michael Wookey said the following on 22.09.2009 11:17:
> 2009/9/22 Marius Storm-Olsen <mstormo@gmail.com>:
>> Michael, how are you trying to compile git? With the IDE or the
>> GNU Make? Which version of MSVC? If you use the IDE, can you make
>> sure it doesn't contain the UNICODE define in the compiler
>> section of the properties of the projects?
>=20
> I'm using the VS 2008 Professional IDE (the solution doesn't open
> in VS 2005). I made no changes to the build settings. In the
> Preprocessor section of the project, UNICODE is defined.

Were these projects generated with the Vcproj generator in=20
contrib/buildsystem, with the Qmake generator, or the projects from=20
=46rank's repo?


> On another note, I see *many* build warnings for things like=20
> "signed/unsigned compares". I'd be willing to work through these=20
> warnings and fix them. Thoughts?

Well, first find out why these are a problem with MSVC and not GCC.=20
Are the types different on these platforms? signed vs unsigned should=20
show up with GCC as well. We need to make sure that we don't fix=20
signed/unsigned issues on one platform, just to introduce it to=20
another platform.
In any case, it would be good for someone to have a look at these,=20
just so we can determine the cause for most of them, and then we=20
should figure out on the list how to deal with them.

Just my =E2=82=AC0.2..

--
=2Emarius
