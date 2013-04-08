From: Aaron Schrab <aaron@schrab.com>
Subject: Re: [PATCH 1/2] clone: Fix error message for reference repository
Date: Mon, 8 Apr 2013 10:57:49 -0400
Message-ID: <20130408145749.GJ27178@pug.qqx.org>
References: <1365376629-16054-1-git-send-email-aaron@schrab.com>
 <20130407234810.GG19857@elie.Belkin>
 <20130408000658.GG27178@pug.qqx.org>
 <7vhajh15w0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 08 18:33:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPF09-0003oz-VC
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 18:33:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965399Ab3DHO5v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 10:57:51 -0400
Received: from pug.qqx.org ([50.116.43.67]:34613 "EHLO pug.qqx.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936213Ab3DHO5u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 10:57:50 -0400
Received: by pug.qqx.org (Postfix, from userid 1000)
	id 6937B1D3EA; Mon,  8 Apr 2013 10:57:49 -0400 (EDT)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vhajh15w0.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21+145 (gd0ebb66) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220429>

At 06:58 -0700 08 Apr 2013, Junio C Hamano <gitster@pobox.com> wrote:
>I do agree that it would be nice to dereference .git gitfile when we
>deal with --reference argument, but you do not want to use in-tree
>repository of a submodule working tree.  What happens when you have
>to check out a version of the containing superproject that did not
>have the submodule you are borrowing from?  The directory will
>disappear, leaving the borrowing repository still pointing at it
>with its .git/objects/info/alternates file, no?

No, submodule directories don't get removed when you checkout a version 
which didn't contain that submodule.  I believe that there are plans to 
change that for submodules which store the repository data under the 
containing project's .git directory; but removing the submodule working 
tree would not affect a repository using that submodule as a reference, 
since the reading of the .git file is only done during the initial 
clone.  I don't think that the risk of such a repository being deleted 
or moved is substantially higher than for any other repository.
