From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH 10/10] push: teach push to be quiet if local ref is strict subset of remote ref
Date: Fri, 2 Nov 2007 11:03:45 +0100
Message-ID: <417C801B-5DFF-4753-AB32-0FA1EB30C8E2@zib.de>
References: <1193593581312-git-send-email-prohaska@zib.de> <11935935822846-git-send-email-prohaska@zib.de> <11935935821136-git-send-email-prohaska@zib.de> <11935935823045-git-send-email-prohaska@zib.de> <11935935821800-git-send-email-prohaska@zib.de> <11935935823496-git-send-email-prohaska@zib.de> <11935935821192-git-send-email-prohaska@zib.de> <7vfxztm2dx.fsf@gitster.siamese.dyndns.org> <52171BF7-50E2-473E-A0BD-CB64D38FD502@zib.de> <7vejfcl8aj.fsf@gitster.siamese.dyndns.org> <F5F68690-68A3-4AFC-A79C-FF02910F0359@zib.de> <7v8x5jiseh.fsf@gitster.siamese.dyndns.org> <B3C76DB8-076D-4C43-AC28-99119A05325C@z ib.de> <7vve8nglrt.fsf@gitster.siamese.dyndns.org> <B16F7DA1-E3E5-47A4-AFD3-6680741F38F1@zib.de> <7vlk9jgeee.fsf@gitster.siamese.dyndns.org> <6B0CD829-A964-410B-8C23-74D26BD2C0FA@zib.de> <!
  47299855.9010204@op5.se> <3550D197-CA8C-4B06-9A95-3C7F18EBEFA7@zib.de> <7vfxzpbtxv.fsf@gitste! r.siamese.dyndns.org> <63FCD695-B952-4624-854C-0F1C662D94D1@zib.de> <7vk5p15bkv.fsf@gitster.s!
 iamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 11:05:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IntOg-00018v-9z
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 11:05:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752945AbXKBKEs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 06:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752947AbXKBKEs
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 06:04:48 -0400
Received: from mailer.zib.de ([130.73.108.11]:55721 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752941AbXKBKEr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 06:04:47 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lA2A2Ole014881;
	Fri, 2 Nov 2007 11:04:41 +0100 (CET)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lA2A2Nc2012192
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 2 Nov 2007 11:02:23 +0100 (MET)
In-Reply-To: <7vk5p15bkv.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63093>


On Nov 2, 2007, at 8:52 AM, Junio C Hamano wrote:

> ... it still holds that what the developer wants to do is not
> just "to push", but "to push after making sure what he is going
> to push is in a good enough shape to be pushed".  Your _workflow_
> is forcing to integrate right away before pushing; don't blame
> git for this.

I don't blame git for forcing the developers to merge. I blame
git for not supporting this workflow well enough.

I still believe that

- in a pull-oriented workflow (Linux kernel, git) there's less
   need to handle unexpected changes on the remote you want to
   push to. There's maybe also less need to push to heads named
   differently on the local and the remote (though I'm not sure
   if this really true).

- in a workflow that is base on shared branches (CVS-style),
   the remote heads certainly will advance unexpectedly, and
   git push should support developers to cope with this situation.
   In addition push should push back to the remote branch a local
   topic was originally branched off. This makes the need for
   pushing to a branch named differently on the remote side more
   likely than in a pull-oriented workflow, where you would
   publish under your local branch name and ask someone else
   to pull.

[...]

>
>> We haven't figured out much more of our workflow. The first
>> milestone is to migrate from CVS to git continuing to use a
>> CVS-style workflow.
>
> I think that is an interesting admission.  As somebody else on
> the thread already said, if you are sticking to CVS workflow,
> there are things that can and cannot be naturally done with
> git.  Don't break git when you hit the situation in the latter
> category without understanding how the world works.

Fair enough. I absolutely agree that it will never be a design
goal of git to directly support a CVS workflow ;)

But I strongly believe that there is a more universal question
behind. It makes sense to have good support for a workflow
that is based on a shared repository. A shared repository
can be a way
- to make it easy for the average developer to get started.
   Only clone to a local working repository is needed, but no
   publishing repository.
- to facilitate that commits will be pushed to at a central
   place. The default is to push back to the shared repository
   (btw, it's easy to setup hooks to do some access control to
   avoid havoc). This may increase visibility of changes. It may
   help doing backups. It may be easy to encourage early integration.

For small projects with developers available for direct
communication it may even be an option to have just this single
shared branch.

For larger project a better infrastructure and more control
over the changes is certainly a good idea. And git greatly
supports more complex workflows. That's the main reason why
I decided to choose git in the first place.

But for me the question is how can git be efficiently used to
support a workflow based on a shared repository. It should be
easy and safe to use and only few commands should be needed
to get started.


>> error: remote 'refs/heads/master' is ahead of local 'refs/heads/
>> master'. Use --verbose for more details.
>
> I'd rather have "Read section XXX of the user's guide".

Ok; do I need to write the section first or is there? ;)


And maybe we could do two things (at least for msysgit):

- Rename or link user-manual.html to git-user-manual.html,
   which would allow saying "git help user-manual".

- Support HTML anchors, such that
   "git help user-manual#section5" would open the user manual
   and jump to the right section.
	
	Steffen
