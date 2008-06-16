From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Guided merge with override
Date: Mon, 16 Jun 2008 12:16:12 +0200
Message-ID: <48563D6C.8060704@viscovery.net>
References: <93c3eada0806152116v2cef4035u272dc1a26005661a@mail.gmail.com> <20080616092554.GB29404@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Geoff Russell <geoffrey.russell@gmail.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Mon Jun 16 12:17:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8BmU-00070j-K2
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 12:17:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752245AbYFPKQ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 06:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbYFPKQ3
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 06:16:29 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:34978 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752854AbYFPKQU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 06:16:20 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1K8Bl1-000175-7U; Mon, 16 Jun 2008 12:16:17 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id C34A06D9; Mon, 16 Jun 2008 12:16:14 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20080616092554.GB29404@genesis.frugalware.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85172>

Miklos Vajna schrieb:
> On Mon, Jun 16, 2008 at 01:46:38PM +0930, Geoff Russell <geoffrey.russell@gmail.com> wrote:
>> I have a two repositories A and B.  B is a tiny subset of the files in
>> A and all have been
>> modified.   If I do a "git pull B" into A, I get conflicts. I always
>> want to resolve these
>> by accepting the version from B. Is there a magic "override" switch to
>> let me do this?
> 
> There was a thread about this:
> 
> http://thread.gmane.org/gmane.comp.version-control.git/84047
> 
> and then you can do a git pull -s theirs B.

I don't think that's what Geoff needs. The 'theirs' strategy replaces the
entire tree by 'their' - B's - tree. But IIUC, only the subset of files
that are contained in B should be replaced by B's version, the rest of the
files should remain unchanged. This is quite different from 'theirs' strategy.

The solution depends on whether *all* files in B should be taken, or only
those files in B where there's a merge conflict. I don't know an easy way
to do the former, but the latter I'd do like this:

	$ git diff --name-only | xargs git checkout B --

-- Hannes
