From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [WIP PATCH 4/4] Teach checkout-index to recursively checkout
 submodules
Date: Sat, 10 Apr 2010 01:22:42 +0200
Message-ID: <4BBFB6C2.1090506@web.de>
References: <4BBF9D6F.2000006@web.de> <4BBF9ED3.9010502@web.de> <7v8w8w1dwl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 10 01:22:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0NXF-0003Ug-9x
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 01:22:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754516Ab0DIXWo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Apr 2010 19:22:44 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:45394 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753887Ab0DIXWn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Apr 2010 19:22:43 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate02.web.de (Postfix) with ESMTP id B3F3115D5DCE6;
	Sat, 10 Apr 2010 01:22:42 +0200 (CEST)
Received: from [80.128.86.62] (helo=[192.168.178.26])
	by smtp05.web.de with asmtp (WEB.DE 4.110 #4)
	id 1O0NX8-0003dG-00; Sat, 10 Apr 2010 01:22:42 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <7v8w8w1dwl.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18wJ9b3NE76GROvdngz77yX7762YyTkxHsJ7iB6
	PO+tooiVfAPG/+OI+mXSS77aIUPBc9/Hlxy/Jv6OAxLrCJNVYV
	j0mPbNbwUBOHqXzZn9+Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144484>

Am 10.04.2010 00:04, schrieb Junio C Hamano:
> As a plumbing I would prefer to leave checkout-index as is; script writers
> can choose to recurse if they choose to.

O.k.; what about adding an option "--recurse-submodules" to activate that
behavior - without having to code it every time - when wanted?


> This is not limited to checkout-index, but what is the stance of this new
> feature on failures from sub-checkout when there are local modifications
> in the work tree?  Some parts of the work tree is checked out while the
> ones after the failure that sorts later in the alphabetical order will not
> be checked out, resulting in an inconsistent state (I am not saying that
> it is good or bad---I am trying to see what the users should expect from
> this new feature)?

I would like to see the same attitude that checkout has on local files:
Don't overwrite anything changed (unless forced to). And an inconsistent
state should never happen, the checks on the submodules should be done
before the first file or submodule is checked out (But i still have to
test and verify that behavior in yet to be added tests).
