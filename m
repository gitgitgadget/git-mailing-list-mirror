From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] Move pathspec validation into interactive_add
Date: Sat, 24 Nov 2007 11:15:27 -0800
Message-ID: <7vir3rqwts.fsf@gitster.siamese.dyndns.org>
References: <7vk5o8smaf.fsf@gitster.siamese.dyndns.org>
	<1195908922-88023-1-git-send-email-win@wincent.com>
	<1195908922-88023-2-git-send-email-win@wincent.com>
	<1195908922-88023-3-git-send-email-win@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Sat Nov 24 20:16:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iw0Tu-00023G-HG
	for gcvg-git-2@gmane.org; Sat, 24 Nov 2007 20:15:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753594AbXKXTPk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Nov 2007 14:15:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753810AbXKXTPj
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Nov 2007 14:15:39 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:39171 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753090AbXKXTPj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Nov 2007 14:15:39 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 951C62EF;
	Sat, 24 Nov 2007 14:16:00 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id DAFAC9948C;
	Sat, 24 Nov 2007 14:15:56 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65959>

Wincent Colaiuta <win@wincent.com> writes:


> Instead of throwing away the return status of pathspec_match() I am
> keeping it, and any successful match breaks out of the loop early.

Leaving it early before checking if all the given pathspecs are
used defeats the whole "error-unmatch" business, doesn't it?

> Another issue is that simple shell shortcuts don't work, so something
> as simple as "git-add -i ." will report:
>
>   error: pathspec '.' did not match any file(s) known to git.

The sample code snippet I sent you probably is not doing 
get_pathspec() before using the "pattern" thing.  And I suspect
that ...

> Likewise it's not possible to validate pathspecs like "\*.sh" either,

... may be related to that.
