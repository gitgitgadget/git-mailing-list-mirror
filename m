From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH (take 2)] gitweb: Do not parse refs by hand, use git-peek-remote instead
Date: Fri, 15 Sep 2006 09:14:23 +0200
Organization: At home
Message-ID: <eedjrj$tja$1@sea.gmane.org>
References: <200609142327.23059.jnareb@gmail.com> <7v8xkm2gfs.fsf@assigned-by-dhcp.cox.net> <200609150343.28334.jnareb@gmail.com> <7v4pv91wqk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri Sep 15 09:14:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GO7uF-0000h6-80
	for gcvg-git@gmane.org; Fri, 15 Sep 2006 09:14:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961AbWIOHOc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Sep 2006 03:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750964AbWIOHOc
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Sep 2006 03:14:32 -0400
Received: from main.gmane.org ([80.91.229.2]:28133 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750960AbWIOHOb (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Sep 2006 03:14:31 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GO7u6-0000f1-2j
	for git@vger.kernel.org; Fri, 15 Sep 2006 09:14:26 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 15 Sep 2006 09:14:26 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 15 Sep 2006 09:14:26 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27063>

Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> This is in response to Linus work on packed refs. Additionally it
>> makes gitweb work with symrefs, too.
>>
>> Do not parse refs by hand, using File::Find and reading individual
>> heads to get hash of reference, but use git-peek-remote output
>> instead.
> 
> Looks nicer.  Will apply.
> 
> Now, once we start doing this, it may make sense to rethink how
> this function and git_get_references functions are used.
[...]
> I very much suspect that you can use git_get_refs_list to return
> a hash and a sorted list at the same time from the same input
> and make git_summary to do with just a single call to it, and
> get rid of git_get_references with a little bit of restructuring
> of the caller.

It can be done. Well, we could also collapse git_get_references and
git_get_refs_list into one subroutine, but it would be slightly slower
than git_get_references.

But, if we change git_get_refs_list to do also work of git_get_references,
we should also change git_get_references to not use info/refs file at all
(it can, and usually for unknown reasons is stale) but always use
git-peek-remote, for consistency.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
