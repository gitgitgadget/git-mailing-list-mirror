From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [TopGit] aborting tg create leafs deleted .top* files in index
Date: Fri, 27 Feb 2009 09:40:45 +0100
Message-ID: <36ca99e90902270040g6ae29c69t1d958fda3dfce960@mail.gmail.com>
References: <36ca99e90902061103u24d4f38eua52d9259cb8d34d1@mail.gmail.com>
	 <36ca99e90902262247q783f8ce1j20bdc971cfc22948@mail.gmail.com>
	 <20090227083211.GA10326@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Petr Baudis <pasky@suse.cz>,
	Git Mailing List <git@vger.kernel.org>,
	martin f krafft <madduck@debian.org>
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Fri Feb 27 09:42:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcyIT-0003yF-P5
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 09:42:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753586AbZB0Iku convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Feb 2009 03:40:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752987AbZB0Iku
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 03:40:50 -0500
Received: from mail-ew0-f177.google.com ([209.85.219.177]:57318 "EHLO
	mail-ew0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752201AbZB0Ikt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Feb 2009 03:40:49 -0500
Received: by ewy25 with SMTP id 25so1108890ewy.37
        for <git@vger.kernel.org>; Fri, 27 Feb 2009 00:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Q0F04rGDiuQoflENa4Vad5dstdp3BRQHFOpvQHOGwW0=;
        b=jc6Tc/qPMG8hOUlOdpTU1kwnZbJrk7CJIysHhdrMbvLQXZ5MGOPoCSpZHXDAiDmmv2
         q5oiR3r9gHRsQzs75CuSUe9mfSUZPBOd14YOvSvdMcNdkv8GWUmKkfTemxKQroytd0jf
         tA9NqC1CtKW8ol9V1+tARKl/zTMyxcZjKOezs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=J45ofDvO4JUoCLgPQz0BqGezuqeaeNJ+lii0dwLHp2zB6fwrBNLnxhNLybBTXr7cXp
         Q1rMJAP/5Ji9cel90tEAz665dtjwlkkk/dhq4bc8feCUL1Xy89KtkpEdRQktK13O6ZIy
         g8hbkP83VqB8tq7Rs/nQWYZrR5ZJlDrLt4C18=
Received: by 10.210.144.8 with SMTP id r8mr269910ebd.28.1235724045631; Fri, 27 
	Feb 2009 00:40:45 -0800 (PST)
In-Reply-To: <20090227083211.GA10326@pengutronix.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111647>

On Fri, Feb 27, 2009 at 09:32, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> I have git version 1.5.6.5 and for me your recipe[1] ends in
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ git status
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# On branch t/test1
> =C2=A0 =C2=A0 =C2=A0 =C2=A0nothing to commit (working directory clean=
)
>
> With git 1.6.1.3 I can reproduce it though.
>
> Here comes a git only test case:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git init
> =C2=A0 =C2=A0 =C2=A0 =C2=A0touch file
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git add file
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git commit -m 'initial commit'
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git checkout -b next
> =C2=A0 =C2=A0 =C2=A0 =C2=A0echo next > file
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git add file
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git rm -f file
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git checkout master
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git status
>
> What about the patch below? =C2=A0It seems git-checkout from 1.6.x me=
rges the
> changes done to the newly checked out branch.
Thank you very much. It works here as expected.

Bert
>
> Best regards
> Uwe
