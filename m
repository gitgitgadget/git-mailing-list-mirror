From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 17/19] transport-helper: export is no longer always the
 last command
Date: Mon, 13 Jun 2011 08:24:03 -0700
Message-ID: <7vvcw9pxf0.fsf@alter.siamese.dyndns.org>
References: <1307558930-16074-1-git-send-email-srabbelier@gmail.com>
 <1307558930-16074-18-git-send-email-srabbelier@gmail.com>
 <7vsjrjzubl.fsf@alter.siamese.dyndns.org>
 <BANLkTim1R=1SrUXgOOjmRioG45KKVity3Q@mail.gmail.com>
 <20110609075141.GA4885@elie>
 <BANLkTinuZAJtuGw4hOLLjqLx5pN9iDhh+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 13 17:24:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QW908-00010E-1M
	for gcvg-git-2@lo.gmane.org; Mon, 13 Jun 2011 17:24:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753697Ab1FMPYV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2011 11:24:21 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63681 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753590Ab1FMPYU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2011 11:24:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D8F2B4808;
	Mon, 13 Jun 2011 11:26:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Z2ju4nXxVqEsKXtG9u3gnCygmfY=; b=o9TPLv
	tkQDCB4rQ0X8TmPvUuLRFjYlp1HAHELE4/Ah1CUI6HpgBRFv4P0J4gaSjeELJt/L
	KYXfruh3PNa0I8pOgwxp5Af2CyWrWVkDpXTqbhbGm9q/fPb3mM5UR8GkJE3/sy4S
	dk2mtXHblz13K22R+tY+2QQN94+DiJlVyBWUk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KPfg9Bwm2LZRq+gLrW2T+eBS7UfvhEIe
	AiqaAruZHsprDz6rN1brPuYvh2yFKvYmr32N8X7akootRoIgMHNx4dUY1CsnW7mv
	iOg1XKk6UjOZFgNyOee1Nqojk3zLEvSfUVd19UKYYpEUE/3WjPU/FNF7moLYeG07
	y6HbK7beH08=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 79A9F4802;
	Mon, 13 Jun 2011 11:26:23 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A9F264801; Mon, 13 Jun 2011
 11:26:15 -0400 (EDT)
In-Reply-To: <BANLkTinuZAJtuGw4hOLLjqLx5pN9iDhh+w@mail.gmail.com> (Sverre
 Rabbelier's message of "Thu, 9 Jun 2011 10:28:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7F173572-95D1-11E0-8A01-C8CFB7AE1C3C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175713>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> On Thu, Jun 9, 2011 at 09:51, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Yes, but I'm still missing something.  What does the trailing \n ever
>> have to be written?
>>
>> "git log -Sdisconnect_helper -- transport-helper.c" doesn't give many
>> clues.  I imagine it's a way to check whether the child is still alive
>> and to warn it not to be alarmed when the output end of its input pipe
>> closes.
>
> Yes, the trailing \n is to signal to the helper that the connection is
> about to close, allowing it to do whatever cleanup necessarily. It's
> kind of like the "done" command for fast-import.

... which is the kind of clarification I wanted to see as the comment to
document that no_disconnect_req field, whose semantics was unclear even to
two people who are known to know a bit about git and had to ask you to
clarify.
