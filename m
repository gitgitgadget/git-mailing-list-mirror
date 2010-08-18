From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 0/6] Extensions of core.ignorecase=true support
Date: Wed, 18 Aug 2010 20:31:09 +0200
Message-ID: <201008182031.10197.j6t@kdbg.org>
References: <cover.1281985411.git.j6t@kdbg.org> <201008172320.17939.j6t@kdbg.org> <AANLkTi=Fkj-_-wHZN4GY2b+2n0mk7MKV=au0Hm4B+i9d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Joshua Jensen <jjensen@workspacewhiz.com>
To: Robert Buck <buck.robert.j@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 18 20:31:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlnQ0-00026v-4u
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 20:31:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753271Ab0HRSbP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Aug 2010 14:31:15 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:33842 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752330Ab0HRSbN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Aug 2010 14:31:13 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id BF26FCDF8F;
	Wed, 18 Aug 2010 20:31:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 7298F19F5FD;
	Wed, 18 Aug 2010 20:31:10 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <AANLkTi=Fkj-_-wHZN4GY2b+2n0mk7MKV=au0Hm4B+i9d@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153871>

On Mittwoch, 18. August 2010, Robert Buck wrote:
> So apparently when core.ignorecase=true, this really means
> casepreserving=false, casesensitive=true.

No. When an entry enters the index from the worktree, an existing entry is 
reused and the index entry's case is preserved, where existence is determined 
in a case-insensitive manner[*]; if the entry is new, the case is preserved.

In the oppsite direction, case preservation depends entirely on the 
capabilities of the file system.

[*] The new part of this series is that this case-insensitive existence test 
happens on for the entire path, and not just the file name part.

> So what I am hearing is that unless one sets core.ignorecase, in mixed
> environments you are in for a world of hurt; you'd end up with Foo and
> foo from the Unix side of the house, and on Macs or Windows the last
> file materialized from the index or repository into the working
> directory would clobber the first one materialized,

core.ignorecase is not designed to help this case. It is a "Doctor, it hurts 
when I poke myself in the eye" problem. Don't have both foo and Foo in your 
repository if you go cross-platform. The git repository format is not 
designed to treat them as identical, and no configuration option alters this.

-- Hannes
