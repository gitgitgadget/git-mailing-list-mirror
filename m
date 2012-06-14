From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] git bisect old/new
Date: Thu, 14 Jun 2012 10:34:57 -0700
Message-ID: <7vlijper0e.fsf@alter.siamese.dyndns.org>
References: <1339466625-17461-1-git-send-email-Valentin.Duperray@ensimag.imag.fr>
 <1339541765-2078-1-git-send-email-Valentin.Duperray@ensimag.imag.fr>
 <7vr4tkhys5.fsf@alter.siamese.dyndns.org>
 <20120613200606.Horde.QkenYnwdC4BP2NaOTf8gvnA@webmail.minatec.grenoble-inp.fr> <CAP8UFD2LBKXuey2w_-0Zy9Thi1DWCgekjCL3RULmHWVK5DXCog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: duperrav@minatec.inpg.fr,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	git@vger.kernel.org, Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Lucien Kong <Lucien.Kong@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Peff <peff@peff.net>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 14 19:35:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SfDwl-0000sB-Py
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jun 2012 19:35:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755409Ab2FNRfB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jun 2012 13:35:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39451 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755286Ab2FNRe7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2012 13:34:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 114128727;
	Thu, 14 Jun 2012 13:34:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MQVkQ7fEgacEMkDp6W88afrdGL4=; b=R8VdCi
	CHTrzTq3GDHUplq4tAlRS7ZUh9aRkqIoVY0n7h9whKLf83RGyUj1lZkmgfpOmzs+
	KhdNkEyI4IUN8DXnRT4o5s2uT6dTWAV7VSj+oP6CJsMGbx0N7ckLokH7ub5ryFi5
	41sxoOm9+Q32ChdtgDMkJkrIVUVIPLxO3WsBc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JmAGkuyUSJ4XqX2eBJFcy8+pGOxWiT93
	pEpAJRx4T8sU5+inKSqr6uRu3vbUpuPFVHyYV5gTRAEAo8BsVRMoCPRfGQ3qByVt
	VZcYpOTIvybYyB2bm6WmPTyboXgKrh6jWlmwj8wyi9IuiFPNGJa41uQV2COSONmE
	Cyxo9DjrIOE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E99528726;
	Thu, 14 Jun 2012 13:34:58 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7571B8724; Thu, 14 Jun 2012
 13:34:58 -0400 (EDT)
In-Reply-To: <CAP8UFD2LBKXuey2w_-0Zy9Thi1DWCgekjCL3RULmHWVK5DXCog@mail.gmail.com>
 (Christian Couder's message of "Thu, 14 Jun 2012 11:56:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 43439788-B647-11E1-8A61-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200025>

Christian Couder <christian.couder@gmail.com> writes:

> Peff said:
>
> -------
> Hmm. I think this is not quite as nice, but it is way simpler. It may be
> worth trying for a bit to see how people like it. If they don't, the
> cost of failure is that we have to maintain "old/new" forever, even
> after we implement a yes/no reversible scheme. But maintaining the
> old/new mapping from yes/no would not be any harder than the good/bad
> mapping, which we would need to do anyway.
>
> So it sounds like a reasonable first step.
> -------

The above is a very reasonable stand.  But I do not think it leads
to the following at all.

> So I'd rather have a file with a generic name like "BISECT_TERMS", but
> it may contain just one line like for example "new/old".

That is forcing an unnecessary complexity, when we do not even know
if we need anything more than old/new.  We can start simple and the
result may be sufficient and in which case we can stop there.

In fact, Peff's advice you quoted is against doing what you just
said, which is to do more than we know that we need right now.

If we end up needing arbitrary pair of words, then at that point we
may add a mechanism that records the pair of words in use, be they
<yes/no>, or <frotz/xyzzy>.  And when that happens, <new/old> will
continue to be supported for free--there is no extra work to support
<new/old> in addition to the work needed to support <good/bad> and
<arbitrary1/arbitrary2> that we need to support anyway.
