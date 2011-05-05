From: Jerome Martin <tramjoe.merin@gmail.com>
Subject: Re: Private/public branches/repos workflow
Date: Thu, 5 May 2011 17:53:40 +0200
Message-ID: <BANLkTinL6UYAKeBtLnU5+rvwmd+N0dYErw@mail.gmail.com>
References: <BANLkTi=TLeePH0JDvnE0XPiCzXFxid9BWQ@mail.gmail.com>
	<201105051535.p45FZQDY019419@no.baka.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Thu May 05 17:53:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI0s6-0002jr-LT
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 17:53:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755242Ab1EEPxl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 May 2011 11:53:41 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:43829 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751913Ab1EEPxl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 May 2011 11:53:41 -0400
Received: by yia27 with SMTP id 27so800917yia.19
        for <git@vger.kernel.org>; Thu, 05 May 2011 08:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:cc:content-type:content-transfer-encoding;
        bh=B46XAnHqqCHp5FVAzEX7KyoCwevvt7GNJqa3gueISPs=;
        b=Ih552MaGsWBlyzo7VbLU5aJDn9t6kneYAl2f2AcivB6/73qpNZxiL4L4xtgO9IVgPE
         Ko0v4KEJpbbaKyTXyJDRA6fK8CfDg7abU7eVDInWQBRDDEJzp5Dr1LMydpl+QZIJ6aut
         GA2PUNMsMqmAg8ekVSIVzPkeXBqVBSF/i3WQY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:cc
         :content-type:content-transfer-encoding;
        b=ngCp7qDEE5VssqDFWApqQgasZgzJg3vFTtUwMVPYKhtBGTPwOErcBuQ12v9dqfhzKd
         Vm1nwqE9gddEfzCFLdHVruW62a+m0KjrBhibK8ilPmNigZh3P51fL8iyZZppFmAMax+H
         4ESJ4sfyB1rysUiQuBS94IzsMLNDnrLdcKiuE=
Received: by 10.146.164.11 with SMTP id m11mr2267455yae.20.1304610820617; Thu,
 05 May 2011 08:53:40 -0700 (PDT)
Received: by 10.147.167.8 with HTTP; Thu, 5 May 2011 08:53:40 -0700 (PDT)
In-Reply-To: <201105051535.p45FZQDY019419@no.baka.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172841>

Thanks for your quick answer!
It seems to be a solution a bit alike one I tested before sending my
initial question, using :
git symbolic-ref HEAD refs/heads/cleanmaster
But I am unsure of the result I am getting.
Are you suggesting that I should entirely replace my current 'public'
branch (there is no important history in there to keep apart from what
is already in the other, private, branch) by cleanmaster or that I
should keep using three branches and push from that third one
(cleanmaster) to the published repo ?
One thing I do not understand clearly is why with a detached (I guess
this is synonym to orphan ? At least when creating it ?) branch cannot
be then merged with the branch that was initially copied to create it
and just get the additional commits. Instead, it gets the whole
history. Being used to using merge between my public/private branches,
I am afraid that using that orphan branch might lead to disaster
eventually.

On Thu, May 5, 2011 at 5:35 PM, Seth Robertson <in-gitvger@baka.org> wr=
ote:
>
> In message <BANLkTi=3DTLeePH0JDvnE0XPiCzXFxid9BWQ@mail.gmail.com>, Je=
rome Martin
> writes:
>
> =A0 =A0Is there any recommended workflow to achieve the result I am l=
ooking
> =A0 =A0for ? How are other people doing it ?
>
> Create an orphan branch. =A0Commit what you want onto it. =A0Push bra=
nch
> to a new repo as master.
>
> git checkout <basesha>
> git checkout --orphan cleanmaster
> git add -A
> git commit -m "base of public release"
> (mkdir ../newrepo; cd ../newrepo; git init --bare)
> git remote add cleanremote ../newrepo
> git push cleanremote cleanmaster:master
>
> You can then cherry pick/rebase from previous branches onto
> cleanmaster any subsequent commits that you want to keep history for.
>
> Another approach might be to finesse a shallow clone to do what you
> want.
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0-Seth Robertson



--
J=E9r=F4me Martin
