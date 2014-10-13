From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote.c - Make remote definition require a url
Date: Mon, 13 Oct 2014 10:19:24 -0700
Message-ID: <xmqqppdv51lv.fsf@gitster.dls.corp.google.com>
References: <1413040849-20056-1-git-send-email-mlevedahl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 13 19:19:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XdjHV-0000aU-PO
	for gcvg-git-2@plane.gmane.org; Mon, 13 Oct 2014 19:19:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754160AbaJMRTd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2014 13:19:33 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50316 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752231AbaJMRTc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2014 13:19:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3D5E5136C5;
	Mon, 13 Oct 2014 13:19:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ELlka2kUo2lblqY8zc3gmdfPwvc=; b=bre7Qm
	CDOK1c3qyLKKZKuKaOuSnTeGE3/l9v2lN6KRLzLIHza6y3kEqTWratBDDysycXBA
	0AhYlDhmO88Fbl7UrjMfgqlb7qRYitDYXnUzYeqtiXFQVtukMIweZB8sD1CSDqzX
	KSix9RtupOuGzmpjfp5dXZ+dj4dN2ejRl7Urk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IcfYJH+juC6YFhph1wFn6M88cAZCYp8P
	FAvx9pXxNxcJUwTogJ1GL9YEGQ1Off/1y7GwL5zxQGMD82z6LBcFEkxAREJWAdYe
	40XCXUaZNbGCU8N+y341LcyDseAgcUgGRoiq9s9BnEll4zZoonfn4g+QRQvozZ9g
	p2Dq6rx0ssQ=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 33C23136C4;
	Mon, 13 Oct 2014 13:19:26 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A9CE7136C2;
	Mon, 13 Oct 2014 13:19:25 -0400 (EDT)
In-Reply-To: <1413040849-20056-1-git-send-email-mlevedahl@gmail.com> (Mark
	Levedahl's message of "Sat, 11 Oct 2014 11:20:49 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 14CC6D80-52FD-11E4-A3AB-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mark Levedahl <mlevedahl@gmail.com> writes:

> Some options may be configured globally for a remote (e.g, tagopt).

Or some remotes may have only pushurl and not url.  "git remote"
output for me has a few such remotes but wouldn't this patch break
it?

If a caller that walks the list of remotes misbehaves only because
it assumes that r->url always is always valid, isn't that assumption
what needs to be fixed?  for_each_remote() should be kept as a way
to enumerate all the [remote "foo"], I would think.
