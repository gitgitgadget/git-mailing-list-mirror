From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 07/32] hold_lock_file_for_append(): release lock on errors
Date: Tue, 09 Sep 2014 15:41:02 -0700
Message-ID: <xmqqiokwifi9.fsf@gitster.dls.corp.google.com>
References: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
	<1409989846-22401-8-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Sep 10 00:41:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRU65-0000X4-A0
	for gcvg-git-2@plane.gmane.org; Wed, 10 Sep 2014 00:41:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752769AbaIIWlI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2014 18:41:08 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58717 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752151AbaIIWlH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2014 18:41:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BF19839745;
	Tue,  9 Sep 2014 18:41:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LUT8GgnAT0Vs8hFrKRw5HP1GdEE=; b=uDSy3d
	KMhh0lZNhtclyIlHDoFsloeyCjNmdYqxQDhraShatCznyU0RSbGhK3ZcCuW1BcTc
	1Lmdt93BgMuCPTESzzcod8Bi3u0QDpGG+n8/lcxyNexpml2Jx73slxDqlzp+KDKG
	b1MvVGOhJsPtWuVZ2EMTEg9oy4k1+YWOxdx8s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RJ91nzsdRIxANDDMND8U5tnn0xClXFtk
	o6oB/mP5qlVFEE51fpAHLMvwgyLL2Mp/ck9A5gnzOYKMRncPmNbb4IH34usD42lM
	CEilh3ovDbgJ+ds5TglWfhaKqgvZBYZORrFKlZN1ZP6jyoQu3x40nq6q8yojIrik
	ZFMKh5BwqIk=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B6A4439744;
	Tue,  9 Sep 2014 18:41:06 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id ADA6339742;
	Tue,  9 Sep 2014 18:41:04 -0400 (EDT)
In-Reply-To: <1409989846-22401-8-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Sat, 6 Sep 2014 09:50:21 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 61DCC76E-3872-11E4-84CF-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256722>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> If there is an error copying the old contents to the lockfile, roll
> back the lockfile before exiting so that the lockfile is not held
> until process cleanup.

Same comment as 06/32 applies here.
