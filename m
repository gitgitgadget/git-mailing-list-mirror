From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] Fix cg-commit -p to not touch the working tree
Date: Tue, 13 Feb 2007 09:22:12 +1300
Message-ID: <45D0CC74.9020606@vilain.net>
References: <20070212031923.D20B913A382@magnus.utsl.gen.nz> <7v8xf4atoe.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Feb 12 21:22:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGhhQ-00061k-Al
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 21:22:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965364AbXBLUWY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 15:22:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965365AbXBLUWY
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 15:22:24 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:60227 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965364AbXBLUWX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 15:22:23 -0500
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id 0165713A384; Tue, 13 Feb 2007 09:22:21 +1300 (NZDT)
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id 4C20C13A302;
	Tue, 13 Feb 2007 09:22:15 +1300 (NZDT)
User-Agent: Thunderbird 1.5.0.2 (X11/20060521)
In-Reply-To: <7v8xf4atoe.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.0.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=none autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39434>

Junio C Hamano wrote:
>> Previously, the working tree state was modified with `patch', which
>> was a fragile operation.  Do everything with `git-apply --cached
>> --index' instead.
>>     
> I do not use Cogito so I do not know what behaviour is wanted
> here, but '--cached --index' is same as saying just '--cached'
> as far as I know.  It will patch against the index and should
> not touch working tree.  If the original used 'patch' to apply,
> I suspect it wanted to touch the working tree (and possibly, it
> wanted to leave the index alone?), so --cached might be
> completely wrong thing to use here?
>   

The context is that "cg-commit -p", a kind of poor man's interactive
commit that lets you preview changes that are to be committed in 'diff'
form, and edit the patch to be applied. Many users expect this command
to behave this way; they're quite surprised and sometimes even miffed
when the changes they deleted from the patch are gone from their working
copy.

Sam.
