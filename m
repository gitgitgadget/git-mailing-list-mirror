From: Tor Arntsen <tor@spacetec.no>
Subject: Re: Find out on which branch a commit was originally made
Date: Sat, 18 Sep 2010 13:28:25 +0200
Message-ID: <AANLkTim4cqAhWPTY5tSsFq7S1A_f=9QFy=3Mrp9ZFwXT@mail.gmail.com>
References: <1jp0h7e.lgk0kp19qe5bbM%lists@haller-berlin.de>
	<AANLkTiknoBS7x2za3qzghfS0TD6UUL83eoZz7LFBPUuc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	git@vger.kernel.org
To: Stefan Haller <lists@haller-berlin.de>
X-From: git-owner@vger.kernel.org Sat Sep 18 13:28:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Owvaq-0004Dz-QD
	for gcvg-git-2@lo.gmane.org; Sat, 18 Sep 2010 13:28:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754814Ab0IRL20 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 18 Sep 2010 07:28:26 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:43698 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754520Ab0IRL20 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Sep 2010 07:28:26 -0400
Received: by qwh6 with SMTP id 6so2475514qwh.19
        for <git@vger.kernel.org>; Sat, 18 Sep 2010 04:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=glft4fT24mRw32I1GOByJKJtqLphYfBCPUhW/5USYJw=;
        b=QOt5C76xYMxm/BvWKU7/ukRnExcVwmWM6LMJtaXDbtG8DEEz6BdRTy5XIsDDRvHg0i
         IqG2Jz7Hh3LzcpbjiKt2SVljvGNvXNthmtYeVPZrUF7dE8xyBBeu698PI2sB4U6Bzp22
         Bi/5LKR5ugSjI0JngwafzxDv2zazdLEu3ornQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=u0/gWK5ES5RfSQoo14snPZ9Ah9WYCdwlqcafADOuZedmirq6NB7BZ22QOCSQV8VA7y
         uSE8z0M79nm5tCOpb2Z17rQgzvYTKuCakuZPv9BtJuQGR8I9MOp3hIsFePtdThTU542w
         Li7TlueyQk2y8f4SyU0vjbOBA9jIcIyBNx/qo=
Received: by 10.224.80.133 with SMTP id t5mr4181975qak.341.1284809305424; Sat,
 18 Sep 2010 04:28:25 -0700 (PDT)
Received: by 10.229.62.98 with HTTP; Sat, 18 Sep 2010 04:28:25 -0700 (PDT)
In-Reply-To: <AANLkTiknoBS7x2za3qzghfS0TD6UUL83eoZz7LFBPUuc@mail.gmail.com>
X-Google-Sender-Auth: r9FuZzb9FrI0jJCs1NsA2B7gmZg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156452>

On Sat, Sep 18, 2010 at 11:58, =C6var Arnfj=F6r=F0 Bjarmason <avarab@gm=
ail.com> wrote:
[..]
> What Git *does* track however when you do `git merge topic` is the
> name of the `topic` branch you're merging into some other branch,
> e.g. here (from git-merge(1)):
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 A---B---C topic
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/ =A0 =A0 =A0 =A0 \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 D---E---F---G---H master
>
> Even though A B and C might have been commited on branches called
> `blah`, `bluh` and `blarghl` you'll never know. You'll just know that
> someone put them all together on a branch called `topic` and that
> someone later merged that into master in the main repository. E.g.:
>
> =A0 =A0Merge: A G
> =A0 =A0Author: Some Guy <some-guy@example.com>
> =A0 =A0Date: =A0 <....>
>
> =A0 =A0 =A0 =A0Merge branch 'topic'
>
> >From there you can *infer* that A-B-C came from the topic branch,
> because of that merge commit and that the DAG doesn't meet master
> until commit E.
[..]

However, you can see it explictly if you add --log when merging, i.e.
git merge --no-ff --log topic
(you'll get a list of one-line commit messages from those commits
merged into master from topic).
It doesn't identify the commits, only the commit messages. Therefore I
add problem report IDs into my oneline-messages, and I get a shortlist
of exactly what was fixed by a given merge. This is sufficient support
for me, I too don't care where a commit _originally_ came from, before
it arrived into the branch that I at some point merge to the delivery
branch.

-Tor
