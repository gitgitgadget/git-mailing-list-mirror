From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] use a hashmap to make remotes faster
Date: Wed, 30 Jul 2014 11:26:28 -0700
Message-ID: <xmqqd2cmzorv.fsf@gitster.dls.corp.google.com>
References: <25222.0938886865-sendEmail@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git" <git@vger.kernel.org>
To: "Patrick Reynolds" <patrick.reynolds@github.com>
X-From: git-owner@vger.kernel.org Wed Jul 30 20:26:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCYaI-0006Cb-5n
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jul 2014 20:26:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755440AbaG3S0i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2014 14:26:38 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53654 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752914AbaG3S0h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2014 14:26:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3F3962B248;
	Wed, 30 Jul 2014 14:26:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JHNMrWzEncXxK/OKTVKDL10H+bg=; b=tVFPwz
	ULxU+yf7m9SSTXAGAFVJtgnGsy8hl1SbVq+znqzNhhKk40Ic0eEFWhA7lYu/TP2L
	5ZdM7bBKRnaOF9mC9ocPa0serYScW5024kKun4dh9DUZ4AjiU0itWQnMMFabDfAJ
	75Ct8b7aArEn7uJUs+UpXh75BWBlkyZg0If50=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jQrAhrglyDgWtRUfyz2kXJuvgqEYR80i
	KuVVh+dRSd1CU0SfjQWY9fX1E6qiTp9WDXqW4edf7M4hBf1n47uX9pa2zXx70o6C
	1XnW7d2UulfXQnyZGJvBto0SaU3S8NLgezNhnWvchUnfddhlRQjAZ2XTh12aA+ht
	iNZWUk86KeQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 358A42B247;
	Wed, 30 Jul 2014 14:26:37 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C38912B23C;
	Wed, 30 Jul 2014 14:26:30 -0400 (EDT)
In-Reply-To: <25222.0938886865-sendEmail@debian> (Patrick Reynolds's message
	of "Tue, 29 Jul 2014 14:43:39 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 06F6CF5A-1817-11E4-966E-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254507>

Please don't do this:

    Content-Type: multipart/related; boundary="----MIME delimiter for sendEmail-128858.688128279"
