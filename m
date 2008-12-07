From: Deskin Miller <deskinm@umich.edu>
Subject: Re: [PATCH] git-svn: Make following parents atomic
Date: Sun, 7 Dec 2008 17:24:44 -0500
Message-ID: <20081207222444.GA10881@euler>
References: <1228665970-21204-1-git-send-email-deskinm@umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: normalperson@yhbt.net, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 07 23:26:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9S4u-0006kN-FB
	for gcvg-git-2@gmane.org; Sun, 07 Dec 2008 23:26:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752969AbYLGWY5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Dec 2008 17:24:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752878AbYLGWY5
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Dec 2008 17:24:57 -0500
Received: from an-out-0708.google.com ([209.85.132.249]:52789 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752497AbYLGWY4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Dec 2008 17:24:56 -0500
Received: by an-out-0708.google.com with SMTP id d40so365932and.1
        for <git@vger.kernel.org>; Sun, 07 Dec 2008 14:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent:sender;
        bh=a6nGsIHmpMbPCYHM8X6CYfu52Ot+ErrKIWKKiZE1rC0=;
        b=pAjE5gUQL3lobuXS5qJpIQfmKUayvIiH2qbPkMB88c07/L/UbS94ZZIVDo3uFzC/UE
         ZjXkkULFjiXhhmNjP7Rj/yV9q77m4s9Odr5Fo7xSLTRbrJvzn2po1d6hICEVdO/WTdsB
         M+Ewvf+udCrAWaIepDvurV6do/5gvBoTtCn+s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent:sender;
        b=XMj/cTsk7uNSWNjRVTIsD78DspT+4z/BL3KNyciZPXarPgabqBr9RIFd9UaoClCyjF
         Xc6g1gKwE3FGT1P0JaKTSDOqgnaQg0Eb/rPe8qRfgpn70wIVpauN38V2S2V1NlwMGdwf
         yLZO9zoKt689PlxAoCpeFS74UjHAmZcJzm7wU=
Received: by 10.65.242.7 with SMTP id u7mr2214049qbr.23.1228688694700;
        Sun, 07 Dec 2008 14:24:54 -0800 (PST)
Received: from euler ([68.40.49.130])
        by mx.google.com with ESMTPS id s27sm6609938qbs.11.2008.12.07.14.24.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Dec 2008 14:24:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1228665970-21204-1-git-send-email-deskinm@umich.edu>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102510>

On Sun, Dec 07, 2008 at 11:06:10AM -0500, Deskin Miller wrote:
> [...]
>
> To fix this, when we initialise the Git::SVN object $gs to search for
> and perhaps fetch history, we check if there are any commits in SVN in
> the range between the current revision $gs is at, and the top revision
> for which we were asked to fill history.  If there are commits we're
> missing in that range, we continue the fetch from the current revision
> to the top, properly getting all history before using it as the parent
> for the branch we're trying to create.

On looking at the patch again, I think I might have introduced a bug:
it'll take the most commit on the parent branch, even if it was branched
from an earlier point.  I'll spend more time looking at it and should
have a v2 in a day at most if I'm rigth, hopefully more like a few
hours.

Deskin Miller
