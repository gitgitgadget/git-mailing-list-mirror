From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v3] gitk: Teach gitk to respect log.showroot
Date: Sat, 8 Oct 2011 17:47:04 +1100
Message-ID: <20111008064704.GA27056@bloggs.ozlabs.ibm.com>
References: <20111004200813.GA16596@kennedy.acc.umu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: zbyszek@in.waw.pl, gitster@pobox.com, git@vger.kernel.org
To: Marcus Karlsson <mk@acc.umu.se>
X-From: git-owner@vger.kernel.org Sat Oct 08 08:47:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCQh2-0002NV-PF
	for gcvg-git-2@lo.gmane.org; Sat, 08 Oct 2011 08:47:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441Ab1JHGrV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Oct 2011 02:47:21 -0400
Received: from ozlabs.org ([203.10.76.45]:59977 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751383Ab1JHGrV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Oct 2011 02:47:21 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 3AB63B7105; Sat,  8 Oct 2011 17:47:20 +1100 (EST)
Content-Disposition: inline
In-Reply-To: <20111004200813.GA16596@kennedy.acc.umu.se>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183139>

On Tue, Oct 04, 2011 at 10:08:13PM +0200, Marcus Karlsson wrote:
> Teach gitk to respect log.showroot.

Sounds reasonable, ...

> -	set cmd [concat | git diff-tree -r $flags $ids]
> +	set cmd [concat | git diff-tree -r]
> +	if {$log_showroot eq true} {
> +	    set cmd [concat $cmd --root]
> +	}
> +	set cmd [concat $cmd $flags $ids]

but is there any reason not to do it like this?

	if {$log_showroot} {
	    lappend flags --root
	}
	set cmd [concat | git diff-tree -r $flags $ids]

I.e., do you particularly want the --root before the other flags?

Paul.
