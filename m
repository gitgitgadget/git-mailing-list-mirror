From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] post-update.sample referenced obsolete binary "git-update-server-info"
Date: Tue, 21 Jul 2009 10:01:02 +0200
Message-ID: <4A6575BE.6040308@drmicha.warpmail.net>
References: <874otb724d.fsf@write-only.cryp.to> <4A60A2DC.90506@drmicha.warpmail.net> <87r5wb5s4o.fsf@write-only.cryp.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Peter Simons <simons@cryp.to>
X-From: git-owner@vger.kernel.org Tue Jul 21 10:01:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTAHv-0005GA-Du
	for gcvg-git-2@gmane.org; Tue, 21 Jul 2009 10:01:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751507AbZGUIBV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2009 04:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751945AbZGUIBU
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 04:01:20 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:40565 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751537AbZGUIBT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Jul 2009 04:01:19 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 391503BBE61;
	Tue, 21 Jul 2009 04:01:19 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 21 Jul 2009 04:01:19 -0400
X-Sasl-enc: SyPJSGk7TtfcJnsRfvM9XXBHPlhvc2XES4E8iu5KYXmv 1248163278
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 9D57EAA6B;
	Tue, 21 Jul 2009 04:01:18 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.1pre) Gecko/20090718 Lightning/1.0pre Shredder/3.0b4pre
In-Reply-To: <87r5wb5s4o.fsf@write-only.cryp.to>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123648>

Peter Simons venit, vidit, dixit 20.07.2009 16:46:
> Hi Michael,
> 
>  >> -exec git-update-server-info
>  >> +exec git update-server-info
>  >>
>  >
>  > t/t5540-http-push.sh should fail if this really needed a fix (libexec
>  > is in $PATH for hooks).
> 
> you are right, the call to git-update-server-info does succeed, so there
> is no need to make that change.
> 
> Personally, I find it unfortunate, though, that those scripts rely on
> commands that won't exist when a normal user runs them.
> 
> Just my 2 cents,
> Peter
> 

Anyone can run them, just not from the default $PATH.

In fact, calling the dashed versions from the hooks is both safer and
(marginally) more efficient: Many people have several versions of git
lying around, and we've had more than one "bug" report where people
messed up because of mixing git bits from several versions. Calling the
dashed form above relies on the environment as set up by the caller, not
the user (who may have several "git" in $PATH, but not
"git-update-server-info"). Also, the command is called directly rather
than indirectly with "git" having to look for it.

Michael
