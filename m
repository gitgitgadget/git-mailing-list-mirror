From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 1/1] Use GIT_ASKPASS environment to launch thirdpart UI
	app to get password
Date: Thu, 25 Feb 2010 01:15:01 -0800
Message-ID: <20100225091500.GB2903@gmail.com>
References: <1266923463-2828-1-git-send-email-lznuaa@gmail.com> <20100224051307.GA3232@gmail.com> <1976ea661002240013j164fc875o469c0dcdf74afe0c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>
To: Frank Li <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 10:15:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkZoa-0007Oi-3E
	for gcvg-git-2@lo.gmane.org; Thu, 25 Feb 2010 10:15:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753425Ab0BYJPI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Feb 2010 04:15:08 -0500
Received: from mail-yx0-f182.google.com ([209.85.210.182]:36723 "EHLO
	mail-yx0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752233Ab0BYJPH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2010 04:15:07 -0500
Received: by yxe12 with SMTP id 12so991824yxe.33
        for <git@vger.kernel.org>; Thu, 25 Feb 2010 01:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Rq4P3xhjmLS6Z1+wHTVoh2UNNJiW6rZWDqKpqV4TNHo=;
        b=oQpBvbs8vDBJOVvwbjAIMv5K9joxhnt72BuHu1z+cG3p5G6ocdl/0nK08wMkOt+Jon
         eTyyLnYVm5xKT0TJ+ha195OhAf4pzjRXBD0bpcCwGZs3dKmJlcEtWozQOqyHjH0eI37k
         SI9HP3qPDDREEurIV70xPknsKJS6aims3Orzg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=GuN0Lt3bu2iJt7HW5dVe3nAZqjm2491VIwq03ueHolwCyT8dRVoZMW0TSRo2JYcyKd
         GgYCq7OkU7Zsq3iwTFJ+WF60e57FExHdxhfHxu7V6JYX9X/XRbhTtlgjiqaKjI0Tbu0P
         59D+U4cqmHaMlZR/a9k9GdGhfsP/2tn0BcSEY=
Received: by 10.150.65.3 with SMTP id n3mr1229221yba.322.1267089305962;
        Thu, 25 Feb 2010 01:15:05 -0800 (PST)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 4sm1482023ywi.6.2010.02.25.01.15.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Feb 2010 01:15:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1976ea661002240013j164fc875o469c0dcdf74afe0c@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141036>

On Wed, Feb 24, 2010 at 04:13:01PM +0800, Frank Li wrote:
>=20
> > Many users already have SSH_ASKPASS defined. =C2=A0It would be very
> > nice if we supported SSH_ASKPASS as a fallback when GIT_ASKPASS
> > is not provided.
> >
>=20
> I consider add such fallback at git.c.  when user use git svn,  git
> main program will be called firstly.
> git main entry will check if GIT_ASKPASS and SSH_ASKPASS, if
> SSH_ASKPASS set but GIT_ASKPASS not set,
> GIT_ASKPASS will be set as SSH_ASKPASS.
>=20
> Do you think we needs add such check at git-svn.perl ?
>=20
> best regards
> Frank Li

Interesting question.  I had never thought of moving the
fallback to git.

I would have done it in the script as a localized fix but
I definately see the value in aiding scripts from
all having to implement this same fallback, though:

	$ENV{GIT_ASKPASS} ||=3D $ENV{SSH_ASKPASS};

If Junio, Eric, and the git list think that this should
live in git instead then by all means.

--=20
		David
