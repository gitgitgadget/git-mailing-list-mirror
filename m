From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] treewalk.c: Rename variable ret to cb_bits and remove some dead lines.
Date: Fri, 19 Jul 2013 11:13:12 -0700
Message-ID: <7vli52wh8n.fsf@alter.siamese.dyndns.org>
References: <1374183327-14939-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Jul 19 20:13:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0FBB-0008Sl-2B
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 20:13:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752726Ab3GSSNQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 14:13:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51691 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752622Ab3GSSNQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 14:13:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0EB4E324F3;
	Fri, 19 Jul 2013 18:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ALV+6VcBsNIfiRfXHV8J/e2Vens=; b=eARhvP
	bu7kn4IpfTezCKEQcPfJbaP9snQDd9cEKw3L5FKH9+QjDhKgOpLdproBiXtBn0/d
	W7qVoFV3zX/oVHrqlySScpGjOElnz3azaaNQlejzbWj0iWjeT1gSF2g7bSI6jc9t
	2wqfDUKFQtl7FojmFNPffl2TCgeyDv7QSNDUg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Iojeiw/2gAz3QhlTjBnCwhFXE1dqkYrw
	+rOxyR6eN/GHYmaqDMvqew7kLUTEZRS4/JSaMYrgYKvWJg/UHgM7R6tROaHzBaHP
	kaDI21T4SH5KZWg8gRmB3zo6A2QT4dhJWzzMi6YOtvG7kn+6xJuOhhs1cj0phNoh
	tjN4BU6Y7ZI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 02DC9324F2;
	Fri, 19 Jul 2013 18:13:15 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 603D3324EF;
	Fri, 19 Jul 2013 18:13:14 +0000 (UTC)
In-Reply-To: <1374183327-14939-1-git-send-email-stefanbeller@googlemail.com>
	(Stefan Beller's message of "Thu, 18 Jul 2013 23:35:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E0F2B454-F09E-11E2-8458-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230834>

The "ret" was meant to mean "the return value we got from the
callback function", not "the return value we would give our caller".

This rename is a bit misleading in that "cb_bits == -1" does not
mean "full bits set", and it does not tell us much what these "bits"
signify.

They are used to answer this question: which one of the trees in
t[0..n] did the callback function consumed (hence needs their
pointers updated).

So perhaps call it "trees_used" or something?

By the way, our log message usually do not Capitalize the subject
after the "<area>:", i.e. do something like this instead:

    Subject: [PATCH 1/3] traverse_trees(): clarify return value of the callback

Thanks.
