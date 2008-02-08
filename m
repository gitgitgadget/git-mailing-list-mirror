From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Adding gitweb.owner, last shot
Date: Thu, 07 Feb 2008 23:38:44 -0800
Message-ID: <7v3as3lwxn.fsf@gitster.siamese.dyndns.org>
References: <1202445714-28971-1-git-send-email-ribas@c3sl.ufpr.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Bruno Ribas <ribas@c3sl.ufpr.br>
X-From: git-owner@vger.kernel.org Fri Feb 08 08:39:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNNpe-0003qx-V8
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 08:39:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758708AbYBHHi5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 02:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758636AbYBHHi4
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 02:38:56 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34369 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758521AbYBHHiz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 02:38:55 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 592F76B4C;
	Fri,  8 Feb 2008 02:38:54 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A08736AF3;
	Fri,  8 Feb 2008 02:38:47 -0500 (EST)
In-Reply-To: <1202445714-28971-1-git-send-email-ribas@c3sl.ufpr.br> (Bruno
	Ribas's message of "Fri, 8 Feb 2008 02:41:52 -0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73050>

Bruno Ribas <ribas@c3sl.ufpr.br> writes:

> ... there is no major performance downgrade
> compared to $projects_list , as seen below:
>
> 8<-------
> These times i got with a 1000projects running 2 dd to generate disk IO.
> Here comes the resultm
> NO projects_list  projects_list
> 16m30s69          15m10s74       default gitweb, using FS's owner
> 16m07s40          15m24s34       patched to get gitweb.owner
> 16m37s76          15m59s32       same above, but without gitweb.owner
>
> Now results for a 1000projects on an idle machine.
> NO projects_list  projects_list
> 1m19s08           1m09s55       default gitweb, using FS's owner
> 1m17s58           1m09s55       patched to get gitweb.owner
> 1m18s49           1m08s96       same above, but without gitweb.owner
> 8<-------

Large installations would maintain the project_list in the flat
file format for performance reasons anyway.  Benchmarking under
a condition that yields unreasonably long response time is
somewhat meaningless, I am afraid.  Who sane would wait for 15
minutes for project list to come up?

So I think your patch makes sense.  It would not help nor hurt
large installations, and would help smaller installations that
do not care much about performance but are more interested in
the convenience of not having to worry about maintaining the
project_list.

As the act of signing off patches is a legal statement, I'd
prefer real person's name, not "Git Managment for C3SL", in the
messages to be applied.  The change that adds the feature, and
the documentation update to describe that new feature, should be
in the same single patch for a small change like this.
