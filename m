From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] git config: do not create .git/ if it does not exist yet
Date: Wed, 24 Feb 2016 10:14:03 +0000
Message-ID: <20160224101403.GN1766@serenity.lan>
References: <c4027d758b0914dbc2e1ff5df344b0669aac4447.1456299545.git.johannes.schindelin@gmx.de>
 <20160224082657.GD12511@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 24 11:14:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYWSi-0007lf-JJ
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 11:14:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755863AbcBXKOV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 05:14:21 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:59261 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755883AbcBXKOT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 05:14:19 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id C0411CDA5A6;
	Wed, 24 Feb 2016 10:14:16 +0000 (GMT)
X-Quarantine-ID: <7eNdNG2uvk-s>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.2
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 tagged_above=-9999 required=5
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 7eNdNG2uvk-s; Wed, 24 Feb 2016 10:14:16 +0000 (GMT)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 1107ACDA5B8;
	Wed, 24 Feb 2016 10:14:05 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <20160224082657.GD12511@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287187>

On Wed, Feb 24, 2016 at 03:26:57AM -0500, Jeff King wrote:
> On Wed, Feb 24, 2016 at 08:47:00AM +0100, Johannes Schindelin wrote:
> 
> > 	I cannot think of a way how to test this: all of the regression
> > 	tests run inside Git's own worktree, and we cannot even assume
> > 	that /tmp/ is outside of a worktree (or that it exists).
> 
> We could make the test conditional on whether we are in a repo. Anybody
> who builds from a tarball, or who uses --root would then run the test.

Could we use GIT_CEILING_DIRECTORIES for this?  If it's set to
TEST_OUTPUT_DIRECTORY won't that cover the in-tree and out-of-tree test
cases?

We probably do still want Peff's REPOLESS prereq just in case someone is
collecting test results in a repository, but I think that will see much
better coverage than relying on people running tests from the tarball.
