From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] rebase -i: fix misleading error message after 'exec no-such'
 instruction
Date: Tue, 18 Sep 2012 13:29:34 +0200
Message-ID: <50585B1E.6030900@viscovery.net>
References: <505857CE.3050909@viscovery.net> <vpq7grrlgqy.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Sep 18 13:30:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDw08-0006Id-Ov
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 13:30:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932666Ab2IRL3i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 07:29:38 -0400
Received: from lilzmailso03.liwest.at ([212.33.55.24]:50756 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932069Ab2IRL3h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 07:29:37 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.76)
	(envelope-from <j.sixt@viscovery.net>)
	id 1TDvzi-00045h-MN; Tue, 18 Sep 2012 13:29:34 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 672271660F;
	Tue, 18 Sep 2012 13:29:34 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:15.0) Gecko/20120907 Thunderbird/15.0.1
In-Reply-To: <vpq7grrlgqy.fsf@grenoble-inp.fr>
X-Enigmail-Version: 1.4.4
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205822>

Am 9/18/2012 13:20, schrieb Matthieu Moy:
> Johannes Sixt <j.sixt@viscovery.net> writes:
> 
>> From: Johannes Sixt <j6t@kdbg.org>
>>
>> When the todo sheet of interactive rebase instructs to run a non-existing
>> command, the operation stops with the following error:
>>
>>   Execution failed: no-such
>>   You can fix the problem, and then run
>>
>>           git rebase --continue
>>
>>   fatal: 'rebase' appears to be a git command, but we were not
>>   able to execute it. Maybe git-rebase is broken?
> 
> While you're there, maybe you want to turn the first line into
> 
> Execution failed: no-such (command not found)

No, I don't want to: Neither do we have errno here, nor can we be specific
enough because the whole shell script the user gave after 'exec' is
repeated here.

I would rather remove the line so that it does not distract from the more
specific error message that the shell gave. On top of that, the command is
already dumped before it is executed; we don't need to repeat it.

-- Hannes
