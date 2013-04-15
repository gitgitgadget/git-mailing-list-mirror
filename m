From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [RFC/PATCH] clone: introduce clone.submoduleGitDir to relocate
 $GITDIR
Date: Mon, 15 Apr 2013 16:32:26 -0400
Message-ID: <516C63DA.4080209@xiplink.com>
References: <1365881007-25731-1-git-send-email-artagnon@gmail.com> <7vy5ck4m6b.fsf@alter.siamese.dyndns.org> <CALkWK0mvtRhFc0_4883ATNaYpb+kDwpV9VxeAoqJy5HxNQ6vgg@mail.gmail.com> <516C21CF.5080705@xiplink.com> <7vvc7nu1hu.fsf@alter.siamese.dyndns.org> <516C4A52.1080908@xiplink.com> <7va9ozsk60.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 15 22:32:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URq4u-0003sT-Vl
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 22:32:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755495Ab3DOUc3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 16:32:29 -0400
Received: from smtp138.ord.emailsrvr.com ([173.203.6.138]:42323 "EHLO
	smtp138.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755367Ab3DOUc1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 16:32:27 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp18.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 62B8530094;
	Mon, 15 Apr 2013 16:32:26 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp18.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id E48E130103;
	Mon, 15 Apr 2013 16:32:25 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <7va9ozsk60.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221312>

On 13-04-15 02:50 PM, Junio C Hamano wrote:
> Marc Branchaud <marcnarc@xiplink.com> writes:
> 
>>> After that "clone" or "init" creates a repository, you still have to
>>> "add" if you want to make it a submodule to the toplevel.
>>
>> To me it makes more sense to move the .git directory when the user invokes
>> "git submodule add" instead of creating it in an unusual place when the
>> sub-repo is cloned.  After all, git can't *know* that it'll be a submodule
>> until it's submodule-added to the super-repo.
> 
> It does not relieve "git add" (or "git submodulea add") from the
> responsibility of moving .git directory.  It only reduces the need
> to do so.
> 
> When the user says "add" and the repository has .git directory in
> it, "add" (or "submodule add") is still responsible for relocating
> it.

So it looks like the proposed change to git-clone provides no benefit to the
submodule-adding machinery, which still needs to know when and how to
relocate .git directories.

Ram, assuming Junio's explanations match your intentions, if the whole
motivation for this change is "to make 'git add' DTRT wrt submodules, and
deprecate 'git submodule add'" then I don't think it's bringing you any
closer to that goal.

		M.
