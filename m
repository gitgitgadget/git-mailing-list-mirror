From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Ignore dirty submodule states during stash
Date: Mon, 16 May 2016 18:29:03 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605161817590.3303@virtualbox>
References: <20160516020735.GA7884@gmail.com> <CAGZ79kaTss6ctZDCiRP2wjuxH+rJ79RKFLM79_FJN+37Bed+HQ@mail.gmail.com> <20160516154606.GA8797@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org
To: Vasily Titskiy <qehgt0@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 16 18:29:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2LOL-0003yP-PU
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 18:29:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754388AbcEPQ3J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 12:29:09 -0400
Received: from mout.gmx.net ([212.227.17.22]:61772 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754255AbcEPQ3I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 12:29:08 -0400
Received: from virtualbox ([88.128.80.193]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0M20Jj-1br1GO36WB-00tzVB; Mon, 16 May 2016 18:29:04
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <20160516154606.GA8797@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:xSAUm3oxGIy96815/8i+ombjHtX6qIGHKbKERNp4NhNMbEXPCLv
 A50Rp6NZkVmrBRQ04BAAzm0ZFCg/uoUgAFk9KYl159xFD6LUK2D5WJ/2KRXH84M5O/xOdcQ
 bTGWsOB/t4s493zobvrifruyxj8zz75qQhCEZIdivqQdB5KIdGKwITpzmny2RDmOFArJAmS
 o6gBRRF0+SBdPDVkLALrA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sVDXbPau6oI=:KUvliR7qnJJ6V2MWnwZxEI
 XgEv0XE83YxfastTITINeVps3fA7LewHA2c3cU3VltN3GQrmByh/MC/0Uv5hQ5N2J3LcSsezm
 RRjZNgDSAVC+8Q/KGTX8KcAvuYU0r/3Nuv0soI7wqMHRyrN4/O+B3iHFhX5nY/iQz9UqapsIK
 kQyH3iz/45YFBM8ihBDySb0IXl/nEuCe9mTpn+gf8nCI8j7ecstm+0g8p214tPNg5soEJEqJW
 XAjJnlYrgFZQPcKbAAcPiEB2JRx/mFPUPJH+E5nWO5pywa028VIRzByf6CmYl+7hzyNS1DrHP
 IrS+gn9Yea40M9XRyLxVzq+uQSOnaTlNpKZWBKU9yOu976ts5BFB4AR8MiAS8Qdjktku6QwIs
 APK61iAE8zG8mrPTpDmAQhPgFyDKNV1ROdZgZPr+jW6Mki36NdpHb+YibYPN570Bthr1UKpws
 Z8+sXNNm7csIhl7aHmkmQEr5OTlgIcC0f+VyOgc80YIbdomyMV4+RDqX8E81pud8arfIk4wJI
 WQluZGNq/hiXfvedGe0xmCC0COjBcUDxO1z5ts4x4pZjgGKI/vB7HHhVrH5otZI31P8Gx9AcD
 qaroGKDBD2HL5p2SnYSw7TJa759EjnR7YTelv3HlSoRZH4VQU/suf5ArWWy5Z2XxF51sLA5Uo
 iTJO9fnrFnGhuggXR31I+kJyqYom+VQ/sa88ecSVr4Zl2n4bElRP/O1Ti7yaMbb5jQzr6ev3G
 pyW0m8k5obOo199flyhi1ISAioFst2dUhOJh/dPBKWVGP9YanH2cCezrSB/TEhvNwHn7xtyP 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294752>

Hi Vasily,

On Mon, 16 May 2016, Vasily Titskiy wrote:

> On Sun, May 15, 2016 at 11:37:20PM -0700, Stefan Beller wrote:
> > On Sun, May 15, 2016 at 7:07 PM, Vasily Titskiy <qehgt0@gmail.com> wrote:
> > > Do not save states of submodules as stash should ignore it.
> > 
> > Can you explain why this is a good idea?
> > (It is not obvious to me either way.)
> Actually, submodules are already ignored by stash, but not fully (it was
> introduced in commit 6848d58).
> Current behavior is counter-intuitive, for example (if one has a project
> with a submodule):
>  [...]
> 
> So, this is the issue. Instead of getting my local changes, I got a
> conflict (and stash is not poped out). The root cause is the 'stash'
> command does not know how to deal with submodules, but currently it
> tries to save the state of submodules, and even tries to re-apply the
> state (and it fails of course). The proposed solution fixes this
> behaviour.

Please make it a habit to put such information into the commit message. I
have to admit that I was as puzzled as Stefan by the proposed patch. Such
problems, and tedious back-and-forth discussion, can be easily avoided by
providing additional background in the commit message. We even ask in our
Documentation/SubmittingPatches explicitly to do that:

> The body should provide a meaningful commit message, which:
>
>   . explains the problem the change tries to solve, iow, what is wrong
>     with the current code without the change.
>
>   . justifies the way the change solves the problem, iow, why the
>     result with the change is better.
>
>   . alternate solutions considered but discarded, if any.

BTW this is not something we ask to make contributors' lives harder. In
fact it helps everybody, including the contributors themselves. Just
imagine what kind of kick-ass commit message you would want to read in six
months when you stumble over your very own commit and want to know what
the heck it was about.

Ciao,
Johannes
