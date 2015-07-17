From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH] Fix detection of uname failure
Date: Fri, 17 Jul 2015 18:01:42 +0100
Message-ID: <20150717170142.GA9616@hashpling.org>
References: <1437135095-6244-1-git-send-email-charles@hashpling.org>
 <ef7d56584c3b5d6431f895df1d94eba8@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 17 19:01:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZG91E-0000zB-Dn
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jul 2015 19:01:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755005AbbGQRBs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2015 13:01:48 -0400
Received: from avasout05.plus.net ([84.93.230.250]:57846 "EHLO
	avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752454AbbGQRBr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2015 13:01:47 -0400
Received: from hashpling.plus.com ([212.159.69.125])
	by avasout05 with smtp
	id tV1i1q0062iA9hg01V1jWA; Fri, 17 Jul 2015 18:01:44 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=FZvKv8K6 c=1 sm=1 tr=0
 a=wpJ/2au8Z6V/NgdivHIBow==:117 a=wpJ/2au8Z6V/NgdivHIBow==:17 a=EBOSESyhAAAA:8
 a=0Bzu9jTXAAAA:8 a=Ew9TdX-QAAAA:8 a=yEdEr6MRgwAA:10 a=kj9zAlcOel0A:10
 a=zOBTXjUuO1YA:10 a=FygwMpgOUyCzh_P2Mt0A:9 a=CjuIK1q_8ugA:10
Received: from charles by hashpling.plus.com with local (Exim 4.84)
	(envelope-from <charles@hashpling.plus.com>)
	id 1ZG914-0002XL-Or; Fri, 17 Jul 2015 18:01:42 +0100
Content-Disposition: inline
In-Reply-To: <ef7d56584c3b5d6431f895df1d94eba8@www.dscho.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274082>

On Fri, Jul 17, 2015 at 03:06:57PM +0200, Johannes Schindelin wrote:
> 
> From a quick `git grep '== -1'` and another quick `git grep '< 0'` it appears to me that we prefer the latter. Maybe you want to adjust it in the patch, too?

I did the same grep and found lots of examples of both. Many of the "<
0" applied to comparisons with variables and not API calls and many were
internal (to git) calls and not POSIX or C library calls so I wasn't
convinced to change my initial fix.

Having said that and thought about it some more, I think '< 0' is
probably better. In POSIX, we shouldn't ever get a negative value which
isn't -1, but if we ever do it is probably safer to fail. I'll send and
update.

Charles.
