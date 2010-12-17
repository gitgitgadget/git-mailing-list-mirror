From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Performance issue exposed by git-filter-branch
Date: Fri, 17 Dec 2010 02:54:12 +0100
Message-ID: <201012170254.13005.trast@student.ethz.ch>
References: <41C1B4AC-8427-4D62-BEB6-689A4BE4EE5B@irridia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Ken Brownfield <krb@irridia.com>
X-From: git-owner@vger.kernel.org Fri Dec 17 02:54:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTPWW-0002GK-T1
	for gcvg-git-2@lo.gmane.org; Fri, 17 Dec 2010 02:54:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751867Ab0LQByQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Dec 2010 20:54:16 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:33513 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751114Ab0LQByP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Dec 2010 20:54:15 -0500
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.218.12; Fri, 17 Dec
 2010 02:54:13 +0100
Received: from pctrast.inf.ethz.ch (84.74.105.24) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.218.12; Fri, 17 Dec
 2010 02:54:13 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.37-rc5-16-desktop; KDE/4.5.3; x86_64; ; )
In-Reply-To: <41C1B4AC-8427-4D62-BEB6-689A4BE4EE5B@irridia.com>
X-Originating-IP: [84.74.105.24]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163850>

Ken Brownfield wrote:
> git filter-branch --index-filter 'git rm -r --cached --ignore-unmatch -- bigdirtree stuff/a stuff/b stuff/c stuff/dir/{a,b,c}' --prune-empty --tag-name-filter cat -- --all
[...]
> Now that the same repository has grown, this same filter-branch
> process now takes 6.5 *days* at 100% CPU on the same machine (2x4
> Xeon, x86_64) on git-1.7.3.2.  There's no I/O, memory, or other
> resource contention.

If all you do is an index-filter for deletion, I think it should be
rather easy to achieve good results by filtering the fast-export
stream to remove these files, and then piping that back to
fast-import.

(It's just that AFAIK nobody has written that code yet.)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
