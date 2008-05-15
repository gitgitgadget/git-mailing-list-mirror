From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How can I tell if a SHA1 is a submodule reference?
Date: Thu, 15 May 2008 13:21:11 -0700
Message-ID: <7vabirgvyg.fsf@gitster.siamese.dyndns.org>
References: <7F242E8F-13CF-4BE5-B3E6-85F285391658@ohloh.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Luckey <robin@ohloh.net>
X-From: git-owner@vger.kernel.org Thu May 15 22:23:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jwjxy-0000I5-At
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 22:22:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754581AbYEOUV2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2008 16:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757945AbYEOUV2
	(ORCPT <rfc822;git-outgoing>); Thu, 15 May 2008 16:21:28 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:35851 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761673AbYEOUVZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2008 16:21:25 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7364937D9;
	Thu, 15 May 2008 16:21:22 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id C629137D3; Thu, 15 May 2008 16:21:19 -0400 (EDT)
In-Reply-To: <7F242E8F-13CF-4BE5-B3E6-85F285391658@ohloh.net> (Robin Luckey's
 message of "Thu, 15 May 2008 12:39:03 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7C3D9E9E-22BC-11DD-8058-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82229>

Robin Luckey <robin@ohloh.net> writes:

> I am parsing the output of git-diff-tree to create some code analysis
> reports.
>
> When a user adds a submodule to a repository, git-diff-tree reports
> the SHA1 of the commit from the submodule.
>
> However, if I subsequently try to pass this SHA1 to git-cat-file, or
> indeed any other git command I have tried, I receive an error:
>
> error: unable to find b0f8c354b142e27333abd0f175544b71a0cc444e
> fatal: Not a valid object name b0f8c354b142e27333abd0f175544b71a0cc444e
>
> This makes sense to me, since these objects are not stored locally;
> they are stored in the submodule repository.
>
> However, is there a simple and reliable way for me to know which SHA1
> hashes refer to such submodule objects? I'd like to simply ignore them.

I presume you are reading "diff-tree --raw" format output.  The mode bits
for submodules (aka gitlinks) are 160000, as opposed to either 100644 or
100755 for regular files and 120000 for symbolic links.
