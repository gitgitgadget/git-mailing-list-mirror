From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v6 00/42] Use ref transactions for all ref updates
Date: Mon, 5 May 2014 08:09:31 -0700
Message-ID: <CAL=YDWkQEMwOaxQHHGC9g+kJjVTnTGNt4KxKFY9cRwcudK4i_A@mail.gmail.com>
References: <1398976662-6962-1-git-send-email-sahlberg@google.com>
	<53678ABA.4010104@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue May 06 18:58:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Whi3K-0006KZ-SH
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:17:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933131AbaEEPJc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2014 11:09:32 -0400
Received: from mail-ve0-f179.google.com ([209.85.128.179]:56429 "EHLO
	mail-ve0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932842AbaEEPJb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2014 11:09:31 -0400
Received: by mail-ve0-f179.google.com with SMTP id oy12so5787076veb.24
        for <git@vger.kernel.org>; Mon, 05 May 2014 08:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ImzDiBoVNbCCtzHrG0XPGjM8pKnvHuLdtOkkticaMsk=;
        b=GaLIyWyvr/yl5uM86jbqLvFZ/2F0PMK3WYOPxizVFsNuL5r/ApH826xPLMCJcNT/xN
         z5L4GW94YGRanNGfy4wt+S/QNAX/AZxEJ5f9F7rddRlolEeHkTi0OoaiGFe4bD8vYwTB
         WDnsLjb8+xMpRncxqZ5zEef1M3KKZ3uWR8BJui3uwsLJSWmoKs0n9icf1nFk3tcf/SED
         L1gFKKAVFuGEpsBGtkfgW5BbNtNS/MTr+/s+bjXsL4d9BQNk1A4Z3b5xgOpciUplbVSK
         +f8E/j2PIB9w6UvQUTuRmCE708Q+FWsYPSKJPcvGjET2DDmRJejagcgFBKipCh2qHPAx
         6JOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=ImzDiBoVNbCCtzHrG0XPGjM8pKnvHuLdtOkkticaMsk=;
        b=bqyqh6wpCEhAWAmo2pNGuL7sDOQfRd5ud0r4HpxuBtJzaIqRWTcVTtJGV5vWynYbn5
         LaYB1iBPxmiAJYttuCyWaNkmxM7HIB/ncKIGZPNCHpfC8NR2M8khNf6TRE+WNhY2PjuB
         dLKiiBIU1MQ6iuQXIQ0e1qa0f/u/n+syzzGNEOZcC7oRXtjGAwhskFtxxW3EWLD+roY0
         JT9TuVL2CN+I6IBkg6sV/iUWS+k5bVevG5qMh+DSv5Er/W2MUMhieSF4KDEUHmu36uRo
         bT9gZ6xCR7yaOUSZRnsRHrP6TXhiIql/0fz/UWj/RJnAa45uIitRj0A8nnw90KbIsM10
         YElA==
X-Gm-Message-State: ALoCoQmygmfEO5UatepqQwq6Jt9wkrrIy0YcF/d3x7oj04DACZhVjnDK9lRNsaDHCWkl/6+O9VhC
X-Received: by 10.220.191.134 with SMTP id dm6mr29018199vcb.16.1399302571231;
 Mon, 05 May 2014 08:09:31 -0700 (PDT)
Received: by 10.52.0.139 with HTTP; Mon, 5 May 2014 08:09:31 -0700 (PDT)
In-Reply-To: <53678ABA.4010104@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248164>

On Mon, May 5, 2014 at 5:57 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 05/01/2014 10:37 PM, Ronnie Sahlberg wrote:
>> This patch series is based on next and expands on the transaction API. [...]
>
> Meta-comment:
>
> Ronnie,
>
> It seems like successive versions of this patch series are growing not
> only in maturity but also in breadth.  That makes it harder to review them.
>
> I, for one, would prefer that a patch series cover a roughly fixed set
> of changes [1], so that all of the patches in a version of the series
> are at roughly the same level of maturity.  That way, the whole series
> can progress from "is this a good idea?" to "is the implementation
> correct?" to "are all the details right?" at roughly the same time, and
> then Junio can merge the branch, locking in that bit of progress.  While
> this is happening, other series can be making their way through other
> stages of the pipeline.
>
> When new patches are added to an old series, then they delay the merge
> of the older patches, even if those are ripe.  Plus, it makes it harder
> for reviewers to keep track of the maturity level of each patch and to
> read off how the older patches have changed.  It makes the patch series
> a moving target.
>
> There's no need to re-split this patch series, but please take this wish
> into account in the future.
>

Understood.
