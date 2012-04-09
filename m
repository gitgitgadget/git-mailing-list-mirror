From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: make annotate configurable
Date: Mon, 09 Apr 2012 11:07:40 -0700
Message-ID: <7vwr5owzgz.fsf@alter.siamese.dyndns.org>
References: <1333758550-9187-1-git-send-email-felipe.contreras@gmail.com>
 <7vy5q8xhkb.fsf@alter.siamese.dyndns.org> <vpqaa2n7rvd.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	"Yann Dirson" <ydirson@altern.org>,
	"Michael Witten" <mfwitten@MIT.EDU>,
	"Ryan Anderson" <ryan@michonline.com>,
	"Michael Witten" <mfwitten@gmail.com>,
	"Adam Roben" <aroben@apple.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Apr 09 20:08:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHJ0N-0003K4-LK
	for gcvg-git-2@plane.gmane.org; Mon, 09 Apr 2012 20:07:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757644Ab2DISHo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Apr 2012 14:07:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33933 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757587Ab2DISHm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2012 14:07:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 420566D60;
	Mon,  9 Apr 2012 14:07:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YaInHyHY8aElaAq4xKS9k+qv0UU=; b=rJQ4q5
	wZorntRF3jJt7uNxDjoTBvEW1Du85vatsAfO/xm/Jy0YPJJ7Wwg2fb/AT8GRX98l
	Ro9Z6QMcYZBtm6vXkIn9vC24FcbvC9uZR2xWca3x98nRiKQZg0bGAC2p/VnpMN1J
	yarynkBJahi/P7cFN1Fwe8dZLxuc/kz/oi89c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ujk33oMPpwOGyz5u5uqSRV999k5u+CxM
	kwfpT7tQnniNHV+bnM+7AMhFkfutJD7H1eEzwhopF54oUQ/qNS3tn3dJhA/+lbZP
	D9TfLEY0ZwShLCO0ws0S66seOmEeqYyun+1FdRzvureEpraN7ieLQ01cECU6xWXB
	nyNQJsRxDIg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 386A36D5F;
	Mon,  9 Apr 2012 14:07:42 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A394E6D5E; Mon,  9 Apr 2012
 14:07:41 -0400 (EDT)
In-Reply-To: <vpqaa2n7rvd.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Sat, 07 Apr 2012 12:34:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E626FC2C-826E-11E1-A758-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195020>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
> ...
>> As long as there is --no-annotate to cancel a configured value for
>> one-shot invocation (I didn't check, but it should be added if there isn't
>> already one), I think this change makes sense (I admit that I do not use
>> the --annotate option myself, though).
>
> I almost always use --annotate, so this option definitely makes sense
> for me (I usually call send-email through an alias that adds --annotate
> anyway).

I do not doubt the usefulness of it, but if there is no --no-annotate, it
would make the new variable unusable for those who would never run it
without --annotate option; while you said "almost always", you didn't give
us any useful information, so I had to check ;-)  It turns out that

    $ git send-email --no-annotate </dev/null

errors out with "unrecognized argument: --no-annotate", which first needs
to be addressed before the configuration variable can become useful.
