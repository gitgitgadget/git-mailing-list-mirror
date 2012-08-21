From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] git-svn.perl: consider all ranges for a given merge,
 instead of only tip-by-tip
Date: Tue, 21 Aug 2012 15:38:35 -0700
Message-ID: <7vobm3c1lg.fsf@alter.siamese.dyndns.org>
References: <20120819193356.GA6203@dcvr.yhbt.net>
 <1345426781-7754-1-git-send-email-stevenrwalter@gmail.com>
 <20120821220556.GA5848@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Walter <stevenrwalter@gmail.com>, sam@vilain.net,
	avarab@gmail.com, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Aug 22 00:38:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3x5x-00019U-HS
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 00:38:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174Ab2HUWik (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Aug 2012 18:38:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35507 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751069Ab2HUWii (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2012 18:38:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 902E2931D;
	Tue, 21 Aug 2012 18:38:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0Roe7SdgOfn9OqjzkdH/FS7MgBs=; b=c5B2O2
	XDc9inq8cNLy9soZQeUeoeZMaPfBVwinQJ+VTOuYALRqYQK2H6f6zy5v7PgAImBR
	hRT/nt1faqV3+lQRdM2971sGCqXmmJ5aUcyeeUhY4TYp7xITtW+S9oDKTXI7REnx
	WkosYiUwDGxA3PaR0CdukTRN/3tBR8hl1rUSg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qQFw5xaoT4x8ldLq9+Ki2KgR/Dm/yd9P
	92jjI0hq04XeiBVvqU4w9krHtfqZh2YO9AiwuC54axDpmIwsmZkdSHQp81C1Qpzl
	psbKhLFvB+K0uHyABu4oUHaOGDKFFQi8XQBIPAlBSb+iYBpta85UnkEtZW/YgJa3
	/44Rs2B78Eo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7D1DC931C;
	Tue, 21 Aug 2012 18:38:37 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EEED7931B; Tue, 21 Aug 2012
 18:38:36 -0400 (EDT)
In-Reply-To: <20120821220556.GA5848@dcvr.yhbt.net> (Eric Wong's message of
 "Tue, 21 Aug 2012 22:05:56 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F2671C0C-EBE0-11E1-93E1-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204002>

Eric Wong <normalperson@yhbt.net> writes:

> Steven Walter <stevenrwalter@gmail.com> wrote:
>> Consider the case where you have trunk, branch1 of trunk, and branch2 of
>> branch1.  trunk is merged back into branch2, and then branch2 is
>> reintegrated into trunk.  The merge of branch2 into trunk will have
>> svn:mergeinfo property references to both branch1 and branch2.  When
>> git-svn fetches the commit that merges branch2 (check_cherry_pick),
>> it is necessary to eliminate the merged contents of branch1 as well as
>> branch2, or else the merge will be incorrectly ignored as a cherry-pick.
>> 
>> Signed-off-by: Steven Walter <stevenrwalter@gmail.com>
>
> Thanks, I've Signed-off (also added Sam's Reviewed-by) and
> pushed to "for-git-master" on git://bogomips.org/git-svn
>
> (Will wait on a few other patches before asking Junio to pull)

If there are stuff that should go to 1.7.12 maintenance track,
please separate them from new features and risky improvements.

Thanks.
