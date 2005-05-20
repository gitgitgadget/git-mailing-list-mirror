From: Raja R Harinath <rharinath@novell.com>
Subject: Re: [PATCH] Fix and clean up man page building
Date: Fri, 20 May 2005 19:38:01 +0530
Organization: Linux Private Site
Message-ID: <m37jhu56ta.fsf@harinath.blr.novell.com>
References: <E1DYmy8-0003YB-JW@highlab.com>
	<20050519155804.GB4513@pasky.ji.cz> <E1DYnpO-0003cF-I6@highlab.com>
	<Pine.LNX.4.58.0505190956330.2322@ppc970.osdl.org>
	<E1DYpbT-0003jv-JY@highlab.com> <20050520133533.GA27395@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri May 20 16:36:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZ8Zu-0001kY-6Y
	for gcvg-git@gmane.org; Fri, 20 May 2005 16:34:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261324AbVETOfO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 May 2005 10:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261365AbVETOfO
	(ORCPT <rfc822;git-outgoing>); Fri, 20 May 2005 10:35:14 -0400
Received: from main.gmane.org ([80.91.229.2]:36782 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261324AbVETOfK (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 May 2005 10:35:10 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1DZ8WR-0001AE-U3
	for git@vger.kernel.org; Fri, 20 May 2005 16:30:44 +0200
Received: from 202.144.86.147 ([202.144.86.147])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 20 May 2005 16:30:43 +0200
Received: from rharinath by 202.144.86.147 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 20 May 2005 16:30:43 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 202.144.86.147
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.3 (gnu/linux)
Cancel-Lock: sha1:5Pap8E0/Odf91jk25k8dYQ0aK8k=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

Jonas Fonseca <fonseca@diku.dk> writes:

> +%.7 : %.1
> +	# FIXME: this next line works around an output filename bug in asciidoc 6.0.3
> +	if [ -f "$<" ]; then mv $< $@; fi
> +
>  %.1 %.7 : %.xml
>  	xmlto man $<
> -	# FIXME: this next line works around an output filename bug in asciidoc 6.0.3
> -	[ "$@" = "git.7" ] || mv git.1 $@
>  
>  %.xml : %.txt
>  	asciidoc -b docbook -d manpage $<

That doesn't look right.  I think you want

  %.7: %.xml
      xmlto man %<

  %.1: %.xml
       xmlto man $<
       [ test -f $@ ] || mv git.1 $@

- Hari

