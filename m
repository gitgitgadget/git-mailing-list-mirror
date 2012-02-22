From: Tim Henigan <tim.henigan@gmail.com>
Subject: Re: [PATCH] contrib: added git-diffall
Date: Wed, 22 Feb 2012 15:14:43 -0500
Message-ID: <CAFouetgyYRKT7h1h4hv40Kxp=ibq1Hw-1mzFe6DsyAUknXKyYQ@mail.gmail.com>
References: <1329785969-828-1-git-send-email-tim.henigan@gmail.com>
	<7vd397g8ic.fsf@alter.siamese.dyndns.org>
	<CAFouetiLmK3dXLRkBh+cTNA_OMPS77xo8z95WK5y4tk-o-UUog@mail.gmail.com>
	<7vbooregj6.fsf@alter.siamese.dyndns.org>
	<CAJDDKr72rPqp1z-12Ht3Q2UaeUVFutKwoOgkD1G+SbhsBs+p1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 22 21:14:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0IaU-00058y-8D
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 21:14:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752436Ab2BVUOp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Feb 2012 15:14:45 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:49069 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751871Ab2BVUOo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Feb 2012 15:14:44 -0500
Received: by iacb35 with SMTP id b35so469405iac.19
        for <git@vger.kernel.org>; Wed, 22 Feb 2012 12:14:43 -0800 (PST)
Received-SPF: pass (google.com: domain of tim.henigan@gmail.com designates 10.50.154.200 as permitted sender) client-ip=10.50.154.200;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of tim.henigan@gmail.com designates 10.50.154.200 as permitted sender) smtp.mail=tim.henigan@gmail.com; dkim=pass header.i=tim.henigan@gmail.com
Received: from mr.google.com ([10.50.154.200])
        by 10.50.154.200 with SMTP id vq8mr28994477igb.14.1329941683828 (num_hops = 1);
        Wed, 22 Feb 2012 12:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=HJBz1qVqgb5y+XUc8ur2Ev7KhdzSc795RJj5CotS0l4=;
        b=ivcZPzax40TfVG5WjdqJYebiNA9I+lorCCkorX0uzsx8fUVJqQ7ebpf0mbU/ZKv+lr
         aYbTKJZp6sA3pES7QFFOANHKCq+7o6n1ukA4ntktjlldZJ014LD2oAwyPITEK2A6eyzb
         7l/5ScjRGZFHuCyZGbQ+Q7i0wG97grAjJdnUI=
Received: by 10.50.154.200 with SMTP id vq8mr23543165igb.14.1329941683782;
 Wed, 22 Feb 2012 12:14:43 -0800 (PST)
Received: by 10.42.220.136 with HTTP; Wed, 22 Feb 2012 12:14:43 -0800 (PST)
In-Reply-To: <CAJDDKr72rPqp1z-12Ht3Q2UaeUVFutKwoOgkD1G+SbhsBs+p1A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191276>

On Wed, Feb 22, 2012 at 4:15 AM, David Aguilar <davvid@gmail.com> wrote=
:
> On Tue, Feb 21, 2012 at 6:41 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> Tim Henigan <tim.henigan@gmail.com> writes:
>>
>> David, any idea on this?
>
> I don't see any bash-isms there myself, either. =C2=A0We should keep =
this
> stuff without bash-isms.
> I haven't had time to read these patches in depth yet but will try to
> read the re-roll.
>
> Can we ask the github user to elaborate on what exactly was erroring =
out?
> Does dash not handle || inside $()? =C2=A0We can only make wild guess=
es
> without their help.
>
> The only hint from the pull request is "silent exit with no results".
> Do we do that?
> There are a few code paths where we do "exit 1" but that's only under
> error conditions.
>
> We haven't had any reports about git-mergetool/difftool, which use
> these functions...
> are we certain the problem was not some other bash-isms in the script=
?

I have not heard back from the user, but I tested on Ubuntu earlier
today.  I found that when using an older version of the script
(fbedb7a in the GitHub repo), I could repeat the error.  It is the
'git-diffall' script that fails silently, I believe due to a bash-ism
that was fixed in a subsequent commit.

In my latest local version of the script, I have switched back to
#!/bin/sh.  It runs successfully, so I will squash the change into v2
of the patch.

=46or what it is worth, since that bug was originally reported, I have
been running "checkbashisms" [1] on the git-diffall script.  That
utility reports that the script is clean.

-Tim

[1]: http://sourceforge.net/projects/checkbaskisms/
