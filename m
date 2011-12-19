From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: post-receive for web deployment
Date: Mon, 19 Dec 2011 07:55:20 +0100
Message-ID: <4EEEDFD8.1050604@viscovery.net>
References: <CALzTOmJUqzO8H5UxyFaodi98DBJtFvsbQsHsYh1U=Ggq3NRO5A@mail.gmail.com> <CALzTOm+sJHF_7WzjD7bCqAiAbQSV0A3hEX1KdWfFzV7-ePzX2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Stephen Major <smajor@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 19 07:55:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RcX8M-0000mn-69
	for gcvg-git-2@lo.gmane.org; Mon, 19 Dec 2011 07:55:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751585Ab1LSGzZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Dec 2011 01:55:25 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:64859 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082Ab1LSGzY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Dec 2011 01:55:24 -0500
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1RcX85-0000LM-Aq; Mon, 19 Dec 2011 07:55:21 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 132D61660F;
	Mon, 19 Dec 2011 07:55:20 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <CALzTOm+sJHF_7WzjD7bCqAiAbQSV0A3hEX1KdWfFzV7-ePzX2w@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187440>

Am 12/19/2011 3:42, schrieb Stephen Major:
> checking the remote server files 4 5 6 are still found in:
> /home/user/domains/domain.com/public_html/live
> 
> Why is this happening?

Before you check out the files, you must ensure that the index matches the
content in the GIT_WORK_TREE that you populate by git checkout.

You first push a tree that removes 4 5 6 while the index you happen to
have still has those files recorded, the files are removed. Your second
push does not have these files anymore, but the index does not record the
files anymore, either; therefore, git does not act on the files 4 5 6 that
happen to live in the other worktree.

Perhaps you should maintain separate index files and set GIT_INDEX_FILE
accordingly before git checkout.

-- Hannes
