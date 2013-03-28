From: Thomas Taranowski <tom@baringforge.com>
Subject: Re: git subtree oddity
Date: Thu, 28 Mar 2013 12:29:17 -0700
Message-ID: <CAH0ocazrojrJPdDDmLyL3RQaxxGjPnmhxq+FzSE0P9Y3Y05C1Q@mail.gmail.com>
References: <7v38vfwlxv.fsf@alter.siamese.dyndns.org> <1827202810.1012362.1364488493363.JavaMail.root@openwide.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	"David A. Greene" <greened@obbligato.org>,
	Stephen Smith <ishchis2@gmail.com>
To: Jeremy Rosen <jeremy.rosen@openwide.fr>
X-From: git-owner@vger.kernel.org Thu Mar 28 20:30:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULIWs-0002WW-Gw
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 20:30:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751854Ab3C1TaA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Mar 2013 15:30:00 -0400
Received: from mail-wg0-f51.google.com ([74.125.82.51]:38470 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751279Ab3C1T37 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Mar 2013 15:29:59 -0400
Received: by mail-wg0-f51.google.com with SMTP id b12so1894443wgh.30
        for <git@vger.kernel.org>; Thu, 28 Mar 2013 12:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=YAlh3exR2bad70aNWD5imry1ehTHogzIBogwmh77U24=;
        b=03qQTrU1iz9fWgY6tiJ/+9yryzg5H8RLhrQbVx52ySdNFs23z4EO2zrk8KZxo84SHL
         hlyP3lOMAHAbp7R6cxUx+OmREippQvu8Sh+K/Aj688tmL1DF89CRV+8wpeWlUcvn1Oci
         /vFcT2z78BaZt60cPPUyD0GWLUf2W/oy33OKnsJaR4ucOHEBddRIiH6a4ey8CBNqjOSi
         fuymLXI09TW8+qXTiKpC9E8NN9A0/RogRSIE6o+cULeZRQ3MGTDsRaDzErjCVuk01ZfS
         Au1nNczDhtL0oQtw6kmepa4VS1u17uplyWg43zie1jJXcnGMimV/mbHoyl78l9tdFUBS
         3BEQ==
X-Received: by 10.180.37.166 with SMTP id z6mr18557376wij.34.1364498997989;
 Thu, 28 Mar 2013 12:29:57 -0700 (PDT)
Received: by 10.180.19.161 with HTTP; Thu, 28 Mar 2013 12:29:17 -0700 (PDT)
In-Reply-To: <1827202810.1012362.1364488493363.JavaMail.root@openwide.fr>
X-Google-Sender-Auth: nZsQM6-D8aWC8O8Y9A2_8cpEV_A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219451>

I agree that subtree solves some specific use cases I would like to
support.  In particular, I was hoping to use the subtree command in
lieu of using the subtree merge strategy to manage and overlay changes
to upstream projects, as well as other local components.

At any rate, it looks like the problem I'm having is not entirely
related to the subtree command, but happens when I checkout a remote
into a branch ( which subtree is presumably doing in the background).

It's the same setup as before.  Here is the sequence of commands I'm ru=
nning.

git init
git remote add upstream git://gnuradio.org/gnuradio
fetch upstream
git checkout -b upstream_tracking upstream/master

Now, at this point, I expect the upstream branch to contain the
contents of the gnuradio project.  I also expect that my local mater
branch has only the contents of my local sources, and NOT the contents
of the gnuradio.  However, if I 'git checkout master', I see the
contents of the gnuradio project.  Why, when I checkout a branch
tracking upstream/master, do the changes also appear on my master
branch, and not just in the remote tracking branch?

As a reference, this is close to what I'm trying to accomplish.  His
screenshot titled 'Directory Listing in Master' shows what I expect.
http://typecastexception.com/post/2013/03/16/Managing-Nested-Libraries-=
Using-the-GIT-Subtree-Merge-Workflow.aspx

Thanks
-Tom Taranowski

On Thu, Mar 28, 2013 at 9:34 AM, Jeremy Rosen <jeremy.rosen@openwide.fr=
> wrote:
>>
>> I am starting to regret that I caved in and started carrying a copy
>> of it in contrib/.  It probably is a good idea to drop it from my
>> tree and let it mature and eventually flourish outside.
>>
>
> that's a shame... it solves a real problem, is simple to use, and rea=
lly powerfull.
>
> but unfortunately, I have sent a patch that solves a serious bug... w=
hich had already been reported and patched but had received no answer, =
and nobody replied to it.
>
> Is there anything that can be done to get this rolling, or a way to h=
ave the use-case it covers better handle by git-submodule ?
>
>
> currently the problem of a git repo in a git repo is very complicated=
 to deal with in a clean way...
>
>
> Regards
>
> J=E9r=E9my
