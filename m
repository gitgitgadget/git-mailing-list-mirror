From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v3 0/2] git-gui: change to display the combined diff in
 the 	case of conflicts.
Date: Wed, 31 Mar 2010 09:20:00 +0200
Message-ID: <4BB2F7A0.6020702@viscovery.net>
References: <2cfc40321003300834w59532e58m13d42acce4f2c5ce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, spearce@spearce.org
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 31 09:20:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwsDk-0007co-Uz
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 09:20:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756701Ab0CaHUG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Mar 2010 03:20:06 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:55714 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754872Ab0CaHUE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Mar 2010 03:20:04 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NwsDZ-000188-QT; Wed, 31 Mar 2010 09:20:01 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 69EE81660F;
	Wed, 31 Mar 2010 09:20:00 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.8) Gecko/20100227 Thunderbird/3.0.3
In-Reply-To: <2cfc40321003300834w59532e58m13d42acce4f2c5ce@mail.gmail.com>
X-Enigmail-Version: 1.0.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143650>

Am 3/30/2010 17:34, schrieb Jon Seymour:
> This variant of the patch uses git diff -c instead of git diff HEAD,
> at Johannes Sixt's suggestion.
> 
> The diff displayed in case of a merge conflict now shows the
> differences between the merge result and each of the local and remote
> heads and thus now also allows the user to assess the consequences of
> "Use Remote Version" by showing how the merge result affects the state
> of the local branch.
> 
> I have avoided using gmail client to forward this version of  patch
> because of documented word-wrapping issues, so hopefully this will
> apply cleanly.
> 
> [PATCH v3 1/2] git-gui: Introduce is_unmerged global variable to
> encapsulate its derivation.
> [PATCH v3 2/2] git-gui: change to display the combined diff in the
> case of conflicts.

I looked at the result, but it does not convince me. In my case, I have a
large file that has many changes between the "maint" and "master"
branches. Whenever there are conflicts after merging "maint" to "master",
I see all these changes, and really they *are* uninteresting.

But I, too, think that to offer "Use local version" and "Use remote
version" is *very* dangerous in a modify/modify conflict, particularly to
new-comers. I have only ever found these commands useful in the case of
modify/delete conflicts (and they are actually very handy in this case).

Even when the user sees all changes and can make a decision whether "Use
local" or "remote version" is really wanted, it is not at all obvious
which of the changes shown belong the "local" and which to "remote".

Therefore, I suggest to keep the original --cc display, but do not offer
"Use local version" and "Use remote version" when there is a modify/modify
conflict. The user is already offered "Run mergetool", and it is the safe
option besides editing the file.

-- Hannes
