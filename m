From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH 3/3] implement pattern matching in ce_path_match
Date: Thu, 15 Jan 2009 09:20:18 +0100
Message-ID: <20090115082017.GA7801@localhost>
References: <1231944876-29930-1-git-send-email-drizzd@aon.at> <1231944876-29930-2-git-send-email-drizzd@aon.at> <1231944876-29930-3-git-send-email-drizzd@aon.at> <1231944876-29930-4-git-send-email-drizzd@aon.at> <7vljtd20m6.fsf@gitster.siamese.dyndns.org> <20090114192341.GA26703@localhost> <7vvdshzfpk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, johannes@familieschneider.info
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 15 09:21:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNNTw-0003wy-5l
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 09:21:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755443AbZAOIUQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 03:20:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755084AbZAOIUP
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 03:20:15 -0500
Received: from postman.fh-hagenberg.at ([193.170.124.96]:49270 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754754AbZAOIUO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 03:20:14 -0500
Received: from darc.dyndns.org ([84.154.84.182]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 15 Jan 2009 09:20:11 +0100
Received: from drizzd by darc.dyndns.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1LNNSc-00026C-4Q; Thu, 15 Jan 2009 09:20:18 +0100
Content-Disposition: inline
In-Reply-To: <7vvdshzfpk.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 15 Jan 2009 08:20:12.0882 (UTC) FILETIME=[16821B20:01C976EA]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105771>

On Wed, Jan 14, 2009 at 02:27:03PM -0800, Junio C Hamano wrote:
> In places we read paths from the index or from the work tree and add them
> as pathspec elements---you would want to mark them as non-globbing, too.
> Which probably means that "is it Ok to glob this" setting has to be per
> pathspec array elements.

Right. This certainly complicates things. Also note that this invalidates
1/3, because even if '?' matched exactly, it can still match '*', and vice
versa. Depending on ordering one of these two cases would pose a problem.
