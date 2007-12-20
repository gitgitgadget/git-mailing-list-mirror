From: Pascal Obry <pascal.obry@gmail.com>
Subject: Re: Question about git-svn import
Date: Thu, 20 Dec 2007 17:30:51 +0100
Organization: Home - http://www.obry.net
Message-ID: <476A98BB.8000900@obry.net>
References: <4766AF65.5060706@obry.net> <20071218034836.GA27080@dervierte> <4767724A.9040207@obry.net> <20071218153159.GA12549@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>
To: =?ISO-8859-1?Q?J=F6rg_Sommer?= <joerg@alea.gnuu.de>
X-From: git-owner@vger.kernel.org Thu Dec 20 17:31:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5OIx-0002f3-J2
	for gcvg-git-2@gmane.org; Thu, 20 Dec 2007 17:31:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965750AbXLTQa6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Dec 2007 11:30:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965737AbXLTQa6
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Dec 2007 11:30:58 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:18035 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965495AbXLTQa4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2007 11:30:56 -0500
Received: by fg-out-1718.google.com with SMTP id e21so607108fga.17
        for <git@vger.kernel.org>; Thu, 20 Dec 2007 08:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:organization:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:from;
        bh=vz+frrcQPZX1O2CNpBKgZbSkttmGAk2SJEMYJ8zA23g=;
        b=B7zI6jW6BY5VeAGr2XDvmEz7ngtyvKc8WFCdR2otFgdssT86XjuEiEJBtHcwJeKb7EFSqBDyxp6vfHEk7tZSt8Skh5ZLIB0ZjiE6iTfMF7o81CQqFLV3Mz0z5Mivr0TwEnJUkammJ3OENmwkA6VNyz6TH/SCZXI8FL/ZLvU4vS4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:organization:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:from;
        b=T63P5Dl+tGZEdc637+U795RbMKKXA356rAMT8fdrMsBJn9PZb5GCj825IDf8YL2hIxqA6M643S5IdVT3u9s6GkaRlfRxLOQutN6Im7Bj00fCfvcMTkROxAGQ4StJjNS/XAEhGXDZc2IkKnx39oTWdOVnkGD3EIc9L21J0Ybbw8I=
Received: by 10.86.71.1 with SMTP id t1mr141053fga.69.1198168254622;
        Thu, 20 Dec 2007 08:30:54 -0800 (PST)
Received: from ?192.168.0.100? ( [82.124.126.249])
        by mx.google.com with ESMTPS id 4sm7432923fge.2007.12.20.08.30.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 20 Dec 2007 08:30:53 -0800 (PST)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <20071218153159.GA12549@alea.gnuu.de>
X-Enigmail-Version: 0.95.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69009>

J=F6rg,

I have at least one remaining problem.

# Import old trunk into pre/master
$ git svn init svn+ssh://myserver --prefix=3Dpre/ --trunk=3Dimportfromc=
vs/trunk
$ git svn fetch --revision=3D9458:10242

# Import new trunk into post/master
$ git config svn-remote.svn.fetch trunk/PROJ:refs/remotes/post/trunk
$ git svn fetch --revision=3D11058:11066

# Rewrite post/trunk on top of pre/trunk into merged-master
$ git checkout post/trunk
$ git checkout -b merged-master
$ git-filter-branch --tag-name-filter cat --parent-filter "sed -e
's/^$/-p $(git rev-parse pre/trunk)/'" merged-master

The problem is that at this point I cannot "git svn rebase". Looks like
the filter-branch command did break the link between the Subversion
repository and the git svn one:

$ git svn rebase
Unable to determine upstream SVN information from working tree history

Is there a way around that ?

Thanks,
Pascal.

--=20

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|              http://www.obry.net
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver wwwkeys.pgp.net --recv-key C1082595
