From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 6/7] correct blame for files commited with CRLF
Date: Tue, 29 Mar 2016 13:32:23 -0700
Message-ID: <xmqqa8lhvxd4.fsf@gitster.mtv.corp.google.com>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
	<1459257938-17389-1-git-send-email-tboegi@web.de>
	<xmqqa8lhyzbq.fsf@gitster.mtv.corp.google.com>
	<56FADCAB.1010201@web.de>
	<xmqqio05vxo9.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Mar 29 22:32:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al0JZ-00073Q-06
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 22:32:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753842AbcC2Uc1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Mar 2016 16:32:27 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:57381 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752608AbcC2Uc0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Mar 2016 16:32:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 50CD65053C;
	Tue, 29 Mar 2016 16:32:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=nXcAW/6i2bkT
	aOni+mUM9INiOII=; b=QwRguHvzRWnfNHVhzYA7P4WNAftE4GX8ogI8G4HztSGk
	Jlp4mREWFKGSJYfMiM5XMTMRMLQOu3hb0Mk5xeZVSnc6LlLlwt/xmLI0SheMyzMT
	gxB+MS2kgoF3WqrB0B0rj3UfGyhdoCwM0G88FbVUDu9jfgwIzGZeqflwsa8yjlk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=UcAPMK
	rC1XELfMQI82YuOLiLEeExRX3tj5f7XubRslZOhGIu2VF4tBokx4yt4jSaSczBDk
	Bvwm0r5l9xKPnTnf1BZgykYeZwbS09tqekf6pNv8Lxy4Yt39cz0Xkm3TFwzjZ32X
	ag+fKWCWz6IIsPoT3lKAdeK3pvQ/Mpg8YktNE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 47AC65053B;
	Tue, 29 Mar 2016 16:32:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B5F2150539;
	Tue, 29 Mar 2016 16:32:24 -0400 (EDT)
In-Reply-To: <xmqqio05vxo9.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 29 Mar 2016 13:25:42 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 589FAB82-F5ED-11E5-9462-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290191>

Junio C Hamano <gitster@pobox.com> writes:

> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>
>> If we had made the CRLF -> LF conversion, yes. But we don't do that.
>> crlf_to_git() returns without touching the line endings.
>
> That sounds quite broken.  How would a user ever fix broken data in
> the index then?  I know the commit that often appears in these
> discussions claims to give us "safer CRLF" handling, but I have a
> suspicion that perhaps we should rethink if that claim is really
> true.  Isn't it giving us more problems than it is worth?

Having said all that, within the context of the current codebase
where autocrlf refuses to do the conversion, I agree that teaching
blame to follow the same logic makes sense.  Let me review the
series up to 6/7 with fresh eyes.

Thanks.
