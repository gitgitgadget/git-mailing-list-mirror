From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Bizarro race conditions in the Git Makefile
Date: Fri, 6 Aug 2010 21:40:49 +0000
Message-ID: <AANLkTin=6pmfPjmM-W4UFf1g+0Z9Rrprc0h0mThUOUFx@mail.gmail.com>
References: <AANLkTim2NMi3Vf-EGbFwy370q-YseQoGj=QLGMAq6N=B@mail.gmail.com>
	<20100806211407.GB6495@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 06 23:40:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhUeu-0005N2-27
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 23:40:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964821Ab0HFVkw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Aug 2010 17:40:52 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:62499 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403Ab0HFVku convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Aug 2010 17:40:50 -0400
Received: by iwn33 with SMTP id 33so1623622iwn.19
        for <git@vger.kernel.org>; Fri, 06 Aug 2010 14:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=VKMplUEQvHf7XqKhmLUMpa878V6UL+WAu9F6dGqRrk4=;
        b=ioOV/hz2GdDAxo/4YdM2j4ml60cccQehQ8BOPygNEyAxIGa+v0BZp5PvEAi6apcTbC
         cUQv/iXhBwspdvt9hUxx8QFsaEHWR4oKXvchcHEjCfLGVXsw+ENGo4EDNliBQOAOVzzH
         jB7y8Or74vOm0CrN40VeXX7P2tNBarfCRT4xU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=twqikTQ30jRaq0+w0vbC7kFJ51C1M4t6FE7pMPLobodcuPwC9L3qaR8gStz5/EV8lw
         PPW7rwQ8ewGzgFBWw4CCyIpgL2xu5ppQPrX+WlZWMg4FvzqlUPda8oOwmwwk8RO1cdFq
         hjzBI55mK5XC48AwnGfM+1aRtMy/XA0Oc2K7I=
Received: by 10.231.191.6 with SMTP id dk6mr14912729ibb.51.1281130849328; Fri, 
	06 Aug 2010 14:40:49 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Fri, 6 Aug 2010 14:40:49 -0700 (PDT)
In-Reply-To: <20100806211407.GB6495@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152820>

On Fri, Aug 6, 2010 at 21:14, Jonathan Nieder <jrnieder@gmail.com> wrot=
e:
> =C4=98var Arnfj=C3=B6r=C5=A1 Bjarmason wrote:
>
>> Those interested in
>> poking their eyes can try:
>>
>> =C2=A0 =C2=A0 while nice -n 30 make -j 15 clean all CFLAGS=3D-O0 CC=3D=
gcc; do 1; done
>
> You are asking make to simultaneously build and unbuild everything.
> It does not really surprise me that it gets confused.
>
> Does
>
> =C2=A0while
> =C2=A0 =C2=A0 =C2=A0 =C2=A0nice -n 30 make -j 15 clean CFLAGS=3D-O0 C=
C=3Dgcc &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0nice -n 30 make -j 15 all CFLAGS=3D-O0 CC=3D=
gcc
> =C2=A0do
> =C2=A0 =C2=A0 =C2=A0 =C2=A0:
> =C2=A0done
>
> behave better?

Yes that works. I thought that -j $n would mean that make would use $n
jobs to complete the first target, then move onto the next. Not
execute them all in paralell.

Thanks, and I have no idea about those Makefile/Perl changes.
