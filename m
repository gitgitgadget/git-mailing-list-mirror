From: Phil Hord <hordp@cisco.com>
Subject: Re: ACLs for GIT
Date: Mon, 16 May 2011 11:33:30 -0400
Message-ID: <4DD143CA.3000700@cisco.com>
References: <4DD02876.1040404@bbn.com> <20110515201513.GA27758@jpl.local> <4DD1250D.50005@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?Magnus_B=E4ck?= <magnus.back@sonyericsson.com>,
	git@vger.kernel.org
To: Martin L Resnick <mresnick@bbn.com>
X-From: git-owner@vger.kernel.org Mon May 16 17:33:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLzne-0001cZ-5e
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 17:33:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756126Ab1EPPdc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2011 11:33:32 -0400
Received: from sj-iport-1.cisco.com ([171.71.176.70]:34185 "EHLO
	sj-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755999Ab1EPPdc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2011 11:33:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=hordp@cisco.com; l=1218; q=dns/txt;
  s=iport; t=1305560012; x=1306769612;
  h=message-id:date:from:mime-version:to:cc:subject:
   references:in-reply-to:content-transfer-encoding;
  bh=3EwxyB81ifYBnlbZ4ALQnwTK6B7CT6Obim7WJhVfhME=;
  b=KIkZ08+s1mbBm0q4+ozZ3uKs8e+fsvievJbo0Oc+OP4fWH8ezu3SE9s+
   LbNmKe1J+g+izX0EnZVSP6qzPM0uZ4IeRDkE5RlWFpVAisODEnyr4RH0U
   E7fp4HkQ4ogDK+M8fnFScp4OEU4TtMQtxxAzUBtS4bqAC80rTXKirUIlL
   s=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsEAIRD0U2tJV2b/2dsb2JhbACmGXepEJ14hhkEkBGEL4pi
X-IronPort-AV: E=Sophos;i="4.64,374,1301875200"; 
   d="scan'208";a="448554534"
Received: from rcdn-core-4.cisco.com ([173.37.93.155])
  by sj-iport-1.cisco.com with ESMTP; 16 May 2011 15:33:30 +0000
Received: from [64.100.104.120] (dhcp-64-100-104-120.cisco.com [64.100.104.120])
	by rcdn-core-4.cisco.com (8.14.3/8.14.3) with ESMTP id p4GFXUoA014446;
	Mon, 16 May 2011 15:33:30 GMT
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110419 Lightning/1.0b2 Thunderbird/3.1.9
In-Reply-To: <4DD1250D.50005@bbn.com>
X-Enigmail-Version: 1.1.2
X-TagToolbar-Keys: D20110516113330543
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173741>

On 05/16/2011 09:22 AM, Martin L Resnick wrote:
> Thanks Mangus.
>
> You pointed out some hurdles I'll have to think about
> (blocked files not matching the SHA and so can't be committed).
>
> As to why I want to do this consider NSA non-export rules.
> Our application would be built with NSA encryption
> but we have foreign nationals working on the code
> and so they are not permitted to see that part.
> The makefiles look to see if the NSA encryption code file
> is there and link it in. If not a stub is used.

We use submodules for this same need here.  If the submodule is loaded,
the code is used from that.  If not, pre-built binaries are used
instead.  These could be stubs.

When we share code with outside partners, we give them access only to
the modules they need.

We further guard the code in the submodule by PGP-encrypting the source
files and storing them in the repository (as binaries).  This practice
lets us be more free with the repository and not worry so much that it
may be cloned well out of our control.  Storing code as shrouded
binaries negates much of git's power, but only for this one submodule. 
Our other submodules are still quite git-friendly.

Phil
