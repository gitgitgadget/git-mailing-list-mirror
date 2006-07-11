From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [PATCH] Eliminate Scalar::Util usage from private-Error.pm
Date: 10 Jul 2006 18:38:49 -0700
Message-ID: <86bqrwncnq.fsf@blue.stonehenge.com>
References: <20060710130046.GW29115@pasky.or.cz>
	<20060711005354.5911.62525.stgit@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 11 03:39:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G07DJ-0008Oq-QG
	for gcvg-git@gmane.org; Tue, 11 Jul 2006 03:39:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965032AbWGKBiw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 21:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965048AbWGKBiw
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 21:38:52 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:33030 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP id S965032AbWGKBiv
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jul 2006 21:38:51 -0400
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id C93B88D526;
	Mon, 10 Jul 2006 18:38:50 -0700 (PDT)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 07553-01-2; Mon, 10 Jul 2006 18:38:50 -0700 (PDT)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 0B09B8D560; Mon, 10 Jul 2006 18:38:50 -0700 (PDT)
To: Petr Baudis <pasky@suse.cz>
x-mayan-date: Long count = 12.19.13.8.4; tzolkin = 1 Kan; haab = 17 Tzec
In-Reply-To: <20060711005354.5911.62525.stgit@machine.or.cz>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23678>

>>>>> "Petr" == Petr Baudis <pasky@suse.cz> writes:

Petr> We used just the blessed() routine so steal it from Scalar/Util.pm. ;-)
Petr> (Unfortunately, Scalar::Util is not bundled with older Perl versions.)

Wow.  That's sure the long way around for what I would use this for:

sub blessed {
        my $item = shift;
        local $@; # don't kill an outer $@
        ref $item and eval { $item->can('can') };
}

We call it "doing the can-can". :)

And this solution has the advantage that it doesn't pollute UNIVERSAL.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
