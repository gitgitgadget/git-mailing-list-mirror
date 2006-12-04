X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: egit/jgit wishlist
Date: Mon, 4 Dec 2006 22:54:42 +0100
Organization: Dewire
Message-ID: <200612042254.43224.robin.rosenberg.lists@dewire.com>
References: <20061204172836.GB6011@spearce.org> <Pine.LNX.4.63.0612041841280.14187@alpha.polcom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Mon, 4 Dec 2006 21:52:37 +0000 (UTC)
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.4
In-Reply-To: <Pine.LNX.4.63.0612041841280.14187@alpha.polcom.net>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33259>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrLje-0004sp-R9 for gcvg-git@gmane.org; Mon, 04 Dec
 2006 22:52:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967417AbWLDVwY convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006 16:52:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967412AbWLDVwY
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 16:52:24 -0500
Received: from [83.140.172.130] ([83.140.172.130]:15610 "EHLO
 torino.dewire.com" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with
 ESMTP id S967408AbWLDVwX convert rfc822-to-8bit (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006 16:52:23 -0500
Received: from localhost (localhost [127.0.0.1]) by torino.dewire.com
 (Postfix) with ESMTP id 975D5802ABB; Mon,  4 Dec 2006 22:48:34 +0100 (CET)
Received: from torino.dewire.com ([127.0.0.1]) by localhost (torino
 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id 32005-07; Mon,  4 Dec
 2006 22:48:34 +0100 (CET)
Received: from [10.9.0.3] (unknown [10.9.0.3]) by torino.dewire.com (Postfix)
 with ESMTP id 2720C800199; Mon,  4 Dec 2006 22:48:32 +0100 (CET)
To: Grzegorz Kulewski <kangur@polcom.net>
Sender: git-owner@vger.kernel.org

m=E5ndag 04 december 2006 19:16 skrev Grzegorz Kulewski:
> Hi,
>
> I am interested in seeing GIT support in Eclipse.
>
> I think that doing it in 100% pure Java is ok in long run but I wonde=
r if
> you couldn't make "wrapper" plugin for a start (that would call the r=
eal C
> git for every operation) and make it usable (with full pure Java SWT =
UI
> support) and then try to implement feature by feature in pure Java (w=
ith
> config options telling what should be called by wrapper and what by p=
ure
> implementation)?
>
> This way we could probably rather fast (basic versions of other GIT U=
Is
> were created rather fast IIRC) have basic support for GIT (preferably
> with GIT Java wrapper library for other projects) that would be usabl=
e for
> most users and this way you could gain more interest in the project. =
Also
> testing new pure implementation would be a lot easier (changing one l=
ine
> in config file to enable some pure Java feature and of course having =
an
> option to come back to wrapped version of this feature if new pure
> implementation was wrong).
>
> What do you think about it?
>
Calling wrappers on top of C (JNI/exec), bash script, perl script etc e=
tc is=20
not very easy or quick and requiring all dependencies on whatnot, makes=
=20
installation of plugins very complicated. There would go a lot of work =
into=20
working with the wrappers, instead of creating a pure Java implementati=
on. As=20
Shawn knows the Git internals very well, and the datastructures being=20
documented, implementing a pure java version is the best thing, and may=
be the=20
simplest, to do If an complete C library existed, maybe things would be=
=20
different. Most of the git storage access is already there.

Note that many Git tools work with egit too allowing a smooth transitio=
n and=20
the implementation of feature by feature. I use clone, pull, push, Stac=
ked=20
git, and the CVS tools today just fine in the same working area as egit=
=2E=20
Having a dependency on bash/perl/python etc, etc i EGIT would be counte=
r=20
productive. I /could/ imaging a C-implementation of the index to make i=
t=20
fully interoperable with the git tools in the same working area, but th=
at's=20
about it, because that would have to be C as java's portable API's does=
 not=20
include lstat.

It is possible though for those that wish to implement a separate plugi=
n that=20
provides wrapper-implementation of certain features. To eclipse that wo=
uld=20
just be yet another plugin that provides some git-related feature.  Suc=
h=20
plugins could use egit, jgit if necessary.

