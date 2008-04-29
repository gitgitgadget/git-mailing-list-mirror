From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix use after free() in builtin-fetch
Date: Tue, 29 Apr 2008 00:30:42 -0700
Message-ID: <7vtzhl6rtp.fsf@gitster.siamese.dyndns.org>
References: <20080428184138.GA30702@redhat.com>
 <20080428202335.GA10600@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Dave Jones <davej@redhat.com>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 09:32:05 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqkJn-0003SV-O1
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 09:32:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754772AbYD2HbB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 03:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753946AbYD2HbA
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 03:31:00 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54053 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753686AbYD2HbA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 03:31:00 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CCC5915A3;
	Tue, 29 Apr 2008 03:30:57 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 0C9AA15A2; Tue, 29 Apr 2008 03:30:50 -0400 (EDT)
In-Reply-To: <20080428202335.GA10600@steel.home> (Alex Riesen's message of
 "Mon, 28 Apr 2008 22:23:35 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80666>

Alex Riesen <raa.lkml@gmail.com> writes:

> As reported by Dave Jones:
> ...
> export MALLOC_PERTURB_=$(($RANDOM % 255 + 1))
>
> which is handy for showing up such bugs.
>
> More info on this glibc feature is at http://udrepper.livejournal.com/11429.html
>
> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>

Thanks.  I can reproduce the issue and the fix (and can even bisect this
down to ba22785 (Reduce the number of connects when fetching, 2008-02-04),
which makes perfect sense).

Will apply to 'maint' and merge up.
