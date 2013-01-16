From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] Move Git::SVN::get_tz to Git::get_tz_offset
Date: Wed, 16 Jan 2013 07:37:31 -0800
Message-ID: <7vehhlyw90.fsf@alter.siamese.dyndns.org>
References: <1358291405-10173-1-git-send-email-bdwalton@gmail.com>
 <1358291405-10173-2-git-send-email-bdwalton@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: esr@thyrsus.com, git@vger.kernel.org
To: Ben Walton <bdwalton@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 16:38:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvV3q-0005z2-R5
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 16:37:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754888Ab3APPhe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 10:37:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51965 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752688Ab3APPhd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 10:37:33 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 85732AD8F;
	Wed, 16 Jan 2013 10:37:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=J2TdkXN0Zr5JwsuZbWOpCfK61BA=; b=h0HawT
	DRA494cRMtrzqTUwwzB/5ql26Z7pMgKZh8TjnaPlviXs5cdbEIkkQt4fCZUGoyOj
	ZeFUn9IHembGtHomLzYboPNr26lqtmilXcPeHwCK5woZdT4V8rIvjMbosngdhZXv
	LskZYe0kqlmJAx0+gZ4iy460AipX71KrPRIOM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hlK5gQdk0CM3yli9kTn/6LNIDXxs6itC
	066t5lj07vPLOkh+2PLZA3srWHSsnxStESzXaUIkY7/Py4oJGQA69gFZFzE7CYxU
	DLxW4DKqodZ8mmXRRnZQjMp7/P3Pzff+moxJ/PxNSxsU4Zwprb5rQzR3teIuX3c5
	/gghMiEIsC8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7AADFAD8E;
	Wed, 16 Jan 2013 10:37:33 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E82B1AD8C; Wed, 16 Jan 2013
 10:37:32 -0500 (EST)
In-Reply-To: <1358291405-10173-2-git-send-email-bdwalton@gmail.com> (Ben
 Walton's message of "Tue, 15 Jan 2013 23:10:03 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A5013BA6-5FF2-11E2-B26F-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213759>

Ben Walton <bdwalton@gmail.com> writes:

> +sub get_tz_offset {
> +	# some systmes don't handle or mishandle %z, so be creative.

Hmph.  I wonder if we can use %z if it is handled correctly and fall
back to this code only on platforms that are broken?
