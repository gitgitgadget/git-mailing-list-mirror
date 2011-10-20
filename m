From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] revert: fix buffer overflow in insn sheet parser
Date: Wed, 19 Oct 2011 18:30:45 -0700
Message-ID: <7v8vogbgai.fsf@alter.siamese.dyndns.org>
References: <1319058208-17923-1-git-send-email-artagnon@gmail.com>
 <1319058208-17923-4-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 20 03:30:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGhTE-00044E-JI
	for gcvg-git-2@lo.gmane.org; Thu, 20 Oct 2011 03:30:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755775Ab1JTBat (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Oct 2011 21:30:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54216 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754537Ab1JTBas (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2011 21:30:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E370C56D7;
	Wed, 19 Oct 2011 21:30:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fbuKvZNrWBVhsCzX6UsMxfGH5m4=; b=cKWNOE
	phYu7cZRi2SseP8pnArjn77gbKHkw4XQI4SrfLYH0Y6EYlwFyzvCCQbyKJIDDI2r
	eg1viaVBPL3daTPc0//WG48fiBD9yYw7opIZ9x1qOIUyia5VUr72KPK0XuKsynvj
	I0UbA9QLtGYaqP7httPM2OMEtGYlVWd2VmjSw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UGmOPS8ndJcduaqL3wvJo4ZX42gqN/Ts
	PvFZj/CI5ipc5ZD4ZSvnLHS4j+oMs3gBhd20V9uFJJkxf67f2Re+l8ifgGOwQVf9
	9LitdJBMxKS1+jQEzC5WPcyM3RQORBryF4uNfzptI3+EL0UrSkPOeibV9TTQQAMy
	oX1gpsrd3s0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D872D56D6;
	Wed, 19 Oct 2011 21:30:47 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6F4CE56D4; Wed, 19 Oct 2011
 21:30:47 -0400 (EDT)
In-Reply-To: <1319058208-17923-4-git-send-email-artagnon@gmail.com> (Ramkumar
 Ramachandra's message of "Thu, 20 Oct 2011 02:33:25 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 23082F44-FABB-11E0-8E31-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183997>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Check that the commit name argument to a "pick" or "revert" action in
> '.git/sequencer/todo' is not too long, to avoid overflowing an
> on-stack buffer.  This fixes a regression introduced by 5a5d80f4
> (revert: Introduce --continue to continue the operation, 2011-08-04).

Given that this function is going to be fixed properly so that it does not
even need to use the "on-stack buffer", is this really necessary?
