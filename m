From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 11/11] walker.c: use ref transaction for ref updates
Date: Mon, 21 Apr 2014 14:26:24 -0700
Message-ID: <xmqqioq28jcv.fsf@gitster.dls.corp.google.com>
References: <1397763987-4453-1-git-send-email-sahlberg@google.com>
	<1397763987-4453-12-git-send-email-sahlberg@google.com>
	<5352D31A.6000107@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Apr 21 23:26:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcLjf-0003WR-2X
	for gcvg-git-2@plane.gmane.org; Mon, 21 Apr 2014 23:26:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754609AbaDUV0e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2014 17:26:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58352 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754434AbaDUV03 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2014 17:26:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BC7FC7F3A6;
	Mon, 21 Apr 2014 17:26:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1byjp9k5QdCScXIthYPgjBDEcXU=; b=hWBB2d
	052pKrlweyujbDmh2JFAzQ40Cd86Dl/ezEfw7qWo1vs6hL3vQ+mGUlEoX9Sbv5LT
	5spS2/TGvDJDCFbjG/0fS7KRmBuF3tpJJl/hDNhY+S7EttQdRQCQwCwig3TC6SVK
	gjUmDjuoDvJ+NceDsUGOXnAvg/zOLrk9N23ik=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=l311RqZbicx07jWZ71ABjrDf/cZ9ea+v
	hpmAsmuw8YTAsoE82nV6Og3mW3AlGXGXfh/9XzBC5nASsVfHQ2Zfeshylxtle2jz
	e0VRtSKf0i6UNPfb5ak2O3K5hwJhQn8qYw3ueS3auXWGbONGCej4O4y4jJtkSIJi
	AndW563yqN4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A52F37F3A5;
	Mon, 21 Apr 2014 17:26:28 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 010147F3A2;
	Mon, 21 Apr 2014 17:26:25 -0400 (EDT)
In-Reply-To: <5352D31A.6000107@alum.mit.edu> (Michael Haggerty's message of
	"Sat, 19 Apr 2014 21:48:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 981F477A-C99B-11E3-82F2-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246646>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 04/17/2014 09:46 PM, Ronnie Sahlberg wrote:
>> Switch to using ref transactions in walker_fetch(). As part of the refactoring
>> to use ref transactions we also fix a potential memory leak where in the
>> original code if write_ref_sha1() would fail we would end up returning from
>> the function without free()ing the msg string.
> ...
> Aside from my other comments, patches 01-10 in the series looked fine.
> Thanks!

Thanks, both.

When this is queued on 'pu', it appears that t5550 breaks.  I had to
futz with conflicts with the lockfile topic, so a botched conflict
resolution might be a cause for the breakage, though.
