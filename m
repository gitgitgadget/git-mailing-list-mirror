From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH (GITK) v2 3/4] gitk: Support filenames in the locale encoding.
Date: Fri, 10 Oct 2008 22:21:16 +1100
Message-ID: <18671.15020.13951.943822@cargo.ozlabs.ibm.com>
References: <1222772422-28020-1-git-send-email-angavrilov@gmail.com>
	<1222772422-28020-2-git-send-email-angavrilov@gmail.com>
	<1222772422-28020-3-git-send-email-angavrilov@gmail.com>
	<1222772422-28020-4-git-send-email-angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 10 13:24:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KoG6g-0002Mu-Dk
	for gcvg-git-2@gmane.org; Fri, 10 Oct 2008 13:24:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753019AbYJJLXQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Oct 2008 07:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753097AbYJJLXP
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Oct 2008 07:23:15 -0400
Received: from ozlabs.org ([203.10.76.45]:53822 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752903AbYJJLXO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Oct 2008 07:23:14 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 0C226DDF25; Fri, 10 Oct 2008 22:23:13 +1100 (EST)
In-Reply-To: <1222772422-28020-4-git-send-email-angavrilov@gmail.com>
X-Mailer: VM 8.0.9 under Emacs 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97926>

Alexander Gavrilov writes:

> The previous patch changed the encoding used for
> reading diffs to binary, which broke non-ASCII filename
> support. This one fixes the breakage, together with some
> existing bugs related to filename encoding.

Sounds like this patch should be combined with the previous one.

> @@ -6250,11 +6250,12 @@ proc gettreeline {gtf id} {
>  	    set line [string range $line 0 [expr {$i-1}]]
>  	    if {$diffids ne $nullid2 && [lindex $line 1] ne "blob"} continue
>  	    set sha1 [lindex $line 2]
> -	    if {[string index $fname 0] eq "\""} {
> -		set fname [lindex $fname 0]
> -	    }
>  	    lappend treeidlist($id) $sha1
>  	}
> +	if {[string index $fname 0] eq "\""} {
> +	    set fname [lindex $fname 0]
> +	}

Concerning this part of the change, do we know whether git ls-files
will quote filenames containing special characters or not?

Paul.
