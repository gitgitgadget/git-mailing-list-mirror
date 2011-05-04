From: Stephen Bash <bash@genarts.com>
Subject: Re: How to fork a file (git cp ?)
Date: Wed, 4 May 2011 15:05:45 -0400 (EDT)
Message-ID: <14525153.18843.1304535945960.JavaMail.root@mail.hq.genarts.com>
References: <4DC19955.7040503@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Mikhail T." <mi+thun@aldan.algebra.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed May 04 21:13:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHhW1-0002OS-IR
	for gcvg-git-2@lo.gmane.org; Wed, 04 May 2011 21:13:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754562Ab1EDTNh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2011 15:13:37 -0400
Received: from hq.genarts.com ([173.9.65.1]:26547 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753941Ab1EDTNg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2011 15:13:36 -0400
X-Greylist: delayed 463 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 May 2011 15:13:36 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id B4DC3EA2352;
	Wed,  4 May 2011 15:05:52 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DkLumMYB-SsN; Wed,  4 May 2011 15:05:46 -0400 (EDT)
Received: from mail.hq.genarts.com (mail.hq.genarts.com [10.102.202.62])
	by mail.hq.genarts.com (Postfix) with ESMTP id 01C0AEA22D6;
	Wed,  4 May 2011 15:05:46 -0400 (EDT)
In-Reply-To: <4DC19955.7040503@kdbg.org>
X-Mailer: Zimbra 6.0.10_GA_2692 (ZimbraWebClient - SAF3 (Mac)/6.0.10_GA_2692)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172763>

----- Original Message -----
> From: "Johannes Sixt" <j6t@kdbg.org>
> Sent: Wednesday, May 4, 2011 2:22:13 PM
> Subject: Re: How to fork a file (git cp ?)
> 
> Am 04.05.2011 19:56, schrieb Mikhail T.:
> > I need to add a new thing to our project. The thing will be similar
> > to
> > what already exists. I'd like to "derive" the new files from the
> > existing ones -- without altering them and by preserving the
> > change-history.
> 
> You cannot. Git does not have such a thing as
> "copy-with-preserved-history".
> 
> You just cp the file and git add it. But you will not be able to
> follow a history of the file.

Log (and other commands) can search for copies while traversing history:

  -C[<n>]
  --find-copies[=<n>]
  Detect copies as well as renames. See also --find-copies-harder. If n is specified, it has the same meaning as for -M<n>.

  --find-copies-harder
  For performance reasons, by default, -C option finds copies only if the original file of the copy was modified in the same changeset. This flag makes the command inspect unmodified files as candidates for the source of copy. This is a very expensive operation for large projects, so use it with caution. Giving more than one -C option has the same effect.

But as I discovered a few weeks ago, the existing merge strategies don't understand copies (recursive can follow a rename, but if two files pass rename detection, I think the one with the higher similarity index wins).

Thanks,
Stephen
