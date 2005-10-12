From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] git-fetch --tags: deal with tags with spaces in them.
Date: Wed, 12 Oct 2005 08:36:47 -0700
Message-ID: <434D2D8F.2020407@zytor.com>
References: <46a038f90510062014l7f5740e0l77fc53b50f822e8f@mail.gmail.com>	<46a038f90510082014i6b296f2bvbac56e25344cbdf2@mail.gmail.com>	<4349ED5D.6020703@catalyst.net.nz>	<7v4q7p927d.fsf@assigned-by-dhcp.cox.net>	<7vzmpgznfj.fsf_-_@assigned-by-dhcp.cox.net>	<7virw4zlod.fsf_-_@assigned-by-dhcp.cox.net>	<7vzmpgy4g4.fsf@assigned-by-dhcp.cox.net> <7vk6gjl2uu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"Martin Langhoff (CatalystIT)" <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Wed Oct 12 17:39:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPife-0006gI-H2
	for gcvg-git@gmane.org; Wed, 12 Oct 2005 17:37:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964816AbVJLPhT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Oct 2005 11:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964804AbVJLPhT
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Oct 2005 11:37:19 -0400
Received: from terminus.zytor.com ([192.83.249.54]:9119 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S964816AbVJLPhR
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2005 11:37:17 -0400
Received: from [172.27.0.18] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j9CFamZq007753
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 12 Oct 2005 08:36:49 -0700
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vk6gjl2uu.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.9 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10038>

Junio C Hamano wrote:
> 
> Here is mine.
> 
> I do not personally think it is too much of a restriction if we
> said we only allow tags using letters from [-a-zA-Z0-9.] (yes I
> am trying to be controversial by not allowing even latin-1
> names).  Even without going that far, if we just said we do not
> allow shell metacharacters in tagnames (i.e. assuming UTF-8
> encoded pathnames, non-ascii part of unicode character space is
> allowed), I suspect things will get much simpler to handle.
> 
> The troublesome tags Martin's repository had were autocreated
> with cvsimport.  That is something we could easily fix (I think
> we already do certain tagname munging).
> 

I don't know about this.  Saying we only support ASCII tagnames can be 
quote brutal for non-English-language projects.  Even with the set 
above, we'd at the very least need underscore, and I know of at least 
one project which require # in tagnames.  In short, I don't think we can 
make that decision for people.

We can disallow whitespace, and we *have* to disallow at least newline 
due to the file format; I believe we should disallow all control 
characters (0-31, 127-159.)

	-hpa
