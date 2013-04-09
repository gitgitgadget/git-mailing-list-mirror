From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: commit-message attack for extracting sensitive data from rewritten
 Git history
Date: Tue, 09 Apr 2013 08:03:24 +0200
Message-ID: <5163AF2C.2020107@viscovery.net>
References: <CAFY1edbNPjs5JGOPRxzB+ie4w=SvR+rUeePhsEnpr0tWtZpeHg@mail.gmail.com> <7vehelyqrv.fsf@alter.siamese.dyndns.org> <20130408215457.GB11227@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Roberto Tyley <roberto.tyley@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 09 08:03:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPRee-0002aB-MW
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 08:03:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760291Ab3DIGDc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Apr 2013 02:03:32 -0400
Received: from so.liwest.at ([212.33.55.13]:24858 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751186Ab3DIGDa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 02:03:30 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1UPReP-00039p-CT; Tue, 09 Apr 2013 08:03:25 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id D67F41660F;
	Tue,  9 Apr 2013 08:03:24 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <20130408215457.GB11227@sigill.intra.peff.net>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220552>

Am 4/8/2013 23:54, schrieb Jeff King:
> Yeah, it would make sense for filter-branch to have a "--map-commit-ids"
> option or similar that does the update. At first I thought it might take
> two passes, but I don't think it is necessary, as long as we traverse
> the commits topologically (i.e., you cannot have mentioned X in a commit
> that is an ancestor of X, so you do not have to worry about mapping it
> until after it has been processed).

Topological traversal is not sufficient. Consider this history:

     o--A--o--
    /     /
 --o--B--o

If A mentions B (think of cherry-pick -x), then you must ensure that the
branch containing B was traversed first.

-- Hannes
