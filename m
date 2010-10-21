From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Converting to Git using svn-fe (Was: Speeding up the initial git-svn fetch)
Date: Thu, 21 Oct 2010 10:16:46 +0200
Message-ID: <201010211016.47998.jnareb@gmail.com>
References: <20101018051702.GD22376@kytes> <201010202244.39728.jnareb@gmail.com> <AANLkTi=mhN1M+KrGVCYLhZiMUMXSABG-YEPPgDFb-nSv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Will Palmer <wmpalmer@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Stephen Bash <bash@genarts.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Tomas Carnecky <tom@dbservice.com>
To: mrevilgnome <mrevilgnome@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 21 10:17:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8qKc-00016O-8t
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 10:17:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751698Ab0JUIQ4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Oct 2010 04:16:56 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:65254 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081Ab0JUIQy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 04:16:54 -0400
Received: by bwz18 with SMTP id 18so67160bwz.19
        for <git@vger.kernel.org>; Thu, 21 Oct 2010 01:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=M6Aichv4IvSs5lfEvnfUrmams0rEyLhYpGkyRFRneLc=;
        b=YVR8f3ISTH0eTe/GnyrLqc8g1v9JFRiP8YcIDbMZhLR+qkL5+eos9u5VKG/k/TM13g
         GO294jsEfKj79X0ly27uJmtlll9e/Y/8FZjoQkmF8v+FVmWXDmWDuK/rzu3aN1zj6Xaz
         BM9CjUKEBgkjLrNV2t9oHokHJrKLWmKSdLRuc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ET9tu6MJ31ys6J65WORTxVa34L06zdolEg2p1u0xm/eLoumYEpFQOsvxpcdpkJPeG5
         8mByPudwjuNwAcWRfsXY4N4Uti1FuOWbGloj6a+QXqa0DD5WvnxYihy9F1XDEV22y6tP
         PzxabLnU94gygKVj5KxbPG1FkeeA0n8W4gFKs=
Received: by 10.204.117.195 with SMTP id s3mr331067bkq.203.1287649013214;
        Thu, 21 Oct 2010 01:16:53 -0700 (PDT)
Received: from [192.168.1.13] (abvl250.neoplus.adsl.tpnet.pl [83.8.209.250])
        by mx.google.com with ESMTPS id u4sm939625bkz.5.2010.10.21.01.16.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 21 Oct 2010 01:16:51 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTi=mhN1M+KrGVCYLhZiMUMXSABG-YEPPgDFb-nSv@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159488>

On Thu, 21 Oct 2010, mrevilgnome wrote:
> Jakub Narebski wrote:

> > Subversion uses the inter-file branching model (Wikipedia says it w=
as
> > "borrowed" from Perforce) to handle branches and tags. =C2=A0It use=
s "branches
> > are copies (folders)" paradigm, and technically it doesn't have sep=
arate
> > namespace for branches but have projects, branches, and projects'
> > filesystem hierarchy mixed together; what part of path is branch na=
me
> > is defined by convention only. =C2=A0This model makes it easy to me=
ss up
> > repository (because there are no technological barriers for going
> > against conventions, like mentioned all-branches change, or changin=
g
> > tags, or reversed hierarchy or branches and projects).
>
> I agree.  The repository that I'm interested in converting has
> branches all over the place /sandbox/, /sandbox/<username>/*,
> /stable/MAIN/*, /stable/Features/*,  /features/*, /branches/*, etc...
> Because subversion didn't enforce the convention it was all to easy t=
o
> ignore when our questionable branching strategy was created.  Instead
> of expecting sub-folders of a particular path to be a branch is there
> something that we can key off of in the dumpfile?  Are copy operation=
s
> notated in some fashion?
=20
Actually it shouldn't be that hard to implement, it it isn't already
implemented in svn-fe.

We don't need to have copy operations notated in some fashion; it shoul=
d
be enough to tell svn-fe where the top directory of project is in=20
repository tree hierarchy (e.g. that it is at /stable/MAIN/* at
revision 1).  git-fe can/could use then 'tree' movement detection that=20
'subtree' merge strategy uses.

--=20
Jakub Narebski
Poland
