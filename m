From: greened@obbligato.org
Subject: Re: [PATCH/RFC] [git-subtree.sh] Use raw subject and body modifier "%B" instead of "%s%n%n%b" for commit
Date: Mon, 20 Aug 2012 20:52:15 -0500
Message-ID: <87628df1v4.fsf@waller.obbligato.org>
References: <1344561358-2953-1-git-send-email-techlivezheng@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, apenwarr@gmail.com
To: Techlive Zheng <techlivezheng@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 04:24:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3e8i-0007h8-3q
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 04:24:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755188Ab2HUCXq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 22:23:46 -0400
Received: from li209-253.members.linode.com ([173.255.199.253]:38997 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755027Ab2HUCXd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 22:23:33 -0400
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.77)
	(envelope-from <greened@obbligato.org>)
	id 1T3djk-0000fn-Dz; Mon, 20 Aug 2012 20:58:32 -0500
In-Reply-To: <1344561358-2953-1-git-send-email-techlivezheng@gmail.com>
	(Techlive Zheng's message of "Fri, 10 Aug 2012 09:15:57 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  Techlive Zheng <techlivezheng@gmail.com> writes: > I don't
    know if it is the right place to post this patch, I have sended > an email
    to the original author apenwarr and have no response. According > to <https://github.com/apenwarr/git-subtree/blob/master/THIS-REPO-IS-OBSOLETE>,
    > this is the place, but <https://github.com/git/git/blob/master/contrib/README>
    says > different, which is really confusing. Anyway, here I am. [...] 
 Content analysis details:   (-0.9 points, 5.0 required)
  pts rule name              description
 - 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203921>

Techlive Zheng <techlivezheng@gmail.com> writes:

> I don't know if it is the right place to post this patch, I have sended
> an email to the original author apenwarr and have no response. According
> to <https://github.com/apenwarr/git-subtree/blob/master/THIS-REPO-IS-OBSOLETE>,
> this is the place, but <https://github.com/git/git/blob/master/contrib/README> says
> different, which is really confusing. Anyway, here I am.

This is the place.

> Recently, I imported a foreign git project as a sub directory into a
> main repo which I intend to maintain as primary.

Ok.

> Due to the project I imported has its own remote repo which hosted
> on the github, I expected after a 'git-subtree.sh split' the newly
> generated subtree branch would be exactly identical to the original
> branch. 

I would have thought so too.

> Unfortunately, it is not. I have fixed the committer date and make
> everything looks the same with the original branch, but they just did
> not end up with same commit sha1 hash. Then, I used `git cat-file -p`
> to view the raw output of the both commits and found that the commit
> generate by git-subtree has a extra 'new-line' character appended at
> the end of the subject which causes the problem.

Hmm.

> I checked the source and found "%s%n%n%b" were used to generate the
> commit message, this works the fine when a commit has a subject as
> well as a body, but most of my commits only have a subject under
> which condition a extra 'new-line' character is appended.

Ah.  Yes, we should fix this.

> Instead, a raw subject and body message modifier '%B' should be used.

Ok.

> Though I think this patch should be applied by default, but the mistake
> has been there for a long time, applying this patch may cause the patched
> git-subtree generate a different branch for those whose subtree branch
> has already been generated using the old git-subtree. Maybe this should
> be explained in the help or man page, and add a condition check or a
> compatible mode somehow.

The problem is in the split code?  I'm not sure this is a big issue.  I
can run some experiments.

                      -Dave
