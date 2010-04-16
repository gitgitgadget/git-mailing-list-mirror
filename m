From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH] Building Git on Tru64
Date: Fri, 16 Apr 2010 08:58:00 +0200
Message-ID: <h2y40aa078e1004152358s66299ef9p55d454902113c7d4@mail.gmail.com>
References: <1271358589.19032.1370170305@webmail.messagingengine.com>
	 <r2n81b0412b1004151229g6fe840a1v23a9d06f72e8d36a@mail.gmail.com>
	 <1271360809.25304.1370186353@webmail.messagingengine.com>
	 <m34ojcfly1.fsf@localhost.localdomain>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Daniel Richard G." <skunk@iskunk.org>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 16 08:58:12 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2fVD-0004KP-2J
	for gcvg-git-2@lo.gmane.org; Fri, 16 Apr 2010 08:58:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756983Ab0DPG6F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Apr 2010 02:58:05 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:62408 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756924Ab0DPG6B convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Apr 2010 02:58:01 -0400
Received: by wwb24 with SMTP id 24so965006wwb.19
        for <git@vger.kernel.org>; Thu, 15 Apr 2010 23:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=AbgOw7bMMUNJScFcPkExrsz0+C3N6Yvme8lv+laAx3E=;
        b=LkRKJCxSMSdhyHpQ/YSfM1cqic1mKv8SmtP0sJH4W49AhbPu4sc1Ef+dGR3DXvEYSo
         Ae84YA6IrKzLFRgihmiRmO2iNzGQBJQjHPF4do6EC03l6QN5kJKhVmRa5mfd3P0sXY0E
         TwztDx0BayTgQXQh7Ub71xkuPhfzDBbmcEYHY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=QzBZiHcfrNQWIg/l4ken24zBLP1wN2tGHUwmcdi+RQdlyvJBK0mUdBeRWpO3j6HAJt
         WJFS7W1YdLgcHL3jliFb4y2o9r332rMr4BwoO2/wqdakOLUMY3m/sk7RxOET+6ODX6WI
         PiNYteabNHf8lh6Vl02eGcPGSmzqM+Ic5PC0Y=
Received: by 10.216.73.8 with HTTP; Thu, 15 Apr 2010 23:58:00 -0700 (PDT)
In-Reply-To: <m34ojcfly1.fsf@localhost.localdomain>
Received: by 10.216.158.3 with SMTP id p3mr1226688wek.9.1271401080154; Thu, 15 
	Apr 2010 23:58:00 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145054>

On Thu, Apr 15, 2010 at 11:24 PM, Jakub Narebski <jnareb@gmail.com> wro=
te:
> "Daniel Richard G." <skunk@iSKUNK.ORG> writes:
>
>> On Thu, 2010 Apr 15 21:29+0200, Alex Riesen wrote:
>> >
>> > That one may be better handled at one place (git-compat-util.h?) w=
ith
>> > something like:
>> >
>> > =A0 #ifdef Tru64
>> > =A0 #define MAP_FAILED ((void *)MAP_FAILED)
>> > =A0 #endif
>>
>> I agree with the sentiment, but you can't have a macro refer to itse=
lf
>
> It can. =A0From (cpp.info)
>
> =A03.10.5 Self-Referential Macros
> =A0------------------------------
>
> =A0<snip> =A0It is passed into the
> =A0preprocessor output unchanged.
>

Not very useful in this case, no?

$ echo "#define MAP_FAILED (-1L)
#define MAP_FAILED ((void *)MAP_FAILED)
void *v =3D MAP_FAILED" | gcc -x c -
<stdin>:2:1: warning: "MAP_FAILED" redefined
<stdin>:1:1: warning: this is the location of the previous definition
<stdin>:3: error: 'MAP_FAILED' undeclared here (not in a function)
<stdin>:3: error: expected ',' or ';' at end of input
$ echo "#define MAP_FAILED (-1L)
#define MAP_FAILED ((void *)MAP_FAILED)
void *v =3D MAP_FAILED" | cpp
# 1 "<stdin>"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "<stdin>"
<stdin>:2:1: warning: "MAP_FAILED" redefined
<stdin>:1:1: warning: this is the location of the previous definition


void *v =3D ((void *)MAP_FAILED)
$

--=20
Erik "kusma" Faye-Lund
