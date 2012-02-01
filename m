From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/2] Factor find_pack_entry()'s core out
Date: Wed, 01 Feb 2012 14:33:34 -0800
Message-ID: <7v1uqe2ngh.fsf@alter.siamese.dyndns.org>
References: <1328010239-29669-1-git-send-email-pclouds@gmail.com>
 <1328104135-475-1-git-send-email-pclouds@gmail.com>
 <alpine.LFD.2.02.1202011056140.2759@xanadu.home>
 <7vaa522oum.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@fluxnic.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmc=?= =?utf-8?B?4buNYw==?= Duy 
	<pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 01 23:33:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsikJ-0005qn-D2
	for gcvg-git-2@plane.gmane.org; Wed, 01 Feb 2012 23:33:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755405Ab2BAWdj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Feb 2012 17:33:39 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53222 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753950Ab2BAWdi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2012 17:33:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C65668BD;
	Wed,  1 Feb 2012 17:33:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+u4lCuWDW7Kbup9BcPpYoTW/01s=; b=sG3btA
	rvf1AkmmQ/QKDb8YJlb9MA/TaWGSBhfIGeXdXOYZuNuvgnN9HAJs7O1dhUyMV+tF
	ZxBq4hYNnHOpWZTdxQj57jh7uybtnlMFFG4MfKiuDMiDJGtk8cJ9I207NE5FNmMM
	HqlVV0jr4GyZ/tsLBBEg8yMVzbBrXWhmVFugU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xekm+xR1VgVHNXlewu69pLeCck1sgNPi
	18eezb5tW/RLoOp1Iz02wqPhyH/mCWWsP1ubJnYd6D/wJKJbjRvoSXuln51GCg+0
	gvqG3tEApoBeM76Ejiy5lfssWnGwpm07VqI4Ov56Mzt+twlOQMhtXgTZkTUspTAC
	OZxzy0mYGes=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 92C9768BC;
	Wed,  1 Feb 2012 17:33:37 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2626C68BB; Wed,  1 Feb 2012
 17:33:37 -0500 (EST)
In-Reply-To: <7vaa522oum.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 01 Feb 2012 14:03:29 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C840B4F2-4D24-11E1-95C1-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189548>

Junio C Hamano <gitster@pobox.com> writes:

> Nicolas Pitre <nico@fluxnic.net> writes:
>
>>> +static int find_pack_entry_1(const unsigned char *sha1,
>>> +			     struct packed_git *p, struct pack_entry *e)
>>
>> This looks all goot but the name.  Pretty please, try to find something 
>> that is more descriptive than "1".  Suggestions: 
>> "find_pack_entry_lookup", "find_pack_entry_inner", etc.
>
> Perhaps "find_pack_entry_in_pack(sha1, e, p)"?
> That would go well with the caller "find_pack_entry(sha1, e)".

I amended 1/2 (and adjusted 2/2 to match) to call it fill_pack_entry.
Will push out the result tonight.
