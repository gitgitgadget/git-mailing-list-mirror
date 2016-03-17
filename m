From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Code reorgnization
Date: Thu, 17 Mar 2016 14:49:15 -0700
Message-ID: <xmqqh9g4zsf8.fsf@gitster.mtv.corp.google.com>
References: <20160317111136.GA21745@lanh>
	<CAGZ79kbcwFcPSJ9xwE6xi4gQ871m3brtfAut2TChGNzL-foxdQ@mail.gmail.com>
	<xmqqy49gzzrf.fsf@gitster.mtv.corp.google.com>
	<20160317214355.GA32317@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, Duy Nguyen <pclouds@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu Mar 17 22:49:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agfnK-0004fg-T1
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 22:49:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031072AbcCQVtW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 17:49:22 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:62052 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S936206AbcCQVtS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 17:49:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6EA914D585;
	Thu, 17 Mar 2016 17:49:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kWGP5ujuRa8mct1+KS210v5gTWo=; b=eZvwJK
	by2snfYqNmzwTYNPQWVPLDke1loZEQNzefDqtSe7Trhiv4SXLxaPesrlzDsveQ+R
	mzwGYTyacM1hZZxrqnjNmeCcRS/rkCCTpvfPW2oQ0jEuSHIJpU5pfyhfJeY5aval
	y4gdff0dJjzVCnWom6q2tSxpg824fuJQvPWC4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a4WR9mElSynz5YQCm6VMuDzRffevMpc/
	gy4hEFORH864iF9qDovOVPZ6lpZWZAa+onqp1xMrPnZ0mTLFtbXufxl3lFuUNzDi
	JZZijCjdLWI6DYemK1LRSWZqOXQT+cjqLKJajI3i+J28z8OY2up2k7Nakhq4NlSO
	4QWPU6zggII=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 657934D584;
	Thu, 17 Mar 2016 17:49:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D5A804D583;
	Thu, 17 Mar 2016 17:49:16 -0400 (EDT)
In-Reply-To: <20160317214355.GA32317@serenity.lan> (John Keeping's message of
	"Thu, 17 Mar 2016 21:43:55 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 18B5C004-EC8A-11E5-AC4F-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289161>

John Keeping <john@keeping.me.uk> writes:

> The organisation of the git code shouldn't make a difference since CGit
> just links with libgit.a, even if it does CGit pulls in git.git as a
> submodule so it can just fix any problems in the same commit that
> updates the submodule reference.

I was mostly worried about where Duy and Stefan want to place *.h
