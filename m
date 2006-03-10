From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: What's in git.git
Date: Sat, 11 Mar 2006 00:59:55 +1300
Message-ID: <46a038f90603100359o402d9e32j268e1b746d0bdfc8@mail.gmail.com>
References: <7v1wxg82r3.fsf@assigned-by-dhcp.cox.net>
	 <46a038f90603060105m29595745ke64d4a623506c0b0@mail.gmail.com>
	 <20060310104443.GA4491@c165.ib.student.liu.se>
	 <Pine.LNX.4.63.0603101215100.25810@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Fredrik Kuivinen" <freku045@student.liu.se>,
	"Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 10 13:00:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHgHy-0006Fv-TD
	for gcvg-git@gmane.org; Fri, 10 Mar 2006 13:00:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751818AbWCJMAF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Mar 2006 07:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932341AbWCJMAF
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Mar 2006 07:00:05 -0500
Received: from wproxy.gmail.com ([64.233.184.205]:38971 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750888AbWCJMAC convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Mar 2006 07:00:02 -0500
Received: by wproxy.gmail.com with SMTP id i22so632052wra
        for <git@vger.kernel.org>; Fri, 10 Mar 2006 04:00:01 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=W4OPJ2E9LZM22+eOQqfedj8rKICuNOG9gwjeqsIHORyBoqMycKtUqeA0ukfuSQ0PyWfqjBrxc3aXo3JnF0GzD96AGcddEoASf8D+CX6lxCfkZ/BVWF2bwEEyxpdiXFQwPUZFeKDVEhYq1ak6Flv7CjbafPyRBW9JlB+E6fKwE04=
Received: by 10.54.77.2 with SMTP id z2mr597252wra;
        Fri, 10 Mar 2006 03:59:55 -0800 (PST)
Received: by 10.54.71.5 with HTTP; Fri, 10 Mar 2006 03:59:55 -0800 (PST)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0603101215100.25810@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17472>

On 3/11/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> The history is linearized, and the commits are ordered accordingly, then
> to be passed to git-annotate/-blame.

Exactly.

If a process has already done the costly git-rev-list for other
purposes (say, grab logentries of the relevant commits), and wants to
also run annotate/blame, it should be able to reuse it cheaply, by
passing -S filename. Possibly an IDE (or gitk/qgit) would want to do
this.

Now, what I use it for in git-cvsserver is to "flatten" merges. CVS
clients don't really understand that we know about parallel history,
so every time we have a merge the view that the CVS client gets is of
a "merge commit" with a merge summary. And I sweep the merged commits
under the carpet.

(there's some arbitrary nondeterministic magic in how I pick what side
to track and what side to merge. let's not think about that too much.
but I just want git-blame to see a somewhat simplified git-rev-list).

does that help?

cheers,


m
