From: "Zakirov Salikh" <salikh@gmail.com>
Subject: Re: [PATCH] Fix "git add -u" data corruption.
Date: Thu, 16 Aug 2007 09:15:44 +0900
Message-ID: <eb5812d90708151715k5125d4aq3008d7be54fa66b6@mail.gmail.com>
References: <f9v1t6$uph$1@sea.gmane.org>
	 <7v643gplph.fsf@gitster.siamese.dyndns.org>
	 <7v1we4pknl.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 16 02:16:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILT20-0005ju-Ld
	for gcvg-git@gmane.org; Thu, 16 Aug 2007 02:16:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751980AbXHPAPr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 20:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753336AbXHPAPq
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 20:15:46 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:4369 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752981AbXHPAPp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 20:15:45 -0400
Received: by wa-out-1112.google.com with SMTP id v27so89229wah
        for <git@vger.kernel.org>; Wed, 15 Aug 2007 17:15:45 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZKw1HXrWw4KnkXq24/KvApzxYTlAYFLZOUY7H62AdOTZuH2phDbJsZ8ZMSilNojuv/bNE9e5wWtCo6Gzn8wASqSPZkUwp1eEr9CIENy61/7OYaHSuyVt+FzLNp4lHv4MwR0otbkOjRYG7gmLo6yPiZhWf9SA7j0VJTMAY5b/kS8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=K6q6rB+dUw2zLEljrc8HRLpbtk/JsLr/PRPASaqlfXZeCVuCfwdULRFoeJFGVEPYHpVviZ4DvUQ6xwyUss8kW/Bj3iiJJC/y4iv5Q8sARCMvLMVlmmIZGC4AWJjtjtWWobRGU52qP5lItYoNZ3KF9VFmNVlplga7nTcx3ntpFb0=
Received: by 10.114.254.1 with SMTP id b1mr1143840wai.1187223344908;
        Wed, 15 Aug 2007 17:15:44 -0700 (PDT)
Received: by 10.114.74.14 with HTTP; Wed, 15 Aug 2007 17:15:44 -0700 (PDT)
In-Reply-To: <7v1we4pknl.fsf_-_@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55972>

Junio wrote:
> This applies to 'maint' to fix a rather serious data corruption
> issue.  When "git add -u" affects a subdirectory in such a way
> that the only changes to its contents are path removals, the
> next tree object written out of that index was bogus, as the
> remove codepath forgot to invalidate the cache-tree entry.

Fixes the issue, thanks.

To make this more fair to git, especially to a notorious statement
"git never lost any data in its existence", this commit corruption,
while annoying, does not lose any data from working directory,
and was easy to fix and work around once I've figured out what's happened.
