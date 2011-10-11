From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 0/7] Provide API to invalidate refs cache
Date: Tue, 11 Oct 2011 07:50:42 +0200
Message-ID: <4E93D932.6020001@alum.mit.edu>
References: <1318225574-18785-1-git-send-email-mhagger@alum.mit.edu> <1318235064-25915-1-git-send-email-mhagger@alum.mit.edu> <7vty7ggzum.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Martin Fick <mfick@codeaurora.org>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 11 07:51:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDVFR-0007Qu-Bi
	for gcvg-git-2@lo.gmane.org; Tue, 11 Oct 2011 07:51:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751902Ab1JKFvQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Oct 2011 01:51:16 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:38370 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851Ab1JKFvO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Oct 2011 01:51:14 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p9B5oh3e018007
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 11 Oct 2011 07:50:43 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 Thunderbird/3.1.15
In-Reply-To: <7vty7ggzum.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183282>

On 10/11/2011 02:02 AM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
>> These patches apply on top of mh/iterate-refs, which is in next but
>> not in master.
> 
> Building your series on mh/iterate-refs would unfortunately make the
> conflict resolution worse. It would have been better if this were based on
> a merge between mh/iterate-refs and jp/get-ref-dir-unsorted (which already
> has happened on 'master' as of fifteen minutes ago).

AAAAaaaarrrgghh did that really have to happen?!?

> I could rebase your series, but it always is more error prone to have
> somebody who is not the original author rebase a series than the original
> author build for the intended base tree from the beginning.

I don't mind rebasing this little series on jp/get-ref-dir-unsorted.
But it's going to be an utter nightmare (as in, "can I even muster the
energy to do so much pointless work") to rebase my much bigger
hierarchical-refs series [1] onto jp/get-ref-dir-unsorted.  The latter
makes changes all over refs.c and changes several things at once
(separate ref_entry out of ref_list, change current_ref to a ref_entry*,
rename ref_list to ref_array, change data structure to array plus
rewrite all loops, change to binary search).  And
jp/get-ref-dir-unsorted includes a change that was inspired by my patch
series [2], so it is not like jp/get-ref-dir-unsorted was developed in
complete isolation from hierarchical-refs.

And this rebase will be work with no benefit, because my series includes
all of the improvements of jp/get-ref-dir-unsorted plus much more.  But
my change to the data structure is implemented in a different order and
following other improvements.  For example, I add a lot of comments,
change a lot of code to use the cached_refs data structure more
consistently, and accommodate partly-sorted lists by the time my patch
series includes everything that is in jp/get-ref-dir-unsorted.

Rebasing 78 patches is going to be a morass of clerical work.  Is there
any alternative?

Michael

PS: I see that some confusion might have been caused by one of my emails
[3], where I mistakenly approved of the merge of jp/get-ref-dir-unsorted
(meaning the "Don't sort ref_list too early" part) just before asking
that jp/get-ref-dir-unsorted not be merged (meaning the rest).  So maybe
I brought this whole mess down on my own head :-(

[1] branch hierarchical-refs on git://github.com/mhagger/git.git
[2] http://marc.info/?l=git&m=131740585620461&w=2
[3] http://marc.info/?l=git&m=131753257824405&w=2

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
