From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Detection of relocations within a file
Date: Tue, 31 Aug 2010 03:43:03 +0200
Message-ID: <201008310343.05280.jnareb@gmail.com>
References: <SNT124-W40BFB8E681711F9CD33D9AC4890@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Bo Yang <struggleyb.nku@gmail.com>
To: Tim Mazid <timmazid@hotmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 31 03:43:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqFsJ-00050o-Lr
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 03:43:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756594Ab0HaBmu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Aug 2010 21:42:50 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:47434 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756544Ab0HaBmt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Aug 2010 21:42:49 -0400
Received: by fxm13 with SMTP id 13so3676842fxm.19
        for <git@vger.kernel.org>; Mon, 30 Aug 2010 18:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=FGyySzIThdTUoOMZgN3qdYhm3ic/9ACuRd9solevENA=;
        b=pqhL2TylmZnLfg0eppBywY8DSJ2KOut7f8ZXhV/bHpU5sXq5CAJtmQ1he5QO8AUP0I
         CgHl1AjC3rUg5Ln0uiWolouM5PnGku8VAbuVWAfGsCs5HzXiRvpwkm0tzW7yFTUpQ9mV
         RusjFPQXV1cTl3lftemf5m8oNvCpJV1a+sfnc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=MU+YKJy2OYD0vWhFiSxWDnwSh2jineIyt5hGiEPHuVV1dHxMTjOkU+BI1pRY/bCOPz
         l+YvGtJtVIl+SSJHB260DwoDNNB8zlgq3IqhHRHyQ2GHvdUkLKv3IbbUbqtKTuvV1NLC
         6PqpqlfCnOvh37l1MzF/WCCcToMZYOPj/cdac=
Received: by 10.223.103.72 with SMTP id j8mr4711499fao.4.1283218968209;
        Mon, 30 Aug 2010 18:42:48 -0700 (PDT)
Received: from [192.168.1.13] (abws159.neoplus.adsl.tpnet.pl [83.8.242.159])
        by mx.google.com with ESMTPS id r5sm3714134faq.32.2010.08.30.18.42.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 30 Aug 2010 18:42:45 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <SNT124-W40BFB8E681711F9CD33D9AC4890@phx.gbl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154876>

On Mon, 30 Aug 2010, Tim Mazid wrote:
> Matthieu Moy wrote:

> > 2. I am mystified not by some particular piece of code but by an
> > entire file. =A0The command
> > $ git gui blame -- git.c
> > works okay.
>=20
> It does, to an extent.
>=20
> The specific case I was thinking of is when, as a function grows
> larger, you decide to break it down and move a section of it to a new
> function.  Now, if the two lines remain exactly the same, there is no
> problem and git gui blame does the job.
>
> However, if there is any change in the line at all, even leading
> whitespace, as moving code around usually changes its "tabbage", then
> "git gui blame" will not detect that as being the same line of code
> sitting somewhere else, as it sees the two as "different".  =20
> Is there any way to get around this?
>=20
> Further, in the previous point regarding a movement patch, it too
> should not be overly sensitive to leading whitespace.=20
>=20
> Actually, git in general shouldn't be too sensitive to leading
> whitespace (or at least should have an option to turn this on/off).=20

You can always pass `-w' option to git-blame:

  -w   Ignore whitespace when comparing the parent's version and the
       child's to find where the lines came from.

I'm not sure if you can pass other diff whitespace options to git-blame
(-b, -w, --ignore-space-at-eol).


Note that "git gui blame" shows *two* blames: ordinary and '-C -C -w',
i.e. with copy detection and ignoring whitespace changes.

--=20
Jakub Narebski
Poland
