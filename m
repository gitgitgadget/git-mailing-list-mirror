From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 0/6] Improved infrastructure for refname normalization
Date: Sat, 10 Sep 2011 05:31:47 +0200
Message-ID: <4E6ADA23.4010800@alum.mit.edu>
References: <1315568778-3592-1-git-send-email-mhagger@alum.mit.edu> <4E6A1D7D.6050602@gmail.com> <4E6A31D1.5020404@alum.mit.edu> <7vzkidtx81.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitzilla@gmail.com, git@vger.kernel.org, cmn@elego.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 10 05:32:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R2EIj-0002EP-Gn
	for gcvg-git-2@lo.gmane.org; Sat, 10 Sep 2011 05:32:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758627Ab1IJDcI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 23:32:08 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:32832 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751924Ab1IJDcG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2011 23:32:06 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.134] (p54BEAB10.dip.t-dialin.net [84.190.171.16])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p8A3VloF017897
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 10 Sep 2011 05:31:48 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.21) Gecko/20110831 Lightning/1.0b2 Thunderbird/3.1.13
In-Reply-To: <7vzkidtx81.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181136>

On 09/09/2011 07:57 PM, Junio C Hamano wrote:
> By the way, does this series introduce new infrastructure features that
> can be reused in different areas, such as Hui's "alt_odb path
> normalization" patch?

That code is for normalizing filesystem paths, right?

The rules for normalizing filesystem paths are similar to those for
refnames (except maybe for stripping the leading "/").  But the validity
checks are different, and should be kept separate in case some of the
rules need to be tweaked.  Since I put the code for validity checks and
normalization of refnames in a single function, I don't think it makes
sense to share code.

It would be possible to separate the validity checks from the
normalization, but that would require two scans of the refname.  And I
think it should be considered rather an accident that filesystem names
and refnames have similar conventions (even though there is a strong
historical reason for the similarity); they could some day diverge if,
say, we started adding support for Windows-native paths.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
