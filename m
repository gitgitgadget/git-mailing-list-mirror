From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH (resend)] Pass -C1 to git-apply in StGIT's apply_diff() and apply_patch().
Date: Tue, 10 Apr 2007 17:48:29 +0100
Message-ID: <b0943d9e0704100948k2b505916w5485b99e72d36c10@mail.gmail.com>
References: <20070409112422.GE11593@moonlight.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: catalin.marinas@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 11 02:37:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbJWF-0001Tn-EI
	for gcvg-git@gmane.org; Tue, 10 Apr 2007 18:48:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031120AbXDJQsc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 12:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031122AbXDJQsb
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 12:48:31 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:4589 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031120AbXDJQsa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 12:48:30 -0400
Received: by ug-out-1314.google.com with SMTP id 44so107207uga
        for <git@vger.kernel.org>; Tue, 10 Apr 2007 09:48:29 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=evX8ruiB9uGJ5S1i6NOrXanxeVOPHe+wXQK0pdndobYzx5GZqaWuogdTYSta8QxoRU9U/AHpM9wprss0D3s9bbfG/msXJY82xVFUmjidDFObBrnYbf4/8W9jVTc23x7ihyW6RS3oZevL5LdxS/TEK2P/3SneqMUvcd8uq2UKGZU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qDLAy14f8HR/5/oHPSJN/Wn8/+rM/kR4AWy2NaNDDlYsURwE6H/qQCVi89Pc5SeGgB0sfGsUcDvCxrTNbkyYyR7c6h+AAkl1llmaanqD1h5nNJR9m7FgmLNK3EvqAq0llls6Kon/ZWXYExEx7mFx/B8uQ1qzppQKk+IQazwkRNs=
Received: by 10.67.97.18 with SMTP id z18mr121139ugl.1176223709481;
        Tue, 10 Apr 2007 09:48:29 -0700 (PDT)
Received: by 10.66.255.11 with HTTP; Tue, 10 Apr 2007 09:48:29 -0700 (PDT)
In-Reply-To: <20070409112422.GE11593@moonlight.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44155>

On 09/04/07, Tomash Brechko <tomash.brechko@gmail.com> wrote:
> Running git-apply without -C is too restrictive: when the patch has
> some fuzz (it could have been applied upstream with the fuzz, or
> different local branches have slightly different context), StGIT would
> start manual merge because of the conflict in the context.  Passing
> -C1 makes git-apply behave close to default mode of diff/patch: 'diff'
> generates 3 lines of context, and 'patch' allows 2 line mismatch,
> i.e. it requires the match of at least one context line.
>
> Fix in apply_diff() relaxes the restriction in 'push --merged' and
> 'rebase --merged' for detection of upstream merges, fix in
> apply_patch() does relaxation 'import', 'fold' and 'sync' commands.

Thanks for the patch. I'm OK with -C1 in apply_patch() but I'm a bit
concerned with the 'push/rebase --merged' logic being relaxed. There
is also the reporting of patches being modified during 'push', i.e.
the push succeeded only after a three-way merge.

I think I could add separate config options for both apply_diff and
apply_patch, only that it might confuse users not knowing the StGIT
internals.

-- 
Catalin
