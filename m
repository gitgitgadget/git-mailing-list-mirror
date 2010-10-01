From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: integrity of linux copy of a git repo
Date: Fri, 1 Oct 2010 15:01:02 -0500
Message-ID: <20101001200102.GA1882@burratino>
References: <i85dub$fp5$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Neal Kreitzinger <neal@rsss.com>
X-From: git-owner@vger.kernel.org Fri Oct 01 22:04:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1lqA-0003n9-AM
	for gcvg-git-2@lo.gmane.org; Fri, 01 Oct 2010 22:04:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751737Ab0JAUER (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Oct 2010 16:04:17 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:42076 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751466Ab0JAUEQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Oct 2010 16:04:16 -0400
Received: by iwn5 with SMTP id 5so4211721iwn.19
        for <git@vger.kernel.org>; Fri, 01 Oct 2010 13:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=D9T7993DEsqhutVCRMNotJOB6P4EWClqn9/MZoSizdU=;
        b=Q7SjdpTfcgaPFVQ2Hjp5ThEl6j6CQWNu/jXvdvshExD/5vO4nJATIVsQz0s/pxSXO3
         +0vQ+qTQMxCj/kCW61YFwl+e6jF0vKoGWZ4K3sZc/Egz7nqdoPiJyekZyjRir4mZA8Bt
         gwGWR7ZTbsTd3cLNZiWQiDSYOt2HEjNeLsrv0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=bZiYN6OByVLGqS/7O5AZe4ysSqnX00YaxLTMQ8obMDjDswD/cdOQuleazkAFKFSPZD
         AYHXpBqOAjUnz9NWzkH6Cp5/NCk9tBCVzzPhTHwkGKLI1hkq7V20+1rY6uZ1um44KfXI
         m4Zpgv+E1ZQ4AQdusLA/GVENBKO7m3zIUQg3E=
Received: by 10.231.191.138 with SMTP id dm10mr6163519ibb.126.1285963455765;
        Fri, 01 Oct 2010 13:04:15 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id t1sm1535765ibc.8.2010.10.01.13.04.14
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 01 Oct 2010 13:04:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <i85dub$fp5$1@dough.gmane.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157776>

Hi Neal,

Neal Kreitzinger wrote:

> If I make a recursive linux copy, "cp -rfp", of a git repo working tree is 
> the resulting copy interchangeable with the original?

Yes, the git metadata does not hardcode the path to the repo anywhere.
See gitrepository-layout(7) for perhaps more detail than you wanted.

You might want to use "git add --refresh ." (or even just "git diff")
to update the cached stat() information before starting work with the
new worktree, but that only matters if you are going to use very
low-level commands.

> cp -rfp /orig-wk-tree /orig-wk-tree-copy
> (do some stuff that breaks /orig-wk-tree)
> rm -rf /orig-wk-tree
> mv /orig-wk-tree-copy /orig-wk-tree
> 
> Have I truly recovered the full integrity of the original

Sure, that's a good way to do experiments.

Hope that helps,
Jonathan
