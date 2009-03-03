From: John Tapsell <johnflux@gmail.com>
Subject: Re: proper way to merge?
Date: Tue, 3 Mar 2009 05:01:30 +0000
Message-ID: <43d8ce650903022101x584d7dcfr1758efc5e2c2e5cc@mail.gmail.com>
References: <450196A1AAAE4B42A00A8B27A59278E709F06FDA@EXCHANGE.trad.tradestation.com>
	 <43d8ce650902272358h4219f439qfa60ba7a7e0d222f@mail.gmail.com>
	 <450196A1AAAE4B42A00A8B27A59278E709F07432@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: John Dlugosz <JDlugosz@tradestation.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 06:06:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeMpB-0006Wa-0T
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 06:05:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbZCCFBf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Mar 2009 00:01:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750711AbZCCFBe
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 00:01:34 -0500
Received: from wf-out-1314.google.com ([209.85.200.170]:19683 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750706AbZCCFBd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Mar 2009 00:01:33 -0500
Received: by wf-out-1314.google.com with SMTP id 28so3106448wfa.4
        for <git@vger.kernel.org>; Mon, 02 Mar 2009 21:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=gRW3leBNj4H9E5zbZVwtfSDaCcHulYRqi1ZgErPWWTI=;
        b=lJttNXyBb6tQ4i/qn222nbXqhlJZhodBvSDUnIWPnolUtcpl1xXYC3MQJziGoMRczb
         hnCUmToMGw1m6b/6lbaqChwVym2v0Plcr+LtQyiQm7Mn9dWhrEDDspM9a5bWYFZv3keV
         UhorVCcVlkHw5otZul0rYFQIRwLrAB9UF2Gds=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BAV47W5ONjLj+6W2fPRxPczzVGGTt3MW1+0GAf5Ac+JUWPc16/TsUeNITn8LqcWScx
         gox2OdGkcoYnEzLZZm80AGRyMzrnqqdojdoPlm4qJhZ6TjUFve2XdPqv+RfhjXLxx9OS
         6tapCzsyhKSc74lbZCUjWPsbC42nmfXo0fgr8=
Received: by 10.142.192.1 with SMTP id p1mr3389651wff.295.1236056490941; Mon, 
	02 Mar 2009 21:01:30 -0800 (PST)
In-Reply-To: <450196A1AAAE4B42A00A8B27A59278E709F07432@EXCHANGE.trad.tradestation.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111995>

2009/3/2 John Dlugosz <JDlugosz@tradestation.com>:
> =3D=3D=3DRe:=3D=3D=3D
> Instead of merge, I prefer to rebase. =C2=A0so:
>
> git checkout dev
> git rebase origin rel
>
> This replays each commit made in 'dev' on top of release, letting you
> fix each commit separately. =C2=A0It also means that when I commit to
> release, the changes are a nice tree.
> =3D=3D=3Dend=3D=3D=3D
>
> The reason I'm doing this -- why I took over maintenance of the repos=
itory -- is because I strenuously objected to his plan to "rebase". =C2=
=A0NO! =C2=A0Merge, don't rebase. =C2=A0Besides never rebasing publishe=
d branches, in this case it works much better the other way around: =C2=
=A0dev made systemic changes, and rel is mostly patches and completely =
new pieces of code. =C2=A0After looking at what was in dev..rel and wha=
t was in rel..dev, I chose to start with dev and bring in the commits f=
rom rel in a controlled manner.

It depends on what you're doing :-)  I find that if the branch is too
large to easily rebase, then it's probably too large entirely :)
Developers don't like master to change in large ways suddenly - makes
it hard for all the other branches.

It also makes it impossible to bisect, something that I find
essential.  If you are combining two trees which are too big to easily
rebase, then there's a high chance that something will break either
due to their individual changes or because of a mistake while merging.
 In such a case, it's then impossible to bisect to try to pinpoint the
actual problem.

It will be interesting to hear your view on merging vs rebasing after
a year or so of trying both.

John
