From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: What to expect after 0.99.8
Date: Mon, 03 Oct 2005 22:48:54 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.10.03.20.48.52.132570@smurf.noris.de>
References: <7v7jcvxxrl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Mon Oct 03 22:53:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EMXI4-0003Ez-2X
	for gcvg-git@gmane.org; Mon, 03 Oct 2005 22:52:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbVJCUwA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Oct 2005 16:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbVJCUv7
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Oct 2005 16:51:59 -0400
Received: from main.gmane.org ([80.91.229.2]:11953 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932348AbVJCUv7 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Oct 2005 16:51:59 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EMXG6-0002hn-HM
	for git@vger.kernel.org; Mon, 03 Oct 2005 22:50:02 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 03 Oct 2005 22:50:02 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 03 Oct 2005 22:50:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9651>

Hi, Junio C Hamano wrote:

> * Libification.  There are many places "run once" mentality is
>   ingrained in the management of basic data structures, which need to be
>   fixed.

I have started work on doing this "the right way"
(as per earlier discussion).

Current status: There's a toplevel "struct git_env", an associated "struct
git_objdb", and (thread-safe and globals-free) library code to read
sha1-identified object (meta)data, including packs and all.

http://netz.smurf.noris.de/git/git.git#libize

Next on my TODO list: introduce a "struct git_obj" which represents
exactly one sha1 and the metadata associated with it, rename the
accessor functions to be more consistent, add SWIG interface code and
Python testcases, submit to everybody's scrutinity.

After that, the task can hopefully be parallelized.

Definitely a post-1.0 job; the job is too big, and shipping 1.0 with a
partial library that doesn't do much that's useful does not make sense.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
We've sent a man to the moon, and that's 29,000 miles away.  The center
of the Earth is only 4,000 miles away.  You could drive that in a week,
but for some reason nobody's ever done it.
		-- Andy Rooney
