From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Move sequencer to builtin
Date: Mon, 10 Jun 2013 01:32:11 -0700
Message-ID: <7v8v2il62c.fsf@alter.siamese.dyndns.org>
References: <20130608164902.GA3109@elie.Belkin>
	<CAMP44s06DaV2G0rbhzJRMujEJnqeGYYv2G-a90pLL6AOS0gp+w@mail.gmail.com>
	<20130608173447.GA4381@elie.Belkin>
	<CAMP44s0n0qEk+1HhpAm-fMn+BWFwOeZCp7pgq9==09COVoNNEw@mail.gmail.com>
	<20130609014049.GA10375@google.com>
	<CAMP44s3CGHVLnkUxo=PR_b+_dTuaz5rwems_pd9GE1_vcEaYRA@mail.gmail.com>
	<20130609052624.GB561@sigill.intra.peff.net>
	<CALkWK0mu2_9M5aTczcEkv37eLaAg5_mGDZ_W9nqQFoesB4wc3g@mail.gmail.com>
	<20130609180437.GB810@sigill.intra.peff.net>
	<CALkWK0kkhDOSSdF=E4PvO24hg++_FpP3YFaGRD3yq80XG0TRJA@mail.gmail.com>
	<20130609184553.GG810@sigill.intra.peff.net>
	<7vppvvnetw.fsf@alter.siamese.dyndns.org>
	<CAMP44s3p1atFz52-mKaKpZkLGp+Uoehc1ovTUQAN-raxWzWd8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Brandon Casey <drafnel@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 10:32:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlxWV-0004Hm-4X
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 10:32:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752384Ab3FJIcP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 04:32:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52812 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751971Ab3FJIcO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 04:32:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3859926EEE;
	Mon, 10 Jun 2013 08:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wv4aNfL4GYXgEOEB2UcUjBWUeHY=; b=J6oI1E
	MsqdcPpY8tRmTSZLvi5EZ49ZHNPvYOZAbeA7xGh+SD1Z6Y3zXzSEwh/6E2Az0R3e
	bOXlH+8wE8Z6HV97TTu+zhayo0SZNu3+EwSV6IHhsVutoevB11ppWcaCSfNaw8x0
	pNMLQeSxO4DViRItQMXkXbwqNsIuzKEKegxyE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PzY8+9sK2ar+ux3sgCfwDCXocySLO1em
	wsUQjoU8tgEBaOfh2amDncTSkB4jtjGueDvb0ubL0s0cecrJMZLopGmya8w2B+66
	7hsRPSAywqL3XLPUtSYnYJyY3567/YiMDJyac/377H3DI4ufKRJObrN144wLbVGp
	9X8NfdR83Dg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F0F326EED;
	Mon, 10 Jun 2013 08:32:13 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9266726EEA;
	Mon, 10 Jun 2013 08:32:12 +0000 (UTC)
In-Reply-To: <CAMP44s3p1atFz52-mKaKpZkLGp+Uoehc1ovTUQAN-raxWzWd8Q@mail.gmail.com>
	(Felipe Contreras's message of "Mon, 10 Jun 2013 00:06:15 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3F96FB66-D1A8-11E2-AA3B-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227261>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Sun, Jun 9, 2013 at 4:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> One example of killing the entire thread is when I see "This patch
>> will not be applied" by Felipe in a thread started with his patch.
>> I understand that it is his way to say "this patch is retracted"
>> without having to explicitly say that he now understands that
>> reviews showed why the patch was wrong or that he thanks the
>> reviewer for enlightening him.
>
> You are wrong. There's nothing wrong with the patch.
> ...
> I thought you understood that code should speak, but apparently you don't.

That is exactly the point Peff raised (and I agreed with), isn't it?

Bad behaviour (being difficult to work with) has consequences.  E.g.
convincing people that it is not worth their time interacting with
you, especially when there are better things to do like tending to
other topics, and you lose the chance to show that your patches are
good when they indeed are (I don't even know if these patches in
question are good, and I am not going to find out).
