From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1.8.0] add: make "add -u" update full tree without
 pathspec
Date: Sun, 27 Feb 2011 22:56:30 -0800
Message-ID: <7vk4gkk5pd.fsf@alter.siamese.dyndns.org>
References: <1297045643-26697-1-git-send-email-pclouds@gmail.com>
 <7vei6t4uwa.fsf@alter.siamese.dyndns.org>
 <AANLkTi=BwTHRWcUu26VLWAhFupmuJpu8fvOF98--HJ5f@mail.gmail.com>
 <7vy6512rnb.fsf@alter.siamese.dyndns.org>
 <AANLkTimqBxhHBVzet9M-6AqiCp664hkroM9QWS_1SiLP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sebastian Pipping <webmaster@hartwork.org>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 28 07:56:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ptx2J-0003Fk-9T
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 07:56:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752012Ab1B1G4q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 01:56:46 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47828 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919Ab1B1G4q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 01:56:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B29D32A76;
	Mon, 28 Feb 2011 01:58:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1V1MRC2fHEZB96SNbBUSIai0uis=; b=UTA4ZJ
	lGHWkG+FsORLsaiIEUBpqkcGX0/FFrf+1ZAW97x9RKkSSMtHMVPpNbJFqzYLYUye
	tM3PiQeneLfW/z4z2lHOaKlnW1HnijrDFeDvLBkcOvNgo3gHqtlcf1Q6hzlNHdoZ
	BUKrUXl5/WGZvSNZkT5p2tSqDrNNcLu+5W6N4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U4dGYqc7f9IFJ2IlBd1Pv7oHEhvsYh/B
	/5HtS8Uk9YKCktCQdaSwugMUNqYI0/yoW6SNLbOFkQKKkhT01DD38tBkXL66B9g7
	H+WpPgFjB/CajElfITlnriy7mPS5lmX85ABGwyHaQ7d6icCJxJdY/0jvhyCZstEc
	UhgXHPzIYAI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 476052A75;
	Mon, 28 Feb 2011 01:57:57 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A13702A73; Mon, 28 Feb 2011
 01:57:49 -0500 (EST)
In-Reply-To: <AANLkTimqBxhHBVzet9M-6AqiCp664hkroM9QWS_1SiLP@mail.gmail.com>
 (Nguyen Thai Ngoc Duy's message of "Mon\, 28 Feb 2011 13\:37\:54 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 129F4202-4308-11E0-BC50-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168072>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Mon, Feb 28, 2011 at 2:39 AM, Junio C Hamano <gitster@pobox.com> wrote:
> ...
>> What you conceive as a problem is just a reminder that any incompatible
>> change you plan to add will have pain involved....
>
> No. But I hoped it would help me somehow, or at least remind me to
> update git on the machines I touch.

Perhaps the migration plan is not helpful enough?  If that is the case we
would need to rethink it to be even less impactful.

I already do not like the possibility of potential double deprecation
myself, one to flip the default and then possibly another to drop the
support of the traditional behavour, but anything I've seen so far would
hurt the end users more than that plan.
