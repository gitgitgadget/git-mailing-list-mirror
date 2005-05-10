From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [PATCH Cogito] cg-init breaks if . contains sub-dir
Date: Tue, 10 May 2005 05:41:16 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.05.10.03.41.15.683163@smurf.noris.de>
References: <20050509233904.GB878@osuosl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Tue May 10 05:35:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVLWe-0004tu-NS
	for gcvg-git@gmane.org; Tue, 10 May 2005 05:35:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261540AbVEJDmc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 May 2005 23:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261547AbVEJDmc
	(ORCPT <rfc822;git-outgoing>); Mon, 9 May 2005 23:42:32 -0400
Received: from main.gmane.org ([80.91.229.2]:37306 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261540AbVEJDma (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 May 2005 23:42:30 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1DVLVd-0004go-6Z
	for git@vger.kernel.org; Tue, 10 May 2005 05:34:13 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 10 May 2005 05:34:13 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 10 May 2005 05:34:13 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi, Brandon Philips wrote:

> -	find * | xargs cg-add
> +	find * ! -type d | xargs cg-add

Actually, (almost) every use of "find | xargs" which is not a subset of
"find -print0 | xargs -0r" is a bug.

So please don't do that. Special files aren't liked by git either, thus:

        find * -type f -print0 | xargs -0r cg-add

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de


