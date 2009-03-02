From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [RFC PATCH] Windows: Assume all file names to be UTF-8 encoded.
Date: Mon, 02 Mar 2009 13:34:19 +0100
Message-ID: <49ABD24B.5060005@viscovery.net>
References: <alpine.DEB.2.00.0903020941120.17877@perkele.intern.softwolves.pp.se> <49ABB529.1080500@viscovery.net> <alpine.DEB.2.00.0903021137110.17877@perkele.intern.softwolves.pp.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Mon Mar 02 13:35:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Le7Mz-0005Vb-0E
	for gcvg-git-2@gmane.org; Mon, 02 Mar 2009 13:35:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbZCBMeN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2009 07:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750958AbZCBMeN
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 07:34:13 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:22516 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750910AbZCBMeM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2009 07:34:12 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Le7LT-0008A3-Se; Mon, 02 Mar 2009 13:34:08 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 615314E4; Mon,  2 Mar 2009 13:34:07 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <alpine.DEB.2.00.0903021137110.17877@perkele.intern.softwolves.pp.se>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111933>

Peter Krefting schrieb:
> Johannes Sixt:
>> If git prints a file name under the assumption that it is UTF-8
>> encoded, then it will be displayed incorrectly because the system uses
>> a different encoding.
> 
> Here setting the local codepage to UTF-8 *might* work, although I
> haven't tested that. Or always use the wchar_t versions of printf and
> friends.

You cannot expect users to switch the locale. For example, I have to test
our software with Japanese settings: I *cannot* switch to UTF-8 just
because of git.

Can you set the local codepage per program? (I don't know.) It might help
here, but it doesn't help in all cases, particularly in certain pipelines:

  git ls-files -o
  git ls-files -o | git update-index --add --stdin
  find . -name \*.jpg | git update-index --add --stdin

- What encoding should 'ls-files' use for its output? Certainly not always
UTF-8: stdout should use the local code page so that the file names are
interpreted correctly by the terminal window (it expects the local code page).

- What encoding should 'update-index' expect from its input? Can you be
sure that other programs generate UTF-8 output?

How do you solve that?

-- Hannes
