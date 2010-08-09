From: Ralf Ebert <info@ralfebert.de>
Subject: Re: [PATCH] More readable 'Not a git repository' messages
Date: Tue, 10 Aug 2010 00:44:56 +0200
Message-ID: <i3q0d8$m8f$1@dough.gmane.org>
References: <i3pdkj$hut$1@dough.gmane.org> <AANLkTinttmKi4+EbE54r-GeRbN3_2wxUHu_qJMn5Nysn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 10 00:45:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oib5t-0008C5-MS
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 00:45:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757092Ab0HIWpO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Aug 2010 18:45:14 -0400
Received: from lo.gmane.org ([80.91.229.12]:50085 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757025Ab0HIWpJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Aug 2010 18:45:09 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Oib5c-00082O-6c
	for git@vger.kernel.org; Tue, 10 Aug 2010 00:45:04 +0200
Received: from port-92-198-61-236.static.qsc.de ([92.198.61.236])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 10 Aug 2010 00:45:04 +0200
Received: from info by port-92-198-61-236.static.qsc.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 10 Aug 2010 00:45:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: port-92-198-61-236.static.qsc.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.11) Gecko/20100713 Thunderbird/3.0.6
In-Reply-To: <AANLkTinttmKi4+EbE54r-GeRbN3_2wxUHu_qJMn5Nysn@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153043>

Hi Duy,

> How about this and avoid adding cwd_orig?
>
> -                               cwd[offset] = '\0';
> -                               die("Not a git repository (or any
> parent up to mount parent %s)\n"
> -                               "Stopping at filesystem boundary
> (GIT_DISCOVERY_ACROSS_FILESYSTEM not set).", cwd);
> +                               die("Not in a git repository: %s\n"
> +                               "(stopped searching at %.*s because "
> +                               "GIT_DISCOVERY_ACROSS_FILESYSTEM is
> not set)", cwd, offset, cwd);

this code is inside a loop that goes up in the directory hierarchy. So 
cwd[offset] = '\0' does not only happen once before dying. Maybe it 
could be done without copying but I thought keeping a copy of the 
unaltered path might be more readable.

--
Ralf
