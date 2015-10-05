From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 38/43] refs: make some files backend functions public
Date: Mon, 05 Oct 2015 11:03:31 +0200
Message-ID: <56123CE3.9070909@alum.mit.edu>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com> <1443477738-32023-39-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 05 11:03:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zj1gK-0002Xz-1i
	for gcvg-git-2@plane.gmane.org; Mon, 05 Oct 2015 11:03:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751963AbbJEJDf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2015 05:03:35 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:54115 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751816AbbJEJDe (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Oct 2015 05:03:34 -0400
X-AuditID: 1207440e-f79516d0000012b3-6c-56123ce5f654
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id A2.77.04787.5EC32165; Mon,  5 Oct 2015 05:03:33 -0400 (EDT)
Received: from [192.168.69.130] (p4FC96E0C.dip0.t-ipconnect.de [79.201.110.12])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t9593VaA001661
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 5 Oct 2015 05:03:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <1443477738-32023-39-git-send-email-dturner@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkleLIzCtJLcpLzFFi42IRYndR1H1qIxRmsG6mnMX8TScYLbqudDM5
	MHkseH6f3ePzJrkApihum6TEkrLgzPQ8fbsE7oyvtx4wFTSxVWy4Np+tgfElSxcjJ4eEgInE
	xosNTBC2mMSFe+vZuhi5OIQELjNK/Ho1lR3COcck0bzrAVgHr4C2xKZJW9hAbBYBVYljk96C
	xdkEdCUW9TSDTRIVCJJYsfwFI0S9oMTJmU/AakQEHCQu7zrKDGILC/hIdK16A7WgjVGiedpq
	VpAEp4CXxP6Gv2ANzAJ6Ejuu/2KFsOUltr+dwzyBkX8WkrmzkJTNQlK2gJF5FaNcYk5prm5u
	YmZOcWqybnFyYl5eapGusV5uZoleakrpJkZIUPLtYGxfL3OIUYCDUYmH90C8YJgQa2JZcWXu
	IUZJDiYlUd5aHaEwIb6k/JTKjMTijPii0pzU4kOMEhzMSiK8r8yAcrwpiZVVqUX5MClpDhYl
	cV61Jep+QgLpiSWp2ampBalFMFkZDg4lCV5za6BGwaLU9NSKtMycEoQ0EwcnyHAuKZHi1LyU
	1KLE0pKMeFBUxhcD4xIkxQO0d5EVyN7igsRcoChE6ylGXY4FP26vZRJiycvPS5US5+UC2SEA
	UpRRmge3ApaCXjGKA30szOsEUsUDTF9wk14BLWECWtIvD7akJBEhJdXAuPrNn6MZ88rMN1vn
	7O1gVF8RrH3+scm8MwmXF/gXZ1/2WJtm+Vkn40EOU/+iXI8pnJqScld6JnV3LutmXvPC8opK
	8t3rxvf36n4yPfxCl/XCJ/ZXV55/XGeWOZvXZ6P8zbBtBwouBHwvXa5RHFD9oXPX 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279051>

On 09/29/2015 12:02 AM, David Turner wrote:
> Because HEAD and stash are per-worktree, other backends need to
> go through the files backend to manage these refs and their reflogs.
> 
> To enable this, we make some files backend functions public.

I have a bad feeling about this change.

Naively I would expect a reference backend that cannot handle its own
(e.g.) stash to instantiate internally a files backend object and to
delegate stash-related calls to that object. That way neither class's
interface has to be changed.

Here you are adding a separate interface to the files backend. That
seems like a more complicated and less flexible design. But I'm open to
be persuaded otherwise...

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
