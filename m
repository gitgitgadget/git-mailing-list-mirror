From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 2/2] show color hints based on state of the git tree
Date: Mon, 15 Oct 2012 17:19:25 +0200
Message-ID: <507C297D.3040304@drmicha.warpmail.net>
References: <7v8vbo7hmd.fsf@alter.siamese.dyndns.org> <20121005211030.GA5414@simaj.xs4all.nl> <507BC7F1.3080506@drmicha.warpmail.net> <507BD0EE.5000107@nieuwland.nl> <507BD3C1.4040807@drmicha.warpmail.net> <507C0D81.7030005@nieuwland.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Simon Oosthoek <s.oosthoek@xs4all.nl>,
	Git Mailing List <git@vger.kernel.org>, gitster@pobox.com,
	spearce@spearce.org, artagnon@gmail.com, schwab@linux-m68k.org
To: Simon Oosthoek <soosthoek@nieuwland.nl>
X-From: git-owner@vger.kernel.org Mon Oct 15 17:19:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNmSB-0006K3-CM
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 17:19:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751832Ab2JOPT2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2012 11:19:28 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:43653 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751131Ab2JOPT2 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Oct 2012 11:19:28 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 747F920DC3;
	Mon, 15 Oct 2012 11:19:27 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 15 Oct 2012 11:19:27 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=4rOf96Fi5SDHa9mLHiGc81
	44DQw=; b=JeSVs7w6AbTCWs5vzxZIbsIOcoUVEnJs4Ge8FrRY5j2DaH9SCttqeY
	xzXGq5s5HKjSrQ9mAeA0yCEC8mcrT/vywiN9JNJT1b3BTllVeijmRGYhnxfgeUGu
	09nlK5nl+jzF5qytXCvxdCuGPKBFffzm3XKE1jqDsKp++Y7qcA3rk=
X-Sasl-enc: kZO8SmCNr/AWz8QKyRGm98OIuIDRWNH91zQUCaZydnPT 1350314367
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 304B14827E5;
	Mon, 15 Oct 2012 11:19:26 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121011 Thunderbird/16.0.1
In-Reply-To: <507C0D81.7030005@nieuwland.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207752>

Simon Oosthoek venit, vidit, dixit 15.10.2012 15:20:
> Hi Michael, sorry for the duplicate, forgot to reply-all...
> 
> On 10/15/2012 11:13 AM, Michael J Gruber wrote:
> 
>> ...only because you don't know the color coding scheme. It's green
>> because those changes are saved somewhere (in the index) and would even
>> survice a branch switch.
>>
> 
> But git doesn't exactly let you do this:
> I modified some things in git-prompt.sh trying to implement some of what 
> we discussed. Then staged the file and tried git checkout HEAD^^ (or any 
> branch)
> 
> error: Your local changes to the following files would be overwritten by 
> checkout:
>          contrib/completion/git-prompt.sh
> Please, commit your changes or stash them before you can switch branches.
> Aborting
> 
> So I don't think it's all that strange to mark the branch as not quite 
> safe to change. The idea (or at least my idea) behind these hints is 
> that it reminds me to do stuff that prevents these "Aborts". I think 
> that that is a useful feature for any user of git.
> 
> In this light, would you accept yellow in the branch color to indicate 
> uncommitted staged changes?

No, simply because it's not up to me to accept something ;)

I still think that following "git status -sb" would be the least
confusing solution, and that means

- green for a checked out branch, where you know that any committed
changes will not be "lost"
- red for a detached head, where any committed changes will only be
accessible from the reflog, and only until pruned.

I'm open to change "git status -sb", but I think having the branch
coloring and the status character coloring be independent has quite some
merit. (Your yellow branch just duplicates the information "there are
staged changes".)

Also note that in your example above, you cannot switch branches because
your staged changes overlap with the changes in the branch that you want
to switch to (changes relative to your current head). Otherwise, you
could have switched. The only way to find out whether there's such a
conflict is to actually try it, and that is too heavy for a prompt command.

Michael
