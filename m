From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git rm / format-patch / am fails on my file: patch does not apply
Date: Wed, 13 Nov 2013 09:04:47 -0800
Message-ID: <xmqqbo1ofd1s.fsf@gitster.dls.corp.google.com>
References: <CAD3a31XPKsnuNE+szw7xgvaDrcxhKZ2jTDHKzTwdwtnCwFb_0w@mail.gmail.com>
	<xmqqhabilpzx.fsf@gitster.dls.corp.google.com>
	<CAD3a31UVkNaPTCWCAbv0NwCOTE5_2A+P7-e28VRnk9Aopa6hcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>
To: Ken Tanzer <ken.tanzer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 13 18:05:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgdsA-0000jz-V8
	for gcvg-git-2@plane.gmane.org; Wed, 13 Nov 2013 18:04:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759260Ab3KMREz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Nov 2013 12:04:55 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50963 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757197Ab3KMREx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Nov 2013 12:04:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B18495016A;
	Wed, 13 Nov 2013 12:04:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jHpZydwLA4wyzm7n0wqmc+F63IE=; b=bmbm+r
	B1YXM1F5qciUk1y1+4ptaT0B0PHkd2vbgUnt0eEjeHvGRU2udQKmGPs9Bt8PNdvy
	FQYK3dxXeo4byH8GiORZbBJf6d9WkR9EJYX/nvcC/aZhKCvMln7FKu8wXjjNhpwA
	oVZpWLjT44ZmQZPTpDZarXceIf4qE9L/SJfhU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I8KSqXjp1eTnqfMRvNj5J8C9gXKpEYXk
	lc6gJIJHIJxzyJzQpapmt4svFHFD8jaVKJx1XBlWsqojJ971Kx9bbAkYijKsD1Uj
	0Rgq61LHAfnNLikzxG/T5CWWPsfsM8+qvgvGSb+UuA5otdDl6CY2Wq+nKjPXclHW
	u1Jkxwk/D4I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A13AD50169;
	Wed, 13 Nov 2013 12:04:52 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DEC6550163;
	Wed, 13 Nov 2013 12:04:51 -0500 (EST)
In-Reply-To: <CAD3a31UVkNaPTCWCAbv0NwCOTE5_2A+P7-e28VRnk9Aopa6hcQ@mail.gmail.com>
	(Ken Tanzer's message of "Tue, 12 Nov 2013 16:26:49 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B6028D76-4C85-11E3-9425-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237793>

Ken Tanzer <ken.tanzer@gmail.com> writes:

>> I am not very much surprised if such a file misbehaves, because the
>> "format-patch | am" pipeline is designed to be used on patches that
>> can be transferred in plain-text e-mail safely.  Long lines should
>> probably be OK, but mixed CRLF, CR and LF may be problematic.
>
> I'm not sure I understand this comment.  format-patch seems to work
> fine on binary files.

Yes.

The problematic is when you tell it to process text files, taking
into account various common text breakages may be introduced to the
payload, and line-end conversion is among the operations that the
user may be telling it to munge the perfectly-fine input, in an
attempt to compensate.
