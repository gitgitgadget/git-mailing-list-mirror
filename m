From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] submodule: fix confusing variable name
Date: Fri, 09 Aug 2013 11:53:41 -0700
Message-ID: <7va9kq66h6.fsf@alter.siamese.dyndns.org>
References: <1375550060-5406-1-git-send-email-sandals@crustytoothpaste.net>
	<1375550060-5406-2-git-send-email-sandals@crustytoothpaste.net>
	<20130803181415.GF2893@elie.Belkin> <51FE90B8.8030203@web.de>
	<20130804212938.GL19369@paksenarrion.iveqy.com>
	<5203D8F6.2020102@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Gustafsson <iveqy@iveqy.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org, judge.packham@gmail.com,
	Jorge-Juan.Garcia-Garcia@ensimag.imag.fr
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Fri Aug 09 20:53:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7ror-0001gM-GN
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 20:53:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030673Ab3HISxp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 14:53:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46944 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030353Ab3HISxo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 14:53:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 34CFC372BB;
	Fri,  9 Aug 2013 18:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ccFTV9ydUQsR0gJmiD29LL4D/yg=; b=I/APnE
	Wq38YFHafG4oesXmIxNlJmuFR5ivxeFUkQDYvklfVVmeq9WVMfwIXn6Vjb47c2yS
	phZY/bld2JPiaaPxNxCfgZoc+DgM9AnXfDr6jClTkfOK+GtcwTIAkfmPrW2iRb6t
	MSSLEoUbcBLsyf2UE/ni0fCccNGIW12ICcTCk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iT5KRuaCptgh4TXRell3TCt7+xj/Ptk1
	uER5aWy4/x/TluQ37VwIJYl+bzKoPZE6L/Qa4euwQpDwOAcK/InDvZMt+el2tiai
	bFzMnyAzxRnXIh7Elxe0ZtKa6EX+Pcwuz7NyBhUgJOkqwlXA1gBi2Wl42iOM0DxE
	u/AHlXpcbDE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 278D9372BA;
	Fri,  9 Aug 2013 18:53:44 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 43DD6372B3;
	Fri,  9 Aug 2013 18:53:43 +0000 (UTC)
In-Reply-To: <5203D8F6.2020102@ramsay1.demon.co.uk> (Ramsay Jones's message of
	"Thu, 08 Aug 2013 18:44:22 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 03677132-0125-11E3-9943-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232011>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> $path is part of the public API, so we can't just remove it. It would
> require a deprecation period, etc,.  (Adding/documenting $sm_path as an
> alternative *may* be worth doing. dunno.)

I think exporting sm_path (if not done already) and documenting the
transition may be a good starting point, but deprecation of $path
may be tricky.  There is no good way for us to warn people who
continue using $path and ask them to fix their fingers and scripts
to use $sm_path instead.
