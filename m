From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] xdiff: load full words in the inner loop of
 xdl_hash_record
Date: Mon, 12 Mar 2012 11:26:46 -0700
Message-ID: <7vmx7lsmjd.fsf@alter.siamese.dyndns.org>
References: <1e11b1466ea3209cfe74e1dd8dff45f8666e942b.1331564754.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Mar 12 19:26:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S79xQ-0000Ha-K7
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 19:26:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756177Ab2CLS0v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 14:26:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55514 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755847Ab2CLS0u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 14:26:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7B3776CF1;
	Mon, 12 Mar 2012 14:26:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=G3OwmlY3WnU2BRv7zBW18KYRSbM=; b=G7zTdt
	O+x8lJ7UOZmcUAsWOpE6K9pRQ5ZN3CKCSkPxflbweJ0yXQhJEG6+t7mdyjdgKK1J
	tFUmV+xzWCoHnEpDp7lfhA276amV1Ot88x3JJs71nJr0MG3CjUX+V03Nooo54ixx
	MmXgRpnqLz3C5KhDGF1bYkvB199Wzx1EEfzfM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=d5cldYp27ehdHaiwX0SZdHEapTR7LoSD
	ZmPvE8VCfu4s6vdF3hAJ7fgKn7jeVjdc6JueUvnbh88HO0IvyipcFUHNcOEBqvf1
	Ls67tfK+MPLFOogC2Rhkz6s9MKTPScrL+DZ6EDB19TSPflDxVasTzE/i7T2wR4bS
	wFTAQzmlJuQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7251B6CF0;
	Mon, 12 Mar 2012 14:26:49 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0B1426CEF; Mon, 12 Mar 2012
 14:26:48 -0400 (EDT)
In-Reply-To: <1e11b1466ea3209cfe74e1dd8dff45f8666e942b.1331564754.git.trast@student.ethz.ch> (Thomas Rast's message of "Mon, 12 Mar 2012 16:10:13 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EE743FA2-6C70-11E1-B858-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192918>

Thomas Rast <trast@student.ethz.ch> writes:

> Also definitely post-v1.7.10 material, but I figure many people will
> be interested.  Since it's such a central part of much of git, it's
> also quite important that it gets tested heavily.

I am interested but this is a material not beyond 'pu'.  Until it
learns to be nice on platforms that do not like unaligned accesses
or use big endian, that is.

Thanks for a fun read, though.
