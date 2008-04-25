From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] --pretty=format does not work ok with rev-list
Date: Fri, 25 Apr 2008 11:24:57 -0700
Message-ID: <7vbq3xpzba.fsf@gitster.siamese.dyndns.org>
References: <1208032825.30817.15.camel@k0001>
 <slrng1386p.ujv.joerg@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?J=C3=B6rg?= Sommer <joerg@alea.gnuu.de>
X-From: git-owner@vger.kernel.org Fri Apr 25 20:26:00 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JpScO-0003O3-EZ
	for gcvg-git-2@gmane.org; Fri, 25 Apr 2008 20:25:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758488AbYDYSZJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Apr 2008 14:25:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758172AbYDYSZJ
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Apr 2008 14:25:09 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:32807 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756690AbYDYSZH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Apr 2008 14:25:07 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C35894124;
	Fri, 25 Apr 2008 14:25:04 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 0F1FC4122; Fri, 25 Apr 2008 14:25:00 -0400 (EDT)
In-Reply-To: <slrng1386p.ujv.joerg@alea.gnuu.de> (=?utf-8?Q?J=C3=B6rg?=
 Sommer's message of "Fri, 25 Apr 2008 09:14:01 +0000 (UTC)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80344>

J=C3=B6rg Sommer <joerg@alea.gnuu.de> writes:

>> k@k0001 ~/linux-2.6 $ git rev-list -2 --pretty=3Dformat:"%H: %cn" ma=
ster
>> commit f4be31ec9690cfe6e94fcbed6ae60a6a38b3c3ed
>> f4be31ec9690cfe6e94fcbed6ae60a6a38b3c3ed: Linus Torvalds
>> commit 44cad261025c04327fd7e847a7088fd3031b0c3e
>> 44cad261025c04327fd7e847a7088fd3031b0c3e: Linus Torvalds
>
> Is this a bug? I've the same =E2=80=9Cproblem=E2=80=9D in my rebase w=
ith merge patch
> series and added a =E2=80=9C|grep -v ^commit=E2=80=9D. But if this is=
 a bug, I can remove
> it.

I personally do not think the above is a particularly desirable output,
but that's how rev-list worked for a long time and existing scripts
probably expect it that way.

rev-list is for script consumption, and giving --pretty=3Dformat that h=
as %H
in it would be asking for redundant information.
