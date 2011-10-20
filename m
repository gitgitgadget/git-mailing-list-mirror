From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: How to verify that lines were only moved, not edited?
Date: Thu, 20 Oct 2011 08:20:23 +0200
Message-ID: <4E9FBDA7.3000904@viscovery.net>
References: <4E9EDFEC.3040009@viscovery.net> <20111019163354.GB3157@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 20 08:24:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGm3T-0003gh-1T
	for gcvg-git-2@lo.gmane.org; Thu, 20 Oct 2011 08:24:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755941Ab1JTGUd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Oct 2011 02:20:33 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:8209 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755440Ab1JTGU1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Oct 2011 02:20:27 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1RGlzM-0003T1-Hc; Thu, 20 Oct 2011 08:20:24 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 411191660F;
	Thu, 20 Oct 2011 08:20:24 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.23) Gecko/20110920 Thunderbird/3.1.15
In-Reply-To: <20111019163354.GB3157@sigill.intra.peff.net>
X-Enigmail-Version: 1.1.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184007>

Am 10/19/2011 18:33, schrieb Jeff King:
>   git init
>   seq 1 5000 >foo
>   git add foo
>   git commit -m initial
>   sed -i '/^2..$/d' foo
>   seq 200 299 >>foo
>   git commit -a -m 'move 200-299 to end'
> 
> I get the expected result from "git blame -M" (i.e., everything
> attributed to the root commit).

I see. My example is more like this:

 for i in `seq 1 20`; do md5sum - <<< $i; done > foo
 git commit -a -m foo
 for i in `seq 1 20`; do md5sum - <<< $i; done | sort > foo
 git commit -a -m foo\ sorted

i.e., the sort order of a block of lines was changed "in place". Here,
most of the lines are attributed to the last commit. Am I expecting too
much from git-blame to detect line motions in such a case?

-- Hannes
