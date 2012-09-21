From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] t/test-lib.sh: do not trust $SHELL
Date: Sat, 22 Sep 2012 02:37:38 +0530
Message-ID: <CALkWK0kRzN_yQZ1JqJogBs6Z1nLhofBijHzeWR5YfQYHOtpaBA@mail.gmail.com>
References: <505CCA55.6030609@gmail.com> <1348260766-25287-1-git-send-email-artagnon@gmail.com>
 <20120921205834.GC22977@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 21 23:08:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFASH-0000mF-83
	for gcvg-git-2@plane.gmane.org; Fri, 21 Sep 2012 23:08:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756958Ab2IUVIA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2012 17:08:00 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:38703 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752714Ab2IUVH7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2012 17:07:59 -0400
Received: by qaas11 with SMTP id s11so1614012qaa.19
        for <git@vger.kernel.org>; Fri, 21 Sep 2012 14:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=OVMXmBXJLiUfEF4lCTeq/1OvBiSzIzTRo2ivZMTj/hs=;
        b=ya5i9c2ZmZJiHDCv8GYsO84puknXc0/4eI1ZTQeL4UbOe3t03p52scMpiV7wR4l9SX
         AybW2mieBdVQW5q2pn3xkWo/F/6yb4c3QhSpsqSa9lIbF3Gne74lBw1adqnlSRnuwG/E
         wX5eOwmbNDpF/rrinvqY1IdNzHXTZWfGZ9L144/BvI6rzrZTG93BTEyTNrp/mmyXF6Cr
         o6rvI+/YmE1REKBFs0UN/buy78AlWOY2VLOV2DIam4worR8XW3o67CaaQstJNb5aVzP0
         R5xvmxE/gM2cZkkJJBg6iETmmfJPGAgnPfxpSHAI50qJNzLUeTZ3CXVFNMqJy5XGLlrS
         zFEQ==
Received: by 10.229.136.136 with SMTP id r8mr4180631qct.35.1348261678754; Fri,
 21 Sep 2012 14:07:58 -0700 (PDT)
Received: by 10.49.84.105 with HTTP; Fri, 21 Sep 2012 14:07:38 -0700 (PDT)
In-Reply-To: <20120921205834.GC22977@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206166>

Hi,

Jeff King wrote:
> On Sat, Sep 22, 2012 at 02:22:46AM +0530, Ramkumar Ramachandra wrote:
>
>> Replace $SHELL with an explicit `/bin/sh`, as some shells do not
>> support all the features used in the script.  For example, ZSH does
>> not respect IFS, which is used in line 478.
>
> I don't think that is the right thing to do. The point of SHELL is to
> point at a bourne-compatible shell. On some systems, the main reason to
> set it is that /bin/sh is _broken_, and we are trying to avoid it.

But you're only avoiding it in the --tee/ --va* codepath.  In the
normal codepath, you're stuck with /bin/sh anyway.

> A bigger question is: why are you setting SHELL=zsh in the first place?

I use ZSH as my primary shell, so SHELL is set to zsh when I run
tests.  How can we trust $SHELL to be a bourne-compatible shell?

Ram
