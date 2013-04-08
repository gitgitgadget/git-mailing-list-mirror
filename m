From: Aaron Schrab <aaron@schrab.com>
Subject: Re: [PATCH 1/2] clone: Fix error message for reference repository
Date: Mon, 8 Apr 2013 12:17:46 -0400
Message-ID: <20130408161745.GK27178@pug.qqx.org>
References: <1365376629-16054-1-git-send-email-aaron@schrab.com>
 <20130407234810.GG19857@elie.Belkin>
 <20130408000658.GG27178@pug.qqx.org>
 <7vhajh15w0.fsf@alter.siamese.dyndns.org>
 <20130408145749.GJ27178@pug.qqx.org>
 <7vip3xyr8c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 08 18:35:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPF2K-0004NB-6q
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 18:35:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934821Ab3DHQRt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 12:17:49 -0400
Received: from pug.qqx.org ([50.116.43.67]:34841 "EHLO pug.qqx.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934579Ab3DHQRr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 12:17:47 -0400
Received: by pug.qqx.org (Postfix, from userid 1000)
	id 703F557DE5; Mon,  8 Apr 2013 12:17:46 -0400 (EDT)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vip3xyr8c.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21+145 (gd0ebb66) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220437>

At 08:30 -0700 08 Apr 2013, Junio C Hamano <gitster@pobox.com> wrote:
>You switch to a version of the superproject with a plain file at
>dirA/ or there is nothing at dirA.  The checkout will fail and you
>need to manually rectify the situation [*1*], but after that is
>done, you do not have any repository at /path/to/super/dirA/.git
>anymore.
>
>That was the reason why I recommended against the practice.

So you're essentially saying you don't want to support using a new-world 
submodule as a reference because using an old-world submodule as such is 
likely to be problematic?  Even though the type of submodule that is 
actually likely to cause problems would currently be accepted as a 
reference repository?  That seems somewhat perverse to me.

Also, nothing in this series is strictly about submodules; that just 
happens to be what I was working with when I noticed the issue.  It 
would apply to any repository created with --separate-git-dir, although 
submodules are likely to be the most common occurrence by far.

>So you are right that we do not remove in the new world order, but
>then --reference can be given to point at the real location ;-)

Yes, that's definitely a possibility.  But I think that the location of 
the work tree for a repository is much more likely to come to a user's 
mind than the location of a non-bare repository.  Especially when 
dealing with submodules where the repository location was decided for 
the user, and is somewhat of an implementation detail that the user 
shouldn't need to care about.
