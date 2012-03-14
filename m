From: Christopher Tiwald <christiwald@gmail.com>
Subject: Re: [PATCH] push: Provide situational hints for non-fast-forward
 errors
Date: Wed, 14 Mar 2012 12:40:57 -0400
Message-ID: <20120314164057.GD3558@gmail.com>
References: <20120313232256.GA49626@democracyinaction.org>
 <7vobrzst7n.fsf@alter.siamese.dyndns.org>
 <20120314121434.GB28595@in.waw.pl>
 <vpqobrzgww9.fsf@bauges.imag.fr>
 <20120314142752.GD28595@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>, peff@peff.net,
	zbyszek@in.waw.pl
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 14 17:41:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7rGB-00067S-9Z
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 17:41:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030871Ab2CNQlH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Mar 2012 12:41:07 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:52067 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030328Ab2CNQlD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2012 12:41:03 -0400
Received: by eaaq12 with SMTP id q12so1052709eaa.19
        for <git@vger.kernel.org>; Wed, 14 Mar 2012 09:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=9pq8WjBRcc6pjZ0VaNKJAMANxMz9w8NRa1VmRxmrayk=;
        b=dQ6kZSYyfcJFUuR+6K8L6u/6M6iaLtZIIqioDpC32CEHixYC6lj2N2eeLrjv6eUDwv
         QkmD8K/aFy/oeYkVkRAkRG3PdaMh9/O0GQYMxPbEsv/XZVv/bxRhQTNKisrtGME9Bhiq
         LfOo5EMksVZhcKGp0NJhyXYnsGUcmch7YcZhndoaFXzoenvbdef6Q3KV6Pf9Za1MttjZ
         ex910fNe6XxDX857xMh4svFEIIQ8EEpFQ7+8D81YDnxzy8JdO6WtI419Yi5SGNUiMDvc
         ezeVjuzFLLIJTxoXe6t+vOTtFbSFo0UNCdYu1s/ZNexg923PfIKwbcuaDNRZHMvmUmqw
         ftNg==
Received: by 10.229.137.85 with SMTP id v21mr1100589qct.70.1331743262119;
        Wed, 14 Mar 2012 09:41:02 -0700 (PDT)
Received: from gmail.com ([216.55.38.246])
        by mx.google.com with ESMTPS id g16sm9664511qah.6.2012.03.14.09.41.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 14 Mar 2012 09:41:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120314142752.GD28595@in.waw.pl>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193133>

On Wed, Mar 14, 2012 at 03:27:52PM +0100, Zbigniew J=C4=99drzejewski-Sz=
mek wrote:
> On Wed, Mar 14, 2012 at 02:00:38PM +0100, Matthieu Moy wrote:
> > Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl> writes:
> >=20
> > > I think that having three different config keys for the three
> > > different advices makes sense, because the advices will be displa=
yed
> > > at different times.
> >=20
> > I don't think it really makes sense to be such fine-grained. We alr=
eady
> > have 6 different advices, so an advance user who do not want them n=
eed
> > to set these 6 variables. I think we want to keep this number relat=
ively
> > low.
> >=20
> > The advice messages do not point explicitely to the way to disable =
them,
> > so users who know how to set advice.* are users who know a little a=
bout
> > configuration files, and who read the docs.=20
>=20
> Elsewhere in this thread it was proposed to add an actual 'git config=
'
> command to the advice.

After considering it, I tend to agree that three different config keys
is overkill. I feel like users who disable advice are doing it because
they find the messages annoying, not because they've mastered that
particular situation and no longer need the reminder. Forcing them to
disable three different options to get an advice-less 'git push' seems
like it'd just be irritating.

I could be wrong about that. Perhaps users who graduate workflows as yo=
u
described above are more common? I don't disable any advice locally and
thus can't speak well to what motivates that decision.
>=20
> > Instead of having too
> > fine-grained configuration variables, we can have a better doc,
> > explaining shortly the 3 possible cases under advice.nonfastforward=
 in
> > config.txt. The user who disable the advice can read the doc (I usu=
ally
> > think that "users don't read documentation" is a better assumption,=
 but
> > since the user knows about the name of the variable, it is OK here)=
=2E
> >=20
> > Also, if I read correctly the patch, the old variable is left in th=
e doc
> > and in advice.{c,h}, but is no longer used. This means old-timers w=
ho
> > have set it will see the message poping-up again after they upgrade=
,
> > which I think is inconveinient for them.
>=20
> So it seems that the old variable should be respected, not to annoy
> "old-timers".

I hadn't considered users who already have the variable set. I'll
correct for that. I'll also attempt to improve the doc for
advice.nonfastforward.

--
Christopher Tiwald
