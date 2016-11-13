Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73ED52021E
	for <e@80x24.org>; Sun, 13 Nov 2016 02:10:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932280AbcKMCKY (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Nov 2016 21:10:24 -0500
Received: from homie.mail.dreamhost.com ([208.97.132.208]:59865 "EHLO
        homiemail-a14.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932217AbcKMCKX (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 12 Nov 2016 21:10:23 -0500
Received: from homiemail-a14.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a14.g.dreamhost.com (Postfix) with ESMTP id 9EFBD392076;
        Sat, 12 Nov 2016 18:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=mattmccutchen.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=
        mattmccutchen.net; bh=G42dCkMH3KtbQZL7TOAlrdm2pkw=; b=W25g5EOaOj
        jiS3/rB7C1Uc+ffSnYmRhEbDssWQozHqLHI8WLL+q6hMz43H7oj+V9bJUpRzJG7Q
        21X05r13sQFBTvxAyJIkEHMZoaRFUec+GY7fjKmpbpNhIRbtC45vYzd+FgbIqGSh
        KNkIB7Kl2YI1lYsQVbrFvrK+3yGXN2IhY=
Received: from main (c-50-177-20-184.hsd1.ma.comcast.net [50.177.20.184])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: matt@mattmccutchen.net)
        by homiemail-a14.g.dreamhost.com (Postfix) with ESMTPSA id 364EB392075;
        Sat, 12 Nov 2016 18:10:21 -0800 (PST)
Message-ID: <1479003016.3471.18.camel@mattmccutchen.net>
Subject: Re: Fetch/push lets a malicious server steal the targets of "have"
 lines
From:   Matt McCutchen <matt@mattmccutchen.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Date:   Sat, 12 Nov 2016 21:10:16 -0500
In-Reply-To: <xmqqtwbuuuuy.fsf@gitster.mtv.corp.google.com>
References: <1477690790.2904.22.camel@mattmccutchen.net>
         <xmqqmvhoxhfp.fsf@gitster.mtv.corp.google.com>
         <1477692961.2904.36.camel@mattmccutchen.net>
         <xmqq7f8sx8lg.fsf@gitster.mtv.corp.google.com>
         <1477712029.2904.64.camel@mattmccutchen.net>
         <CAPc5daVOxmowdiTU3ScFv6c_BRVEJ+G92gx_AmmKnR-WxUKv-Q@mail.gmail.com>
         <1477757268.1524.20.camel@mattmccutchen.net>
         <xmqqtwbuuuuy.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 2016-10-30 at 01:03 -0700, Junio C Hamano wrote:
> Matt McCutchen <matt@mattmccutchen.net> writes:
>=20
> >=20
> > On Fri, 2016-10-28 at 22:31 -0700, Junio C Hamano wrote:
> > >=20
> > > Not sending to the list, where mails from Gmail/phone is known to
> > > get
> > > rejected.
> >=20
> > [I guess I can go ahead and quote this to the list.]
> >=20
> > >=20
> > > No. I'm saying that the scenario you gave is bad and people
> > > should be
> > > taught not to connect to untrustworthy sites.
> >=20
> > To clarify, are you saying:
> >=20
> > (1) don't connect to an untrusted server ever (e.g., we don't
> > promise
> > that the server can't execute arbitrary code on the client), or
> >=20
> > (2) don't connect to an untrusted server if the client repository
> > has
> > data that needs to be kept secret from the server?
>=20
> You sneaked "arbitrary code execution" into the discussion but I do
> not know where it came from.=C2=A0=C2=A0In any case, "don't pull from o=
r push
> to untrustworthy place" would be a common sense advice that would
> make sense in any scenario ;-)

A blanket statement like that without explanation is not very helpful
to users who do find themselves needing to pull from or push to a
server they don't absolutely trust. =C2=A0The only "definitely safe" opti=
on
it leaves them is to run the entire thing in a sandbox. =C2=A0A statement=
 of
the nature of the risk=C2=A0is much more helpful: users can determine tha=
t
they don't care about the risk, or if it does, what the easiest
workaround is.

The new risk we discovered in this thread is of leakage of private data
from the local repository. =C2=A0To avoid that risk, it's sufficient for
users to move private data to a separate repository, so that's the
advice I propose to give. =C2=A0Are you aware of issues with fetch/push w=
ith
potential impact beyond leakage of private data, which would make my
proposed text insufficient? =C2=A0I was giving "arbitrary code execution"=
 as
an example of what the impact of such an issue could be.

> Just for future reference, when you have ideas/issues that might
> have possible security ramifications, I'd prefer to see it first
> discussed on a private list we created for that exact purpose, until
> we can assess the impact (if any).=C2=A0=C2=A0Right now MaintNotes says=
 this:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0If you think you found a security-sensitive iss=
ue and want to
> disclose
> =C2=A0=C2=A0=C2=A0=C2=A0it to us without announcing it to wider public,=
 please contact us
> at
> =C2=A0=C2=A0=C2=A0=C2=A0our security mailing list <git-security@googleg=
roups.com>.=C2=A0=C2=A0This
> is
> =C2=A0=C2=A0=C2=A0=C2=A0a closed list that is limited to people who nee=
d to know early
> about
> =C2=A0=C2=A0=C2=A0=C2=A0vulnerabilities, including:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0- people triaging and fixing report=
ed vulnerabilities
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0- people operating major git hostin=
g sites with many users
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0- people packaging and distributing=
 git to large numbers of
> people
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0where these issues are discussed without risk o=
f the information
> =C2=A0=C2=A0=C2=A0=C2=A0leaking out before we're ready to make public a=
nnouncements.
>=20
> We may want to tweak the description from "disclose it to us" to
> "have a discussion on it with us" (the former makes it sound as if
> the topic has to be a definite problem, the latter can include an
> idle speculation that may not be realistic attack vector).

OK. =C2=A0I'll admit that I didn't even look for a policy on reporting of
security issues because I believed the issue had low enough impact that
a report to a dedicated security contact point would be unwelcome.
=C2=A0Maybe that was reckless. =C2=A0The new text sounds good, if you put=
 it in a
place where people like me would see it. :/

Matt
