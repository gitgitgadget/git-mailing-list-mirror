From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 1/2] wt-status: better advices for git status
Date: Tue, 29 May 2012 21:27:16 -0700
Message-ID: <7vbol61efv.fsf@alter.siamese.dyndns.org>
References: <1337852264-32619-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1338035905-24166-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <7v1um47vik.fsf@alter.siamese.dyndns.org> <vpqwr3whjkp.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kong Lucien <Lucien.Kong@ensimag.imag.fr>, git@vger.kernel.org,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>,
	Nguyen Huynh Khoi Nguyen Lucien 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed May 30 06:27:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZaVm-0001sA-Er
	for gcvg-git-2@plane.gmane.org; Wed, 30 May 2012 06:27:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219Ab2E3E1T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 May 2012 00:27:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52261 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750956Ab2E3E1S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2012 00:27:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 256C084EF;
	Wed, 30 May 2012 00:27:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lUBZ8S+mU27I+dN0YybrIRDBJAU=; b=t+jb2R
	Mj4Rm/AIyzq05PgUCsYMQVbSK4HbIYNEk5BcXtV6YJnEnGHzrQeGDbWi9Lyl4TkF
	1+IugOn9BUBm6a2ddUHvzZtKiBgl+LyAwZ8IDGhNlkjePyzJ32dL8UHVWYUX+Jng
	uAW6+JwztvXxJ1m4B6/h86MHjdQ3nhvuWT1r0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=P0+yM926ddPYoiN2SVDI61nebMg9Pix9
	NVdboM329G3W8vDC/kdBB4jwViokxXXR+ienBtCOghnyPOOBIc2GpNCAmcGR1D4b
	HZDYItrRj8unrTbveVvGmtL21yifinehS/MvEtPIn6viY1IXSmscGcHGCtPKpGXC
	/MZeAOiTt+g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C27984EE;
	Wed, 30 May 2012 00:27:18 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7F58C84ED; Wed, 30 May 2012
 00:27:17 -0400 (EDT)
In-Reply-To: <vpqwr3whjkp.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Mon, 28 May 2012 09:05:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BD5707A6-AA0F-11E1-8A02-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198779>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> These are not independent (you cannot be in bisect and am at the
>> same time).
>
> You should not, but it seems you can. At least, I just successfully
> started a "git am" during a "git bisect".

Yeah, that actually is a sensible thing to support (and I am happy
to hear it still works).

> The variable naming is wrong (it could be s/conflicts/unmerged_present/
> and s/unmerged_state/merge_in_progress/ for example). But these two
> variables are indeed independant. You can have unmerged path without an
> actual merge in progress (conflicts during "git am"), an you can have a
> merge in progress without conflicts (if you've just "git add"-ed them).
