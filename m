From: Junio C Hamano <junkio@cox.net>
Subject: Re: describe fails on tagless branch
Date: Tue, 06 Feb 2007 18:14:22 -0800
Message-ID: <7vr6t2g1dt.fsf@assigned-by-dhcp.cox.net>
References: <eqb660$ft7$1@sea.gmane.org> <eqb73j$hri$1@sea.gmane.org>
	<45C92918.8010801@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: hanwen@xs4all.nl
X-From: git-owner@vger.kernel.org Wed Feb 07 03:14:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEcKJ-0003OP-2X
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 03:14:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbXBGCOY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Feb 2007 21:14:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752317AbXBGCOY
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Feb 2007 21:14:24 -0500
Received: from fed1rmmtai15.cox.net ([68.230.241.44]:48148 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751446AbXBGCOX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Feb 2007 21:14:23 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070207021421.YFOT1306.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Tue, 6 Feb 2007 21:14:21 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id LSEN1W00g1kojtg0000000; Tue, 06 Feb 2007 21:14:23 -0500
In-Reply-To: <45C92918.8010801@xs4all.nl> (Han-Wen Nienhuys's message of "Wed,
	07 Feb 2007 02:19:20 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38884>

Han-Wen Nienhuys <hanwen@xs4all.nl> writes:

> Jakub Narebski escreveu:
>> 
>> _Which_ INIT? In git there can be more than one root commit. In git.git
>
> I don't really care, but I would like git-describe to produce something 
> useful in the absence of tags.  The -g<SHA-1> already makes the commit
> uniquely identifiable.

Then you would script like this:

	#!/bin/sh
	git describe "$1" 2>/dev/null || git rev-parse --verify "$1"

I do not think it a good idea to make "git-describe" itself do
the above, as the user of describe may want to fall back on
something other than "rev-parse --verify" after ||.
