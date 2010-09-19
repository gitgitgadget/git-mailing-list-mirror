From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 0/2] fix problems with recursive submodule fetching
Date: Sun, 19 Sep 2010 18:40:32 +0200
Message-ID: <4C963D00.9050207@web.de>
References: <4C7A819B.3000403@web.de> <7vocckhcb6.fsf@alter.siamese.dyndns.org> <778BC76C-FDFA-4EF0-AA94-6631272DEC02@sb.org> <89574F83-293C-4E3E-A99D-EB6CE6D47646@sb.org> <4C9221B6.7070807@web.de> <AF9B7F7E-0956-4814-A3A8-BAD7619A043D@sb.org> <4C9351A7.7050609@web.de> <4C9359D4.2030109@viscovery.net> <4C935D77.3080008@web.de> <329A2E43-ADE3-467C-A2A6-24ACB9DF641E@sb.org> <4C953DE5.6020900@web.de> <DD3654D9-46B9-4980-9138-38FDC33A383C@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Sun Sep 19 18:40:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxMwU-0008Dj-7A
	for gcvg-git-2@lo.gmane.org; Sun, 19 Sep 2010 18:40:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754830Ab0ISQkh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Sep 2010 12:40:37 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:54248 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754814Ab0ISQkg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Sep 2010 12:40:36 -0400
Received: from smtp03.web.de  ( [172.20.0.65])
	by fmmailgate03.web.de (Postfix) with ESMTP id 762C2160CA416;
	Sun, 19 Sep 2010 18:40:35 +0200 (CEST)
Received: from [93.240.116.45] (helo=[192.168.178.29])
	by smtp03.web.de with asmtp (WEB.DE 4.110 #24)
	id 1OxMwN-0002mp-00; Sun, 19 Sep 2010 18:40:35 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
In-Reply-To: <DD3654D9-46B9-4980-9138-38FDC33A383C@sb.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+6kH0Mx1RSuN0jKKnmv6PDh0JgCmzmp3ckXHhK
	143FP+YG5hlfQEw6yEkT7XLJR3vTzs9PPHWmmPrhtIEKwc/a1u
	Hd5q1UFJazTRoUqU6KBg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156503>

Am 19.09.2010 05:54, schrieb Kevin Ballard:
> Here's the submodule layout:
> 
>  .--Root-.
> / / /|\ \ \  
> A B C D E F G
>     |
>     H
>    /|\
>   I J K
>    /|\
>   L M N
>    /|\
>   O P Q
> 
> I control the root, and I control most of the first-level of submodules. I would also not mind seeing updates to other submodules at that level, though that doesn't generally concern me. However, I don't control submodule H, and I have absolutely no desire whatsoever to see updates to I-Q unless needed by submodule H. In this layout, regularly running `git submodule update --init --recursive` works perfectly. Having `git fetch` fetch submodules I-Q on every invocation is a complete waste of my time.

Sounds like adding  the "fetch=no" option to the .gitmodules entry
for submodule H would help you. That would tell "git fetch" to not
recurse into H and deeper.

But as you seem to be fine with running "git submodule update --init
--recursive" when needed you might be even better off by setting the
upcoming global config option to control recursive fetching to false.

But IMHO it makes more sense to let checkout take care of submodules
too and get rid of the necessity to call "git submodule update" every
time a submodule needs to be updated ...
