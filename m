X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: sf <sf@b-i-t.de>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 01 Dec 2006 13:03:48 +0100
Message-ID: <45701A24.5060500@b-i-t.de>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net> <200611281335.38728.andyparkins@gmail.com> <20061129160355.GF18810@admingilde.org> <200611292000.23778.andyparkins@gmail.com> <20061130170625.GH18810@admingilde.org> <456F29A2.1050205@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 1 Dec 2006 12:04:38 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 33
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ip-213157015184.dialin.heagmedianet.de
User-Agent: Thunderbird 1.5.0.8 (X11/20061110)
In-Reply-To: <456F29A2.1050205@op5.se>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32905>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gq77z-0000gl-VZ for gcvg-git@gmane.org; Fri, 01 Dec
 2006 13:04:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936488AbWLAMEW (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 07:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936489AbWLAMEW
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 07:04:22 -0500
Received: from main.gmane.org ([80.91.229.2]:25512 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S936488AbWLAMEV (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 07:04:21 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gq77m-0000dV-Dg for git@vger.kernel.org; Fri, 01 Dec 2006 13:04:14 +0100
Received: from ip-213157015184.dialin.heagmedianet.de ([213.157.15.184]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Fri, 01 Dec 2006 13:04:14 +0100
Received: from sf by ip-213157015184.dialin.heagmedianet.de with local
 (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Fri, 01
 Dec 2006 13:04:14 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Andreas Ericsson wrote:
...
> The only problem I'm seeing atm is that the supermodule somehow has to 
> mark whatever commits it's using from the submodule inside the submodule 
> repo so that they effectively become un-prunable, otherwise the 
> supermodule may some day find itself with a history that it can't restore.

That has nothing to do with submodules. What you state here is the 
problem of alternate repositories.

There are two solutions:

1. Do not use alternates.

2. Do not prune a repository that is used as an alternate repository by 
other repositories.

For the submodule discussion that would mean:

1. Only fetch and work on branches of submodules you are interested in. 
It does not matter that the origin repository contains (probably orders 
of magnitude) more data. You will never touch that.

2. You can never prune the main (the supermodule's) repository, at least 
not with what git provides today.

That is why the sanest approach to subprojects is to put commits into 
tree objects, define a way to name these commits and make git understand 
these new commit names. Done. Works.

Regards

Stephan
