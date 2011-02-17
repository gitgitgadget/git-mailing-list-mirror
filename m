From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 2/2 (v2)] t7406: "git submodule update {--merge|--rebase]"
 with new submodules
Date: Thu, 17 Feb 2011 22:39:59 +0100
Message-ID: <4D5D95AF.6080106@web.de>
References: <1297959526-8089-1-git-send-email-olsonse@umich.edu> <1297959526-8089-2-git-send-email-olsonse@umich.edu> <4D5D7A45.6020204@web.de> <7v4o82bekf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Spencer E. Olson" <olsonse@umich.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 17 22:40:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqBa4-0003QY-9p
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 22:40:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932501Ab1BQVkB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 16:40:01 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:43325 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754727Ab1BQVkB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 16:40:01 -0500
Received: from smtp03.web.de  ( [172.20.0.65])
	by fmmailgate02.web.de (Postfix) with ESMTP id CCB6A19867266;
	Thu, 17 Feb 2011 22:39:59 +0100 (CET)
Received: from [93.246.40.171] (helo=[192.168.178.43])
	by smtp03.web.de with asmtp (WEB.DE 4.110 #2)
	id 1PqBZv-0000oa-00; Thu, 17 Feb 2011 22:39:59 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <7v4o82bekf.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19ikXYWHGXWcNep7Npo1tiMN2xXAkV5dGDd3prJ
	iOTn1In9KjmUv1UqcFPV0D7U7XoF6s42WhHMIbgSeQnD+TxkEJ
	Oas8tqPF+hPg0tG9mCGA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167125>

Am 17.02.2011 21:18, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>> This should be fixed to be able to detect regressions in the future, so
>> I came up with replacing the "git submodule status submodule" calls with
>> "git status -s submodule", which did the trick for me.
> 
> Hmph, is that a bug in "git submodule status" or is the subcommand
> deliberately designed to ignore this class of differences?

The latter, it doesn't care about working tree modifications inside of
submodules as It uses the "--ignore-submodules=dirty" option when calling
"git diff-files" (I added that in 18076502). The reason for one test to
succeed and the other to fail is that the merge succeeds even though
the work tree is empty while rebase errors out. So "git submodule status"
is the wrong command to detect work tree differences, that's why we have
to use "git status" here.
