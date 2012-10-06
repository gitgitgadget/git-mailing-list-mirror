From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git-svn, perl/Git.pm: extend and use Git->prompt
 method for querying users
Date: Sat, 06 Oct 2012 11:28:10 -0700
Message-ID: <7vmwzzqwud.fsf@alter.siamese.dyndns.org>
References: <4EC52508.9070907@tu-clausthal.de>
 <4EC65DE4.90005@tu-clausthal.de>
 <CABPQNSbfM0JRVPk3fxfSEq7QaO-fynHM8FBGpPribdgeRqpZKA@mail.gmail.com>
 <4ED0CE8B.70205@tu-clausthal.de>
 <20111130064401.GC5317@sigill.intra.peff.net>
 <4EF907F1.1030801@tu-clausthal.de> <m3d3baf5kd.fsf@localhost.localdomain>
 <4EF9D8B9.9060106@tu-clausthal.de> <4EF9EBF4.7070200@tu-clausthal.de>
 <4EF9ED58.8080205@tu-clausthal.de> <7vd3b967ql.fsf@alter.siamese.dyndns.org>
 <7vty4l4rr8.fsf@alter.siamese.dyndns.org> <4EFA5F08.2060705@tu-clausthal.de>
 <7vpqf91kqo.fsf@alter.siamese.dyndns.org> <4EFAF241.9050806@tu-clausthal.de>
 <7v39c41keo.fsf@alter.siamese.dyndns.org>
 <7vpqf8z8a6.fsf@alter.siamese.dyndns.org> <4F00B7F3.1060105@tu-clausthal.de>
 <4F038E49.9080809@tu-clausthal.de> <7vy5toqqab.fsf@alter.siamese.dyndns.org>
 <50704BB8.1020603@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>
To: Sven Strickroth <sven.strickroth@tu-clausthal.de>
X-From: git-owner@vger.kernel.org Sat Oct 06 20:28:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKZ6t-00088K-BO
	for gcvg-git-2@plane.gmane.org; Sat, 06 Oct 2012 20:28:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753222Ab2JFS2N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Oct 2012 14:28:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55632 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751676Ab2JFS2M (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Oct 2012 14:28:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 760AE90B5;
	Sat,  6 Oct 2012 14:28:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aSaKsmAI7vEIRd3yZANMegaAVBA=; b=SxMqWk
	SRYroVpP8qeSx4Py23TV0JrisAakv8sDojN6Cfkz2zzLrLWt02DBHeEReezX2Qon
	GaJLk1ZK5j8n8OgA5MwJE1nKt/3ya/Sq6xvk+Lg9ZmLiVRckx4LDxzeG6s7BXxW0
	9JWK7rCg2CmmGaasitlxP7o7di01T2KCapFKg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pRjlZwz93c68ZEd1nfguzNp5cxLzVzws
	F68Wsws0W9ZW+p+0jBAbEqW7QKQ4gi71zY4/bnfCM1PuhGh78N5+6DYBZ6WawoRk
	1kfSGAyunzb+4FXNYDDDVmhlFGK5AL1GgGA4tbdcE39wpvKw6A/k37U4FJCUxeGp
	o/s9pYwHnLM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 62DA490B4;
	Sat,  6 Oct 2012 14:28:12 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D55E790B3; Sat,  6 Oct 2012
 14:28:11 -0400 (EDT)
In-Reply-To: <50704BB8.1020603@tu-clausthal.de> (Sven Strickroth's message of
 "Sat, 06 Oct 2012 17:18:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 95BE634E-0FE3-11E2-8077-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207161>

Sven Strickroth <sven.strickroth@tu-clausthal.de> writes:

> Am 04.01.2012 01:12 schrieb Junio C Hamano:
>> Now "prompt" is no longer a method but is merely a helper function, so
>> I've queued this (and 1/2 rewrite we discussed in a separate thread) to
>> 'pu' after rewording the commit log message.
>> 
>> Thanks.
>
> Is there a reason why these changes did not get merged? The issues are
> still there.

It is either that it was simply forgotten, or after I wrote the part
you quoted early in January there were discussions later that showed
the patch was not desirable for some reason. I do not recall which.
