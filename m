From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/4] apply: reject input that touches outside $cwd
Date: Tue, 03 Feb 2015 13:23:15 -0800
Message-ID: <xmqqtwz2pu4c.fsf@gitster.dls.corp.google.com>
References: <1422919650-13346-1-git-send-email-gitster@pobox.com>
	<1422919650-13346-2-git-send-email-gitster@pobox.com>
	<20150203005005.GB31946@peff.net>
	<xmqqpp9qrbgf.fsf@gitster.dls.corp.google.com>
	<20150203210140.GA20594@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 03 22:23:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YIkwM-0003gK-3b
	for gcvg-git-2@plane.gmane.org; Tue, 03 Feb 2015 22:23:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161169AbbBCVXS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2015 16:23:18 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54855 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161164AbbBCVXR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2015 16:23:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 15AC235DA1;
	Tue,  3 Feb 2015 16:23:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DKlJ5cA9YqOPmSMjnD5dD96qex4=; b=nOmrKT
	fu4IwHOaAO6Aqbn52rKrEQEWS8c9fps5pWmj2oioj2WwC8Bj50Bnien2QJEPFxTh
	2bG+4ohv313btPIgxkbY7O99AIGAgrm1a1sAXr5ukZKV8unF7IuMyn62j5nJixYS
	wua8LV0vLQDBkRa8t06IQOzMRyWLZQYU2GUHQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uptQUsAhLObkLXNjiyqTK48OJrXVvyHz
	BtoRfgcZfvoM/YbCrY5kUdlat2kbsPgr6xKcSefdBO74ZyYYyeO/pDNoWxitlsgw
	3jzL+QIEKahmNZW/WMsrebNZXcWu8iSZlaUjGQH6PllCdsurDP6IfVV7pH9NJEfV
	gY4B/SlcM00=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0CF1A35DA0;
	Tue,  3 Feb 2015 16:23:17 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 78E8835D9F;
	Tue,  3 Feb 2015 16:23:16 -0500 (EST)
In-Reply-To: <20150203210140.GA20594@peff.net> (Jeff King's message of "Tue, 3
	Feb 2015 16:01:40 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DE1C5FEC-ABEA-11E4-9C76-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263334>

Jeff King <peff@peff.net> writes:

> Right, I do not think these tests will _fail_ when the filesystem does
> not support symlinks. But nor are they actually testing anything
> interesting. They would pass on such a system even without your patch,
> as we would fail to apply even the symlink creation part of the patch.

I thought we write out the contents of the symbolic link as a
regular file on such a filesystem, and as long as we do not expect
"test -h expected-to-be-symlink-we-just-created" to succeed we would
be fine.
