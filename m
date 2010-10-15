From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Automating svn<->git gateway
Date: Fri, 15 Oct 2010 18:48:59 +0200
Message-ID: <201010151849.00161.jnareb@gmail.com>
References: <20101011193007.GA30870@efreet.light.src> <201010130125.49725.jnareb@gmail.com> <20101013171734.GA3693@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Fri Oct 15 18:49:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6nTA-0004pG-6X
	for gcvg-git-2@lo.gmane.org; Fri, 15 Oct 2010 18:49:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756365Ab0JOQtR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Oct 2010 12:49:17 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:58711 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756081Ab0JOQtR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Oct 2010 12:49:17 -0400
Received: by fxm4 with SMTP id 4so606866fxm.19
        for <git@vger.kernel.org>; Fri, 15 Oct 2010 09:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version
         :content-disposition:content-type:content-transfer-encoding
         :message-id;
        bh=XJ7ItP0/QkzyXYNCK69yY9Vk2OkecZwDRjRT3gJBSgQ=;
        b=wTn+V5KVhwE8tawIuKc5nm7vQK1ii95HB5yIv4brVJEP53C5tdDsESvrZ06pGW/qI2
         GZGko2708/gZmfjw5+M3vVy7jLHVQ60rWhl6464ZvejzFJFuCskr6rT/zl6vXETmASCv
         /HrdeYzXJ2iOPdu++uSwKHAKFE2LTzQmSS57Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-disposition:content-type
         :content-transfer-encoding:message-id;
        b=QNYo1tVn6oobVczZagYQqpQFgwPqiA/CXdcljIwrNYtrtQSUv5lWs40wcZKFMLzARf
         EAIedVDmXFEgPGlX6LtBNDAqAIj8kqq8wYevWDZxvd4D3otmwnGxAQUzK2afLNGoOKQ0
         6sfuRy/OpHGBB2UJkgN1aJO1phSe0qDy9Nd3k=
Received: by 10.204.54.82 with SMTP id p18mr906436bkg.142.1287161355629;
        Fri, 15 Oct 2010 09:49:15 -0700 (PDT)
Received: from [192.168.1.13] (abvv67.neoplus.adsl.tpnet.pl [83.8.219.67])
        by mx.google.com with ESMTPS id x13sm12751781bki.12.2010.10.15.09.49.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 Oct 2010 09:49:11 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20101013171734.GA3693@efreet.light.src>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159123>

On Wed, 13 Oct 2010, Jan Hudec wrote:
> On Wed, Oct 13, 2010 at 01:25:48 +0200, Jakub Narebski wrote:
> > On wtorek 12. pa=C5=BAdziernika 2010 22:31, Jan Hudec napisa=C5=82:

> > > So while I'm sure the native SVN support will solve the quirks an=
d bugs of
> > > git-svn, it will not do away with need for the gateway repository=
 that will
> > > somehow synchronize itself with subversion.
> >=20
> > Well, I think that native SVN support would allow to treat subversi=
on
> > repository as one of repositories in the network of repositories.  =
Those
> > repositories could be set in that pushing to central git repository=
 pushes
> > also to subversion repository, and like central git repository fetc=
hes
> > from leaf repositories, it would fetch from subversion repository.
>=20
> Yes. Except I don't know how to do the "pushing to central git reposi=
tory
> pushes also to..." part. Subversion or not.
>=20
> Though, I guess if it worked well enough to preserve the merge commit=
 (i.e.
> when I push and pull, I see the commit I pushed, not any kind of rewr=
ite),
> pushing in update-hook would be quite many bits simpler.

I was thinking about setting up appropriate hook for that...

=2E..but it might have been also done "manually", i.e. by having mainta=
iner[*]
do something like 'git pushall' to push to all distribution points (pub=
lic
git repositories), including Subversion repository, when pushing from=20
his/her private repository to public repository/repositories.  Maintain=
er
would fetch (pull) from all leaf repositories, including Subversion
repository.  This means that SVN repository is both leaf and distributi=
on
point.

[*] I wonder if "The surgical team" idea (less known than "The mythical
    man-month" aka 'assigning more programmers to a project running beh=
ind
    schedule will make it even later') from seminal work by Fred Brooks=
'
    "The Mythical Man-Month" is still valid.  The 'surgeon' would be th=
e
    maintainer / code reviewer, and would be responsible for merging in
    code from other developers.

--=20
Jakub Narebski
Poland
