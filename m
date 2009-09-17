From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 04/15] Set _O_BINARY as default fmode for both MinGW and
 	MSVC
Date: Thu, 17 Sep 2009 15:30:36 +0200
Message-ID: <4AB239FC.9050302@viscovery.net>
References: <cover.1253088099.git.mstormo@gmail.com>	 <4AB10F01.9010703@viscovery.net>	 <e2480c70909161300o3db4b416k8f33ccce2f987c55@mail.gmail.com>	 <4AB1E118.70504@viscovery.net> <4AB1E4C5.80102@gmail.com>	 <4AB1E6E4.1040100@viscovery.net> <4AB1EB02.2090308@gmail.com>	 <4AB1EF0E.5010600@viscovery.net>	 <e2480c70909170139x9580bb4pcc1ad8e1b93aef17@mail.gmail.com>	 <4AB1FB79.5070903@viscovery.net> <e2480c70909170602l6afc9842v7be2b91fde9ad498@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Marius Storm-Olsen <mstormo@gmail.com>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de, msysgit@googlegroups.com,
	gitster@pobox.com, j6t@kdbg.org, lznuaa@gmail.com,
	raa.lkml@gmail.com,
	Marius Storm-Olsen <marius.storm-olsen@nokia.com>
To: Alexey Borzenkov <snaury@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 17 15:31:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoH4V-0003VL-6U
	for gcvg-git-2@lo.gmane.org; Thu, 17 Sep 2009 15:30:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753555AbZIQNaj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2009 09:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753361AbZIQNaj
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Sep 2009 09:30:39 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:32670 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753354AbZIQNai (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2009 09:30:38 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MoH4H-0002Zf-9j; Thu, 17 Sep 2009 15:30:39 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id D308ABC81; Thu, 17 Sep 2009 15:30:36 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <e2480c70909170602l6afc9842v7be2b91fde9ad498@mail.gmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128756>

[for the archives: this is about intermittent failures of t3903-stash.sh
with MinGW git]

Alexey Borzenkov schrieb:
> "after finding i_tree and i_commit" is immediately before calculating
> w_tree. As you can see, "before git read-tree" is off by a second. I
> think it's just a bug in msys, cp -p doesn't preserve mtime exactly.
> :-/

Ah, now I recall everything: git-stash.sh does "cp -p", and from the times
where git-commit was still a shell script I know that this does not always
preserve the timestamp correctly. Since this is a bug attributable to MSYS
(and not MinGW git), I was satisfied by simply inserting 'sleep 1' in the
test case to avoid the racily-clean situation. (Although today, I would
modify the content to have a different size.)

-- Hannes
