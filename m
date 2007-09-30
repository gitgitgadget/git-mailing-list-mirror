From: Junio C Hamano <gitster@pobox.com>
Subject: Re: GIT_EXTERNAL_DIFF invoked with undocumented calling convention after unstashing conflicts
Date: Sun, 30 Sep 2007 12:59:26 -0700
Message-ID: <7vk5q7hqld.fsf@gitster.siamese.dyndns.org>
References: <200709302117.37422.bruno@clisp.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bruno Haible <bruno@clisp.org>
X-From: git-owner@vger.kernel.org Sun Sep 30 21:59:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ic4x6-0007Zn-35
	for gcvg-git-2@gmane.org; Sun, 30 Sep 2007 21:59:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751614AbXI3T7e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2007 15:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751586AbXI3T7e
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Sep 2007 15:59:34 -0400
Received: from rune.pobox.com ([208.210.124.79]:60050 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751484AbXI3T7d (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2007 15:59:33 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 66CB113ED57;
	Sun, 30 Sep 2007 15:59:54 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id B34EE13EA2C;
	Sun, 30 Sep 2007 15:59:50 -0400 (EDT)
In-Reply-To: <200709302117.37422.bruno@clisp.org> (Bruno Haible's message of
	"Sun, 30 Sep 2007 21:17:37 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59551>

> "git diff --uncached" invokes the GIT_EXTERNAL_DIFF variable with just one
> argument (instead of 7 arguments, as documented) in a particular situation:

You are looking at an unmerged path.

    'GIT_EXTERNAL_DIFF'::
            When the environment variable 'GIT_EXTERNAL_DIFF' is set, the
            program named by it is called, instead of the diff invocation
            described above.  For a path that is added, removed, or modified,
            'GIT_EXTERNAL_DIFF' is called with 7 parameters:

    ...
    +
    For a path that is unmerged, 'GIT_EXTERNAL_DIFF' is called with 1
    parameter, <path>.

The script needs to decide how it wants to present an unmerged
path; the information on each unmerged stages can be read from
the output of "ls-files -u $thatpath".
