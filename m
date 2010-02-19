From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Bug Report ( including test script ): Non-Fastforward merges 
	misses directory deletion
Date: Fri, 19 Feb 2010 08:40:47 +0100
Message-ID: <81b0412b1002182340w71aa6364tfe2e17ad6fd1b1e8@mail.gmail.com>
References: <loom.20100218T104300-858@post.gmane.org>
	 <loom.20100218T113103-602@post.gmane.org>
	 <20100219055721.GC22645@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Sebastian Thiel <byronimo@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 19 08:40:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiNTs-0001eE-KD
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 08:40:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754697Ab0BSHkv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2010 02:40:51 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:33100 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754582Ab0BSHku (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2010 02:40:50 -0500
Received: by ewy19 with SMTP id 19so7719464ewy.21
        for <git@vger.kernel.org>; Thu, 18 Feb 2010 23:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=aFEDiRx+wa3ueGmy61BQaBMMjvCA3NlTP/QD5Fs/Umg=;
        b=Lj997seyli0WNKz9o7qZXhf47+DNWwrrgpxpsSuAIzkHWHJ5oL+IREbOi7vsPqiRK5
         /txe0kN+HmUb73Sc/ZM8cZlGpboZMH4fvzLGn8wIaz9VDYhJ+bRUOdmUTTBg1JHaDDBu
         86izpO8NLIpznE8stq3q9gHouwS8AyeNnDr2M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Rmier0sNRcbEDLMxIxopsf4dj2Md1JcaSr2lbZ8awooy05TRHpEvJbrFxtko0uOvbD
         EAb1PeQmZLgmjOamsRD1KutT5lXGBapteisH2OOxBXrSwT8ugAa89ow+qBzvuzCBR6xN
         NatDRBHdPsE38DRiY2rxBfJaxo7OyIoUK+2zo=
Received: by 10.204.133.91 with SMTP id e27mr2091474bkt.19.1266565247963; Thu, 
	18 Feb 2010 23:40:47 -0800 (PST)
In-Reply-To: <20100219055721.GC22645@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140427>

On Fri, Feb 19, 2010 at 06:57, Jeff King <peff@peff.net> wrote:
> On Thu, Feb 18, 2010 at 11:43:23AM +0000, Sebastian Thiel wrote:
> If we remove a path in a/deep/subdirectory, we should try to
> remove as many trailing components as possible (i.e.,
> subdirectory, then deep, then a). However, the test for the
> return value of rmdir was reversed, so we only ever deleted
> at most one level.

What was I thinking!

Sincerely-sorry: Alex Riesen <raa.lkml@gmail.com>

> This was introduced by Alex's 4a92d1b (Add remove_path: a function to
> remove as much as possible of a path, 2008-09-27), which ironically
> complained about bugs in the code it was replacing. :)

Well, it did fix the bugs it claimed to fix
