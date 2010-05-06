From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: how to squash a few commits in the past
Date: Thu, 06 May 2010 08:45:49 +0200
Message-ID: <4BE2659D.2070208@viscovery.net>
References: <loom.20100503T112508-677@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Gelonida <gelonida@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 06 08:46:00 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9uqO-0004Nx-HV
	for gcvg-git-2@lo.gmane.org; Thu, 06 May 2010 08:46:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753420Ab0EFGpw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 May 2010 02:45:52 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:7563 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752852Ab0EFGpw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 May 2010 02:45:52 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1O9uqE-0001rF-ES; Thu, 06 May 2010 08:45:50 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 260101660F;
	Thu,  6 May 2010 08:45:50 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <loom.20100503T112508-677@post.gmane.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146447>

Am 5/3/2010 11:33, schrieb Gelonida:
> One of the team members accidentally commited a very huge file together with
> some useful sources.
> a few commits later he noticed his error and removed the huge file.
> 
> The plan would be:
> - create a new git repository without the huge file
> - let everybody clone the new repository and continue working.

Use 'git filter-branch':

  git filter-branch \
    --index-filter 'git rm --ignore-unmatch --cached the/huge/file' \
    --prune-empty \
    -- --all

The --prune-empty removes the commit that removed the file from the
history if the removal of the/huge/file was the only thing it did.

If you have tags that must be rewritten, add "--tag-name-filter cat" to
the command before "--".

Try this in a backup copy or clone first!

-- Hannes
