From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH] Added hook in git-receive-pack
Date: Sat, 13 Aug 2005 20:31:27 +0200
Message-ID: <200508132031.27668.Josef.Weidendorfer@gmx.de>
References: <200507312117.43957.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Aug 13 20:33:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E40oc-0001IA-0D
	for gcvg-git@gmane.org; Sat, 13 Aug 2005 20:33:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932238AbVHMScR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Aug 2005 14:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932247AbVHMScR
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Aug 2005 14:32:17 -0400
Received: from pop.gmx.de ([213.165.64.20]:42149 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932238AbVHMScQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Aug 2005 14:32:16 -0400
Received: (qmail invoked by alias); 13 Aug 2005 18:32:15 -0000
Received: from p54968113.dip0.t-ipconnect.de (EHLO linux) [84.150.129.19]
  by mail.gmx.net (mp030) with SMTP; 13 Aug 2005 20:32:15 +0200
X-Authenticated: #352111
To: git@vger.kernel.org
User-Agent: KMail/1.8.2
In-Reply-To: <200507312117.43957.Josef.Weidendorfer@gmx.de>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sunday 31 July 2005 21:17, Josef Weidendorfer wrote:
> Added hook in git-receive-pack

Regarding the update hook:
In this script, it would be nice to be able to distinguish rebasing/forced 
setting of a head from a regular fast forwarding. In the first case, I do not 
want to potentially send a list of all commits starting from project root, 
which currently can happen.

A solution would be to call the hook simply with
	update refname new_sha1
if this is not a fast forward.

The question is if there is a use case for the script to get the old_sha1 even 
in a rebase situation. So another option would be to call the script with
	update action refname old_sha1 new_sha1
with action being "fastforward" or "forcedrebase" or similar.

Or is there already an easy way to detect the fast-forward situation in the 
script?

Josef
