From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH JGIT 1/2] Calculate CRC32 on Pack Index v2
Date: Wed, 25 Mar 2009 14:59:31 -0700
Message-ID: <20090325215931.GC23521@spearce.org>
References: <ff6a9c820903231953q29a5ccbk8e5b54c9afdb8abd@mail.gmail.com> <1237962115-22709-1-git-send-email-j16sdiz+freenet@gmail.com> <49CA3218.9090202@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Daniel Cheng (aka SDiZ)" <j16sdiz+freenet@gmail.com>,
	git@vger.kernel.org
To: Marek Zawirski <marek.zawirski@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 23:01:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lmb9k-0005Zv-Bw
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 23:01:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753555AbZCYV7d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 17:59:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752767AbZCYV7d
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 17:59:33 -0400
Received: from george.spearce.org ([209.20.77.23]:58589 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752573AbZCYV7c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 17:59:32 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 67A6138211; Wed, 25 Mar 2009 21:59:31 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <49CA3218.9090202@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114683>

Marek Zawirski <marek.zawirski@gmail.com> wrote:
> I just wonder if it is sensible to compute it always regardless of used  
> index version (outputVersion) - for index v1 we don't really need CRC32  
> to be computed. I don't have a good idea how can it be avoided in truly  
> elegant way, as we cannot rely on the outputVersion checking in this  
> code - currently it may became changed after writing pack, but before  
> writing index.  But maybe it's not so important issue, as AFAIR v2 is  
> already default version for index.

If the index version is specifically set to 1, we may be forced to
write a version 2 index if the pack file is huge, in which case we
need the CRC32 data on each object.  Since version 2 is the default,
we probably hav to compute it no matter what.

> Have you tested that code? It seems that CRC32 updates is  missing in  
> write() method... or did I slept too short this night?:)

Yea, its missing the updates in the write method.

I'm writing up an alternate series of patches.

-- 
Shawn.
