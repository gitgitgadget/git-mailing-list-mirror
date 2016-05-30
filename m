From: Konstantin Khomoutov <kostix+git@007spb.ru>
Subject: Re: How to add custom metadata to Git commit object
Date: Mon, 30 May 2016 21:24:38 +0300
Message-ID: <20160530212438.32d863cf1448361d286bdcb4@domain007.com>
References: <959E96F7-0FF3-4336-B098-58836136DB08@jetbrains.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Kirill Likhodedov <kirill.likhodedov@jetbrains.com>
X-From: git-owner@vger.kernel.org Mon May 30 20:24:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7Rrr-0006Zq-Ea
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 20:24:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161851AbcE3SYo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2016 14:24:44 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:37010 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161330AbcE3SYn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2016 14:24:43 -0400
X-Greylist: delayed 26002 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 May 2016 14:24:42 EDT
Received: from tigra.domain007.com ([192.168.2.102])
	by mailhub.007spb.ru (8.14.4/8.14.4/Debian-4) with SMTP id u4UIOcdp032441;
	Mon, 30 May 2016 21:24:39 +0300
In-Reply-To: <959E96F7-0FF3-4336-B098-58836136DB08@jetbrains.com>
X-Mailer: Sylpheed 3.5.0beta1 (GTK+ 2.24.25; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295919>

On Mon, 30 May 2016 20:58:08 +0300
Kirill Likhodedov <kirill.likhodedov@jetbrains.com> wrote:

> Is it possible to add custom metadata to Git commit object? 
> Such metadata should be ignored by Git commands, but could be used by
> a 3-party tool which knows the format and knows where to look. 
> 
> I assume that this should be possible, given that Git objects are
> actually patches, and patches can contain additional details. But can
> this be done with the help of Git commands? 
[...]
> There are git-notes, which could be used for the purpose, but they
> are visible to the user via standard Git command, and could be used
> by the user for other purposes, so they are not very suitable for the
> task.

AFAIK, within your restrictions, it's not possible because there are
only two ways to add meta information for a Git commit:

* Store it externally and somehow correlate it with the commit.

  This is what git-notes does.

* Encode it directly into a commit object.

  Since you can't use your own headers in commit objects,
  you have to encode this information into the commit message in some
  form parsable by a machine.   This is what, say, git-svn does to
  make it possible to correlate the commits it creates with their source
  Subversion revisions.

In both cases the information can be viewed by the user.

What I can't really understand is what is so bad about the user being
able to peer at that data.
