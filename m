From: Peter Vereshagin <peter@vereshagin.org>
Subject: Re: delete deprecated refs to release disk space
Date: Thu, 17 Nov 2011 03:44:22 +0400
Organization: '
Message-ID: <20111116234422.GA5131@external.screwed.box>
References: <20111113151033.GD16065@external.screwed.box>
 <CACBZZX5kBqM1eye40_Vw0W=8qnNsUQBVCE0q9JrixYomGPuZbg@mail.gmail.com>
 <20111114142525.GB8641@external.screwed.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Cc: ??var Arnfj??r?? Bjarmason <avarab@gmail.com>, git@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 17 00:45:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQpAq-0001PJ-C0
	for gcvg-git-2@lo.gmane.org; Thu, 17 Nov 2011 00:45:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754590Ab1KPXpo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Nov 2011 18:45:44 -0500
Received: from ns1.skyriver.ru ([89.108.118.221]:59703 "EHLO mx1.skyriver.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751674Ab1KPXpn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2011 18:45:43 -0500
Received: from localhost (rainbowwarrior.torservers.net [77.247.181.164])
	by mx1.skyriver.ru (Postfix) with ESMTPSA id 18BC15A94;
	Thu, 17 Nov 2011 03:10:57 +0400 (MSK)
Content-Disposition: inline
In-Reply-To: <20111114142525.GB8641@external.screwed.box>
X-Face: 8T>{1owI$Byj]]a;^G]kRf*dkq>E-3':F>4ODP[#X4s"dr?^b&2G@'3lukno]A1wvJ_L(~u
 6>I2ra/<,j1%@C[LN=>p#_}RIV+#:KTszp-X$bQOj,K
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185561>

Hello.

2011/11/14 18:25:25 +0400 Peter Vereshagin <peter@vereshagin.org> => To ??var Arnfj??r?? Bjarmason :
PV> N commits ago is a fine setting for me as it's a cron job backup. Thanks?

* = Thanks!

Here is the PoC QnD code that releases disk space for me by far:

    git rev-list --all --timestamp |\
        perl -Mstrict -MTime::ParseDate -wE \
            'my $match = 0; my $expire = parsedate( "3 days ago" ); while (<>)
                { chomp; my ( $tstamp => $graft_id ) = split /\s+/;
                    if ( not( $match ) and $tstamp < $expire )
                        { say $graft_id; $match = 1; } }
            ' > .git/info/grafts && \
    git filter-branch -f

for case a one shall seek for it.

--
Peter Vereshagin <peter@vereshagin.org> (http://vereshagin.org) pgp: A0E26627 
