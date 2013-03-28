From: Thomas Taranowski <tom@baringforge.com>
Subject: Re: git subtree oddity
Date: Thu, 28 Mar 2013 12:44:11 -0700
Message-ID: <CAH0ocayVmTOFjTkYBRuA6RULafD1zY6hq1PWHWKONL9o24SFUA@mail.gmail.com>
References: <7v38vfwlxv.fsf@alter.siamese.dyndns.org> <1827202810.1012362.1364488493363.JavaMail.root@openwide.fr>
 <CAH0ocazrojrJPdDDmLyL3RQaxxGjPnmhxq+FzSE0P9Y3Y05C1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	"David A. Greene" <greened@obbligato.org>,
	Stephen Smith <ishchis2@gmail.com>
To: Jeremy Rosen <jeremy.rosen@openwide.fr>
X-From: git-owner@vger.kernel.org Thu Mar 28 20:45:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULIlG-0006ac-8y
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 20:45:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752300Ab3C1Tox convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Mar 2013 15:44:53 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:41723 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751614Ab3C1Tox convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Mar 2013 15:44:53 -0400
Received: by mail-wi0-f175.google.com with SMTP id c10so3663377wiw.8
        for <git@vger.kernel.org>; Thu, 28 Mar 2013 12:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=poHKiVdzyOXQLyk0zhCAzE3q2k04h8Kcjug8W2Oi1DI=;
        b=YUdECPUVi1/x9c/OJ2L4wqquc8az5yW+dcoNUCWC7i+iK2JwtJwiOrcXOl2HDtyFd+
         WGCzXJfNmK5fngAkE2cuaHpggprzUiVbpl33hY5leH/64DJTpqeS5wn3VowxnOnFAYLy
         48+j7lBcSNCjRnq+M/wUKa8IpnGPTsecDvb++86R4+81S9ZqsjYhZJ/xkk6eGMAT/C/2
         91ggmUVH4WmaPtH5BK/nrJ/ybCHsvRLcQFZjRbQQmFkrZuaDClBMnq57Cgi9gVzxiWA/
         R3gPTzV/LzYxxvIIdUfmx2btTdnY6FxAhCm4ULxKi3IC4KRMcciET4l0a3kqnMEqf147
         S5Wg==
X-Received: by 10.180.10.105 with SMTP id h9mr18624484wib.34.1364499891937;
 Thu, 28 Mar 2013 12:44:51 -0700 (PDT)
Received: by 10.180.19.161 with HTTP; Thu, 28 Mar 2013 12:44:11 -0700 (PDT)
In-Reply-To: <CAH0ocazrojrJPdDDmLyL3RQaxxGjPnmhxq+FzSE0P9Y3Y05C1Q@mail.gmail.com>
X-Google-Sender-Auth: mjxB-HcDO3LyD7Qimj3a1yfBR9s
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219453>

Oh, this is odd.  I can get the behavior I want by adding the '-f'
flag to the remote add.

So: git remote add -f upstream git://gnuradio.org/gnuradio

According to the remote add help, the -f is only doing a fetch, which
I was doing as a manual step after the remote add.

Another interesting artifact is that I know see the "warning: no
common commits" log, which I wasn't seeing in my prior process.

So, my problem is 'fixed' now, but it seems like this is a bug,
particularly since most of the subtree merge tuturoials I've seen
online do the manual fetch step.  Is there any additional information
that would be useful for folks to see?

-Tom

On Thu, Mar 28, 2013 at 12:29 PM, Thomas Taranowski <tom@baringforge.co=
m> wrote:
> I agree that subtree solves some specific use cases I would like to
> support.  In particular, I was hoping to use the subtree command in
> lieu of using the subtree merge strategy to manage and overlay change=
s
> to upstream projects, as well as other local components.
>
> At any rate, it looks like the problem I'm having is not entirely
> related to the subtree command, but happens when I checkout a remote
> into a branch ( which subtree is presumably doing in the background).
>
> It's the same setup as before.  Here is the sequence of commands I'm =
running.
>
> git init
> git remote add upstream git://gnuradio.org/gnuradio
> fetch upstream
> git checkout -b upstream_tracking upstream/master
>
> Now, at this point, I expect the upstream branch to contain the
> contents of the gnuradio project.  I also expect that my local mater
> branch has only the contents of my local sources, and NOT the content=
s
> of the gnuradio.  However, if I 'git checkout master', I see the
> contents of the gnuradio project.  Why, when I checkout a branch
> tracking upstream/master, do the changes also appear on my master
> branch, and not just in the remote tracking branch?
>
> As a reference, this is close to what I'm trying to accomplish.  His
> screenshot titled 'Directory Listing in Master' shows what I expect.
> http://typecastexception.com/post/2013/03/16/Managing-Nested-Librarie=
s-Using-the-GIT-Subtree-Merge-Workflow.aspx
>
> Thanks
> -Tom Taranowski
>
> On Thu, Mar 28, 2013 at 9:34 AM, Jeremy Rosen <jeremy.rosen@openwide.=
fr> wrote:
>>>
>>> I am starting to regret that I caved in and started carrying a copy
>>> of it in contrib/.  It probably is a good idea to drop it from my
>>> tree and let it mature and eventually flourish outside.
>>>
>>
>> that's a shame... it solves a real problem, is simple to use, and re=
ally powerfull.
>>
>> but unfortunately, I have sent a patch that solves a serious bug... =
which had already been reported and patched but had received no answer,=
 and nobody replied to it.
>>
>> Is there anything that can be done to get this rolling, or a way to =
have the use-case it covers better handle by git-submodule ?
>>
>>
>> currently the problem of a git repo in a git repo is very complicate=
d to deal with in a clean way...
>>
>>
>> Regards
>>
>> J=E9r=E9my
