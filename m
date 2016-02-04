From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-completion.bash: always swallow error output of
 for-each-ref
Date: Thu, 4 Feb 2016 12:26:19 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1602041216240.2964@virtualbox>
References: <56B32953.2010908@gmail.com> <20160204111307.GA30495@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Sebastian Schuberth <sschuberth@gmail.com>, git@vger.kernel.org,
	szeder@ira.uka.de, Junio C Hamano <gitster@pobox.com>,
	tr@thomasrast.ch
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 04 12:26:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRI3n-0002Ij-46
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 12:26:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757873AbcBDL0l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 06:26:41 -0500
Received: from mout.gmx.net ([212.227.15.15]:60996 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755286AbcBDL0j (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 06:26:39 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0Lcj9b-1ZjfVg05hf-00k7ff; Thu, 04 Feb 2016 12:26:23
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <20160204111307.GA30495@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:wSEjNRYoitwJNPXafjoTVrVCFrYw7+Waii1Kqq7NMisjnycjaZS
 8xt3e5fVgNKNuxR7Tct+OaS1KSD3nWgGCWligZKtzsLGfx0AOob09moVmHDaeg/vJ94uIuk
 uxJYKgew63bT2ZycBCzUFtKR0Tx/Ct4FfIB1yaW/SZBHLAszQCE6a7gIHuMdyCeMvTBfEUK
 mULDZOJmx+7WkSc1UA1Bg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:M3DMTYkvW2U=:1lz4/lkv6qxSC8f8HB7/IC
 iTh2SED53pa8pOMUrORu4Mu3sHZNkNaGs8ds/pZCnnnUbPKjkP824lwA3N+mwiTvcvBV/Um9f
 HiDQSmRRaBj+Ezb/2dwxSLX24+pmpAlrCqNH7E7KcFgy4UqWMHPTc9BP6p7O3dwf27MTtePF2
 dJQv3Z1lA5Xoc8moX4oOGvpmDbGOAtNv0h/jhrDRcZteh4rOwF4Vtgz63mkwYwRkFG1/kRoVt
 l8juIPexWLywNHvVqGx0QLxl9conNZe56J5/h1qN7SXxwRmysfU1jrIiwI/Os0u7qsLBu8EL9
 0xbFI4vPcTARik9Y3R7wtY5864uUjMnnKM8MZxmo/02GmQeIH5ICGwHLWsElZKPbJx4nwcp/2
 Eq4ETSH8nd1TO61b8xsRjG7Ux4CQ39WAiVXUrfSyXcgez7TtT6eoeNZ/1O2RhkPiJwJnQPzc4
 LATQHH3iTQ0ooyK55U4tu4LchTlRpu7ZZgi4rT3TEzIlf6+9xRZaH/9TSfz8WqFj6R4ur50cc
 oN6JMtE1xDossbS0a2rQ/ThJgawPuqa9YiZCmOxK9WzXlxWsoQ/h0MG8qsMtWpMaF2qcvRDVE
 4Jm5Wuj7s63O9Qt0frl6CytcGFUyXr7vWqZpklFq6ftjDWBfq9WDUpbCo2ieeYkMvOWrXTGyj
 WpQIKhLoOd4fyoIgYIj9ewgQNZqeMes4qjUlZu0d3yB3ddBz/bkXXgyEcwVzyuCfm3CPHvXkA
 i6SOLWNrviS+bQZGY17m8+8zL5atZToF24YHpXAHgq5zvwdicOg2mK0rDBGjzEnNvYJ5mgvU 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285452>

Hi Peff,

On Thu, 4 Feb 2016, Jeff King wrote:

> On Thu, Feb 04, 2016 at 11:34:59AM +0100, Sebastian Schuberth wrote:
> 
> > This avoids output like
> > 
> >     warning: ignoring broken ref refs/remotes/origin/HEAD
> > 
> > while completing branch names.
> 
> Hmm. I feel like this case (HEAD points to a branch, then `fetch
> --prune` deletes it) came up recently and we discussed quieting that
> warning. But now I cannot seem to find it.

I am pretty certain that it came up in my patch series:

	http://thread.gmane.org/gmane.comp.version-control.git/278538

> Anyway, I this is a reasonable workaround. Errors from bash completion
> scripts are almost always going to be useless and get in the way of
> reading your own prompt.

Maybe we should just shut up the completions in more cases? Dunno...

> > diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> > index 15ebba5..7c0549d 100644
> > --- a/contrib/completion/git-completion.bash
> > +++ b/contrib/completion/git-completion.bash
> > @@ -317,7 +317,7 @@ __git_heads ()
> >  	local dir="$(__gitdir)"
> >  	if [ -d "$dir" ]; then
> >  		git --git-dir="$dir" for-each-ref --format='%(refname:short)' \
> > -			refs/heads
> > +			refs/heads 2>/dev/null
> >  		return
> 
> Not really related to your topic, but digging into it caused me to read
> b7dd2d2 (for-each-ref: Do not lookup objects when they will not be used,
> 2009-05-27), which is about making sure for-each-ref is very fast in
> completion.
> 
> It looks like %(refname:short) is actually kind of expensive:

Yep, this was reported on the Git for Windows bug tracker, too:

	https://github.com/git-for-windows/git/issues/524

> $ time git for-each-ref --format='%(refname)' refs/tags  >/dev/null
> 
> real    0m0.004s
> user    0m0.000s
> sys     0m0.004s
> 
> $ time git for-each-ref --format='%(refname:short)' refs/tags >/dev/null
> 
> real    0m0.009s
> user    0m0.004s
> sys     0m0.004s

And the timings in the ticket I mentioned above are not pretty small:
0.055s vs 1.341s

> The upcoming refname:strip does much better:
> 
> $ time git for-each-ref --format='%(refname:strip=2)' refs/tags >/dev/null
> 
> real    0m0.004s
> user    0m0.000s
> sys     0m0.004s

This is funny: after reading the commit message at
https://github.com/git/git/commit/0571979b it eludes me why strip=2 should
be so much faster than short...

Ciao,
Dscho
