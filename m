From: Jonathan Nieder <jrnieder@gmail.com>
Subject: the careless committer and fear of commitment (rebase -i vs add -p)
Date: Tue, 30 Mar 2010 00:02:48 -0500
Message-ID: <20100330045704.GA9004@progeny.tock>
References: <alpine.DEB.1.00.1003281834520.13534@pip.srcf.ucam.org>
 <32541b131003291331y3ae5ca23la33466d588c1b9e1@mail.gmail.com>
 <20100330030508.GA2887@progeny.tock>
 <32541b131003292132q10db3c5eh1bb6443d625fcb82@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Thomas <drt24@srcf.ucam.org>,
	Git Mailing List <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 30 07:02:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwTbD-0007Je-Ac
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 07:02:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755213Ab0C3FCm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Mar 2010 01:02:42 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:41840 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751643Ab0C3FCl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Mar 2010 01:02:41 -0400
Received: by gwaa18 with SMTP id a18so4537428gwa.19
        for <git@vger.kernel.org>; Mon, 29 Mar 2010 22:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=vnTxTcSDpB0V5KtI+Y3zvf/Egv9hKaxVwnV1BjhzIiQ=;
        b=vtdTpPRv/ZsH7RAzE68tWfgNs0AvqRklcRSvbwB96Svvd9BkI6X6D/4VP8331bGzV0
         Jn3HLxdiVzcwdHOP525Uq7sQ/0IKd/dqHunpqTHBluuTj2hhJPURe4Ri7kF94x+SnP+y
         D2iDk+UIpcIvOMeBNrZI+ES6/AlpYHSRLQVpg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=jKZ49+xAg49n9AlV+8Guqz9l0sNmYMzZ3bLFGNQTmprPJy7DgANtVYn9xNQeAp8QJm
         zlST7/DPV2UQuEmR44fNITrQ36gF5neb/CVW6GaMbQJX+o97m8g4vHb4sOpVWqhSNaU2
         CCbX0xDMioXgm49eS284TLhmDp2+TlnduSMWU=
Received: by 10.150.172.14 with SMTP id u14mr1335705ybe.298.1269925360662;
        Mon, 29 Mar 2010 22:02:40 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 22sm4765252iwn.0.2010.03.29.22.02.39
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 29 Mar 2010 22:02:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <32541b131003292132q10db3c5eh1bb6443d625fcb82@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143544>

Avery Pennarun wrote:

> I generally just make a temporary commit
> with "git commit", then revise it using "git commit --amend" over
> time.
>=20
> Or else I make a series of commits, then *later* squash them all
> together using 'git merge --squash' or 'git rebase -i'.
>=20
> It seems like the suggested feature would encourage people to do it
> the "wrong" way (not creating temporary commits, thus making it easy
> to make a mistake and blow things away) just because they aren't awar=
e
> of the above options.
>=20
> Is there a reason that these methods don't work for you?

I like =E2=80=98git diff --cached=E2=80=99 and =E2=80=98git diff=E2=80=99=
 to show the entire list
of staged and unstaged changes.  I don=E2=80=99t consider this =E2=80=9C=
wrong=E2=80=9D at all.
Generally, once something becomes precious enough to be worth keeping,
it is already in presentable form and I can come up with an appropriate
commit message.  I understand that other people work differently; this
is just my personal preference.

I also use the stash heavily, which maybe mitigates the =E2=80=9Cconten=
t could
be blown away with a simple rm -f=E2=80=9D problem.

You might also be interested in Pasky=E2=80=99s analysis at
http://thread.gmane.org/gmane.comp.version-control.git/138641/focus=3D1=
38672

Cheers,
Jonathan
