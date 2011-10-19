From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [RFC 04/13] add_ref(): move the call of check_refname_format()
 to callers
Date: Wed, 19 Oct 2011 23:59:19 +0200
Message-ID: <4E9F4837.5070108@alum.mit.edu>
References: <1319057716-28094-1-git-send-email-mhagger@alum.mit.edu> <1319057716-28094-5-git-send-email-mhagger@alum.mit.edu> <7vsjmobqim.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, cmn@elego.de,
	A Large Angry SCM <gitzilla@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 19 23:59:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGeAs-0006Ig-9s
	for gcvg-git-2@lo.gmane.org; Wed, 19 Oct 2011 23:59:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754810Ab1JSV7m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Oct 2011 17:59:42 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:36382 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754775Ab1JSV7l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2011 17:59:41 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p9JLxKiB013658
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 19 Oct 2011 23:59:20 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 Thunderbird/3.1.15
In-Reply-To: <7vsjmobqim.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183986>

On 10/19/2011 11:49 PM, Junio C Hamano wrote:
> mhagger@alum.mit.edu writes:
>> I'm still not clear on how extra_refs are used.  Are they generated
>> from local refs or are they generated from remote refs?  If the
>> latter, then it is probably irresponsible not to do *some* sanity
>> checking in add_extra_ref() to prevent any chance of refnames like
>> "../../../etc/passwd".
> 
> No, add_extra_ref() already tells us what their values are, these are
> never used to actually read from filesystem. Their refname field has
> almost no value other than for debugging and we probably shouldn't even
> insist on uniqueness among extra refs or for that matter collision with
> the real refs. [...]

Thanks for the explanation.  I'm inspired to separate them a little bit
more from "real" refs because they are such a special case.  For
example, maybe it would make sense to add a function
for_each_extra_ref() to avoid having to mix them with real refs in the
iteration.  OTOH not important AFAICS.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
