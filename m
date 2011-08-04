From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: What's cooking in git.git (Aug 2011, #01; Wed, 3)
Date: Thu, 04 Aug 2011 09:19:49 +0200
Message-ID: <4E3A4815.5060309@viscovery.net>
References: <7vzkjq6mpn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 04 09:20:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QosDq-0000kq-8K
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 09:20:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751758Ab1HDHT6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Aug 2011 03:19:58 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:38731 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751395Ab1HDHT4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 03:19:56 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1QosDd-0003Bc-Qy; Thu, 04 Aug 2011 09:19:50 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 9069D1660F;
	Thu,  4 Aug 2011 09:19:49 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
In-Reply-To: <7vzkjq6mpn.fsf@alter.siamese.dyndns.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178704>

Am 8/4/2011 2:32, schrieb Junio C Hamano:
> * en/merge-recursive (2011-07-14) 50 commits
>  - fixup! Do not assume that qsort is stable
...
>  - merge-recursive: Fix sorting order and directory change assumptions
...
> The tip one should be squashed somewhere.

I suggest this one.

> I wanted to push this out in
> 'next' today, but this seems to regress a rather trivial renaming merge,
> so I had to rewind and rebuild 'next' before pushing it out.

Also, make_room_for_path() walks the entire list of files to remove on
each invocation and calls unlink() on each of them, which fails after the
name was re-created as a directory. IIUC, this is O(N*M) behavior where N
is the number of files to remove and M is the number of directories to
create, and causes unnecessary system calls. (Well, this can be fixed when
the series is in next because it is not as critical as the regression that
you found.)

-- Hannes
