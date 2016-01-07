From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Some issues when trying to set up a shallow git mirror server
Date: Thu, 07 Jan 2016 10:00:07 -0800
Message-ID: <xmqq4mep5kyg.fsf@gitster.mtv.corp.google.com>
References: <20160107165417.GB3397@logi.codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Richard Maw <richard.maw@codethink.co.uk>
X-From: git-owner@vger.kernel.org Thu Jan 07 19:00:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHErH-0006O4-I5
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jan 2016 19:00:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752516AbcAGSAR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2016 13:00:17 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56468 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752026AbcAGSAQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2016 13:00:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F0FE238A0F;
	Thu,  7 Jan 2016 13:00:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CgBrLTToESxoW2yNrPokWUOT1xE=; b=VBlBP3
	3iwoRyF2EkjlGyBgQPBqEIoEMrnIsoDAVGHHKdLJ+3b5fFXPKzUgbt5dAc16WUCl
	Je478AAP+0Y7Hm45OhD4IZ/R230hK0lrbKh3Eq7P0SEWKpd+kpssveialfo4C8x4
	9/We6mDP0XmoReBNM2UTV0lhjxeYTdJlaeNps=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rKcWntXbWPX5NUw1kT1b/IVlRBJ4WnoG
	So+PrMDgiPkMvTu1h0twWk/n7bgxFn/R5740dGk9q5Ad/GT0bZn5UsrAP91PPnba
	XdJKTYM9hWKsxTmS+WQrJiQSBLenJFY4Mbdb+iRG3WK8YA2uT1fsU2FlEp0UziIY
	zWSM0WE644g=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DF50138A0E;
	Thu,  7 Jan 2016 13:00:09 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id F147338A0B;
	Thu,  7 Jan 2016 13:00:08 -0500 (EST)
In-Reply-To: <20160107165417.GB3397@logi.codethink.co.uk> (Richard Maw's
	message of "Thu, 7 Jan 2016 16:54:17 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7D6A112A-B568-11E5-8B69-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283497>

Richard Maw <richard.maw@codethink.co.uk> writes:

> This is inconvenient for us,
> as we were explicitly using refspecs which didn't force the fetch,
> since we were using the "non fast-forward update" errors
> to detect whether upstream force pushed important refs
> which could be a sign of tampering.
>
> While the client doesn't have enough information
> the server has those commits.
> Would it make sense for the server to be able to tell the client
> "trust me, that commit is a descendant of the previous one"?

It does not in our security model, as you do not blindly trust the
other side, whether you are a "client" or a "server".
