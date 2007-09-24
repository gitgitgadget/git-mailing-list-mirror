From: Adam Roben <aroben@apple.com>
Subject: Re: git-svn: Deleting directories
Date: Mon, 24 Sep 2007 09:37:10 -0700
Message-ID: <46F7E7B6.7000601@apple.com>
References: <46F7C3EA.2080806@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Russ Brown <pickscrape@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 24 18:38:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZqwa-0001Gh-4H
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 18:38:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761174AbXIXQhP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2007 12:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761874AbXIXQhN
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Sep 2007 12:37:13 -0400
Received: from mail-out4.apple.com ([17.254.13.23]:60626 "EHLO
	mail-out4.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762327AbXIXQhL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2007 12:37:11 -0400
Received: from relay13.apple.com (relay13.apple.com [17.128.113.29])
	by mail-out4.apple.com (Postfix) with ESMTP id 4EAC412B0A63;
	Mon, 24 Sep 2007 09:37:11 -0700 (PDT)
Received: from relay13.apple.com (unknown [127.0.0.1])
	by relay13.apple.com (Symantec Mail Security) with ESMTP id 32A5228088;
	Mon, 24 Sep 2007 09:37:11 -0700 (PDT)
X-AuditID: 1180711d-a4361bb000006cd8-c4-46f7e7b71ec9
Received: from [17.203.12.236] (aroben.apple.com [17.203.12.236])
	by relay13.apple.com (Apple SCV relay) with ESMTP id 0DBF528057;
	Mon, 24 Sep 2007 09:37:11 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <46F7C3EA.2080806@gmail.com>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59060>

Russ Brown wrote:
> I've just noticed that when deleting entire directory trees in git, when
> the dcommit happens only the files in that trees get deleted, which
> leaves a 'ghost town' of a directory tree with folders but no files,
> which will no doubt have somewhat confused my svn-using colleagues.
>
> This is obviously an interoperability problem, but I understand that git
> does not track folders and is so tricky to fix.
>
> The question though is how to handle it. Ideally, dcommit will detect
> that an entire directory has gone and send through a changeset which
> deletes just that one directory, instead of the current behaviour of
> explicitly deleting every file in the directory but leaving the
> directories themselves intact.
>   
There's a similar problem when renaming a directory. dcommit will 
essentially commit a series of moves of individual files rather than 
moving the whole directory. Again this is due to git not tracking 
directories. I should hope that whatever logic is used for detecting a 
directory removal may also be used for detecting a directory rename.

-Adam
