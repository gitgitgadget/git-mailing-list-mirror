From: John Tapsell <johnflux@gmail.com>
Subject: Re: .gitk should created hidden in windows
Date: Tue, 24 Mar 2009 02:08:37 +0000
Message-ID: <43d8ce650903231908y54bb1c34t45a78f218b2ccd9f@mail.gmail.com>
References: <49BFA97A.1030203@lanwin.de>
	 <18887.26239.115820.450313@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Steve Wagner <lists@lanwin.de>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Mar 24 03:10:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Llw5m-000321-C5
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 03:10:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754006AbZCXCIl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Mar 2009 22:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753918AbZCXCIk
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 22:08:40 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:60117 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753832AbZCXCIj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Mar 2009 22:08:39 -0400
Received: by yw-out-2324.google.com with SMTP id 5so2386692ywb.1
        for <git@vger.kernel.org>; Mon, 23 Mar 2009 19:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=cFiwF8nV5KEzdARXruJ+ZL85cSeawLSlty8GaDj6OEk=;
        b=Vlck0W77OP4LJf9fmOYYPpDe99yI8886Eu/gi7hJ9dPzCDAq+tLUZLhuk9hz1sUcVb
         RY/Rbt/M61v/bdCxm1owlgKFHq17ivhD1ppEvktib34NaE8CggEUE5KGsur+EHXIM7Mz
         tmn0ScdSvrxP8PgDdmIkoCQWhDFyUrYX9vhqA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=bPgSdfbpZQQI1PYcHqvnI/DqSddD/BvPyr4uIGaOE9c3K6qsUK/YIwpW68G0JKYxMs
         Cx0ZyOBHBQZfYpW474wmIZVfW9Wwrcpu7A2xPaHaGupn9Y1A1g7FzTrFHB0WGZ/nTW0c
         33SbBVVpSMM0BlEUc431w2K1npUrgFCAMmTTU=
Received: by 10.220.75.140 with SMTP id y12mr2217853vcj.41.1237860517210; Mon, 
	23 Mar 2009 19:08:37 -0700 (PDT)
In-Reply-To: <18887.26239.115820.450313@cargo.ozlabs.ibm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114393>

2009/3/23 Paul Mackerras <paulus@samba.org>:
> Steve Wagner writes:
>
>> The problem is that windows dose not hides files beginning with a do=
t as
>> it is in unix. So the .gitk file is created as visible in the window=
s
>> user profile. Problematic too is that i can no set the hidden attrib=
ute
>> to this file, because it is recreated every time i start gitk, so th=
e
>> hidden attribute gets lost.
>>
>> Can you control this and create the file with the hidden attribute o=
n
>> windows?
>
> Please try this patch and let me know if it does what you want.
>
> Paul.
>
> diff --git a/gitk b/gitk
> index d7de27e..54f3f2b 100755
> --- a/gitk
> +++ b/gitk
> @@ -2487,6 +2487,9 @@ proc savestuff {w} {
> =C2=A0 =C2=A0 if {![winfo viewable .]} return
> =C2=A0 =C2=A0 catch {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0set f [open "~/.gitk-new" w]
> + =C2=A0 =C2=A0 =C2=A0 if {$::tcl_platform(platform) eq {windows}} {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 file attributes "~/.gitk-new" -h=
idden true
> + =C2=A0 =C2=A0 =C2=A0 }
> =C2=A0 =C2=A0 =C2=A0 =C2=A0puts $f [list set mainfont $mainfont]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0puts $f [list set textfont $textfont]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0puts $f [list set uifont $uifont]

How about making all files beginning with .  hidden?  .gitignore for ex=
ample
