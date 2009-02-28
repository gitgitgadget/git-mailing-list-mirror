From: John Tapsell <johnflux@gmail.com>
Subject: Re: proper way to merge?
Date: Sat, 28 Feb 2009 07:58:14 +0000
Message-ID: <43d8ce650902272358h4219f439qfa60ba7a7e0d222f@mail.gmail.com>
References: <450196A1AAAE4B42A00A8B27A59278E709F06FDA@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: John Dlugosz <JDlugosz@tradestation.com>
X-From: git-owner@vger.kernel.org Sat Feb 28 08:59:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdK6r-0001hU-3V
	for gcvg-git-2@gmane.org; Sat, 28 Feb 2009 08:59:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751634AbZB1H6S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Feb 2009 02:58:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751586AbZB1H6R
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Feb 2009 02:58:17 -0500
Received: from wf-out-1314.google.com ([209.85.200.174]:30740 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751540AbZB1H6Q convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Feb 2009 02:58:16 -0500
Received: by wf-out-1314.google.com with SMTP id 28so1734271wfa.4
        for <git@vger.kernel.org>; Fri, 27 Feb 2009 23:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=mpMecY9dcLWYxxAMdwrBpqr78f/W3nuRUmA6AW6XdKg=;
        b=FIED2ZYbXv7c4AJM8mut4WyiEzPhLwIOedLOT1N/Psc6mhUov80cFTj2CoZCD/tMrE
         LpvQvw02AjeM2Gu3IU5fvrAmsVBL12BGBKy/3P58PDVVJyeAnMXLNW+U89zwiUBIf31a
         jD5M414qKZtM7b5E+IZ6eJdRMMAV1NmsR3Yus=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=FNCzBUt1xNTxLV0WoGzV1B+cVvRRYiy7j9VEqiuTWJ6DsBoooH8ierfVd7CoIBvYeW
         nMc5L0xsVsw+0ZEaJe20aIStNeyGXL764Pr33RrQ3TFRW8Cvdlu/7ozpDRJmOfGQcr/d
         H2ixJZJ/ZQCzj9mGgoI55yq7vWn/JTr8D8QwA=
Received: by 10.142.215.5 with SMTP id n5mr1746965wfg.63.1235807894894; Fri, 
	27 Feb 2009 23:58:14 -0800 (PST)
In-Reply-To: <450196A1AAAE4B42A00A8B27A59278E709F06FDA@EXCHANGE.trad.tradestation.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111753>

2009/2/27 John Dlugosz <JDlugosz@tradestation.com>:
> I'm merging two branches: let's say "dev" is for development of futur=
e
> releases, and "rel" is changes made to the current release for immedi=
ate
> application. =C2=A0Now I want to bring the changes made in rel back t=
o dev.
>
> Rather than trying to merge it all at once, I'm applying the changes =
a
> few at a time and making sure it still compiles as I go. =C2=A0Then,
> git-reset and I have dev as my HEAD and the desired merge result in t=
he
> working tree.
>
> Now, I want to introduce the proper commit node to show that this is =
the
> graft. =C2=A0But, I don't want to be presented with all the differenc=
es that
> I already resolved; I know what it should look like already. =C2=A0Ho=
w do I
> commit the current state of things and have it show up with both dev =
and
> rel as parents? (then make that the new dev)
>
> I'm also interesting in learning how to do it better next time. =C2=A0=
But I'm
> doing the incremental merging now and need to know how to conclude it=
=2E

Instead of merge, I prefer to rebase.  so:

git checkout dev
git rebase origin rel

This replays each commit made in 'dev' on top of release, letting you
fix each commit separately.  It also means that when I commit to
release, the changes are a nice tree.

This only works if you have a relatively small number of changes.  I
tried to rebase 50 patches from 'dev' to 'rel' where the patches
changed pretty much every file.  It took all day to do.  (But it was
still better than trying to merge, in my specific case)

JohnFlux



>
> --John
>
> TradeStation Group, Inc. is a publicly-traded holding company (NASDAQ=
 GS: TRAD) of three operating subsidiaries, TradeStation Securities, In=
c. (Member NYSE, FINRA, SIPC and NFA), TradeStation Technologies, Inc.,=
 a trading software and subscription company, and TradeStation Europe L=
imited, a United Kingdom, FSA-authorized introducing brokerage firm. No=
ne of these companies provides trading or investment advice, recommenda=
tions or endorsements of any kind. The information transmitted is inten=
ded only for the person or entity to which it is addressed and may cont=
ain confidential and/or privileged material. Any review, retransmission=
, dissemination or other use of, or taking of any action in reliance up=
on, this information by persons or entities other than the intended rec=
ipient is prohibited. If you received this in error, please contact the=
 sender and delete the material from any computer.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
