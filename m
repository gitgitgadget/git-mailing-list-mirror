From: "Todd A. Jacobs" <nospam+listmail@codegnome.org>
Subject: git bundle unbundle and "check-outable" refs
Date: Thu, 29 Sep 2011 08:51:23 -0700 (PDT)
Message-ID: <dec8c877-bd6e-4120-b045-87179d54abe2@i30g2000yqd.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 29 18:35:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9JaM-0002UU-PJ
	for gcvg-git-2@lo.gmane.org; Thu, 29 Sep 2011 18:35:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756752Ab1I2Qfm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Sep 2011 12:35:42 -0400
Received: from mail-yx0-f184.google.com ([209.85.213.184]:62653 "EHLO
	mail-yx0-f184.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753892Ab1I2Qfl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2011 12:35:41 -0400
X-Greylist: delayed 1888 seconds by postgrey-1.27 at vger.kernel.org; Thu, 29 Sep 2011 12:35:41 EDT
Received: by yxl11 with SMTP id 11so1342677yxl.1
        for <git@vger.kernel.org>; Thu, 29 Sep 2011 09:35:41 -0700 (PDT)
Received: by 10.146.117.21 with SMTP id p21mr156666yac.12.1317311483777; Thu,
 29 Sep 2011 08:51:23 -0700 (PDT)
Received: by i30g2000yqd.googlegroups.com with HTTP; Thu, 29 Sep 2011 08:51:23
 -0700 (PDT)
User-Agent: G2/1.0
X-Google-Web-Client: true
X-Google-Header-Order: HUALESNKRC
X-HTTP-UserAgent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0.2) Gecko/20100101 Firefox/6.0.2,gzip(gfe)
X-Google-IP: 65.111.91.107
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182406>

Never having needed git bundle before, I've recently been using it as
a sneakernet. In particular, I'm using bundles to work around
limitations of filesystem semantics on vfat and hpfs+ drives when
shared between Linux and OS X systems. The systems are air-gapped, so
sneakernet is essential.

At any rate, the issue I'm dealing with is that "git bundle unbundle"
is sort of non-intuitive to deal with. It seems to add the commits
directly to the local repository, but doesn't give me any of the
branch refs that I'm expecting from such an operation. In other words,
if I bundle branch foo on machine A, then unbundle on machine B, I
expect to be able to "git checkout foo" and get on with life.

Instead, it seems that I have to figure out what commits were
unbundled, and create a new branch ref pointing to the head that I
want. I assume this is to prevent namespace collisions, but it seems
really, really cumbersome. Wouldn't it make more sense to include
branch names in the bundle, and simply prompt the user to rename refs
that conflict?

I'm certainly open to other ideas of how to accomplish this workflow,
and if there's an invocation to simplify this that I'm unaware of,
please advise. Otherwise, I really think the default behavior of the
unbundle sub-command ought to be more intuitive.
