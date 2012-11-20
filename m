From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] pathspec: apply "*.c" optimization from exclude
Date: Tue, 20 Nov 2012 11:47:53 -0800
Message-ID: <7vlidwrr86.fsf@alter.siamese.dyndns.org>
References: <1353229989-13075-1-git-send-email-pclouds@gmail.com>
 <1353229989-13075-4-git-send-email-pclouds@gmail.com>
 <7vtxsluw3k.fsf@alter.siamese.dyndns.org>
 <CACsJy8C=vdvHYgMr8Qa7M+Mq=QO6p6dsOFm_ZW=Nf2VQrPwaMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 20 20:48:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tatnn-00084Z-4d
	for gcvg-git-2@plane.gmane.org; Tue, 20 Nov 2012 20:48:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751849Ab2KTTr5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2012 14:47:57 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53071 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751600Ab2KTTr4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2012 14:47:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ABD989320;
	Tue, 20 Nov 2012 14:47:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CrQ9G/YMUMhH4S8sYDEkfhPQQHc=; b=CflnRH
	V4ovu08p7O/ByjzfyftnR99h5bEsogfdDpvNraPEuRTauaFsJrQZTlwiXuYGvRqd
	ltCd6c+QIaYBk167/UnEDtM/qSaKy+vSCeyPHRoHyRXtq8CS8cbw1fBcqH244U+B
	l0BPDVggqYsHd7CYaS41QXdJAPRetUza+K7G0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=avBTyGDeQsRZBLAhZJr7Ia5hX/+xE86N
	5KLRelY+lA3OdQHZtugeJq1f462IssoljPY4ZKBtR0sObCPLCvx5GleXlyArFis2
	km2elrzc4vBzE9S2pONJbyrVlymBc1gNv+PYXXCurj3rtmmvHLTHHw6tOUVoqQS/
	tEDO+mkkSUs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 96B35931E;
	Tue, 20 Nov 2012 14:47:55 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 15B07931C; Tue, 20 Nov 2012
 14:47:54 -0500 (EST)
In-Reply-To: <CACsJy8C=vdvHYgMr8Qa7M+Mq=QO6p6dsOFm_ZW=Nf2VQrPwaMg@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Tue, 20 Nov 2012 20:23:35 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2D59F4AE-334B-11E2-A836-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210106>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

>> When you come to strcmp(), you see that string_len is 1, pattern_len
>> is 3, and pattern is "oob".  string+string_len-pattern_len = "oob",
>> one past the beginning of the original string "foob".  They match.
>>
>> Oops?
>
> Oops indead. I'll need to check exclude code too :(

Ok, the one queued on 'pu' has been locally fixed when I sent the
message you are responding to.
