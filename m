From: Brandon Casey <drafnel@gmail.com>
Subject: Re: Fwd: permission to re-license strbuf subsystem as LGPL
Date: Fri, 23 Sep 2011 17:50:27 -0500
Message-ID: <CA+sFfMdt-95rfaZmiYAHx02Ukjt_WN-kLJr410AzZfGHYkSv5w@mail.gmail.com>
References: <CA+sFfMeRDQiqGhO9Y=k3tEnzdXjMx59huFE_fx6Y14cJxj1J=Q@mail.gmail.com>
	<CA+sFfMcmsKkKM7C0g4vKmjmCCNqRHuvz-hwEHAm=+stqnOPpAw@mail.gmail.com>
	<m3mxdvqj31.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 24 00:50:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7EZo-0000g7-2G
	for gcvg-git-2@lo.gmane.org; Sat, 24 Sep 2011 00:50:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752736Ab1IWWua convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Sep 2011 18:50:30 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:39223 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752413Ab1IWWua convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Sep 2011 18:50:30 -0400
Received: by fxe4 with SMTP id 4so4273591fxe.19
        for <git@vger.kernel.org>; Fri, 23 Sep 2011 15:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=h3euh0SgF429VVh62Yofsx68OWVRL5h0AD5vrvSTUtA=;
        b=n1Rclvzh6KF5acRQO6R0C373GU34XDzHIuclMG1Mlc5esOcLHfNzyMbeTzGGrPB+WX
         VtmmDM75X3AcYrNqkGi57NTOTkOnMwA2EEvhOf/Rov5LRMIH3rja2QX9yg4qvvjgA47v
         D/8hZD9JiTPOIKxXsd+/iLR+WgYd9GwSY03wA=
Received: by 10.223.13.208 with SMTP id d16mr5755149faa.141.1316818227230;
 Fri, 23 Sep 2011 15:50:27 -0700 (PDT)
Received: by 10.152.8.227 with HTTP; Fri, 23 Sep 2011 15:50:27 -0700 (PDT)
In-Reply-To: <m3mxdvqj31.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182011>

2011/9/23 Jakub Narebski <jnareb@gmail.com>:
> Brandon Casey <drafnel@gmail.com> writes:
>
>> ---------- Forwarded message ----------
>> From: Brandon Casey <drafnel@gmail.com>
>> Date: Thu, Sep 22, 2011 at 11:21 PM
>> Subject: permission to re-license strbuf subsystem as LGPL
>>
>> To those who have contributed to git's strbuf subsystem,
>>
>> I'd like to turn git's strbufs into a library. =C2=A0So with your co=
nsent
>> I'd like to re-license the code in strbuf.c and strbuf.h, and any
>> compat/ dependencies as LGPL so that I can create a strbuf library.
>
> That's a laudable goal. =C2=A0Do you plan on librarizing other univer=
sal
> mini-libraries, like parseopt or test-lib?

Not at the moment.

> I wonder if for example "perf" tool in Linux kernel sources (userspac=
e
> companion to perf events subsystem) will move to using it; currently
> it reuses some of internal git minilibraries, IIRC strbuf and parseop=
t
> included.

I would be pleased if it was useful to them.

> By the way, how the 'strbuf' from git (which I think was created amon=
g
> others to avoid additional external dependencies) differs from
> existing C (not C++) string libraries, like 'bstring'[1], The Better
> String Library, or the C libraries in http://bstring.sourceforge.net/=
features.html?
>
> [1]: http://bstring.sourceforge.net

Hmm, I forgot about bstring.  I think strbuf is a little smaller in
scope than bstring, perhaps less ambitious.  Less abstraction, and
less protection too.  With strbuf, you never forget that you're
dealing with C char arrays.  The data structures are pretty similar,
but I don't think strbuf will ever have a function like

   bconcat(bstring1, bstring2)

instead, you'd just do

   strbuf_add(strbuf1, strbuf2.buf, strbuf2.len)

The benefit, of course, of a bconcat function is that either bstring1
or bstring2 can be NULL (like if a previous bstring2 =3D bfromcstr()
initialization failed).  This allows you to perform a sequence of
bstring operations and only check errors at the end.

-Brandon
