From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [RFC PATCH] git-p4: add option to store files in Git LFS on import
Date: Thu, 3 Sep 2015 11:40:20 +0200
Message-ID: <1D65DD68-EE3F-4C87-9B5F-E436BA13704E@gmail.com>
References: <1440764691-62254-1-git-send-email-larsxschneider@gmail.com> <CAE5ih7-TfLqwye8YpmZz90AVjYGQ8m0sF6GLKnG9pjvV8cTSjw@mail.gmail.com> <9951C805-DFBF-47AC-B215-B9C657D4A852@gmail.com> <CAE5ih7-w5ZjO=QUE45yBvwyqdqKCADczrLt7=4W8X6BR+cy4PA@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Users <git@vger.kernel.org>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Thu Sep 03 11:40:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXR0N-0000i0-Vl
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 11:40:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753007AbbICJkY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Sep 2015 05:40:24 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:36556 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752810AbbICJkY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Sep 2015 05:40:24 -0400
Received: by wibz8 with SMTP id z8so92373329wib.1
        for <git@vger.kernel.org>; Thu, 03 Sep 2015 02:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+2QXrr2XT1RdF+E54PNBr+TK2aygW70+8ODe322auIQ=;
        b=WWouPtp3ozH4T3REzz8ZznKr7aOkNi1ivCwxI9m0AstizKOAv8LwFPCPQyLbz8UziE
         gtbxl423KjgHHyyrsBj7kCFDvDNZVHxfveD3InZDf70RqPoRuupLMRDuRx6yB+0B55vt
         OZRHzr5D81QhkrIa0FeumB0Ejnei6Giy9wYQZkMKwuaauiyasX8BgkbmwM/z89Q/GzPb
         qQp73WRZFBitm94HqX0GttwTrIemrjd05IVLEhXKXm8/nvxKlG3iYlw0a5fRsrNNA5uu
         WgKS2vVMuXQvstGi6UXwiadCT8kiKkv/dhzw7eLd2uzP/Cn0voF8SxetRJx8cPpD4Gsd
         cb4Q==
X-Received: by 10.180.37.201 with SMTP id a9mr12883452wik.83.1441273222924;
        Thu, 03 Sep 2015 02:40:22 -0700 (PDT)
Received: from slxbook3.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id hn2sm36821863wjc.45.2015.09.03.02.40.22
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 03 Sep 2015 02:40:22 -0700 (PDT)
In-Reply-To: <CAE5ih7-w5ZjO=QUE45yBvwyqdqKCADczrLt7=4W8X6BR+cy4PA@mail.gmail.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277192>


On 30 Aug 2015, at 18:36, Luke Diamand <luke@diamand.org> wrote:

> On 30 August 2015 at 11:18, Lars Schneider <larsxschneider@gmail.com>=
 wrote:
>> Thanks for your feedback!
>>=20
>> I like the =93handle big files=94 plugin kind of idea. However, I wo=
nder if it makes sense to put more and more stuff into git-p4.py (>3000=
 LOC already). What do you think about splitting git-p4 into multiple f=
iles?
>=20
> I was wondering about that. I think for now, the simplicity of keepin=
g
> everything in one file is worth the slight extra pain. I don't imagin=
e
> that the big-file-handler code would be very large.
OK.

>=20
>>=20
>> Regarding Python 3:
>> Would you drop Python 2 support or do you want to support Python 2/3=
 in parallel? I would prefer the former=85
>=20
> For quite some time we would need to support both; we can't just have
> a release of git that one day breaks git-p4 for people stuck on Pytho=
n
> 2. But it might not be that hard to support both (though converting
> all those print statements could be quite tiresome).
Agreed. However supporting both versions increases code complexity as w=
ell as testing effort. Would a compromise like the following work? We f=
ork =93git-p4.py=94 to =93git-p4-python2.py=94 and just apply important=
 bug fixes to that file. All new development happens on a Python 3 only=
 git-p4.py.=20

Cheers,
Lars