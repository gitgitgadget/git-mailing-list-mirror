From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCHv2 1/4] refs: add common refname_match_patterns()
Date: Mon, 13 Feb 2012 06:00:40 +0100
Message-ID: <4F3898F8.2000201@alum.mit.edu>
References: <1328926618-17167-1-git-send-email-tmgrennan@gmail.com> <1328926618-17167-2-git-send-email-tmgrennan@gmail.com> <4F3614F6.2000106@alum.mit.edu> <20120211191748.GC4903@tgrennan-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: pclouds@gmail.com, git@vger.kernel.org, gitster@pobox.com,
	jasampler@gmail.com
To: Tom Grennan <tmgrennan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 13 06:00:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rwo22-0005tx-Jz
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 06:00:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952Ab2BMFAq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Feb 2012 00:00:46 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:39387 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750873Ab2BMFAp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2012 00:00:45 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.134] (p54BEA12C.dip.t-dialin.net [84.190.161.44])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q1D50eXC026391
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 13 Feb 2012 06:00:41 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.26) Gecko/20120131 Lightning/1.0b2 Thunderbird/3.1.18
In-Reply-To: <20120211191748.GC4903@tgrennan-laptop>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190606>

On 02/11/2012 08:17 PM, Tom Grennan wrote:
> Yes, I didn't explicitly state that the precedence is the order written
> and in correctly described the first case. How about?
> 
> /**
>  * Returns in highest to lowest precedence:
>  *   1 with an empty patterns list
>  *   0 if refname fnmatch()es any ^ prefaced pattern
>  *   1 if refname fnmatch()es any other pattern
>  *   0 otherwise
>  */

Much better; thanks.

Please note that this choice of semantics limits its power.  For
example, if the rule were instead (like with gitattributes(5)) "if more
than one pattern matches a refname, a later pattern overrides an earlier
pattern", then one could do things like

    refs/remotes/*/* !refs/remotes/gitster/* refs/remotes/gitster/master

to include specific references within a hierarchy that is otherwise
excluded.

However, since rev-list apparently uses a rule more like the one that
you are proposing, it might be better to be consistent than to choose a
different convention.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
