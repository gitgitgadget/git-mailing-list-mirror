From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2] git-stash.txt: Add example "Using stash selectively"
Date: Thu, 06 May 2010 11:04:36 +0200
Message-ID: <4BE28624.70302@viscovery.net>
References: <1273045035-7292-1-git-send-email-jari.aalto@cante.net>	<7v39y6jfmv.fsf@alter.siamese.dyndns.org> <87pr194e3v.fsf_-_@jondo.cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Thu May 06 11:04:49 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9x0g-0002Eu-PC
	for gcvg-git-2@lo.gmane.org; Thu, 06 May 2010 11:04:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756528Ab0EFJEl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 May 2010 05:04:41 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:21682 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756512Ab0EFJEk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 May 2010 05:04:40 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1O9x0W-00072d-R9; Thu, 06 May 2010 11:04:37 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 87E311660F;
	Thu,  6 May 2010 11:04:36 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <87pr194e3v.fsf_-_@jondo.cante.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146465>

Am 5/6/2010 10:40, schrieb Jari Aalto:
> +$ git reset                     # make the index clean
> +$ git add -p A C                # add necessary bits to the index
> +$ git stash save --keep-index   # the remainder goes to the stash

Isn't "the remainder goes to the stash" wrong? I thought that both
worktree changes and index go to stash; only that changes recorded in the
index are not undone in the index and worktree.

> +... test, debug, perfect ...
> +$ git commit
> +$ git stash pop                 # get the remainder back

And here both changes are unstashed, but since the changes that previously
were only in the index are already commited, it looks as if no index
changes were unstashed.

The distinction is important because if you 'stash --keep-index', but then
change your mind and 'reset --hard', you actually do *not* lose data
because the index changes are still in the stash.

Or spelled in a different way: you cannot undo the index changes and keep
only the worktree changes by 'stash --keep-index', 'reset --hard', 'stash
pop'.

-- Hannes
