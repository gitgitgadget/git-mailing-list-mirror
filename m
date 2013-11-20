From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Bizarre git merge behaviour
Date: Wed, 20 Nov 2013 08:20:30 +0100
Message-ID: <528C62BE.7060803@viscovery.net>
References: <l6hbgg$oej$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Matthew Cengia <mattcen@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 20 08:20:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vj25Y-0008VG-KI
	for gcvg-git-2@plane.gmane.org; Wed, 20 Nov 2013 08:20:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751796Ab3KTHUg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Nov 2013 02:20:36 -0500
Received: from so.liwest.at ([212.33.55.18]:36397 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751608Ab3KTHUg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Nov 2013 02:20:36 -0500
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Vj25P-0008U4-IR; Wed, 20 Nov 2013 08:20:31 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 477A716613;
	Wed, 20 Nov 2013 08:20:31 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <l6hbgg$oej$1@ger.gmane.org>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238068>

Am 11/20/2013 4:49, schrieb Matthew Cengia:
> The other day I was merging a feature branch (shown below as
> origin/22869-new-kernel) into my staging release (shown below as 'wtf'),
> and it *reverted* a bucket-load of changes I'd made on other branches
> which had been merged into staging before. I can't for the life of me
> work out why this happened, and would appreciate any ideas. Output below
> shows symptoms:

Not really. It's impossible to tell what's wrong if you

- show only ..topic
- but not topic..
- and you keep secret which of the changes is unexpected.

Perhaps you did the following:

- On one branch, you made a change A and then another change B that reverts A.
- On the other branch, you also made the same changes as A, but there is
no equivalent of B.

In this case, it is expected that the changes made by B (i.e. the reversal
of change A) are *NOT* in the merge, i.e., the changes of A survive. It
looks as if the merge reverted change B.

If that is not the case, it could be helpful that you pick one of the
files that contains an unexpected change and post the output of

git log --left-right --oneline wtf...origin/22869-new-kernel \
    file/with/changes | cut -c1-70

-- Hannes
