From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach ignore machinery about pattern "/"
Date: Sat, 26 May 2012 23:15:31 -0700
Message-ID: <7vwr3yp2t8.fsf@alter.siamese.dyndns.org>
References: <1337950056-26491-1-git-send-email-pclouds@gmail.com>
 <7vlikgtbcx.fsf@alter.siamese.dyndns.org>
 <CACsJy8BjUQsCVVdzZtJxA9Qu2G0izZa8dvP1EKsQQAHWXZbHdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 27 08:16:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYWm6-00034D-1t
	for gcvg-git-2@plane.gmane.org; Sun, 27 May 2012 08:16:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365Ab2E0GPj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 May 2012 02:15:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63248 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751277Ab2E0GPi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2012 02:15:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 21857408C;
	Sun, 27 May 2012 02:15:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3x7Rb5oa56IAq6JjTh0jDbPxM94=; b=TlTdj/
	Z1YuHzWEMyjjH3uQN81ffEaO3eklU65KJXSdeWWs3+PIHipe0yq8owuavRSSSHhM
	ArCRbuANaJb+Ep4b+J2FSm3ym4bcTEo4WtwoJr6lKdElNJyjg/X6gzr4I1/NxJTS
	swgu/fpYRLWseb10O+tSXmLh1Xw+a91GcvXvM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PzxVMw6bin7Kz5sJjwXjKpbjBxcc53qM
	qvI1F7trmD/USRJc6M7ASwWlWb+NPgpbGhicCpFAnUKSFMI8Ib5RE8gcrkmtXNaL
	NaeHTiNpdwn0ySgeBcD2kzoWZtxWocIZlvu5wtYgc16N4ThfqbSCPTeGXBrdiaL0
	rtL/rCo/0KI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 184A1408B;
	Sun, 27 May 2012 02:15:35 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AC007408A; Sun, 27 May 2012
 02:15:33 -0400 (EDT)
In-Reply-To: <CACsJy8BjUQsCVVdzZtJxA9Qu2G0izZa8dvP1EKsQQAHWXZbHdg@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Sat, 26 May 2012 11:30:36 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5E1B6DAC-A7C3-11E1-8B3D-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198577>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

>> When talking about an ambiguous expression X that can be in multiple ways
>> and each interpretation gives surprisingly different result, if there are
>> ways A, B and C to unambiguously spell each and every of its possible and
>> useful interpretations, and if one of the interpretations C is to ignore
>> the expression altogether, it is preferrable to either
>>
>> (1) warn if it does not trigger anything useful to write a no-op; or
>> (2) just ignore it if a no-op is a meaningful behaviour
>>
>> when you see X.
>
> except that we do the ignoring in (2) but I don't see this as a
> meaningful behavior.

That would mean you would want to update the code to do (1), not silently
trigger a different behaviour.
