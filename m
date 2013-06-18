From: =?UTF-8?Q?Beno=C3=AEt_Person?= <benoit.person@ensimag.fr>
Subject: Re: [PATCH V3 1/4] git-mw: Introduction of GitMediawiki.pm
Date: Tue, 18 Jun 2013 11:06:16 +0200
Message-ID: <CAETqRCjiMh_cYuZit5Z8OLki_RTz8=ViYPMv005iQu9Fv=U0ow@mail.gmail.com>
References: <1371349893-7789-1-git-send-email-benoit.person@ensimag.fr>
	<1371349893-7789-2-git-send-email-benoit.person@ensimag.fr>
	<vpqobb5g679.fsf@anie.imag.fr>
	<CAETqRChcu+N-2uNzL9_J6abR5fnduT5UVRif5NTQYOoxPTiRTw@mail.gmail.com>
	<vpq8v299pn6.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Celestin Matte <celestin.matte@ensimag.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 18 11:06:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uorru-0000W0-8B
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 11:06:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755442Ab3FRJGT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 05:06:19 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:51675 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755280Ab3FRJGR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 05:06:17 -0400
Received: by mail-ie0-f172.google.com with SMTP id 16so9527348iea.3
        for <git@vger.kernel.org>; Tue, 18 Jun 2013 02:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=9y34kbEZFnw89glmlOgviVx8Y0r7pVZClQ86EQHRphA=;
        b=EgBA7MFVBxZi4C1xxnRntG7YBHOMeNXKPuXpWkvfJDrhj1Swwohnq57YCZX0oDcrN7
         b8ssOcLnuPBnCOaZb9HOEHiUzr4kn725ZgbGlgqSLFCOA1Nv1++V6vEtj2fZxooD9yS7
         XK7Jp6rSfE/QRnvtTbln8zEm8AIi6EsGg0unpWq2S4I74uz4qAX+Lsi+rG4wqM6oXhj/
         iwT+c0oy6bRZAnuhckz+dnVzFW/BMtVRz17teFe6ithJLBhLOIkJkvpHgbHBTOznh1Nq
         rE0qPm/WD8T6jO9bwAIXI1xLE0WEsrMWQyfJBYYrOZVwueTibcYTHQ+DBYmRDEC9Z5G8
         1iVQ==
X-Received: by 10.50.41.34 with SMTP id c2mr6989451igl.57.1371546376405; Tue,
 18 Jun 2013 02:06:16 -0700 (PDT)
Received: by 10.42.210.20 with HTTP; Tue, 18 Jun 2013 02:06:16 -0700 (PDT)
In-Reply-To: <vpq8v299pn6.fsf@anie.imag.fr>
X-Google-Sender-Auth: URIk2qX2vZIOpBcgf3qsDPwkPjY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228178>

On 17 June 2013 09:12, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
>>> Also, it seems to be only part of the solution. With your change, from
>>> contrib/mw-to-git/ and after running only "make",
>>>
>>> ./git-mw takes the installed version of GitMediawiki.pm in priority
>>>
>>> ../../bin-wrappers/git takes the installed version of git-mw only (i.e.
>>> does not know "git mw" if "make install" hasn't been ran).
>> Same thing as the documentation point, I think I am a bit lost in that
>> whole thing. I will re-look into it for the next version :/ .
>
> In short, the include path should contain both the *.pm file and the
> git-<foo> ones.
The fact is, for now, is there a way to test changes in
git-remote-mediawiki.perl without 'make install'-ing it ? I could not find one

So maybe in the "build-perl-script" of the toplevel Makefile we could add
something copying the script at the toplevel ?

And in GitMediawiki's Makefile, we let everything stay as is : copying *.pm
into /perl/blib/lib when building and copying it in installdir when installing ?

> I think you removed a newline from the end of the file. It's usually
> considered good practice to have this trailing newline (e.g. so that
> "cat file" in a terminal doesn't put your prompt after the last line).
> IIRC, it's actually required to call the file a "text file" according to
> POSIX.
That catch oO, thanks for the explanations.
From my point of view, this could definitely be improved from:
> -     perlcritic -2 *.perl
> +     perlcritic -2 *.perl
> \ No newline at end of file
to something like that:
> -     perlcritic -2 *.perl
> +     perlcritic -2 *.perl
> \ removed newline at end of file
which gives more insights into why the line is considered "edited".

Benoit Person
