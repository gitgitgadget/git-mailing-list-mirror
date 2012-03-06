From: Elia Pinto <gitter.spiros@gmail.com>
Subject: Re: [PATCH] configure.ac: Add --with-gcc-warnings configure option
Date: Tue, 6 Mar 2012 17:08:12 +0100
Message-ID: <CA+EOSBm6autG8MCe1fWC+8V=Kx6FkAuVdS-SLKUzkmxz-x-qiw@mail.gmail.com>
References: <1331044385-14796-1-git-send-email-gitter.spiros@gmail.com>
	<4F56329E.9050506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, jnareb@gmail.com
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 06 17:08:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4wvy-0002Jd-4f
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 17:08:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753397Ab2CFQIN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Mar 2012 11:08:13 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:47873 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753140Ab2CFQIM convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 6 Mar 2012 11:08:12 -0500
Received: by obbuo6 with SMTP id uo6so5587144obb.19
        for <git@vger.kernel.org>; Tue, 06 Mar 2012 08:08:12 -0800 (PST)
Received-SPF: pass (google.com: domain of gitter.spiros@gmail.com designates 10.182.141.9 as permitted sender) client-ip=10.182.141.9;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of gitter.spiros@gmail.com designates 10.182.141.9 as permitted sender) smtp.mail=gitter.spiros@gmail.com; dkim=pass header.i=gitter.spiros@gmail.com
Received: from mr.google.com ([10.182.141.9])
        by 10.182.141.9 with SMTP id rk9mr9996656obb.50.1331050092213 (num_hops = 1);
        Tue, 06 Mar 2012 08:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=2zTpv91uyP2EHieqyRi6ID8k98gnC6UdKHUIV8RzV8w=;
        b=LnqOgb+YpAYzvLODedMhwyII8WTpqUHurVB2ItFg/MmHCdfmgTdxaPGReNNqV9pCS/
         YJBu3datEYClLDC8D059dX8kmm5vwvJzbxhU4jtcbvXOhk58Gk5t5/8YdiUfboswhFHy
         evGvHExxegzPFtREulEGHOMDd+dlRsq+kjV2Y65jso0LVFB85IQgXN2xheE2Vl28iEZt
         f2Wd4jgB78b4+NpWciZ5rNacpgEvwgSfYzNBqLupWcZ+0/DO/mOP6AB5N9aw5hnzNxN7
         c9loc6r9oZiHDjWcrg9m05XNTlXlqmCQofVeemDIFNJ9rDL6LTzSHHKT7Zi9wRfyNZ4o
         0Y0g==
Received: by 10.182.141.9 with SMTP id rk9mr8783588obb.50.1331050092137; Tue,
 06 Mar 2012 08:08:12 -0800 (PST)
Received: by 10.182.81.202 with HTTP; Tue, 6 Mar 2012 08:08:12 -0800 (PST)
In-Reply-To: <4F56329E.9050506@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192361>

2012/3/6 Stefano Lattarini <stefano.lattarini@gmail.com>:
> On 03/06/2012 03:33 PM, Elia Pinto wrote:
>> Introduce a new --with-gcc-warnings configure option
>> using a new autoconf macro that check if the compiler
>> know the option passed or not in a portable way, as
>> it not depends from the gcc version or from the
>> other compiler used.
>>
>> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
>> ---
>> This is the version 2 of the patch, in which i have
>> slightly changed the commit message for
>> clarify the purpose. To activate the
>> patch is of course necessary to do a autoreconf -vfi after
>> applying the patch.
>>
>>
>> =A0Makefile =A0 =A0 =A0| =A0 =A02 +-
>> =A0config.mak.in | =A0 =A01 +
>> =A0configure.ac =A0| =A0118 ++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++
>> =A03 files changed, 120 insertions(+), 1 deletions(-)
>>
>> diff --git a/Makefile b/Makefile
>> index be1957a..d0aef0f 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -310,7 +310,7 @@ endif
>>
>> =A0CFLAGS =3D -g -O2 -Wall
>> =A0LDFLAGS =3D
>> -ALL_CFLAGS =3D $(CPPFLAGS) $(CFLAGS)
>> +ALL_CFLAGS =3D $(CPPFLAGS) $(CFLAGS) $(AM_CFLAGS)
>>
> Wouldn't it be better to use $(WARN_CFLAGS) here? =A0It makes the pur=
pose
> of the variable clearer, and don't give the wrong impression that Aut=
omake
> is involved (as the 'AM_' prefix might suggest).
Ok, this is derived from the similar patch in popt HEAD and in branch
1.17, for which i use  the full autofu.
No problem to reroll with your suggestions.

Thanks a lot

Regards

Elia
