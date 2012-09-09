From: Stephen Bash <bash@genarts.com>
Subject: Re: [PATCH 0/2] Teaching -Xours/-Xtheirs to binary ll-merge driver
Date: Sun, 9 Sep 2012 10:30:18 -0400 (EDT)
Message-ID: <545618054.286621.1347201018375.JavaMail.root@genarts.com>
References: <1347165639-12149-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 09 16:30:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAiWv-000128-6B
	for gcvg-git-2@plane.gmane.org; Sun, 09 Sep 2012 16:30:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753689Ab2IIOaZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Sep 2012 10:30:25 -0400
Received: from hq.genarts.com ([173.9.65.1]:9063 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751870Ab2IIOaZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Sep 2012 10:30:25 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 37E61BE133C;
	Sun,  9 Sep 2012 10:30:24 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aAY-UWlcVCb7; Sun,  9 Sep 2012 10:30:18 -0400 (EDT)
Received: from mail.hq.genarts.com (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 68C45BE1182;
	Sun,  9 Sep 2012 10:30:18 -0400 (EDT)
In-Reply-To: <1347165639-12149-1-git-send-email-gitster@pobox.com>
X-Mailer: Zimbra 7.2.0_GA_2669 (ZimbraWebClient - GC21 (Mac)/7.2.0_GA_2669)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205081>

----- Original Message -----
> From: "Junio C Hamano" <gitster@pobox.com>
> Sent: Sunday, September 9, 2012 12:40:37 AM
> Subject: [PATCH 0/2] Teaching -Xours/-Xtheirs to binary ll-merge driver
> 
> The part that grants Stephen's wish is unchanged from the earlier
> "perhaps like this" patch, but this time with a bit of documentation
> and test.
> 
> A more important change between the two actually is [PATCH 2/2].
> When a "binary" synthetic attribute is given to a path, we used to
> (1) disable textual diff and (2) disable CR/LF conversion, but it is
> also sane to disable the textual merge for a path marked as
> "binary", and setting the "-merge" attribute to summon the "binary"
> ll-merge driver is the way to do so.
> 
> Junio C Hamano (2):
>   merge: teach -Xours/-Xtheirs to binary ll-merge driver
>   attr: "binary" attribute should choose built-in "binary" merge
>   driver
> 
>  Documentation/gitattributes.txt    |  2 +-
>  Documentation/merge-strategies.txt |  3 ++-
>  attr.c                             |  2 +-
>  ll-merge.c                         | 25 ++++++++++++++++++++-----
>  t/t6037-merge-ours-theirs.sh       | 14 +++++++++++++-
>  5 files changed, 37 insertions(+), 9 deletions(-)

Thanks for this Junio.  After figuring out how to make the corporate email server NOT munge the patches, I was able to apply these with no problem.  Then 

  $ git merge -Xtheirs maint

mostly does what I want, but conflicting files deleted on the incoming branch are still marked unmerged/"deleted by them" (binary or not).  I'm not sure what the best (most common?) resolution is for that.  In my case I would be happy for the -Xtheirs to also delete the files, but that might not always be the right answer (but then again -Xtheirs is a pretty heavy hammer to begin with).

Thanks,
Stephen
