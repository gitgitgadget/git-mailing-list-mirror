From: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] parse_date(): fix parsing 03/10/2006
Date: Tue, 4 Apr 2006 23:16:06 -0700
Message-ID: <20060404231606.219a4cc5.akpm@osdl.org>
References: <7vodzg4l5n.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, len.brown@intel.com
X-From: git-owner@vger.kernel.org Wed Apr 05 08:17:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FR1KR-00005A-DC
	for gcvg-git@gmane.org; Wed, 05 Apr 2006 08:17:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbWDEGRI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Apr 2006 02:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbWDEGRI
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Apr 2006 02:17:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61070 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751103AbWDEGRH (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Apr 2006 02:17:07 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k356H3tH006786
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 4 Apr 2006 23:17:03 -0700
Received: from bix (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id k356H2fl027463;
	Tue, 4 Apr 2006 23:17:03 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vodzg4l5n.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18415>

Junio C Hamano <junkio@cox.net> wrote:
>
> The comment associated with the date parsing code for three
>  numbers separated with slashes or dashes implied we wanted to
>  interpret using this order:
> 
>  	yyyy-mm-dd
>  	yyyy-dd-mm
>  	mm-dd-yy
>  	dd-mm-yy
> 
>  However, the actual code had the last two wrong, and making it
>  prefer dd-mm-yy format over mm-dd-yy.

But there was a second problem.  Once the parsing had misbehaved, Len
managed to create a commit which was six months in the future:

commit 8313524a0d466f451a62709aaedf988d8257b21c
Author: Bob Moore <robert.moore@intel.com>
Date:   Tue Oct 3 00:00:00 2006 -0400

    ACPI: ACPICA 20060310

Will your fix prevent that from happening?  If not, perhaps some basic
sanity checking might be appropriate.
