From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Possible bug with git status in 1.7.0
Date: Wed, 17 Feb 2010 21:52:33 +0100
Message-ID: <4B7C5711.8060708@web.de>
References: <loom.20100217T184109-183@post.gmane.org> <7vvddvoegv.fsf@alter.siamese.dyndns.org> <4B7C490B.8030902@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sergio Callegari <sergio.callegari@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 17 21:52:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nhqt1-0007Ag-KV
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 21:52:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756116Ab0BQUwh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2010 15:52:37 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:53328 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755779Ab0BQUwg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2010 15:52:36 -0500
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id 219DD147B2856;
	Wed, 17 Feb 2010 21:52:35 +0100 (CET)
Received: from [80.128.113.116] (helo=[192.168.178.26])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #314)
	id 1Nhqss-0006Ph-00; Wed, 17 Feb 2010 21:52:34 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.7) Gecko/20100111 Thunderbird/3.0.1
In-Reply-To: <4B7C490B.8030902@gmail.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/49EFRSE5/GVKNkst/MRsB8EsLe+JQHbvTAqqn
	3g48iXZETbRa34heo8snYG0hvH4zNIWcEbXN3PArAyuy12mppZ
	np3vpqMAMOfpvWfTC/Gg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140261>

Am 17.02.2010 20:52, schrieb Sergio Callegari:
> Junio C Hamano wrote:
>> You are getting reminded that you either forgot to "git add" that file in
>> the submodule, or you forgot to add that file to .gitignore in the
>> submodule.
>>   
> 
> Thanks for the explanation!
> 
> The wording of the reminder is a bit unclear, though.  Suppose that the
> problem is with submodule "mod".
> 
> What you get from git status is a notice that something is modified but
> not updated, with the following suggestion
> 
> # Changed but not
> updated:                                                                                     
> 
> #   (use "git add <file>..." to update what will be committed)
> 
> and then the notice about what is in fact modified
> 
> #       modified:   mod
> 
> 
> So the first problem is that now git status provides a hint that may be
> confusing.  One gets the idea that he needs to add mod (to store a new
> commit id in the index) and not to add a file in mod.

That is a very valid point. I am currently working on git status being
more explicit about the type of modification. I just asked for comments
on this issue on February 14th in the thread titled "[PATCH/RFC] git
diff --submodule: Show detailed dirty status of submodules" (Gmane is
down for me right now, so i am sorry: no link today).

The changes i have in mind for git status would also include giving a
better hint, as you rightfully pointed out.


> As a second issue, note that mod is in fact not really modified being that
> 
> 1) no tracked file in it has been modified.
> 2) no new commit has been made
> 
> and the fact is that from git status I cannot recognize anymore if the
> module is really changed (the module commit id has changed) or has
> uncommited changes (some tracked file is changed) or is merely polluted
> by untracked files, so now I always need to explore the submodule.
> 
> It is true that this can be solved putting more stuff in .gitignore.
> However, it might be a matter of taste, but I do not like putting all
> byproducts in .gitignore  because not doing so allows me to
> differentiate between
> 
> - files that are just garbage
> - files that are not tracked but may be still precious
> 
> and selectively clean either category using the -x or -X options of git
> clean.
> 
> 
> So, it would be nice to improve the feedback of git status for this
> particular case and possibly have an option to avoid status being so
> wordy about untracked files.

So i assume that my proposal to explicitly state that a submodule has
new commits, modified files and/or untracked files would solve your
woes?
