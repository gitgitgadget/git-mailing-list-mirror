From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Modified flag field type in rev_list_info struct in bisect.h. There is no need for flag field to be signed, as it is not supposed to be used as decimal.
Date: Thu, 24 Mar 2016 23:18:56 -0700
Message-ID: <xmqqr3ez5bcf.fsf@gitster.mtv.corp.google.com>
References: <1458848469-12663-1-git-send-email-motroniii@gmail.com>
	<1458848469-12663-2-git-send-email-motroniii@gmail.com>
	<CAGZ79kZmzo+f9YF1K1oC2GfOrzdaojmrca7bUm3cBRoDreeA-g@mail.gmail.com>
	<56F44788.2050509@gmail.com>
	<CAPig+cQcviTXYAGBTATgYXoaPtvxxeOUtCGYkLyW5oTFvLjEUA@mail.gmail.com>
	<CAGZ79kaF42yCFWdvqqDSAZbWmUo0UVJGbXCci1LF=ne+cixZ0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	work <motroniii@gmail.com>, Git List <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 07:19:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajL5P-00064p-IW
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 07:19:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751928AbcCYGTB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 02:19:01 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:59866 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751875AbcCYGTA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 02:19:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D076E493A2;
	Fri, 25 Mar 2016 02:18:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aMPghrGc7/jxIB9ZuE3yBX7lLto=; b=FMQ7pb
	nyV8rWHCaaFrtXmO43B8GZlk/HHVlos+kX9XbfE/I5h5ypgPyyHdsSPvWPi+KTSy
	41DZTiW0kVN3iwFztnArZ6q/ZiW3fpG3tAIcZ5rrXx3q+9FEq7mdNHG261nujPPq
	t0KVYW64voII17r0/QbmIQduAIC1yKbRV0rnU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wPjnrP931Z6FizVWYDw/NBEnP4cpW6Ja
	vDGGBuqon2xtezpUjnlsAnzeGgniZPeN84STJz1TtrWheX70p7igNd1H+ZPWh0Ko
	eqvMzKFZRrhHvG4s6upABNiTy5qrUplevCCRzwV5W5togMwoP7AORTLT7pacsUxX
	cN8z9GiRiuE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C8D21493A1;
	Fri, 25 Mar 2016 02:18:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 45ABC493A0;
	Fri, 25 Mar 2016 02:18:58 -0400 (EDT)
In-Reply-To: <CAGZ79kaF42yCFWdvqqDSAZbWmUo0UVJGbXCci1LF=ne+cixZ0A@mail.gmail.com>
	(Stefan Beller's message of "Thu, 24 Mar 2016 16:04:46 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 758AF37C-F251-11E5-8099-E95C6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289851>

Stefan Beller <sbeller@google.com> writes:

> Maybe my exposure to the code was accidentally in a way such that
> I ever only saw the version without int.

The older part of the code tends to spell flag words with "unsigned"
without "int", which is primarily historical fault of mine.
