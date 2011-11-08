From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] remote: add new sync command
Date: Tue, 08 Nov 2011 09:49:51 -0800
Message-ID: <7vvcquy05c.fsf@alter.siamese.dyndns.org>
References: <1320682032-12698-1-git-send-email-felipe.contreras@gmail.com>
 <20111107172218.GB3621@sigill.intra.peff.net>
 <CAMP44s358k4EsCg+K6MeLEU4eLbb4mWyX9AdAf4P9CHvf9Lrwg@mail.gmail.com>
 <20111107183938.GA5155@sigill.intra.peff.net>
 <CAMP44s0M-qnZeHCUadSJJCYO=t881sUOi11G3fCG2vaAakPyBQ@mail.gmail.com>
 <20111107210134.GA7380@sigill.intra.peff.net>
 <7vhb2f1v7g.fsf@alter.siamese.dyndns.org>
 <CAMP44s0vsQ5sfx8arrRDo+-g9Zff_MmCz5t+yghwCMx_pL4Xzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 08 18:50:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNpo8-0007Ya-Mi
	for gcvg-git-2@lo.gmane.org; Tue, 08 Nov 2011 18:50:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756181Ab1KHRt4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Nov 2011 12:49:56 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54786 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756139Ab1KHRtz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2011 12:49:55 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 840336F80;
	Tue,  8 Nov 2011 12:49:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=70TnsW7NQS7PXEfDqRZ2czXgSNI=; b=bcEkW0
	Tszkp2sXQj25rZpYKiZER/kEiYv50pmfgMb0Z+UHdQDCnCS5PRWFknxVsGK7k0Gg
	Nypr24QSaNMctbcm1ec1lBflfpIWyQiRPRiMR6Nepnt+3lVJGNdhYJtIQ8MZf0wj
	SKybKoOs2sJzIeumOZWEUvfDv3hMmG0Rz2FjA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AVcJz09CjayBPflCOQeUcgz5sAkHU6rK
	tj9yQreTBCZbWJratykmnaEG1gKfLgICPh4iw9Ps3erQGMofCbo3lWMNR/rcS+f8
	bN+UjMQme+V0L27fJf0YYY/r3ki3uHz/ISLpLH6FcFA5DkapaT2NNYW/NV+i35uM
	bsUBRyojf8E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F68A6F7F;
	Tue,  8 Nov 2011 12:49:54 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7C4786F7E; Tue,  8 Nov 2011
 12:49:52 -0500 (EST)
In-Reply-To: <CAMP44s0vsQ5sfx8arrRDo+-g9Zff_MmCz5t+yghwCMx_pL4Xzg@mail.gmail.com> (Felipe
 Contreras's message of "Tue, 8 Nov 2011 18:43:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0FA8F718-0A32-11E1-B7E2-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185100>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Mon, Nov 7, 2011 at 11:25 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Jeff King <peff@peff.net> writes:
>>
>>> That makes sense. But I think it fits in with git's current UI to do
>>> this via a combination of push options and refspecs. Even if we want to
>>> wrap it in some "git remote" command for convenience, I think what
>>> you're asking should be implemented as part of "git push".
>>
>> Yeah, I think it makes sense to give --prune to "push" just like "fetch"
>> already has. These two are the primary (and in the ideal world, only)
>> operations that talk to the outside world. "remote add -f" might have been
>> a tempting "convenience" feature, but I personally think it probably was a
>> mistake for the exact reason that letting anything but "push" and "fetch"
>> talk to the outside world just invites more confusion. There does not have
>> to be 47 different ways to do the same thing.
>
> What about 'git remote update'?

If you asked, I would have to say that is probably a worse mistake in the
hindsight. I am guessing that back them "remote" command might have been a
tool meant only for the read-only customers and the verb "update" may have
made sense as "update me from the upstream", but these days "remote" also
helps the aspect of pushing things out (e.g. "set-url --push"), so "update"
that does not specify the direction is totally an inappropriate verb.

You _could_ argue that adding subcommands and options related to pushing
to "git remote" was a mistake. I don't care too much which side you would
choose to blame, but taken as the whole, in the current set of options,
subcommands and what "git remote" command does, "update" is a complete
misnomer.
