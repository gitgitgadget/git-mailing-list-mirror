From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: Git ignore help
Date: Sat, 21 Mar 2015 23:33:45 -0400
Message-ID: <CAPig+cRU38sNHRsn=8=60wPO_AoQt-zn1dicFHwjG0OK-9tecQ@mail.gmail.com>
References: <47F.3lxhK.7IviRa5Gutr.1L2}X3@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: mdconf@seznam.cz
X-From: git-owner@vger.kernel.org Sun Mar 22 04:33:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZWe7-00063z-BG
	for gcvg-git-2@plane.gmane.org; Sun, 22 Mar 2015 04:33:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751632AbbCVDdr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Mar 2015 23:33:47 -0400
Received: from mail-yh0-f49.google.com ([209.85.213.49]:35107 "EHLO
	mail-yh0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751549AbbCVDdq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Mar 2015 23:33:46 -0400
Received: by yhim52 with SMTP id m52so27076453yhi.2
        for <git@vger.kernel.org>; Sat, 21 Mar 2015 20:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=jtdsFK0xiTuHBRuAYklDQ2YCVQ1brLnZUn6xplH0O84=;
        b=amILgA07OvwZJR/lhrRXZ/gh0wT23k9EYLl1ll4c8++doPQjX79/U1hE1b9kDKS0SY
         hWwz+I1fS1jHsdhaP+3rgbDwblH1rI7ZXSnh5qUyCcK3+uCHFT1NHK23EJxuqFc7u1gf
         epAiXhq/+6QKNuxWkPxV2a2a7HATr2prFc8isMENJOuYKpUap6o+OLVBX94tIVQrNyiD
         CUuZDKWlKTxjJZhA297Gv+avr14S2KoF+5yVabFphTb6fF19+Zsrb9li6bastXv8tu9+
         8gSgrFdOKsMk296ie7BDXfte3p4Hh7J1zBqDkDaod4N7hq3jc93g6EaVJjpdJYLuOPUw
         0pwA==
X-Received: by 10.236.41.45 with SMTP id g33mr6300942yhb.112.1426995225592;
 Sat, 21 Mar 2015 20:33:45 -0700 (PDT)
Received: by 10.170.73.7 with HTTP; Sat, 21 Mar 2015 20:33:45 -0700 (PDT)
In-Reply-To: <47F.3lxhK.7IviRa5Gutr.1L2}X3@seznam.cz>
X-Google-Sender-Auth: nQThBjegOM5eZF_eS4iUfCqwarU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266042>

On Fri, Mar 20, 2015 at 6:36 AM,  <mdconf@seznam.cz> wrote:
> I am trying to setup my git ignore (resp. .git/info/exclude) so that =
I exclude
>  all directories and files except the content of directories that I
> specifically include (incl. anything within them recursively).
>
> I set the .git/info/exclude with the following content:
>
> =3D=3D=3D=3D=3D=3D=3D=3D
> # Exclude everything
> /*
> # Except the below that we include
> !/db/data/load/base/bootstraponly
> !/db/data/load/base/safetoload
> !/db/ddl
> !/labels
> !/reports/usrint
> !/scripts
> !/src/cmdsrc/usrint
> =3D=3D=3D=3D=3D=3D=3D=3D
>
> However it does not do what I anticipated. It indeed excludes everyth=
ing but
> the include part does not work - it only works for !/labels and !/scr=
ipts
> directories (i.e. the first level directories). All other are still i=
gnored -
> so when I create file /db/data/load/base/bootstraponly/somefile.txt g=
it still
> ignores it...
>
> Any idea what I am doing wrong?

The fourth bullet point of the "Pattern Format" section of the
gitignore man page has this to say, which explains the behavior you're
seeing:

    An optional prefix "!" which negates the pattern; any matching
    file excluded by a previous pattern will become included again.
    It is not possible to re-include a file if a parent directory of
    that file is excluded. Git doesn=E2=80=99t list excluded directorie=
s for
    performance reasons, so any patterns on contained files have no
    effect, no matter where they are defined.
