From: Chris Webb <chris@arachsys.com>
Subject: Re: [RFC PATCH] add t3420-rebase-topology
Date: Thu, 27 Sep 2012 13:20:35 +0100
Message-ID: <20120927122035.GL16059@arachsys.com>
References: <1347949878-12578-1-git-send-email-martinvonz@gmail.com>
 <50582873.603@viscovery.net>
 <CANiSa6i+A6fkWpkPMXiBRdT48LaSfPe2yki+AmWFAKYg02p=+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 27 14:20:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THD5E-0007S0-7N
	for gcvg-git-2@plane.gmane.org; Thu, 27 Sep 2012 14:20:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753721Ab2I0MUj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2012 08:20:39 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:36392 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753202Ab2I0MUi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2012 08:20:38 -0400
Received: from [81.2.114.212] (helo=arachsys.com)
	by alpha.arachsys.com with esmtpa (Exim 4.80)
	(envelope-from <chris@arachsys.com>)
	id 1THD52-0003jJ-S5; Thu, 27 Sep 2012 13:20:37 +0100
Content-Disposition: inline
In-Reply-To: <CANiSa6i+A6fkWpkPMXiBRdT48LaSfPe2yki+AmWFAKYg02p=+g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206478>

Martin von Zweigbergk <martinvonz@gmail.com> writes:

> On Tue, Sep 18, 2012 at 12:53 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>
> > Why? Is it more like "--root implies --force"?
> 
> It doesn't currently exactly imply --force, but the effect is the
> same. Also see my reply to Junio's email in this thread.
> 
> Maybe Chris has some thoughts on this?

Hi Martin and Johannes. Sorry for the slow follow-up here.

You're right that rebase --root without --onto always creates a brand new
root as a result of the implementation using a sentinel commit. Clearly this
is what's wanted with --interactive, but rebase --root with neither --onto
nor --interactive is a slightly odd combination for which I struggle to
imagine a natural use. Perhaps you're right that for consistency it should
be a no-op unless --force-rebase is given?

If we did this, this combination would be a no-op unconditionally as by
definition we're always descended from the root of our current commit.
However, given the not-very-useful behaviour, I suspect that rebase --root
is much more likely to be a mistyped version of rebase -i --root than rebase
--root --force-rebase. (Unless I'm missing a reasonable use for this?
History linearisation perhaps?)

Best wishes,

Chris.
