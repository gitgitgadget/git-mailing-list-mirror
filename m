From: Phillip Susi <psusi@ubuntu.com>
Subject: Re: Clone from shallow bundle bug
Date: Wed, 01 Apr 2015 21:26:50 -0400
Message-ID: <551C9ADA.50404@ubuntu.com>
References: <551B0D37.5070407@ubuntu.com> <xmqqbnj8q0bm.fsf@gitster.dls.corp.google.com> <551B5E64.9070906@ubuntu.com> <xmqqtwx0mka8.fsf@gitster.dls.corp.google.com> <CACsJy8AiOsSJ7QsOmpy5Ss_fKaDK1G4ONgi=jDqM_+Vrv++pkA@mail.gmail.com> <xmqqh9szn4t3.fsf@gitster.dls.corp.google.com> <CACsJy8Cew0t9EZ5aVSCa-BehWz+ABRhDbtLR2cJ2K9c38QeGsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 02 03:27:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YdTuP-0004KG-Op
	for gcvg-git-2@plane.gmane.org; Thu, 02 Apr 2015 03:27:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752779AbbDBB0w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2015 21:26:52 -0400
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.228]:29967 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752559AbbDBB0v (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Apr 2015 21:26:51 -0400
X-Greylist: delayed 81001 seconds by postgrey-1.27 at vger.kernel.org; Wed, 01 Apr 2015 21:26:51 EDT
Received: from [72.238.77.169] ([72.238.77.169:39841] helo=[192.168.1.142])
	by cdptpa-oedge01 (envelope-from <psusi@ubuntu.com>)
	(ecelerity 3.5.0.35861 r(Momo-dev:tip)) with ESMTP
	id D3/63-13781-ADA9C155; Thu, 02 Apr 2015 01:26:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <CACsJy8Cew0t9EZ5aVSCa-BehWz+ABRhDbtLR2cJ2K9c38QeGsA@mail.gmail.com>
X-RR-Connecting-IP: 107.14.168.118:25
X-Cloudmark-Score: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266629>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On 04/01/2015 08:33 PM, Duy Nguyen wrote:
> OK two additional options on top of what we already have:
> 
> - save .have and add extra prerequisite SHA-1. - create a bundle
> that does not hit shallow boundary in the first place, roughly
> speaking it's "max depth minus one". This one does not have extra
> .have or prerequisites

Huh?  If it is one less deep that doesn't help: the new clone will
still be missing history.  AFAICS, the only way to keep the new clone
kosher is for it to have a .git/shallow file that identifies it as a
shallow clone so that history walks stop short instead of complaining
about the missing history.

Thus, all that is needed is for the clone, when it notices that
history is missing, is to create the shallow file instead of erroring
out, telling you to fsck yourself, and rudely deleting the new clone.
 It is one thing to tell you that there is missing history, but quite
another to delete the repository it just created due to it missing
history.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBCgAGBQJVHJraAAoJENRVrw2cjl5RABEH/RW+J5eFNRL80qMVSSnYI4Wb
RjCb5Lb1pp4PBQtGK6yJ/7lzDYptAN6aLcpMVrGiyIIJDm7KfZ6rGvhUegn37ImH
dCelZs+XHeR1dVd05Lbn9FGgB3mg873JOb5+i/hMuuudrXhNjRy6hhFGBnVulpPP
lySfaPMscbSH7lzqr1zxgdu4GzRLlLPzKv1ojiWGyy97iRAsN6bRy6I1/wsddKMn
hESUlv7AdTNQxu3b3NsLGS20a9QHMpKjBxBLvOYE6ftr4yyHMkxum/+BnoASY2UB
h5LenKnQzRwFNGiw1BDeQESqYDXpQ4yA7lpd91gsINwgVsRqg82iSen9/fszzq0=
=shT5
-----END PGP SIGNATURE-----
