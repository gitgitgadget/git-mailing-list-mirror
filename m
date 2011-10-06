From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Add multiple workdir support to branch/checkout
Date: Wed, 05 Oct 2011 18:15:06 -0700
Message-ID: <7v62k253ad.fsf@alter.siamese.dyndns.org>
References: <1317786204-57335-1-git-send-email-jaysoffian@gmail.com>
 <CACsJy8AqYq+YF+rvUp=BBeFUAtUz783iF2jbUp3fO58yLp9ptQ@mail.gmail.com>
 <CAG+J_DygQTD5ibco=-NOiKg0BLgBGFJnvV8zPyhngC2iZv_H8g@mail.gmail.com>
 <7vpqib8jzk.fsf@alter.siamese.dyndns.org>
 <CAG+J_Dz-GXvRbYUXSoyfyHfOO-_BszcOza9x=ysHhmL5YBW-Jw@mail.gmail.com>
 <7vzkhf713u.fsf@alter.siamese.dyndns.org>
 <CACsJy8BHeZZqsOP_+OSPfrPdkYgKQe3LgaGfo3bERD+hWT7U0g@mail.gmail.com>
 <7vaa9f59p5.fsf@alter.siamese.dyndns.org>
 <CACsJy8D5FGr3R0tLYOND0kKNct4e_KgYfLUK8xL2Q4uNzWczgQ@mail.gmail.com>
 <7vwrcj3sow.fsf@alter.siamese.dyndns.org>
 <CAG+J_DzZrFx2v09zNxKm2xyA82MyKRTq3AEus3QthtpZYhQn0A@mail.gmail.com>
 <7vsjn73q6j.fsf@alter.siamese.dyndns.org>
 <CAG+J_DxXcvF3tBPkf7ZEtiXvEK80zYJvP1rNx-PagM8TV-1KSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 06 03:15:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBcYW-0002Fk-8k
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 03:15:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935112Ab1JFBPL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Oct 2011 21:15:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59162 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754832Ab1JFBPJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2011 21:15:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DAFE85306;
	Wed,  5 Oct 2011 21:15:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ImzWwLngpx3iTzAdOkBmb8t07Ec=; b=PgDyMC
	DHa61Nqwc/6UiQXkV4nmAZWpipryH65DnK+vzwnfeReSqZ/XXqD9+ceL4huSwLGw
	iNbF6GddVa4q81VPIBDkn/NlAHwAFrUS0IeBkH9vc/Uf58faGN94FmoSTKLN3AFX
	ZgYepTgkZAaVg1zPQCuFzWYuxEkEZ4QJkvMgo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NiXp+Gj6XnRyMsSsIqkMq7pwQ24Hoklp
	tJDirX40n9uq3xLHE+nNdzFz+4ZDCQz6FWeSAZqv6JDl/LPxe6LO2Pknl1TBurOz
	zdrGEswKbokUTI4qtvQbIg6AG9hFW+WhTQURg5uxEBGUb1CbrMjozuqz+pXS/BxA
	GrLPD1ZSAU4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D32095305;
	Wed,  5 Oct 2011 21:15:08 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 694805304; Wed,  5 Oct 2011
 21:15:08 -0400 (EDT)
In-Reply-To: <CAG+J_DxXcvF3tBPkf7ZEtiXvEK80zYJvP1rNx-PagM8TV-1KSA@mail.gmail.com> (Jay
 Soffian's message of "Wed, 5 Oct 2011 20:57:35 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A18BA78C-EFB8-11E0-AFAB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182914>

Jay Soffian <jaysoffian@gmail.com> writes:

> So you're envisioning this?
>
>   $ git commit foo.c
>   Warning, master is also checked out in workdir2

No. I would rather think it needs to be forced.
