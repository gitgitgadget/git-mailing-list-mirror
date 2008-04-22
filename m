From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: showing conflicting merges
Date: Tue, 22 Apr 2008 11:49:23 +0200
Message-ID: <8aa486160804220249y55677f63o892643775960880f@mail.gmail.com>
References: <20080422091233.GA12091@digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?=" <Uwe.Kleine-Koenig@digi.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 11:50:16 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoF8e-0000y5-ND
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 11:50:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762663AbYDVJt2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Apr 2008 05:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762359AbYDVJt2
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 05:49:28 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:31484 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758156AbYDVJt1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Apr 2008 05:49:27 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1202884ywb.1
        for <git@vger.kernel.org>; Tue, 22 Apr 2008 02:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=M1YcveFkIR0ArmIewfMErcMecNDgMo3EuamCfF8T0LU=;
        b=MobMV6AD7ob5RIceHWybab7RYw9MMAwwPIP8bMHbJo+xCKkvhl09oxYAmo9aDKSKb56OuoIhlf2uScC7Rijc9BZwttHTQ6yQLzs+VbdY1d6npE9lD74AyNmDVPRX7ZygMLiFf5iSLIGtNqtOs10jn+Byg7Ss/H2i0tzUsSf+8js=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Hj4vIZZpsKK6WUa+Nfeys0UMqOMr0NVDLdjRE6eJ26Ih0DfDM3sNvEpr/07hsAdULGsqMdQN+Mk9ml7/joXH7MtAlkMTl0frF92gENfnCpez2JZ8RKF7zrntvpgkqPLVTSTJkQKbPNHTER2+BB9E+ZzZKLi8FoU1/mibcXf/ngQ=
Received: by 10.151.156.6 with SMTP id i6mr11675ybo.51.1208857764134;
        Tue, 22 Apr 2008 02:49:24 -0700 (PDT)
Received: by 10.151.14.14 with HTTP; Tue, 22 Apr 2008 02:49:23 -0700 (PDT)
In-Reply-To: <20080422091233.GA12091@digi.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80089>

On Tue, Apr 22, 2008 at 11:12 AM, Uwe Kleine-K=F6nig
<Uwe.Kleine-Koenig@digi.com> wrote:
> Hello,
>
>  There is a thread on the linux-arm-kernel ML that discusses handling=
 of
>  merge conflicts with git.[1]
>
>  I played around a bit with that and wondered about a few things:
>
>         ukleinek@zentaur:~/gsrc/linux-2.6$ git checkout -b test adf6d=
34e460387ee3e8f1e1875d
>         Switched to a new branch "test"
>
>         ukleinek@zentaur:~/gsrc/linux-2.6$ git merge v2.6.25
>         Auto-merged MAINTAINERS
>         CONFLICT (delete/modify): drivers/leds/leds-tosa.c deleted in=
 HEAD and modified in v2.6.25. Version v2.6.25 of drivers/leds/leds-tos=
a.c left in tree.
>         Auto-merged drivers/serial/imx.c
>         Automatic merge failed; fix conflicts and then commit the res=
ult.
>
>  Now "git diff --merge" shows:
>
>         diff --cc drivers/leds/leds-tosa.c
>         index 7ebecc4,0000000..9e0a188
>         ...
>
>  Shouldn't that better be reversed, i.e. 9e0a188..7ebecc4,0000000?

It compares the versions in conflict with the version in the working co=
py.

>
>  The resolution was to delete drivers/leds/leds-tosa.c:
>
>         ukleinek@zentaur:~/gsrc/linux-2.6$ git rm drivers/leds/leds-t=
osa.c
>         rm 'drivers/leds/leds-tosa.c'
>         rm 'drivers/leds/leds-tosa.c'
>
>         ukleinek@zentaur:~/gsrc/linux-2.6$ git commit
>         Created commit 99a64ab: Merge commit 'v2.6.25' into test
>
>  Now "git show" doesn't show the conflict resolution as it does for o=
ther
>  conflicting merges.
>  Adding -p and/or --cc didn't help either.  Looking at the source I t=
hink
>  the problem is that diff_tree_combined only shows diffs for paths th=
at
>  are touched by every parent.  I'm not sure how I want to have the di=
ff
>  shown, but showing nothing seems wrong.  Ideas?

The combined diff does not show conflicts, it only shows the merged
results that are different to all the parents. In this case the merge
resolution is to delete one file as in HEAD, so it won't be shown.

If you want to see the conflict resolution you have to recreate the
merge and compare with the original merge.

Santi
