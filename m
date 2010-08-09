From: Jared Hance <jaredhance@gmail.com>
Subject: Re: workflow with blessed, lieutenant, and developers
Date: Mon, 9 Aug 2010 15:30:09 -0400
Message-ID: <20100809193009.GA8191@localhost.localdomain>
References: <20100809092152.5f32646a@packard.rktmb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 09 21:30:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiY3F-00061w-Vv
	for gcvg-git-2@lo.gmane.org; Mon, 09 Aug 2010 21:30:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754760Ab0HITaT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Aug 2010 15:30:19 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:56248 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754082Ab0HITaS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Aug 2010 15:30:18 -0400
Received: by qwh6 with SMTP id 6so7537858qwh.19
        for <git@vger.kernel.org>; Mon, 09 Aug 2010 12:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=cDEvc4p9dPGmo5FpeCRCoXh7IcUqjALP4VWaz3D7EJw=;
        b=ngmqFGqLCeGknFWxsvDrNCOIKAdI4DFmj9IpJgrIftaPPjL6fJpLkBrM/iQGmykNzc
         nOyD+ufkTSRrZeKzhyFXPZOFDeUEXD9MWZRS27PAW9AgCWunzI3LGo2wIptEPsuNxyoD
         Lk8XTN9fFlDi0lde4byiq1qMA9xzhlMkNk2hA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=tlPVy+2NvoCwdzk73zhOcPylLU2qydhyHvG0ImY5TjiPEVF7d2zClEg46gNtQnWkyG
         3a8nylRlmbrfvJl830iKtODHrpoVgZWtHI8POK/o6VU1sbqULL83+v2v6O3qwap4/Dw8
         TPGI12EgZsQq79kwflUVcYZEWhWuEnpjpsddE=
Received: by 10.224.26.93 with SMTP id d29mr8869502qac.24.1281382217202;
        Mon, 09 Aug 2010 12:30:17 -0700 (PDT)
Received: from localhost.localdomain (cpe-174-101-209-27.cinci.res.rr.com [174.101.209.27])
        by mx.google.com with ESMTPS id w5sm6734896qcq.7.2010.08.09.12.30.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 09 Aug 2010 12:30:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100809092152.5f32646a@packard.rktmb.org>
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153003>

On Mon, Aug 09, 2010 at 09:21:52AM +0300, Mihamina Rakotomandimby wrote=
:
> I would like to setup a similar thing but with=20
> - Only one lieutenant (me)
> - A blessed repository where I am the only one to push to
> - Developers who push to me (the lieutenant)

There are multiple lieutenants, or none. You are the (possible
benevolent) dictator in this case.

> Developers pull/clone from the blessed repository.
> I initially clone from the blessed repository.
>=20
> 1=B0) What command line do developers use to push to me but not to th=
e
> blessed (origin)?

Developers don't push to someone else. They can either:
1) Send an email to the dictator requesting a pull
2) Send an email to the mailing list requesting a pull and review
3) Send patches to the mailing list requesting integration and review

I don't recomend #1 because #2 is strictly better. #3 has a specific
command: git-format-patch

When using #2/#3, its useful to have the developers CC the maintainer
of the project.

Developers usually need to push to a public branch at a hosting site
like github or repo.or.cz.

> 2=B0) After they pushed to me, I have the choice to "approve" or "rej=
ect"
> a commit: what is the keyword and git option for that?

Add the remote and fetch. Then merge the branch into your master (or
whatever branch you choose).

In the case of patches on a mailing list, you need to copy them to a
mailbox (for example, in Mutt, I use t to tag the group and ;C to copy
them all into a mbox) and use git-am to apply all the patches (you
should do this in a new branch). You can then choose to merge the
branch in.

> 3=B0) I push the merge of approved commits to the blessed repository:
> what keywords and git options?

git push origin


Make sure you remember that Git is not a replacement for
communication. There should be a way for people to review patches
BEFORE they are applied to the blessed repository.
