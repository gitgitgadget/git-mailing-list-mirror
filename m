From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] transport-helper: report errors properly
Date: Thu, 11 Apr 2013 11:49:29 -0700
Message-ID: <7vbo9kj41y.fsf@alter.siamese.dyndns.org>
References: <20130410211311.GA24277@sigill.intra.peff.net>
 <20130410211552.GA3256@sigill.intra.peff.net>
 <CAMP44s02K5ydKLNi0umMkuAicoVTWyCdVfjs0yssCa2oyFShGQ@mail.gmail.com>
 <20130411161845.GA665@sigill.intra.peff.net>
 <CAMP44s2-4i_tSzz8Y88_YnK5d1AjNoTqOa7eXZ0W5Vzk9Uosng@mail.gmail.com>
 <20130411165937.GA1255@sigill.intra.peff.net>
 <CAMP44s1KgpT5YGwAr2KAToaoB6rUmtM3ocA-OtFSGfOzudx5RA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 11 20:49:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQMYy-00076x-VS
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 20:49:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933289Ab3DKStd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 14:49:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39485 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752355Ab3DKStc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 14:49:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 91B95140D6;
	Thu, 11 Apr 2013 18:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+IREETpiOGgjmz+gGYTlY/vKLYA=; b=p9mqsV
	bL9Z6ZaDsItSAxxvniXD3sHBnuvV/xuOBoS6WZVj2SGBxDkVVtBhm7lNbaUSoQhP
	WRTBQ0kwn7H+Ql6UukPZENngglNW848EA/TEeW6Uk8UcUijpB9fpCBQW1wgIlLnl
	HhHEf+F5nx1ktUaXQU+T/KJME2hk3S6nhppew=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UWRL2nLKwzZGH7NkWJHWsL5P6x4CGDn6
	94AWF4pYXNA/i978HxmBqvnoxPmp+vKIhRmrG+1kWh+b5eUIWuPRGS5xEaTWIBNJ
	t43lged4aNILsCJvAX3GEkguSkmWZGf5IXBwMBp/3VOJxTPR1CnE4cRqZ1XztW1L
	9aoxTvjbeqA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 84DDB140D5;
	Thu, 11 Apr 2013 18:49:31 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 010B0140D4; Thu, 11 Apr
 2013 18:49:30 +0000 (UTC)
In-Reply-To: <CAMP44s1KgpT5YGwAr2KAToaoB6rUmtM3ocA-OtFSGfOzudx5RA@mail.gmail.com> (Felipe
 Contreras's message of "Thu, 11 Apr 2013 12:57:34 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8B699F02-A2D8-11E2-9574-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220912>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Thu, Apr 11, 2013 at 11:59 AM, Jeff King <peff@peff.net> wrote:
>
>> But I give up on you. I find most of your commit messages lacking in
>> details and motivation, making assumptions that the reader is as
>> familiar with the code when reading the commit as you are when you wrote
>> it. I tried to help by suggesting in review that you elaborate. That
>> didn't work. So I tried to help by writing the text myself. But clearly
>> I am not going to convince you that it is valuable, even if it requires
>> no work at all from you, so I have nothing else to say on the matter.
>
> Me neither. I picked your solution, but that's not enough, you
> *always* want me to do EXACTLY what you want, and never argue back.
>
> It's not going to happen. There's nothing wrong with disagreeing.

Heh, it seems that I was late for the party.

Writing only minimally sufficient in the log messages is fine for
your own project. We won't decide nor dictate the policy for your
project for you.

But _this_ project wants its log messages to be understandable by
people who you may disagree with and who may have shorter memory
span than you do.  Disagreeing with that policy is fine.  You need
to learn to disagree but accept to be part of the project.

Thanks.
