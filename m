From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: tracking submodules out of main directory.
Date: Tue, 28 Jun 2011 19:00:30 +0200
Message-ID: <4E0A08AE.8090407@web.de>
References: <1309180056.2497.220.camel@Naugrim.eriador.com>	<7vvcvrxlol.fsf@alter.siamese.dyndns.org>	<4E08C89E.5020109@web.de>	<7vvcvrw0vn.fsf@alter.siamese.dyndns.org> <BANLkTimsfR4LqDAci0Vr+m9uUE_W-7OSAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	henri GEIST <henri.geist@flying-robots.com>,
	git@vger.kernel.org
To: Alexei Sholik <alcosholik@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 28 19:31:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qbc8U-00065t-0F
	for gcvg-git-2@lo.gmane.org; Tue, 28 Jun 2011 19:31:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759330Ab1F1RBp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jun 2011 13:01:45 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:35993 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755659Ab1F1RAf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2011 13:00:35 -0400
Received: from smtp06.web.de  ( [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id 6C3B71922204A;
	Tue, 28 Jun 2011 19:00:33 +0200 (CEST)
Received: from [93.246.41.92] (helo=[192.168.178.43])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #2)
	id 1QbbeL-0003vb-00; Tue, 28 Jun 2011 19:00:33 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.18) Gecko/20110616 Lightning/1.0b2 Thunderbird/3.1.11
In-Reply-To: <BANLkTimsfR4LqDAci0Vr+m9uUE_W-7OSAw@mail.gmail.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/2VRPCJrmbxoGWzZTzMeJCn/nHucC+KctNsCQZ
	LD2mfDJsCZ5YvHTtYAWbcbz+rxORz+SkpTHASEFmZ0Si5XZCCt
	SNOK4JCZ8pwI5X3LmvZw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176408>

Am 28.06.2011 12:05, schrieb Alexei Sholik:
> On 27 June 2011 22:05, Junio C Hamano <gitster@pobox.com> wrote:
>> That is what I called "there is no direct way". Wouldn't it be nicer if
>> the .gitmodules file in the superproject said something like
>>
>>        [module "project one"]
>>                path = project1
>>                url = ...
>>                depends = lib1
>>        [module "lib1"]
>>                path = lib1
>>                url = ...
>>
>> and then "git submodule init project1" run by the end user implied running
>> also "git submodule init lib1"?
> 
> This is a very nice idea. In my workflow, I find it that I more often
> need to clone a repo _including_ its submodules, because the top-level
> project won't compile without them. If we had a way to specify
> dependencies on submodules, `git pull` could automatically init and
> update them.

While Junio's proposition was about initializing submodules that live
next to each other you seem to be interested in recursive initialization.
My plan is to add a flag to .gitmodules, say "autoinit", which will, when
set, lead to a initialized and checked out submodule on clone.

> If a user really wants to clone only the top-level repo without
> submodules, git could provide him with an option for `git pull` (like
> `git pull --shallow`) to do just that. I think this second scenario is
> less common, so it is more reasonable to have a '--shallow' option for
> it, instead of '--recursive' counterpart.

Apart from the name, where I think "--recurse-submodules=none" is more
consistent with the other options we have, this is the plan when clone
learns to check out submodules  too.
