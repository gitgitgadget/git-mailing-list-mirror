From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [PATCH] filter-branch: when dwim'ing a ref, only allow heads andtags
Date: Tue, 24 Jul 2007 13:04:28 +0200
Organization: eudaptics software gmbh
Message-ID: <46A5DCBC.E585A69D@eudaptics.com>
References: <Pine.LNX.4.64.0707231829210.14781@racer.site>
	 <46A5C615.24C24F0F@eudaptics.com> <Pine.LNX.4.64.0707241134330.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 24 13:04:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDIBu-0006Qd-GG
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 13:04:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932853AbXGXLE0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 07:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932865AbXGXLEZ
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 07:04:25 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:57040 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932667AbXGXLEY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 07:04:24 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtp (Exim 4.66)
	(envelope-from <J.Sixt@eudaptics.com>)
	id 1IDIBg-0004nc-0K; Tue, 24 Jul 2007 13:04:20 +0200
Received: from eudaptics.com (tethys.linz.eudaptics [192.168.1.88])
	by linz.eudaptics.com (Postfix) with ESMTP
	id CF52555DD; Tue, 24 Jul 2007 13:04:19 +0200 (CEST)
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
X-Spam-Score: 2.3 (++)
X-Spam-Report: AWL=-1.363, BAYES_99=3.5, FORGED_RCVD_HELO=0.135
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53563>

Johannes Schindelin wrote:
> -                       grep /"$ref")"
> +                       grep "refs/\(tags\|heads\)/$ref$")"

Thanks, but I don't think that this is a portable grep pattern:

$ echo "abc" | grep '\(a\|x\)'
$ echo "abc" | egrep '(a|x)'
abc

But then, this is on some AIX 4.3. How about:

   fgrep -e "refs/heads/$ref" -e "refs/tags/$ref"
or
   grep -e "^refs/heads/$ref" -e "^refs/tags/$ref"

-- Hannes
