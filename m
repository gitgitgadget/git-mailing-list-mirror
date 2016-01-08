From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 2/2] Handle more file writes correctly in shared
 repos
Date: Fri, 8 Jan 2016 17:04:17 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601081702070.2964@virtualbox>
References: <4aa11f02f4de113bf38152b8815658da42690f43.1450549280.git.johannes.schindelin@gmx.de> <cover.1452085713.git.johannes.schindelin@gmx.de> <c03e5a9d367b76d8a249680c752b4c4d935e9b91.1452085713.git.johannes.schindelin@gmx.de>
 <20160107124608.GB14421@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Yaroslav Halchenko <yoh@onerussian.com>,
	=?ISO-8859-15?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 08 17:04:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHZX5-0000zp-As
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jan 2016 17:04:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755755AbcAHQEv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2016 11:04:51 -0500
Received: from mout.gmx.net ([212.227.15.19]:57068 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755749AbcAHQEt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2016 11:04:49 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LjqLx-1Zfkrq2YfZ-00bpqD; Fri, 08 Jan 2016 17:04:19
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <20160107124608.GB14421@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:mQ9+Cn/uyME7OPTdUV8UwvnTRNnlOAa+UyTZK+mI2fiLn9OxqI0
 qqHqjrI/LG2kVYn/qsVGX2s8AqHx+8qTkWQ0a4uLzMW9opWyWuijNRL0CD4WDtpdk0lkhTx
 lOm+O7DMx71+/oGI9lgykDUdVun/vV/FPEY58mCCrK8loNfF/BRqviqLgMllbSyMrVqPz0d
 g1AgT/ivdbm5HnHIhTwow==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GouKR+cCB20=:/OXGFkmJhwwZXqFfISEuhu
 fMdasYP9bvnUb5Uf5NZdHmxUKYs2WGJFKbizd28IXsjMgn9+v/f04B2EJluhBJsd3A5kCmtYP
 ymgTUc2PgchmGttAAwW+9Hlciv1Vup3JhCNNNrMfFnmAnQHhZQMH3T5Blv1EKJ5DdWDQIFm1i
 W/CysfCGM4uILdIrIuvjE7+/WLbL8+oTHka4CEhRJlJF6bLaN0yiW4R4K79v9DmR8mxRhG9Qh
 +ieY1wwdbDXm/ljXonOqMG26ZTNql97vIkd9xdIKj36uH0TYPJwGO10gpSh2ZRcMcZF9SXcXk
 Mg8tDHE7Y03tfizgjlJZSvdHjsKT/SIrDqsjo1B0oBEdSE5gXuzY/R9d1hGlJ9M1es169RYAK
 udvN8hxvaxZwbucn41e2GPNKpHDgoir74IkN7y8G0Ws8AvUgbqPVB2QUBxs5H1zqlkm6gjYbZ
 xl08Htw30qytuAiy1bVwW22PFaaDA9DHuObwtTpW1SK1vTYiV3YgMs42iDqBFnWUbkSZAlIJ/
 D9hUDFyT9/hB5z8RvlcNgDKEX1/9oxdgoBnwnAoQAgpMPP+gWuPXZf5kudBSoXirKTux8RKnr
 02D/MFoe869cBSDtfn2EnMvwocxUpu3c2N08iZu4KE+t8nOHOjgKjPUHYQpN6mkWXXjFOA1rr
 PRE35ddewLgc/C6dM6h96pG5bfxvrzOCvMIPZWxnMDKVrQQBeNuyy99nEMd4tsa/niftd0h6a
 hsQHGwG4n6eDWmDtw5CO9PiGP/zI8+QzmbqJd4H3xD44JRQmC2sW4nDE1CHVBNj8Ig69ZLo0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283558>

Hi Peff,

On Thu, 7 Jan 2016, Jeff King wrote:

> On Wed, Jan 06, 2016 at 02:09:49PM +0100, Johannes Schindelin wrote:
> 
> > - git am, when splitting mails (git-am correctly cleans up its
> > directory after finishing, so there is no need to share those files
> > between users)
> > 
> > - git apply, when writing rejected hunks
> > 
> > - git fsck, when writing lost&found blobs
> 
> For these latter two, I had to ask myself "why not?". You gave such nice
> reasons for the other items in the list, I wondered what your reasoning
> was here.

My bad. My reading on both rejected hunks and lost & found blobs is that
the files should be cleaned up by the user who generated them. And if
another user can interfere with that cleaning up, that is bad. So I left
them non-shared to avoid such an interference.

> I also wondered why we do not do the usual write-to-temp and rename in
> some of these cases, but that is not really relevant to your patch.

Oh yeah, I'd love to stop here (I already extended this rather simple
one-line patch to something vastly larger, and that was not my intention).

Ciao,
Dscho
