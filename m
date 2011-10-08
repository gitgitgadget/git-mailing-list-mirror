From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] fmt-merge-msg: use branch.$name.description
Date: Fri, 07 Oct 2011 17:01:35 -0700 (PDT)
Message-ID: <m3mxdc1hek.fsf@localhost.localdomain>
References: <7vobxtwaog.fsf@alter.siamese.dyndns.org>
	<4E8EBDA7.2040007@drmicha.warpmail.net>
	<20111007091636.GA22822@elie.hsd1.il.comcast.net>
	<4E8ECA25.205@drmicha.warpmail.net>
	<20111007100646.GA23193@elie.hsd1.il.comcast.net>
	<4E8EED39.1060607@drmicha.warpmail.net>
	<7vobxstt4w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 08 02:01:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCKMI-00042c-WA
	for gcvg-git-2@lo.gmane.org; Sat, 08 Oct 2011 02:01:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754694Ab1JHABi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Oct 2011 20:01:38 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:44401 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753432Ab1JHABh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Oct 2011 20:01:37 -0400
Received: by bkbzt4 with SMTP id zt4so5430563bkb.19
        for <git@vger.kernel.org>; Fri, 07 Oct 2011 17:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=lDZ7QYwZcJ0Wxa/JfVZMHF+zvtHKULjH2DXHFehRegM=;
        b=EIITh9HBcuqRTKXRfeOnQOIy05sBy0LUN9UTAcBbiV3qX3EaCEAjdkaGE+wFYj2lc7
         Wib5eSEaZ2WlXrBxKiG5YQNAl1jlDSN/gfBDNFCPQnATKFQxdxQSUsAa3BkKAJoDv5a3
         V+5UV2fnYiDGTgk4832ElMgIKqFIi68lm5Ajc=
Received: by 10.223.92.147 with SMTP id r19mr14194035fam.18.1318032096627;
        Fri, 07 Oct 2011 17:01:36 -0700 (PDT)
Received: from localhost.localdomain (abrz200.neoplus.adsl.tpnet.pl. [83.8.119.200])
        by mx.google.com with ESMTPS id n18sm15310107fah.2.2011.10.07.17.01.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 07 Oct 2011 17:01:35 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p98012KM003877;
	Sat, 8 Oct 2011 02:01:12 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p9800Zk1003868;
	Sat, 8 Oct 2011 02:00:35 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vobxstt4w.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183129>

Junio C Hamano <gitster@pobox.com> writes:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
>=20
> > Alternatively, one could store the description in a blob and refer =
to
> > that directly, of course. I.e., have
> >
> > refs/description/foo
> >
> > point to a blob whose content is the description of the ref
> >
> > ref/foo
> >
> > That would be unversioned, and one could decide more easily which
> > descriptions to share. (A notes tree you either push or don't.)
[...]

> But it remains that any of these approaches assume branch names are
> universal. Unlike other systems, what we call branches do not have th=
eir
> own identity, so if you really want to go that route (and we _might_ =
need
> to in the longer term, but I am not convinced at this point yet), you
> would first need to define how that local namespace would look like, =
how
> people interact with it, etc. It might be just the matter of declarin=
g a
> convention e.g. "Among people who meet at this central repository,
> everybody must map the branches identically to their local branch
> namespace, and all sharing must go through the central repository", a=
nd
> calling a tuple <central repository URL, branch name in that reposito=
ry>
> with a name that cannot be confused with "branch" (so "remote branch"=
 is
> out), such as "(development) track".

Well, git could by default imply that 'refs/heads/*:refs/remotes/foo/*'
implies 'refs/description/*:refs/remote-descriptions/foo/*'...

=2E..one more argument for hierarchical remote-tracking refs namespace,
i.e. 'refs/remotes/foo/refs/heads/*', and not current 'refs/remotes/foo=
/*'

Just my 3 eurocents^W groszy.
--=20
Jakub Nar=EAbski
