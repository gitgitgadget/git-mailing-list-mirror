From: Phil Hord <hordp@cisco.com>
Subject: Re: [PATCH] git-p4: replace each tab with 8 spaces for consistency
Date: Thu, 07 Apr 2011 12:35:48 -0400
Message-ID: <4D9DE7E4.1030808@cisco.com>
References: <1302156081-3286-1-git-send-email-andrew@andrewgarber.com> <7vhbaafr7r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Andrew Garber <andrew@andrewgarber.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 07 18:35:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7sBW-0002fG-Ne
	for gcvg-git-2@lo.gmane.org; Thu, 07 Apr 2011 18:35:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754258Ab1DGQft (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2011 12:35:49 -0400
Received: from sj-iport-4.cisco.com ([171.68.10.86]:37983 "EHLO
	sj-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753949Ab1DGQft (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2011 12:35:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=hordp@cisco.com; l=1229; q=dns/txt;
  s=iport; t=1302194149; x=1303403749;
  h=message-id:date:from:mime-version:to:cc:subject:
   references:in-reply-to:content-transfer-encoding;
  bh=xuQO6XoV0FW1tkWJNpFEzkwIwVI2kCaZbygb2H7qx/E=;
  b=N4ylJP5X0BzIIaCUZOmVLQx5oFulwfdHzZ1/gdwr3awhVpTD8ZzRD1TU
   UpQ6GrZv+oQPejtvecpNaAavunZZBGsztsmWZyHfaoJ6Ew7invVVXCF4x
   vQR8Ghvuf2JZCC/fj8AHlnVWvmaFvWQ1QBOVd15SaV96+bfNOWFClEguP
   A=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsEAKLmnU2tJV2d/2dsb2JhbACmCHekNJxfhW0EjUWDaA
X-IronPort-AV: E=Sophos;i="4.63,317,1299456000"; 
   d="scan'208";a="282394921"
Received: from rcdn-core-6.cisco.com ([173.37.93.157])
  by sj-iport-4.cisco.com with ESMTP; 07 Apr 2011 16:35:48 +0000
Received: from [64.100.104.120] (dhcp-64-100-104-120.cisco.com [64.100.104.120])
	by rcdn-core-6.cisco.com (8.14.3/8.14.3) with ESMTP id p37GZmQw006575;
	Thu, 7 Apr 2011 16:35:48 GMT
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101208 Lightning/1.0b2 Thunderbird/3.1.7
In-Reply-To: <7vhbaafr7r.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171066>

On 04/07/2011 03:36 AM, Junio C Hamano wrote:
> Mixing tabs and spaces can lead to hard-to-find bugs, I agree.
>
> I just threw this in to my .git/info/attributes:
>
>     contrib/fast-import/git-p4 whitespace=!indent,tail,tab-in-indent
>
> and then did this:
>
>     $ >contrib/fast-import/git-p4
>     $ git diff -R | git apply --whitespace=fix
>     $ git diff
>
> The changes I get out of the last step seem to exactly match your patch.

Junio!  Thanks for that recipe.

I suspected there must be some way to employ git-apply's whitespace=fix
feature to ws-normalize my code, but I was clueless how to do that.  I
wound up cobbling together a python script that reimplements the same
fixes (hopefully).

I wish this (the git-apply trick) was documented somewhere and/or made
more prominent.  Is it, and I have also overlooked it?

This is what I want:

   git fix-whitespace             # fix new ws errors in workdir
   git fix-whitespace --all       # fix all ws errors in workdir
   git fix-whitespace foo         # fix new ws errors since foo
   git fix-whitespace --cached    # fix new ws errors in the index
   etc.

Is this already implemented somewhere in the git porcelain?

Phil
