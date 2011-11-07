From: Ori Avtalion <ori@avtalion.name>
Subject: Re: git-apply that handles rejects like merge conflicts
Date: Tue, 08 Nov 2011 01:18:25 +0200
Message-ID: <4EB86741.7040809@avtalion.name>
References: <4EB85768.1060508@avtalion.name> <20111107225508.GB28188@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 08 00:18:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNYSX-0006pO-Tm
	for gcvg-git-2@lo.gmane.org; Tue, 08 Nov 2011 00:18:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753743Ab1KGXS3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Nov 2011 18:18:29 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63083 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753587Ab1KGXS3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2011 18:18:29 -0500
Received: by mail-fx0-f46.google.com with SMTP id n17so528086faa.19
        for <git@vger.kernel.org>; Mon, 07 Nov 2011 15:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=vQtEZmjBEHUNw3s3ijNV7kIhafjIgAWAc0jvv6ytpvk=;
        b=UgXyz5qvyscr6bwTmGxGlEHTrAmNaY+kEsYqSb8BXonQdek7eV/ClTw1paXPdbNTWo
         W+kTZnYLEXJdUoewJsOpj9caK+gZ6KcjeFJqTfUqa+6mPFMOZ4KF2yTa2uKihQoPdVfX
         NfgwTcThBrcS0lJeN7NBvv22OjJ4d5ytRptCw=
Received: by 10.223.14.3 with SMTP id e3mr51213124faa.25.1320707908526;
        Mon, 07 Nov 2011 15:18:28 -0800 (PST)
Received: from [192.168.1.55] (bzq-79-179-20-244.red.bezeqint.net. [79.179.20.244])
        by mx.google.com with ESMTPS id y17sm3154811faa.22.2011.11.07.15.18.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 07 Nov 2011 15:18:27 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
In-Reply-To: <20111107225508.GB28188@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185046>

On 11/08/2011 12:55 AM, Jeff King wrote:
> If it's an actual git diff, the same 3-way trick will yield good
> results, and it would be nice if it were easier to do that trick without
> calling "git am". But if it's not a git diff (i.e., missing the original
> blob information), then you won't be able to do that.

I'm dealing with two codebases that have branched in the past, before
any VCS was used, and now I'm tracking both separately with git. I'm
trying to  apply changes from one to the other with format-patch and
git-am/apply. So yeah, no blob info.

> In the general case, you can't represent all failed hunks with conflict
> markers, can you? I'm thinking something where we couldn't find any
> relevant context. You know the lines from the original patch from the
> hunk header, so you can drop the failed content from the patch in the
> right spot. But how do you know how big a conflict marker to make for
> the "current" side? The same number of lines as were in the hunk?
> I think you'd end up with confusing conflict markers.

Personally, I wouldn't object to having both "computable" conflicts, and
the .rej files for hunks that lack context, but I see how that would be
very confusing. :)

-Ori
