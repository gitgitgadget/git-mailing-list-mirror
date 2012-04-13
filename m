From: Tim Henigan <tim.henigan@gmail.com>
Subject: Re: [PATCH 8/9 v12] difftool: teach difftool to handle directory diffs
Date: Fri, 13 Apr 2012 12:31:21 -0400
Message-ID: <CAFouetim-sUQ53dKWF6rVKH9Gx-SVuZmzpJFHosQSSrw+wX71w@mail.gmail.com>
References: <1334236726-18393-1-git-send-email-tim.henigan@gmail.com>
	<7viph46c1t.fsf@alter.siamese.dyndns.org>
	<CAFouetg6Ot8sKiNi45A0QRv6YYdL3Mwrb3tkVkajQQuZukSp3g@mail.gmail.com>
	<7v62d4692l.fsf@alter.siamese.dyndns.org>
	<CAJDDKr4UbN3izmqa89CCH7OY4c9LOH0S2EbdUCxHK3G6GHd4xQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, ramsay@ramsay1.demon.co.uk,
	Junio C Hamano <gitster@pobox.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 13 18:31:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIjPI-0007BF-CQ
	for gcvg-git-2@plane.gmane.org; Fri, 13 Apr 2012 18:31:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751687Ab2DMQbX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Apr 2012 12:31:23 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:41144 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751166Ab2DMQbW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Apr 2012 12:31:22 -0400
Received: by iagz16 with SMTP id z16so4448907iag.19
        for <git@vger.kernel.org>; Fri, 13 Apr 2012 09:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=UP3ZiTlYffZPgWg52Okx0rXKB0GlG4U0xXo5VZWhkbY=;
        b=Tk9J1wVMcrjKlURXTbWKaE2eA8zaqxYzgrJEuAm4+mb88KzMEjkgXG0sndwhqm2Afo
         paQzayb48FMpgELFEGNukhrvAdNdyXTHCnvXc+CU6VXRKv6/B1vW1gnwP0xyqW91YdKp
         opPwI+Bmls792hZbzUf+mdjgtM3WnqgEBNVMILuoeijgDJ1jkeNT+Aah1MHlirdRC3XU
         tlaPwDmgxBok4lysthpHZ3xRn4RsXFv26GILkRv5yagNOxSsUxrS/CusOgdhecgUYx6m
         drcmP4bqozl3jyWxfiZReBT/RJyIJON8dCJtLNHfG5VreTBvr2VyIqPUuQligUOjdJPp
         3Bsw==
Received: by 10.43.58.73 with SMTP id wj9mr1651609icb.17.1334334681788; Fri,
 13 Apr 2012 09:31:21 -0700 (PDT)
Received: by 10.42.225.193 with HTTP; Fri, 13 Apr 2012 09:31:21 -0700 (PDT)
In-Reply-To: <CAJDDKr4UbN3izmqa89CCH7OY4c9LOH0S2EbdUCxHK3G6GHd4xQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195425>

On Thu, Apr 12, 2012 at 10:53 PM, David Aguilar <davvid@gmail.com> wrot=
e:
>
> The issue is that this does not properly handle shell characters, IFS=
, etc.
>
> I think a simple solution would be to use git diff --exit-code --quie=
t here.
>
> e.g.
>
> =C2=A0 =C2=A0my $rc =3D system('git', 'diff', '--exit-code', '--quiet=
', @ARGV);
>
> That avoids the shell and properly handles shell meta-characters, IFS=
, etc.

The problem is that I need the output of 'git diff' to drive the rest
of the script.  Getting STDOUT from a system() call is difficult, so I
switched to backticks.  Obviously I missed the regression.

The best solution seems to be to find a way to make
'Git->repository->command*' to work with $GIT_DIR and $GIT_WORK_TREE.
I will send v13 with this change soon.
