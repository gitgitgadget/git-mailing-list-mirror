From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 3/4] fast-export: don't handle uninteresting refs
Date: Tue, 30 Oct 2012 16:55:06 -0700
Message-ID: <20121030235506.GT15167@elie.Belkin>
References: <1351617089-13036-1-git-send-email-felipe.contreras@gmail.com>
 <1351617089-13036-4-git-send-email-felipe.contreras@gmail.com>
 <20121030185914.GI15167@elie.Belkin>
 <CAMP44s3LP65XOYFg-tBe_rzT1+gXp=714C-u14mkwxY26r4b=g@mail.gmail.com>
 <CAMP44s1tFhh3Xqe9tqoDAdtwnGc=kFT6OmAreeP1nbTstweaQQ@mail.gmail.com>
 <20121030214531.GN15167@elie.Belkin>
 <CAMP44s1b+E8a0kdSgREbGzRTFy+nCw4VcjHadd3soQAXRkNzZw@mail.gmail.com>
 <20121030220717.GO15167@elie.Belkin>
 <CAMP44s3ArAQXH+-EbH4MHYaV6fTAWdwGzBdZwzn_qtCABHyonQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 31 00:55:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTLed-0006K4-RN
	for gcvg-git-2@plane.gmane.org; Wed, 31 Oct 2012 00:55:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756407Ab2J3XzP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 19:55:15 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:43413 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756381Ab2J3XzL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 19:55:11 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so541373pbb.19
        for <git@vger.kernel.org>; Tue, 30 Oct 2012 16:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=i/5vZx2jOfa9xUi37RaNaoDYZEKGKKbJbEZNibrVvIM=;
        b=X3uhyZjSf/Tldqd8fvUElIHvQixbEcG59fH1Q7jjmLl65roMybvPkSjJBFL2OBrVzh
         plMAlK8MTwc6hcdvrp8QTdfds8dbvnrsxb6ldkuiG+i9ecOicqXJBAR4s+ZpdwMSV+16
         Ahjl7EPNb8xtME4Emya/ZFrQ5dbSN9M6eC+ahwKER7vGCAK+gWsQPYdaV/JJCzawKP0R
         GszdcHeUdjmHiQ9bIOV1HUsSXYnKcWUwNR7PsTCxWoC2Cin7HpKmsJaGc9WsFtSweGjK
         lO9RpvClf/iAPnLmY+bGaEdBqtbUX6SpzNHoAC6yn+Y8v37mOtwHAXx2yEVKYbQZlUR7
         8RtA==
Received: by 10.68.221.225 with SMTP id qh1mr107623675pbc.50.1351641311336;
        Tue, 30 Oct 2012 16:55:11 -0700 (PDT)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id e9sm1136112paz.28.2012.10.30.16.55.09
        (version=SSLv3 cipher=OTHER);
        Tue, 30 Oct 2012 16:55:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMP44s3ArAQXH+-EbH4MHYaV6fTAWdwGzBdZwzn_qtCABHyonQ@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208771>

Felipe Contreras wrote:
> On Tue, Oct 30, 2012 at 11:07 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:

>> Nope.  I just don't want regressions, and found a patch description
>> that did nothing to explain to the reader how it avoids regressions
>> more than a little disturbing.
>
> I see, so you don't have any specific case where this could cause
> regressions, you are just saying it _might_ (like all patches).

Yes, exactly.  The commit log needs a description of the current
behavior, the intent behind the current code, the change the patch
makes, and the motivation behind that change, like all patches.
Despite the nice examples, it doesn't currently have that.

The patch description just raises more questions for the reader.  From
the description, one might imagine that this patch causes

	git fast-export <mark args> master

not to emit anything when another branch that has already been
exported is ahead of "master".  If I understand correctly (though
I haven't tested), this patch does cause

	git fast-export ^next master

not to emit anything when next is ahead of "master".  That doesn't
seem like progress.

I haven't reviewed the later patches in the series; maybe they fix
these things.  But in the long term it is much easier to understand
and maintain a patch series that does not introduce regressions in the
first place, and the context one might use to convincingly explain
that a patch is not introducing a regression turns out to be essential
for many other purposes as well.

Jonathan
