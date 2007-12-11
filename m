From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH (amend)] diff: Make numstat machine friendly also for renames (and copies)
Date: Mon, 10 Dec 2007 17:06:29 -0800
Message-ID: <7vejdujazu.fsf@gitster.siamese.dyndns.org>
References: <200712102332.53114.jnareb@gmail.com>
	<200712102355.39084.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 02:07:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1taP-0000Gv-Ee
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 02:07:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751636AbXLKBGk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 20:06:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751602AbXLKBGk
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 20:06:40 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40217 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425AbXLKBGk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 20:06:40 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F7A42108;
	Mon, 10 Dec 2007 20:06:33 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A7D12107;
	Mon, 10 Dec 2007 20:06:30 -0500 (EST)
In-Reply-To: <200712102355.39084.jnareb@gmail.com> (Jakub Narebski's message
	of "Mon, 10 Dec 2007 23:55:38 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67772>

Jakub Narebski <jnareb@gmail.com> writes:

> Previous version of this patch (from 7 May 2007) used instead of current
> only "to_name" format similar to git-diff-tree raw format for renames:
>
>   added deleted TAB path for "src" TAB path for "dst" LF
>     
> The problem was when -z option was used: how to separate end of record
> from end of from_name and start of to_name. For git-diff we have status
> to distinguish those; no such thing for numstat output. Previous version
> of patch used (or was to use actually, because of error in the code)
>
>   added deleted TAB path for "src" NUL NUL path for "dst" NUL
>
> when -z option was used.

I think the cleanest at this point is to have --numstat-enhanced that
shows

	<added> <deleted> <status> <path1>
        <added> <deleted> <status> <path1> <path2>

Anything else would be a regression.
