From: "David Frech" <nimblemachines@gmail.com>
Subject: test suite fails if sh != bash || tar != GNU tar
Date: Tue, 10 Jul 2007 19:39:29 -0700
Message-ID: <7154c5c60707101939sc921b07wef1d14f85086947d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 11 04:39:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8S7D-0002XF-2f
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 04:39:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752638AbXGKCjc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 22:39:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752607AbXGKCjc
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 22:39:32 -0400
Received: from nz-out-0506.google.com ([64.233.162.229]:49543 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752494AbXGKCjb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 22:39:31 -0400
Received: by nz-out-0506.google.com with SMTP id s18so1221375nze
        for <git@vger.kernel.org>; Tue, 10 Jul 2007 19:39:30 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=o0v28BlpalEq9sh6ch83UH48PEAKrDaTuG0538B6xpQVlE7RTUZ117enqjoEzf+2zkUQYcHRU8cEJL2gUYqEnCVknhE3UQUChJJDB8ZOvOJaQxlaYj0bCSUCshwutDrLBIgRAX9c98UocI6nfApjqTrBoZYZh3BEizUEK78VZlg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=c+D7nlWZ3EZ+3x7pwAgp8pVEqQ8kA9D0n2H8gbAegVGGs3GiibNKpGm34ZUnpB3wZRRIlkj0bKXXkfUlH5fU36tcU4/A73v6B5955+CGsU7XEg9HwjF5ncYKxmAtvufvMtVWbrCXSF4JCLruDN9YY8U+r6OAcE2yYaJiGXFAJo0=
Received: by 10.114.195.19 with SMTP id s19mr4737792waf.1184121569287;
        Tue, 10 Jul 2007 19:39:29 -0700 (PDT)
Received: by 10.115.59.9 with HTTP; Tue, 10 Jul 2007 19:39:29 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52129>

I've built git on several BSD (FreeBSD and DragonFlyBSD) systems, and
while it builds fine on both platforms, the test suite *fails* on
both.

I tracked most of the problems down to dependencies on bash and GNU
tar. I'm not sure yet what the specific differences are between BSD's
/bin/sh and bash (the two are separate in the BSD world), but it's
obvious what the problem is with tar: the git-archive test parses
datestamps printed out by tar, and the two tar's print datestamps
differently.

If I  set SHELL_PATH=/usr/local/bin/bash and TAR=gtar (the name of GNU
tar on BSD systems) I am able to get thru all the tests on FreeBSD
(this is with a checkout of the v1.5.2.3 tag).

On DragonFly there is another problem that I have not yet tracked
down. git-mailinfo fails on 0004 - it fails to extract *anything* from
the message.

Anyone running Linux or Mac OSX won't see these problems, because on
both platforms /bin/sh == bash and tar == GNU tar.

Cheers,

- David
-- 
If I have not seen farther, it is because I have stood in the
footsteps of giants.
