From: Alexey Muranov <alexey.muranov@gmail.com>
Subject: Re: Feature request: fetch --prune by default
Date: Thu, 19 Jul 2012 18:21:21 +0200
Message-ID: <88300470-AB41-4317-8B97-81DC18FD5899@gmail.com>
References: <2C63E314-2EF5-4B8E-B96A-5306E317E045@gmail.com> <20120719115558.GC29774@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 19 18:21:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SrtTo-0005R6-P6
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jul 2012 18:21:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490Ab2GSQV1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jul 2012 12:21:27 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:59439 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751646Ab2GSQVZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jul 2012 12:21:25 -0400
Received: by weyx8 with SMTP id x8so1887903wey.19
        for <git@vger.kernel.org>; Thu, 19 Jul 2012 09:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        bh=oHpaa8QXW9JwOoX/C/n3HgpqH7ATiM6WAwyJh8nL2vY=;
        b=P62OzdImKRGeU6tNntSG9freSCgwlh4jmHmxzq0REcoQljPujKlZ7LDWBHurSI6FKG
         0nLIyeeFwOQLmJEfGalvcSldE3K1InCmRBhThrWtJuGd1z5MjzmtMtjTiVbbttqTyPTO
         ByIV6tI1NKkYnYOlxUlN/ERZyq7TL2n8oJgrRFdsSrqQlInlWmiS7PfKbbl70NrfGVvU
         cHbWYdISD7eE3szzZcI+zlMoG7yHk4ClumJjspNJEX6ERG5MX5wJ4Ugd6caMy6r0aJ84
         5XmdiqiyyrHnPryvKYM1/p10Ouim81u24tepYsF3T/EP/QcTd6t5Obf/nu3qYaJzaAc3
         R34A==
Received: by 10.216.138.229 with SMTP id a79mr1628957wej.197.1342714884277;
        Thu, 19 Jul 2012 09:21:24 -0700 (PDT)
Received: from [192.168.6.127] (bi1.roaming.dfn.de. [195.37.234.61])
        by mx.google.com with ESMTPS id h9sm39177675wiz.1.2012.07.19.09.21.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 19 Jul 2012 09:21:23 -0700 (PDT)
In-Reply-To: <20120719115558.GC29774@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201738>

On 19 Jul 2012, at 13:55, Jeff King wrote:

> On Thu, Jul 19, 2012 at 09:30:59AM +0200, Alexey Muranov wrote:
> 
>> i would like
>> 
>> `git fetch --prune <remote>`
>> 
>> to be the default behavior of
>> 
>> `git fetch <remote>`
>> 
>> In fact, i think this is the only reasonable behavior.
>> Keeping copies of deleted remote branches after `fetch` is more confusing than useful.
> 
> I agree it would be much less confusing. However, one downside is that
> we do not keep reflogs on deleted branches (and nor did the commits in
> remote branches necessarily make it into the HEAD reflog). That makes
> "git fetch" a potentially destructive operation (you irrevocably lose
> the notion of which remote branches pointed where before the fetch, and
> you open up new commits to immediate pruning by "gc --auto".

I do not still understand very well some aspects of Git, like the exact purpose of "remote tracking branches" (are they for pull or for push?), so i may be wrong.
However, i thought that a user was not expected to follow the moves of a remote branch of which the user is not an owner: if the user needs to follow the brach and not lose its commits, he/she should create a remote tracking branch.

> So I think it would be a lot more palatable if we kept reflogs on
> deleted branches. That, in turn, has a few open issues, such as how to
> manage namespace conflicts (e.g., the fact that a deleted "foo" branch
> can conflict with a new "foo/bar" branch).

I prefer to think of a remote branch and its local copy as the same thing, which are physically different only because of current real world/hardware/software limitations, which make it necessary to keep a local cache of remote data.  With this approach, reflogs should be deleted with the branch, and there will be no namespace conflicts.

Alexey.