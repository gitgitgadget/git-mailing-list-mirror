From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1.8.0] add: make "add -u" update full tree without
 pathspec
Date: Tue, 01 Mar 2011 12:12:23 -0800
Message-ID: <7vzkped2hk.fsf@alter.siamese.dyndns.org>
References: <1297045643-26697-1-git-send-email-pclouds@gmail.com>
 <7vei6t4uwa.fsf@alter.siamese.dyndns.org>
 <AANLkTi=BwTHRWcUu26VLWAhFupmuJpu8fvOF98--HJ5f@mail.gmail.com>
 <7vy6512rnb.fsf@alter.siamese.dyndns.org>
 <AANLkTimqBxhHBVzet9M-6AqiCp664hkroM9QWS_1SiLP@mail.gmail.com>
 <7vk4gkk5pd.fsf@alter.siamese.dyndns.org> <vpqipw2rixy.fsf@bauges.imag.fr>
 <7vd3maelbh.fsf@alter.siamese.dyndns.org> <vpq4o7mfzd1.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org,
	Sebastian Pipping <webmaster@hartwork.org>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Jeff King <peff@peff.net>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Mar 01 21:13:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuVwW-0003Eu-RT
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 21:13:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757431Ab1CAUMl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 15:12:41 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56484 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757428Ab1CAUMk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2011 15:12:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8F7AB3AAA;
	Tue,  1 Mar 2011 15:13:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1vL45lTB/0VGltIDOuVQYLt3el8=; b=BtnpVD
	X9QThLMrepSg4N6PxCzWEs6kOzqPvgl7P7D/kN3HiQVYOPreix0MwUf8JwuK3L8u
	Y8T3N1H8JJ62aui9IZuNVZ09lq7n2zVG/GAJX+8dIX+jRx1DbgCGhsg6KL4EJGDj
	0HWb5I+lo1dS87f6sKczd6PdWO9Xh5eQVeE6c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=R2JKngKs+tPLYpSv4Ltq9G8dZgPokMPu
	zAxixQ/DnldkX6kNYLzcv46xJU0dyz4ENDxvudYJbTAZkP4S/CNvew/So0BR+GRj
	6YaYnpKABlA1jxObEJmfoEar/ZUNyhT1iO5nVLE01eHd0nhYOeFoujGgofp+efEs
	boyQ3WeX1H8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 23DAF3AA9;
	Tue,  1 Mar 2011 15:13:53 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 60EEB3AA6; Tue,  1 Mar 2011
 15:13:45 -0500 (EST)
In-Reply-To: <vpq4o7mfzd1.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Tue\, 01 Mar 2011 19\:51\:38 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6DC07DCA-4440-11E0-956B-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168252>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> But "update" should mean "replace git add -u with git add -u .", which
> is the portable way to do the same.
>
>> so the introduction of the configuration becomes a flag-day event.
>> Hmph...
>
> The introduction of the config variable is a non-event if you already
> use the portable . notation.

I think you got this part wrong.  Until now, there was no "portability" to
worry about when using "git add -u".  "git add -u" used to be _guaranteed_
to be relative to the cwd, with or without ".".  Our update will _break_
that expectation and suddenly make "." "the portable notation".

In other words, it is far from a non-event.  We cannot say "'add -u .' is
the portable way to write it anyway, so you should have been writing that
from day one" as an excuse for breaking their scripts.

We still have to say "We are sorry, we will be breaking your scripts.
Please add an extra dot at the end".  I am Ok saying that, but we should
admit that we are knowingly breaking things.
