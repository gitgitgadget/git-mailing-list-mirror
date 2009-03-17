From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] disable post-checkout test on Cygwin
Date: Tue, 17 Mar 2009 17:59:09 +0100
Message-ID: <49BFD6DD.1010800@viscovery.net>
References: <81b0412b0903170926p4f2d536el2b96a71c79c0159e@mail.gmail.com> <7vprggqeh2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	layer <layer@known.net>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 18:00:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ljcej-0004YI-Uu
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 18:00:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756105AbZCQQ7Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 12:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755767AbZCQQ7P
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 12:59:15 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:50212 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755744AbZCQQ7P (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 12:59:15 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LjcdB-0004Uv-QZ; Tue, 17 Mar 2009 17:59:10 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 8C22C6C4; Tue, 17 Mar 2009 17:59:09 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <7vprggqeh2.fsf@gitster.siamese.dyndns.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113507>

Junio C Hamano schrieb:
> Alex Riesen <raa.lkml@gmail.com> writes:
> 
>> It is broken because of the tricks we have to play with
>> lstat to get the bearable perfomance out of the call.
>> Sadly, it disables access to Cygwin's executable attribute,
>> which Windows filesystems do not have at all.
> 
> Hmm, perhaps when checking hooks to see if they are executable, Cygwin
> port should avoid using the "tricks"?  Compared to paths inside the
> worktree the number of hooks is a lot smaller, no?

Hmm. Nowadays, we run hooks through run_hook() in run_command.c. It uses
access(..., X_OK), not lstat(). We don't play games with access(), do we?

-- Hannes
