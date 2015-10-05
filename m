From: John Keeping <john@keeping.me.uk>
Subject: Re: How can I ignore insignificant change during merge ?
Date: Mon, 5 Oct 2015 21:34:32 +0100
Message-ID: <20151005203432.GR17201@serenity.lan>
References: <CA+aSyzqxjoUbGbPvLMNcrYyE3ZAqwGYiXtSrUgg8O29MZLJWrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jens Brejner <jens@kaabrejner.dk>
X-From: git-owner@vger.kernel.org Mon Oct 05 22:34:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjCTC-0003Jn-RA
	for gcvg-git-2@plane.gmane.org; Mon, 05 Oct 2015 22:34:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752153AbbJEUeq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2015 16:34:46 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:58683 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751255AbbJEUep (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2015 16:34:45 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 04A43CDA591;
	Mon,  5 Oct 2015 21:34:45 +0100 (BST)
X-Quarantine-ID: <4MZx1-ZHlZBv>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_40=-0.001, URIBL_BLOCKED=0.001]
	autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 4MZx1-ZHlZBv; Mon,  5 Oct 2015 21:34:39 +0100 (BST)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 05A42CDA55D;
	Mon,  5 Oct 2015 21:34:34 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CA+aSyzqxjoUbGbPvLMNcrYyE3ZAqwGYiXtSrUgg8O29MZLJWrA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279086>

On Mon, Oct 05, 2015 at 10:13:00PM +0200, Jens Brejner wrote:
> I need to merge a branch, +100k changes. The vast majority of changes
> are insignificant, because they only represent a screen position in
> the editor, so these changes should never have been in git - but but
> MadCap Flare already put them there.
> 
> The files in question are xml, and the difference can be exemplifed like this:
> 
> Original (when branches were created):
> html xmlns:MadCap="http://www.madcapsoftware.com/Schemas/MadCap.xsd"
> MadCap:lastBlockDepth="5" MadCap:lastHeight="32"
> MadCap:lastWidth="400"
> Branch1:
> html xmlns:MadCap="http://www.madcapsoftware.com/Schemas/MadCap.xsd"
> MadCap:lastBlockDepth="5" MadCap:lastHeight="24"
> MadCap:lastWidth="500"
> Branch2:
> html xmlns:MadCap="http://www.madcapsoftware.com/Schemas/MadCap.xsd"
> MadCap:lastBlockDepth="5" MadCap:lastHeight="41"
> MadCap:lastWidth="300"
> 
> How can git help me so files where the only difference matches
> something like this regex:
> /html xmlns:.* MadCap:lastHeight="\d+" MadCap:lastWidth="\d+"/
> 
> for the files that qualify, I want git to ignore the change, and
> therefore the merge-conflict, and then just accept "my" file for the
> merged changeset.
> 
> Any suggestions on how to I can have git help me with that ?

Have you looked into defining a custom merge driver for these files?
It's documented in the "Performing a three-way merge" section of
gitattributes(5) - that is, "git help attributes".

It should be relatively easy to ignore these changes, but you'll have to
deal with merging the rest of the files as well; Python's difflib module
may be useful.
