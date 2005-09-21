From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [PATCH] cg-diff fixed to work with BSD xargs
Date: Wed, 21 Sep 2005 09:33:15 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.09.21.07.33.14.533314@smurf.noris.de>
References: <11253960093915-git-send-email-martin@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Wed Sep 21 09:38:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHz9m-0004N7-Fr
	for gcvg-git@gmane.org; Wed, 21 Sep 2005 09:36:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbVIUHgh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Sep 2005 03:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750742AbVIUHgh
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Sep 2005 03:36:37 -0400
Received: from main.gmane.org ([80.91.229.2]:63913 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750710AbVIUHgg (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Sep 2005 03:36:36 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EHz87-0003dQ-Nf
	for git@vger.kernel.org; Wed, 21 Sep 2005 09:34:59 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 21 Sep 2005 09:34:59 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 21 Sep 2005 09:34:59 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9028>

Hi, Martin Langhoff wrote:

> Calls to cg-diff without filename parameters were dependent on GNU xargs
> traits. 

I don't know what drugs your shell was on when you tested this (assuming
that you did ;-)  but this patch is wrong -- your test always succeeds,
due to the vagaries of test / [ ] semantics.

> -	cat $filter | xargs git-diff-cache -r -p $tree | colorize | pager
> +	if [ -s $filter ]; then
> +		cat $filter | xargs git-diff-cache -r -p $tree | colorize | pager  
> +	else
> +		git-diff-cache -r -p $tree | colorize | pager
> +	fi
>  
 $ foo=""
 $ [ -s $foo ]
 $ echo $?
0
 $ [ -s "$foo" ]
 $ echo $?
1
 $

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
God made pot. Man made beer. Who do you trust?
