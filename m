From: "Eduardo D'Avila" <erdavila@gmail.com>
Subject: Re: [PATCH 2/4] git-prompt.sh: refactor colored prompt code
Date: Sat, 22 Jun 2013 13:45:38 -0300
Message-ID: <CAOz-D1+LoAnoRLgnyRYtq5LQR32RyXp4RR2M5pPTaxaGcXM4yg@mail.gmail.com>
References: <cover.1371780085.git.erdavila@gmail.com> <354a860e12a3463ce5d031c0dc46d095841f717d.1371780085.git.erdavila@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Simon Oosthoek <s.oosthoek@xs4all.nl>,
	Junio C Hamano <gitster@pobox.com>,
	"SZEDER G?bor" <szeder@ira.uka.de>,
	"Eduardo R. D'Avila" <erdavila@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 22 18:46:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UqQxB-00050O-1C
	for gcvg-git-2@plane.gmane.org; Sat, 22 Jun 2013 18:46:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751795Ab3FVQp7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 Jun 2013 12:45:59 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:39914 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751608Ab3FVQp6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Jun 2013 12:45:58 -0400
Received: by mail-ie0-f182.google.com with SMTP id s9so21950587iec.27
        for <git@vger.kernel.org>; Sat, 22 Jun 2013 09:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Gg+iNzvstDBfsqwPhfC4bI3K8GckHu6C08jplGcgw4o=;
        b=wNTeCLT+2nyL0RVn8s4b8u+824rfsM9yCTFYeYmNFjZvUOVw0agAxaXT8IZRNq7nfb
         Jrlih4cW7DwHMO1y1/l8v+IvMhfAIgoindxGgMyVfdXAlChGo57N9LHcYgu8PTjuUf/3
         FwTjom9ezwa5jmbOhZBRWxPi4jM28u7ywDw+x2lUX2q6DK5fPBd8eYJdK8obAdpVYgIE
         jg0YJE/eIEO2x1AWsrrhhRaoZWL9UyRpjiXUiy9WU2ygyYG0fdifoQUwcFGz8BcPalp9
         JBE1Jn0Ol/C0Tmyoq8Ps/Qw/LZrD12nVlQq7m8JIexYoAgXV5YUQnPH8Pn8uDm/1ZZgc
         Q7sQ==
X-Received: by 10.50.17.166 with SMTP id p6mr1818726igd.12.1371919558164; Sat,
 22 Jun 2013 09:45:58 -0700 (PDT)
Received: by 10.42.249.197 with HTTP; Sat, 22 Jun 2013 09:45:38 -0700 (PDT)
In-Reply-To: <354a860e12a3463ce5d031c0dc46d095841f717d.1371780085.git.erdavila@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228715>

2013/6/22 =D8ystein Walle <oystwa@gmail.com>:
> I've gotten the impression it's better to use tput to generate the es=
cape
> sequences instead of hardcoding them. So something like:
>
> local c_red=3D'\['"$(tput setaf 1)"'\]'
> local c_green=3D'\['"$(tput setaf 2)"'\]'
> local c_green=3D'\['"$(tput setaf 4)"'\]'
> local c_clear=3D'\['"$(tput sgr0)"'\]'
>
> which is technically cleaner, if not visually.
>
> The problem with that approach is that tput will be run several times=
 for
> each prompt, so it would be best if the color variables were global. =
Another
> thing is that you rely on tput being available.

Are there any guidelines regarding global shell script variables?

I'm considering doing this:
   __git_c_red=3D"\[$(tput setaf 1 || echo -e '\e[31m')\]"
which handles the case where tput is not available.


Eduardo
