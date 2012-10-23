From: Nahor <nahor.j+gmane@gmail.com>
Subject: Re: [PATCH] git-submodule add: Record branch name in .gitmodules
Date: Tue, 23 Oct 2012 14:45:56 -0700
Message-ID: <50871014.9060000@gmail.com>
References: <61a31f6bc61d4df322a097e32ba472390c583a81.1350923683.git.wking@tremily.us> <5086ED06.5020406@gmail.com> <20121023194436.GD28592@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 23 23:46:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQmIn-0000NL-VX
	for gcvg-git-2@plane.gmane.org; Tue, 23 Oct 2012 23:46:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754225Ab2JWVqJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2012 17:46:09 -0400
Received: from plane.gmane.org ([80.91.229.3]:34869 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754200Ab2JWVqI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2012 17:46:08 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TQmIg-0000E3-QK
	for git@vger.kernel.org; Tue, 23 Oct 2012 23:46:14 +0200
Received: from 173-167-111-189-sfba.hfc.comcastbusiness.net ([173.167.111.189])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 23 Oct 2012 23:46:14 +0200
Received: from nahor.j+gmane by 173-167-111-189-sfba.hfc.comcastbusiness.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 23 Oct 2012 23:46:14 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 173-167-111-189-sfba.hfc.comcastbusiness.net
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <20121023194436.GD28592@odin.tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208255>

On 2012-10-23 12:44, W. Trevor King wrote:
> On Tue, Oct 23, 2012 at 12:16:22PM -0700, Nahor wrote:
>> On 2012-10-22 09:34, W. Trevor King wrote:
>> For instance, the module may later be updated to a commit in branch B
>> instead of branch A. Unless you remember to also update .gitmodule, you
>> have then inconsistent information.
>
> But you're explicitly *using* the configured setting in
>
>    git config --file $toplevel/.gitmodules submodule.$name.branch
>
> That should be a reminder that the configuration is important, and
> you'll remember to change it.

 From my experience with my colleagues at work, that's not going to 
happen. People are very good at forgetting to do something ;)


> Plus, the text from git-pull should
> clearly display the branch you are pulling, which gives you a second
> change to notice if something is going wrong.

That's assuming that the user knows the branch that should be pulled and 
that he's paying attention to the output and not just quick-scanning for 
errors/warnings.
Again, from my experience, that's not going to be the case.

Plus, there isn't always a human being behind a git-pull, e.g. build bots.


>> I think a better place to store that kind of information is using
>> git-notes. That way, if the branch is renamed or deleted, you can easily
>> update the old notes to use the new name instead.
>
> Interesting.  What would you attach the note too?

To the commits in the super-repo where a module branch is selected, i.e.:
- where a module was added
- where the module changed branch
- where a super-branch was merged and there was a conflict on the 
module's branch name
