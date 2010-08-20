From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] xmalloc: include size in the failure message
Date: Fri, 20 Aug 2010 09:31:44 -0700
Message-ID: <7vd3tdckjz.fsf@alter.siamese.dyndns.org>
References: <7vhbipcpe1.fsf@alter.siamese.dyndns.org>
 <1282316991-23320-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Aug 20 18:32:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmUVk-0000Jk-QJ
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 18:32:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751783Ab0HTQby (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 12:31:54 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33749 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994Ab0HTQbw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 12:31:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AC441CD408;
	Fri, 20 Aug 2010 12:31:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iJ1lHutsSwjqs9o0kVOrJbgkYIU=; b=XNLYAM
	Vpn3bdleS5Eb1oID02Obitdu0E7oPvG6A5Hiutehylto6CjuFIee27lXwtxnUsjI
	tenROcTJYKobUumkDP+MOj5kj1k6ezPkT5DZa3MugNEpKGX7ogg8arpQGocjG0LX
	wDtS1b9kMtMiB8fKrWR3ARZ/dIxCSxLoASKUA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I3FY76xOCxxIe3u/wW6WY8q8WcC0zV80
	snb+QUe5wrBougVZefKV/lMtHSirDLHZPImy6TEjTffQObz6OXLZFTw5LPNWKxxI
	uARE2yGm1qUN2aSs5cVvT1acRIugDN/tVQRPJnDWk3li2PCvaLO6g1VRqix+hP/r
	KkJxhVuoR9A=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 78CFCCD401;
	Fri, 20 Aug 2010 12:31:49 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B2111CD3F4; Fri, 20 Aug
 2010 12:31:46 -0400 (EDT)
In-Reply-To: <1282316991-23320-1-git-send-email-Matthieu.Moy@imag.fr>
 (Matthieu Moy's message of "Fri\, 20 Aug 2010 17\:09\:51 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6E843DE2-AC78-11DF-82DE-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154052>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

>> Under NO_C99_FORMAT the format and the argument would not match if size_t
>> is not the same size as uint.  As the one in sha1_file.c seems to be done
>> in a better way, let's use that one.
>
> Sounds good. Not sure why we don't basically use the %lu version
> everywhere though.

I have been wondering about the same thing, but perhaps because we won't
have to worry too much about size_t needing to be unsigned long long on
older platforms where %z is not supported, while we expect %z will be
available on larger where using %lu may become an issue?
