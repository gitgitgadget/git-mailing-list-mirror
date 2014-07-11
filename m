From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 3/4] hashmap: add simplified hashmap_get_from_hash() API
Date: Fri, 11 Jul 2014 15:21:37 -0700
Message-ID: <xmqq8unz35am.fsf@gitster.dls.corp.google.com>
References: <53B48540.5070600@gmail.com> <53B48613.60509@gmail.com>
	<xmqqk37pdpzb.fsf@gitster.dls.corp.google.com>
	<53C036F7.5070104@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 12 00:21:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5jCP-0000kA-5G
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jul 2014 00:21:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753325AbaGKWVp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2014 18:21:45 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50057 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752137AbaGKWVp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 18:21:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 698EF285F0;
	Fri, 11 Jul 2014 18:21:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lrffMDdKtuYjOF9S/y7/LrONLOU=; b=oWx1YA
	cmGWpep5eYDxaRrhR6HGHL7Qr1F+YVGriFA0EKWBHOLd1fcLmEAzpVk+/aBMgU8c
	ohlC+WWE5NIKfAEEID4R4DBpefN7OxR1w3gIo8xnTPcPd/Nv8zlF0tFMpasbXEci
	w62n9RJBmKcceTKDUTasecMEyrJP1hMKZasJs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Urm9gULFeqwRwnq0w406A0pFKqhlFxJ6
	XLFIQqmArZ9uCvKg/W86QawvOInfSpVmbpcsq30aIsPhlVtf10rFNAUSUn9xXwNZ
	VwLZtZvk2P9j+4jZqOfCOcg/qKUASIKi4t+9smNm7Si6iBFkDlnRRBH8bsHxFWJ/
	HvEU0EUEBuM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 60CD2285EF;
	Fri, 11 Jul 2014 18:21:29 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CD5C3285E6;
	Fri, 11 Jul 2014 18:21:23 -0400 (EDT)
In-Reply-To: <53C036F7.5070104@gmail.com> (Karsten Blees's message of "Fri, 11
	Jul 2014 21:11:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B138B4CE-0949-11E4-AE3E-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253336>

Karsten Blees <karsten.blees@gmail.com> writes:

>> In other words, why isn't hashmap_get() more like this:
>>  ...
>> with hashmap_entry_init() purely a static helper in hashmap.c?
>> 
> 1. Performance

OK.

> 2. Simplicity
>
> Hashmap clients will typically provide small, type safe wrappers around the
> hashmap API.

OK.

> 3. Compound keys
>
> The key doesn't always consist of just a single word. E.g. for struct
> dir_entry, the key is [char *name, int len]. So an API like this:
>
>   void *hashmap_get(const struct hashmap *map, const void *key)
>
> won't do in the general case (unless you require clients to define their
> own key structure in addition to the entry structure...).

Yeah, I was being silly.  Thanks.
