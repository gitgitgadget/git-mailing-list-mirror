From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH] Fix an "variable might be used uninitialized" gcc warning
Date: Wed, 01 Feb 2012 16:16:03 +0900
Message-ID: <buo7h07rpl8.fsf@dhlpc061.dev.necel.com>
References: <4EEBC9D6.6010204@ramsay1.demon.co.uk>
 <20111216235908.GA5858@elie.hsd1.il.comcast.net>
 <4F2834AD.20004@ramsay1.demon.co.uk> <20120131194302.GD12443@burratino>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 01 08:21:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsUVH-0000RE-63
	for gcvg-git-2@plane.gmane.org; Wed, 01 Feb 2012 08:21:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754198Ab2BAHVJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Feb 2012 02:21:09 -0500
Received: from relmlor4.renesas.com ([210.160.252.174]:46768 "EHLO
	relmlor4.renesas.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248Ab2BAHVI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2012 02:21:08 -0500
X-Greylist: delayed 300 seconds by postgrey-1.27 at vger.kernel.org; Wed, 01 Feb 2012 02:21:07 EST
Received: from relmlir1.idc.renesas.com ([10.200.68.151])
 by relmlor4.idc.renesas.com ( SJSMS)
 with ESMTP id <0LYP0092TDIUFC80@relmlor4.idc.renesas.com> for
 git@vger.kernel.org; Wed, 01 Feb 2012 16:16:06 +0900 (JST)
Received: from relmlac4.idc.renesas.com ([10.200.69.24])
 by relmlir1.idc.renesas.com (SJSMS)
 with ESMTP id <0LYP00GPYDIUWSF0@relmlir1.idc.renesas.com> for
 git@vger.kernel.org; Wed, 01 Feb 2012 16:16:06 +0900 (JST)
Received: by relmlac4.idc.renesas.com (Postfix, from userid 0)
	id 5F549480A3; Wed, 01 Feb 2012 16:16:06 +0900 (JST)
Received: from relmlac4.idc.renesas.com (localhost [127.0.0.1])
	by relmlac4.idc.renesas.com (Postfix) with ESMTP id 5985248082; Wed,
 01 Feb 2012 16:16:06 +0900 (JST)
Received: from relmlii2.idc.renesas.com [10.200.68.66]	by
 relmlac4.idc.renesas.com with ESMTP id SAA23049; Wed,
 01 Feb 2012 16:16:06 +0900
X-IronPort-AV: E=Sophos;i="4.71,601,1320591600";   d="scan'208";a="66082171"
Received: from unknown (HELO relay41.aps.necel.com) ([10.29.19.9])
 by relmlii2.idc.renesas.com with ESMTP; Wed, 01 Feb 2012 16:16:06 +0900
Received: from dhlpc061 (dhlpc061.dev.necel.com [10.114.97.152])
	by relay41.aps.necel.com (8.14.4+Sun/8.14.4) with ESMTP id q117G4I4005366;
 Wed, 01 Feb 2012 16:16:04 +0900 (JST)
Received: by dhlpc061 (Postfix, from userid 31295)	id CBFC352E247; Wed,
 01 Feb 2012 16:16:03 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-reply-to: <20120131194302.GD12443@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189500>

Jonathan Nieder <jrnieder@gmail.com> writes:
>> The versions which complain are 3.4.4 and 4.1.2, whereas 4.4.0 compiles
>> the code without complaint. So, gcc *may* be getting more sane, but I wouldn't
>> bet on it! :-P
>>
>> I've had examples of this kind of warning, which relies heavily on the
>> analysis performed primarily for the optimizer, come-and-go in gcc before
>
> Yep, judging from the commit message, Junio found the same warning
> in 4.6.2.
>
>> Having said that, unless you are going to decree that the project only
>> supports gcc (and presumably only some particular versions of gcc), then you
>> may well find similar warnings triggered when using other compilers anyway ...
>
> Sure, when the control flow grows too complicated, that's probably worth
> fixing anyway, for the sake of humans especially.
>
> Sometimes gcc is the only crazy one, though. ;-)

It's hard to see how any compiler could detect that "mode" always
receives a value here .... it would have to realize that "stage" always
becomes 2 before the loop is exited, and that seems to depend on
non-trivial properties of external data structures...

-miles

-- 
Joy, n. An emotion variously excited, but in its highest degree arising from
the contemplation of grief in another.
