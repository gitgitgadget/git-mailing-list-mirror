From: Marc Herbert <Marc.Herbert+news@gmail.com>
Subject: Re: git clone, hardlinks and multiple users?
Date: Mon, 23 Jan 2012 17:55:37 +0000
Message-ID: <jfk6up$3dj$1@dough.gmane.org>
References: <jfc8eh$ck5$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 23 18:56:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpO7d-0007sC-Gi
	for gcvg-git-2@lo.gmane.org; Mon, 23 Jan 2012 18:56:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753106Ab2AWRz5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jan 2012 12:55:57 -0500
Received: from lo.gmane.org ([80.91.229.12]:52003 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751990Ab2AWRz4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jan 2012 12:55:56 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RpO7U-0007l0-Ga
	for git@vger.kernel.org; Mon, 23 Jan 2012 18:55:52 +0100
Received: from irdmzpr02-ext.ir.intel.com ([192.198.151.37])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 23 Jan 2012 18:55:52 +0100
Received: from Marc.Herbert+news by irdmzpr02-ext.ir.intel.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 23 Jan 2012 18:55:52 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: irdmzpr02-ext.ir.intel.com
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <jfc8eh$ck5$1@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189002>

On 20/01/2012 17:31, Marc Herbert wrote:
> "git clone" is using hardlinks by default, even when cloning from a
> different user. In such a case the clone ends up with a number of files
> owned by someone else.
>
> Since only immutable objects are cloned this seems to work fine. However
> I would like to know if this "multiple users" case works by chance or by
> specification.

Sorry I meant: "since only immutable objects are HARDLINKED this seems 
to work fine".

A few other clarifications following Neal's long answer:

- Yes we are using Linux. But the question is about any filesystem 
supporting hardlinks and user permissions.

- My question is only about hardlinks in .git/objects/. Whatever happens 
in the checkout is irrelevant.

- I know how to clone with no hardlink and completely avoid the whole 
issue. Unfortunately people have this strange habit of using the 
simplest/default option, and it does hardlinks.

I guess my rephrased question is: while there is no obvious reason for 
git to attempt to touch files in .git/objects/, is there a promise that 
this will never, ever happen? Because it would fail in a multi-users config.

The "core.sharedRepository" option is good example. When set to a new 
value will it ever try to fix existing objects? That would fail.
