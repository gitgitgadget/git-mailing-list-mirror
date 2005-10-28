From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] Avoid using dc in git-count-objects
Date: Fri, 28 Oct 2005 14:32:11 +1000
Message-ID: <20051028043211.GA781@gondor.apana.org.au>
References: <E1EVKmt-0003xn-00@gondolin.me.apana.org.au> <4361A5BB.5040100@zytor.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="VbJkn9YxBvnuCH5J"
Cc: Linus Torvalds <torvalds@osdl.org>, smurf@smurf.noris.de,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 28 06:34:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVLw0-0005Wf-OT
	for gcvg-git@gmane.org; Fri, 28 Oct 2005 06:33:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965077AbVJ1Edf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Oct 2005 00:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965085AbVJ1Edf
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Oct 2005 00:33:35 -0400
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:25866 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S965077AbVJ1Ede
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2005 00:33:34 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6] ident=mail)
	by arnor.apana.org.au with esmtp (Exim 3.36 #1 (Debian))
	id 1EVLuX-0000aP-00; Fri, 28 Oct 2005 14:32:13 +1000
Received: from herbert by gondolin.me.apana.org.au with local (Exim 3.36 #1 (Debian))
	id 1EVLuV-0000DG-00; Fri, 28 Oct 2005 14:32:11 +1000
To: "H. Peter Anvin" <hpa@zytor.com>
Content-Disposition: inline
In-Reply-To: <4361A5BB.5040100@zytor.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10757>


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 27, 2005 at 09:14:51PM -0700, H. Peter Anvin wrote:
> 
> Current ash also has these features, and is about that size compiled 
> static with klibc :)

Interesting.  I just tried it on my POSIX testsuite and unfortunately
it failed a number of simple tests including the case statement and
segfaulted on quite a few occasions too.  I've included one of the
segfault scripts here.

Dash is already used in busybox where it has been linked with ulibc.
So it can't be that hard to make it work with klibc.

Perhaps you could use dash for your project as well?

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dotcmd

trap 'rm -f $TMP' EXIT
TMP=$(tempfile)

cat <<- EOF > $TMP
	return
	echo not here
EOF

a() {
	. $TMP
	echo here
}

a

cat <<- EOF > $TMP
	exit
EOF

(false; . $TMP)
echo $?

--VbJkn9YxBvnuCH5J--
