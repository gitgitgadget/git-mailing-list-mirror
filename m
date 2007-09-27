From: Dan Farina <drfarina@gmail.com>
Subject: backup or mirror a repository
Date: Thu, 27 Sep 2007 12:35:42 -0700
Message-ID: <1190921742.2263.17.camel@Tenacity>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 27 21:36:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iaz9V-0002t4-Jh
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 21:36:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758075AbXI0Tfy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 15:35:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757686AbXI0Tfx
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 15:35:53 -0400
Received: from nz-out-0506.google.com ([64.233.162.235]:39911 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758062AbXI0Tfw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 15:35:52 -0400
Received: by nz-out-0506.google.com with SMTP id s18so1833355nze
        for <git@vger.kernel.org>; Thu, 27 Sep 2007 12:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:subject:from:to:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=tC+dpGTBJoUIT92IfJ+I+7bhExlWeEzd5+GLZsimiyI=;
        b=qDugcAy5p+KCVM2UwapEF3TSCY9PptrAlHEAe9dnsP+R1MA5TMAra5jSjFYohEFCo7CU6MLO/U0VNBjuHjSHJAwHRn6/6Tm+0UJL52lGGVwq1oz3/ozzH4UbCFLfCYq6IUiU9b4LBtcod5HZQ0JKYgB21WJmnul96NZyCPXilsY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:subject:from:to:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=g8T3kxy0WCkDl2x/vd93IFjDgB7OyZKhxx98/89m9Johdv3z0qRKG5+Z8+aoqxB31/RJC5Uju9vwz+WPo/itE6eiiKS5Gde3joQtVsUS1pi0VJccDW9YaOeMjyQa4TdU3dY6s9v+H+I1KrW3rTm65LAMY/MTWOpPSRlJUwFXAAU=
Received: by 10.141.133.14 with SMTP id k14mr1127434rvn.1190921751306;
        Thu, 27 Sep 2007 12:35:51 -0700 (PDT)
Received: from ?192.168.1.101? ( [71.134.240.3])
        by mx.google.com with ESMTPS id g6sm4593183rvb.2007.09.27.12.35.50
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 27 Sep 2007 12:35:50 -0700 (PDT)
X-Mailer: Evolution 2.10.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59320>

Hello list,

I have been poking around on IRC and gmane, but haven't yet seen a
solution to my problem:

What I really want is something semantically identical to a recursive
copy of my entire git repository on one machine sent to another machine.
Right now I can't simply use "rsync -ar --delete ..." because the pack
changes names, thus fooling rsync and sending a bunch of bits over the
network.

I saw git-mirror on gmane and asked around in IRC, but the former seems
to have died sometime last November and the latter told me I'd probably
have to write some glue to process git show-ref and git ls-remote. This
seems viable, but suboptimal. Another user chimed in that they also had
the same use case as myself.


fdr

(Justifications: I am super paranoid, so I want to push my local
branches to another disk to be safe, but then they proliferate over time
since deleted local branches are not also deleted on the target
repository. I also want to work on multiple machines seamlessly, and as
such doing a bunch of "git checkout -r ..." when I need to change
branches is also suboptimal. As I said, I can get what I want by simply
using rsync, so this is entirely about efficiency by exploiting git's
structure)
