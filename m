From: Logan Kennelly <logank@sent.com>
Subject: Re: permissions and packed-refs?
Date: Thu, 10 Apr 2008 11:19:56 -0700
Message-ID: <135BAC69-9549-4E61-BD6F-A99364C27CCC@sent.com>
References: <320075ff0804100530s2af22cc9r43208101e46a8154@mail.gmail.com> <10723DA2-555B-40DB-8428-BDF07CA2510E@manchester.ac.uk>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Nigel Magnay <nigel.magnay@gmail.com>, git <git@vger.kernel.org>
To: Robert Haines <rhaines@manchester.ac.uk>
X-From: git-owner@vger.kernel.org Thu Apr 10 20:21:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jk1OD-0002gD-8I
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 20:20:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757184AbYDJSUC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2008 14:20:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757247AbYDJSUC
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Apr 2008 14:20:02 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:57288 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757135AbYDJSUA (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Apr 2008 14:20:00 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 9FB43ED8A5;
	Thu, 10 Apr 2008 14:19:59 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 10 Apr 2008 14:19:59 -0400
X-Sasl-enc: sU61xFQE9o0chft45mLt7fW1lZIISBpKBYO1DkPv+y8r 1207851599
Received: from [172.16.9.188] (unknown [199.0.156.17])
	by mail.messagingengine.com (Postfix) with ESMTPSA id F0555CCC7;
	Thu, 10 Apr 2008 14:19:58 -0400 (EDT)
In-Reply-To: <10723DA2-555B-40DB-8428-BDF07CA2510E@manchester.ac.uk>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79240>

On Apr 10, 2008, at 9:21 AM, Robert Haines wrote:

> I've seen this after git gc too. Has the owner of the affected  
> files changed? If so you need to make sure that git gc is run by  
> the correct user. If you run it as root for example, everything it  
> touches will end up owned by root!

Not only that, but you must make sure that you have the appropriate  
umask set. I'm not sure if this affects the pack file, but the reflog  
is certainly rewritten in a way that prevents other users from pushing.

I've been meaning to submit a patch to make git better honor  
"core.sharedrepository" (it's probably as simple as adding a couple  
calls to adjust_shared_perm), but the workaround was so easy that I  
had forgotten about the issue.

-- 
                                                         Logan Kennelly
       ,,,
      (. .)
--ooO-(_)-Ooo--
