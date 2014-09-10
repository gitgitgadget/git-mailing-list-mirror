From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 8/9] autoconf: Check for timer_settime
Date: Wed, 10 Sep 2014 14:08:28 -0700
Message-ID: <xmqq38bzgp4j.fsf@gitster.dls.corp.google.com>
References: <1409330561-11806-1-git-send-email-jacob.e.keller@intel.com>
	<1409330561-11806-8-git-send-email-jacob.e.keller@intel.com>
	<5400B7C2.20603@kdbg.org>
	<1409334052.18778.21.camel@jekeller-desk1.amr.corp.intel.com>
	<54106F34.90505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Keller\, Jacob E" <jacob.e.keller@intel.com>,
	"j6t\@kdbg.org" <j6t@kdbg.org>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	"sortie\@maxsi.org" <sortie@maxsi.org>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 10 23:08:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRp7z-0003Cd-AB
	for gcvg-git-2@plane.gmane.org; Wed, 10 Sep 2014 23:08:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753452AbaIJVIb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2014 17:08:31 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50651 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751720AbaIJVIb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 17:08:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 68F69388E7;
	Wed, 10 Sep 2014 17:08:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BZ/KExN4brvRPCUSuF/xQXxdCYQ=; b=O9VsSO
	OqZaK8OqS9kktjR0m3JZuWx1tBVmIPYJG4OkaDet2pMulHz4xgU1uaKCk+f8M6u4
	9GulemRgKkAuWKih4p+YF7cRI2rB+kSyPJd28l8Dh7rxcKgsaWCpBIAEO6L8tGE/
	oke3qeSsebKYSCmj5Gr5Y+OTis9smGkQgoSJo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=E6uEhlUgSKYuEDgP7u/yc0fmc6GQqSKu
	2OKdd4fKKWZ1MOKhXx/nFRPnZWpXDsm96oPFT7T1Bm1i3i2nagnR4h3GmGIdu57O
	6jaAZAj4nRpccQ/4rmVoao4UW7xvpjbzxxczJP7wQdTrrIWWTsH01sSSx17FzTl7
	4Cv+50pL+I8=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5FA70388E6;
	Wed, 10 Sep 2014 17:08:30 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D14DB388E5;
	Wed, 10 Sep 2014 17:08:29 -0400 (EDT)
In-Reply-To: <54106F34.90505@gmail.com> (Karsten Blees's message of "Wed, 10
	Sep 2014 17:33:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9D529136-392E-11E4-A194-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256767>

Karsten Blees <karsten.blees@gmail.com> writes:

> While the timer extension (timer_settime) has graduated to mandatory in
> the current POSIX spec, the monotonic clock extension is still optional
> today (i.e. not necessarily supported even on newer Unices). In contrast
> to this, the XSI extensions seem to be widely supported.
>
> IMO the 'obsolescent' marker in the current POSIX spec is no reason to
> spring into action (at least not yet). E.g. utimes (also in <sys/time.h>)
> has been marked LEGACY in the 2004 version and is no longer LEGACY today.
> Btw., we'd also have to find a replacement for gettimeofday and probably
> a lot of other stuff...
>
> Therefore I tend to agree with Hannes that we should stick with setitimer
> and emulate it on systems that don't have it (as we do on Windows).

Sounds sensible to me.
