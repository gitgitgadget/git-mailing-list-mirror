From: Frans Pop <elendil@planet.nl>
Subject: Re: Testing if a certain commit is in the current branch
Date: Wed, 27 Jan 2010 09:36:14 +0100
Message-ID: <201001270936.14935.elendil@planet.nl>
References: <201001270819.39819.elendil@planet.nl> <7viqaorowo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 09:36:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Na3O5-00035Q-DW
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 09:36:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751854Ab0A0IgR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 03:36:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751801Ab0A0IgQ
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 03:36:16 -0500
Received: from Cpsmtpm-eml109.kpnxchange.com ([195.121.3.13]:49617 "EHLO
	CPSMTPM-EML109.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751728Ab0A0IgQ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jan 2010 03:36:16 -0500
Received: from aragorn.fjphome.nl ([77.166.180.99]) by CPSMTPM-EML109.kpnxchange.com with Microsoft SMTPSVC(7.0.6001.18000);
	 Wed, 27 Jan 2010 09:36:15 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <7viqaorowo.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
X-OriginalArrivalTime: 27 Jan 2010 08:36:15.0456 (UTC) FILETIME=[C9FAFE00:01CA9F2B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138115>

On Wednesday 27 January 2010, Junio C Hamano wrote:
> Frans Pop <elendil@planet.nl> writes:
> > I'm currently using the following command for this:
> >    git log --pretty=format:%H | grep -q "^<commit id>"
> >
> > Problem is that with large repos that can be quite slow.
> >
> > Is there a faster way to do the test?
>
> test "$(git merge-base HEAD $commit)" = "$(git rev-parse $commit)"

Great! If the commit ID is not present that only takes 1 sec versus 11 secs 
for my test. (If the commit _is_ present and fairly recent my test can be 
faster, but 11 secs delay when it's not present hurts more.)

> But this is a literal answer that could be a less than optimal solution
> if you are having an XY problem.

The use case is a wrapper script for kernel builds in which some variation 
are needed (due to changes in the build system) when building older 
kernels, e.g. during bisections or when building older stable updates.
So I test for the presence of commits that introduced relevant changes.

Thanks again,
FJP
