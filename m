From: John Keeping <john@keeping.me.uk>
Subject: Re: Poor performance of git describe in big repos
Date: Fri, 31 May 2013 09:59:59 +0100
Message-ID: <20130531085959.GB1072@serenity.lan>
References: <CAJ-05NPQLVFhtb9KMLNLc5MqguBYM1=gKEVrrtT3kSMiZKma_g@mail.gmail.com>
 <CALkWK0ndKMZRuWgdg6djqPUGxbDAqZPcv2q0qPrv_2b=1NEM5g@mail.gmail.com>
 <CAJ-05NNAeLUfyk8+NU8PmjKqfTcZ1NT_NPAk3M1QROtzsQKJ8g@mail.gmail.com>
 <87ehcoeb3t.fsf@linux-k42r.v.cablecom.net>
 <CAJ-05NOjVhb+3Cab7uQE8K3VE0Q2GhqR3FE=WzJZvSn8Djt6tw@mail.gmail.com>
 <87ip20bfq4.fsf@linux-k42r.v.cablecom.net>
 <20130530193046.GG17475@serenity.lan>
 <CAJ-05NOEuxOVy7LFp_XRa_08G-Mj0x7q+RiR=u71-iyfOXpHow@mail.gmail.com>
 <20130531083252.GA1072@serenity.lan>
 <CAJ-05NNgVPukJchskVv9oL7-9p+txC0g_SXfHne-mwF327Q_3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <kernel-hacker@bennee.com>
X-From: git-owner@vger.kernel.org Fri May 31 11:00:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UiLC9-0001ZU-8q
	for gcvg-git-2@plane.gmane.org; Fri, 31 May 2013 11:00:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752816Ab3EaJAP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 31 May 2013 05:00:15 -0400
Received: from hyena.aluminati.org ([64.22.123.221]:42111 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751334Ab3EaJAL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 May 2013 05:00:11 -0400
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id C496A22EBF;
	Fri, 31 May 2013 10:00:10 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W8879+A96pxJ; Fri, 31 May 2013 10:00:10 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id 02ED122F77;
	Fri, 31 May 2013 10:00:01 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CAJ-05NNgVPukJchskVv9oL7-9p+txC0g_SXfHne-mwF327Q_3Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226085>

On Fri, May 31, 2013 at 09:49:57AM +0100, Alex Benn=E9e wrote:
> On 31 May 2013 09:32, John Keeping <john@keeping.me.uk> wrote:
> > Thomas is suggesting that you might have a tag that does not point =
at a
> > commit but instead points to a blob object.
>=20
> It's looking like I just have some very heavy commits. One data point
> I probably should have mentioned at the beginning is this was a
> converted CVS repo and I'm wondering if some of the artifacts that
> introduced has contributed to this.

You can try another for-each-ref invocation to see if that's the case:

    eval $(git for-each-ref --format 'printf "%s %s\n" \
        $(git cat-file -s %(objectname)) %(refname);') | sort -n

That will print the size of each object followed by the ref that points
to it, sorted by size.

> I'm running the GIT stable PPA:
>=20
> 09:38 ajb@sloy/x86_64 [work.git] >git --version
> git version 1.8.3
>=20
> Although I have also tested with the latest git.git maint. I'm happy
> to try master if it's likely to have changed.

master's still very close to 1.8.3 at the moment, so I don't think that
will make a difference.
