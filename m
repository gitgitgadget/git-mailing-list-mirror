From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: tests for pre-auto-gc hook
Date: Fri, 04 Apr 2008 08:34:39 +0200
Message-ID: <47F5CBFF.1080807@viscovery.net>
References: <cover.1207049697.git.vmiklos@frugalware.org> <7vhceldv12.fsf@gitster.siamese.dyndns.org> <20080402011447.GO3264@genesis.frugalware.org> <7vwsngaoqg.fsf@gitster.siamese.dyndns.org> <20080402190240.GV3264@genesis.frugalware.org> <7vtzik848t.fsf@gitster.siamese.dyndns.org> <cover.1207164676.git.vmiklos@frugalware.org> <96017502f7bca67a14f9a09d19c8ea42bde78949.1207167342.git.vmiklos@frugalware.org> <7vfxu4808c.fsf@gitster.siamese.dyndns.org> <20080402204524.GZ3264@genesis.frugalware.org> <20080403212656.GJ11574@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Bj?rn Steinbrink <B.Steinbrink@gmx.de>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Fri Apr 04 08:35:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhfWT-0000zi-5j
	for gcvg-git-2@gmane.org; Fri, 04 Apr 2008 08:35:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754035AbYDDGev (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Apr 2008 02:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753272AbYDDGev
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Apr 2008 02:34:51 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:58473 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753171AbYDDGeu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Apr 2008 02:34:50 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JhfUc-0002gM-5A; Fri, 04 Apr 2008 08:33:44 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id F1B856C4; Fri,  4 Apr 2008 08:34:39 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20080403212656.GJ11574@genesis.frugalware.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78796>

Miklos Vajna schrieb:
> I wanted to create a test like t7503-pre-commit-hook.sh for pre-auto-gc
> but actually I'm not sure how to trigger git gc --auto to do something.
> 
> Here is what I managed to do so far:
> 
> ----
> git init
> git config gc.auto 1
> for i in `seq 1 500`; do echo $i >file; git add file; done
> git commit -m init
> ----

Avoid 'seq'; it is not available everywhere. To avoid spawning 500
processes, you could create a pack file from the files using fastimport,
then unpack that for each test case. But you must move the pack out of
.git/objects/pack before unpacking, otherwise it won't unpack anything.

-- Hannes
