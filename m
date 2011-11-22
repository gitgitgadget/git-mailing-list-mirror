From: Phillip Susi <psusi@cfl.rr.com>
Subject: Re: [RFC] deprecating and eventually removing "git relink"?
Date: Mon, 21 Nov 2011 20:58:32 -0500
Message-ID: <4ECB01C8.3050107@cfl.rr.com>
References: <7v4ny7mtbx.fsf@alter.siamese.dyndns.org> <buomxbzutjm.fsf@dhlpc061.dev.necel.com> <CAD=rjTXgH+AivmK+zLurQVC+=p1UYqFy_p=wBF-1-TOQ=Cqjtw@mail.gmail.com> <20111114103451.GA10847@sigill.intra.peff.net> <4ECACC13.7050507@cfl.rr.com> <20111121221934.GA21882@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Simon Brenner <olsner@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 22 02:58:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSfdN-0007tK-34
	for gcvg-git-2@lo.gmane.org; Tue, 22 Nov 2011 02:58:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757951Ab1KVB6f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Nov 2011 20:58:35 -0500
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.122]:34791 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755547Ab1KVB6e (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2011 20:58:34 -0500
X-Authority-Analysis: v=2.0 cv=VcZ1zSV9 c=1 sm=0 a=QETZmXXmyubuBiJjAgCHWw==:17 a=y8ZX_BOJfaUA:10 a=PZujzOpSkYQA:10 a=IkcTkHD0fZMA:10 a=xe8BsctaAAAA:8 a=1TnMv5yS14842JVRGDoA:9 a=QEXdDO2ut3YA:10 a=QETZmXXmyubuBiJjAgCHWw==:117
X-Cloudmark-Score: 0
X-Originating-IP: 97.103.252.48
Received: from [97.103.252.48] ([97.103.252.48:53463] helo=[192.168.1.3])
	by cdptpa-oedge02.mail.rr.com (envelope-from <psusi@cfl.rr.com>)
	(ecelerity 2.2.3.46 r()) with ESMTP
	id DD/D6-03218-8C10BCE4; Tue, 22 Nov 2011 01:58:33 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
In-Reply-To: <20111121221934.GA21882@sigill.intra.peff.net>
X-Enigmail-Version: 1.4a1pre
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185772>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/21/2011 05:19 PM, Jeff King wrote:
> Yes, that is one way to do it. The big drawback there is that by
> using hard links, you can only share objects between repos within
> the same filesystem.

Yep, hard links requires same filesystem, but means you don't have to
have a central repo that you have to gc very carefully.

> So yeah, I think it's a perfectly reasonable approach, if you don't
> mind the hard link requirement, and your relink is something like
> "git relink ~/linux-repos/*".

That's the idea.

To sum up, it appears there are 3 possible implementations:

1) hard link + master repo with mutual awareness
2) hard link + no master repo or inter-repo awareness
3) alternatives + master repo with mutual awareness

With #1 you can auto relink when any child does gc

With #2 the repos don't need to be aware of each other

With #3 the repos don't need to be on the same fs, can auto relink
when any child does gc, but moving a child or removing the master repo
causes breakage

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk7LAcgACgkQJ4UciIs+XuKzrQCeIb2Tb3D+nqDlF5bBD8vkQy/t
4sQAniEbL2kZK2wvY+y4tvd+QDRh1G85
=QHQ5
-----END PGP SIGNATURE-----
