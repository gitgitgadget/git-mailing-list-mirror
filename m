From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] gitweb: notes feature
Date: Thu, 04 Feb 2010 08:46:33 -0800
Message-ID: <7v4olxhrti.fsf@alter.siamese.dyndns.org>
References: <1265300338-25021-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1265300338-25021-2-git-send-email-giuseppe.bilotta@gmail.com>
 <7vpr4lhsfu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 17:46:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nd4r1-0003yl-Uo
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 17:46:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758384Ab0BDQqu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2010 11:46:50 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45894 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758321Ab0BDQqt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2010 11:46:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D85596C71;
	Thu,  4 Feb 2010 11:46:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SJJr6IU9FTzaK0zgIiI2BxnP5gI=; b=Is1dLK
	uqlZP1B9zZWoBaEtHakM2CfWNnfU2v1Tauw13i0kf3QcEgnZBnh/quMRdk3aCx1V
	LeCegoteWqaUy8u0db2ls2Y3NSbEkC/LEHOu6H9RtGyNinp8/xj7IznCe+HYbciI
	agpQCQUKUDyRzA9fGIjrW1MqRSBYm/XQNUqh4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Oyqj8Yqq7NgLTEN7BGUkk4XFu7PxPpm9
	xnQATK6QzP8CVOPtkXqyOCwPmm3S3AuzJuMg/N5i/QWkHsMHpCfD4wOATKUqebzY
	vqBJAgGQpV3+t/YN6zSh6RtINU848NuVixafxeJTCerQolT6j+VFXD62ubb2OAa4
	9HKmXqmnBfo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0033396C70;
	Thu,  4 Feb 2010 11:46:40 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BFAD696C67; Thu,  4 Feb
 2010 11:46:34 -0500 (EST)
In-Reply-To: <7vpr4lhsfu.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu\, 04 Feb 2010 08\:33\:09 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DE7B912A-11AC-11DF-9E96-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138979>

Junio C Hamano <gitster@pobox.com> writes:

> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:
>
>> +		my %notes = () ;
>> +		foreach my $note_ref (@note_refs) {
>> +			my $obj = "$note_ref:$co{'id'}";
>
> I think this look-up is wrong (meaning: will stop working anytime in the
> future, and needs to be rewritten).

IOW, the code should be reading output from:

    GIT_NOTES_REF=$note_ref git show -s --format=%N $co{'id'}

as the notes tree may not be storing notes in a flat one-level namespace
like you are assuming.
