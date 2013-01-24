From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: Honor multi-part email messages
Date: Thu, 24 Jan 2013 11:11:55 -0800
Message-ID: <7vr4labdl0.fsf@alter.siamese.dyndns.org>
References: <1316507347-6693-1-git-send-email-zapped@mail.ru>
 <7v1uvb6mn9.fsf@alter.siamese.dyndns.org> <20110921001925.03a83d3a@zappedws>
 <20130124143816.7c33fc1c@ashu.dyn1.rarus.ru>
 <7v622mcuyb.fsf@alter.siamese.dyndns.org>
 <CAEFUfsE-Ca=4jAyoaCtoeVYX0Etsn2Cj42OJm+nu4042JPJaBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Shumkin Alexey <alex.crezoff@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 24 20:12:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TySDk-0003eA-RA
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 20:12:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754939Ab3AXTL7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2013 14:11:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47156 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751893Ab3AXTL6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 14:11:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 42CACBF13;
	Thu, 24 Jan 2013 14:11:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wgKza7dwiJPaM7w4ESCXIHMA20s=; b=rUSJx0
	Y2vjJ2Gw8oA9+BAewX64LtQf+diZCscrmKsc4/ehAr6Smfxs3IaW36tZ4w4wtG+n
	Av4XcCULuWYyRT3f62MKv8AL3QLx2+Qm8Pzae+Kgb74AXHv9T/XyKJntO/lapaJ6
	dwTsOyYif00OSqyrLzf+XlVHbCd2R1NoqIdVI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rXpnfsHfBdul4Vmr9jRL41El6BiGRwhV
	S5H251BdPSYvDIGSb4rrm0OLy6OE9SKXCpyUcM+5ruI4gAm9pOYph+iuJXNEwJ6/
	xTYiOtH28xhKmDutmMfkLpzobgNNJfKWls0uRNz3/nkDxiBYlbG4qtMljYuCbNwH
	UiKRji7EJVs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 32D93BF11;
	Thu, 24 Jan 2013 14:11:57 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A5329BF0F; Thu, 24 Jan 2013
 14:11:56 -0500 (EST)
In-Reply-To: <CAEFUfsE-Ca=4jAyoaCtoeVYX0Etsn2Cj42OJm+nu4042JPJaBg@mail.gmail.com> (Shumkin
 Alexey's message of "Thu, 24 Jan 2013 22:31:46 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EBAFFCC8-6659-11E2-91FE-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214440>

Shumkin Alexey <alex.crezoff@gmail.com> writes:

> I've meant you did not reply to my last message in this thread
> http://thread.gmane.org/gmane.comp.version-control.git/181791

Please repost the patch (with possible updates) for review when
attempting to resurrect an ancient topic, instead of forcing people
to hunt for an ancient message.

I think your patch is wrong.  What happens when we see a Subject:
line with a non-ascii on it that causes an early return of the loop
before your new code has a chance to see Content-Type: header?
