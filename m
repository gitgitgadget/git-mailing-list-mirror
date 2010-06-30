From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [RFC PATCH] rerere: fix overeager gc
Date: Wed, 30 Jun 2010 17:40:36 +0200
Message-ID: <4C2B6574.1060902@viscovery.net>
References: <1277811498-17288-1-git-send-email-szeder@ira.uka.de> <7vy6dx90uk.fsf@alter.siamese.dyndns.org> <4C2AE04E.9090901@viscovery.net> <7v7hlg8s0e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 30 17:40:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTzP6-0001Z6-MI
	for gcvg-git-2@lo.gmane.org; Wed, 30 Jun 2010 17:40:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752232Ab0F3Pkm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jun 2010 11:40:42 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:24958 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751311Ab0F3Pkl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jun 2010 11:40:41 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1OTzOv-0001yb-Bl; Wed, 30 Jun 2010 17:40:37 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id C0A081660F;
	Wed, 30 Jun 2010 17:40:36 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.10) Gecko/20100512 Thunderbird/3.0.5
In-Reply-To: <7v7hlg8s0e.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.0.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149977>

Am 6/30/2010 17:22, schrieb Junio C Hamano:
> Johannes Sixt <j.sixt@viscovery.net> writes:
>> Am 6/29/2010 19:59, schrieb Junio C Hamano:
>>> One possibility is to look at the timestamp of the directory itself
>>> instead.  Then we can safely gc otherwise-unused "thisimage" file when
>>> rerere is not in use.  I wonder if directory m_time timestamps are usable
>>> for this purpose on non-POSIX platforms?
>>
>> I don't think that will work at all: We only use fopen() to write
>> thisimage, which only truncates the file, but doesn't modify mtime of the
>> directory. Nor do we create any other (temporary) directory entries that
>> would modify the mtime.
> 
> Ah, I see; I don't mind a patch that fixes the creation of thisimage to
> follow the "create into temporary and then commit by renaming" pattern.
> 
> Would that solve this issue?

I think so. On Windows, the directory's mtime is updated.

-- Hannes
