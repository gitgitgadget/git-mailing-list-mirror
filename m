From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix new-workdir (again) to work on bare repositories
Date: Tue, 21 Aug 2007 21:33:57 -0700
Message-ID: <7v3ayckx1m.fsf@gitster.siamese.dyndns.org>
References: <20070822015012.GA11085@spearce.org>
	<7v1wdwntc6.fsf@gitster.siamese.dyndns.org>
	<20070822033625.GN27913@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Aug 22 06:34:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INhuy-0006MU-AW
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 06:34:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbXHVEeF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 00:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750938AbXHVEeE
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 00:34:04 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:36841 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820AbXHVEeD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2007 00:34:03 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 8A767124A20;
	Wed, 22 Aug 2007 00:34:21 -0400 (EDT)
In-Reply-To: <20070822033625.GN27913@spearce.org> (Shawn O. Pearce's message
	of "Tue, 21 Aug 2007 23:36:26 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56349>

"Shawn O. Pearce" <spearce@spearce.org> writes:

>> You may have made the part to create the new directory and make
>> bunch of symbolic links to work with your patch, but as far as I
>> know, new-workdir is designed to share the .git/config file with
>> the borrowed repository, which means the configuration would say
>> "core.bare = yes" for a bare repository.  So I suspect that the
>> initial checkout after creating the new directory and populating
>> its .git would barf, although I haven't tested it.
>
> Indeed.  I have a driver script that sets up my bare repos, it
> removes core.bare from their configs.  So if you go into the bare
> repo our auto-sensing bare thing gets activated and says "Hmm, it
> ends in .git but isn't exactly .git so its bare!" (correct answer).
> If you cd into a workdir created by git-new-workdir the auto-sensing
> bare thing gets activated and says "Hmm, it is exactly .git so its
> not-bare!" (correct answer).
>
> So removing that core.bare thing makes the magic work.

Ok, that is better than the response I sent (our messages
crossed).  In that case, perhaps you would want a warning or a
suggestion at the end of new-workdir script, probably before
checkout, to teach the user about that magic?
