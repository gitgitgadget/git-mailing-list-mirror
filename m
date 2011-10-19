From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Restrict ref-like names immediately below $GIT_DIR
Date: Wed, 19 Oct 2011 10:10:42 -0700
Message-ID: <7vr528di0d.fsf@alter.siamese.dyndns.org>
References: <1316121043-29367-1-git-send-email-mhagger@alum.mit.edu>
 <1316121043-29367-20-git-send-email-mhagger@alum.mit.edu>
 <20111011161652.GA15629@sigill.intra.peff.net>
 <7vr52jfm8i.fsf@alter.siamese.dyndns.org>
 <7vmxd7flkw.fsf@alter.siamese.dyndns.org>
 <7v39ezffq5.fsf_-_@alter.siamese.dyndns.org>
 <20111011230749.GA29785@sigill.intra.peff.net>
 <7vehyjcckp.fsf@alter.siamese.dyndns.org>
 <20111012021128.GA32149@sigill.intra.peff.net>
 <7v39eyddoc.fsf@alter.siamese.dyndns.org>
 <20111012045004.GA22413@sigill.intra.peff.net>
 <7vvcru9k22.fsf_-_@alter.siamese.dyndns.org> <4E95D60B.5030904@alum.mit.edu>
 <7vr52i9j8g.fsf@alter.siamese.dyndns.org> <4E9609E3.1000300@alum.mit.edu>
 <7v39epft32.fsf@alter.siamese.dyndns.org>
 <7vty75ec54.fsf@alter.siamese.dyndns.org> <4E9EEA4D.50207@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org, cmn@elego.de,
	A Large Angry SCM <gitzilla@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Oct 19 19:10:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGZfG-0004hl-Ah
	for gcvg-git-2@lo.gmane.org; Wed, 19 Oct 2011 19:10:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756820Ab1JSRKq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Oct 2011 13:10:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42314 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755822Ab1JSRKp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2011 13:10:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD08A489E;
	Wed, 19 Oct 2011 13:10:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=opjozJQVRlEZ7VakyVPyaET02ow=; b=m13Cer
	3EfT3MYuCcAphPP6VbZJyu2C7S3uE7fH9Ds7S4/YUOjUUPI/nGQzhVb34cl0F01E
	+NpZMkpLcATUxcffNg1vA5GuHIFGAo6IcuX0ljRfcq5nx1TrxwxKTMb8iIOuLXvP
	Ifp2s+Y+kUIvopzrq/kWYR/pFR+TAaqHRsZ7c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C4l/zqx8R1xg2i6kOahlZ4bA6khoHidb
	xjEVFBjwDhhWXo+2VqDQhhWCskEDC0lxuWfmDxhlIbMRAaHPUdB9gqUzYYEjXBOg
	UP2GOC5PMsy3GDrN+v/sOLA5Y0BvIraRKCh8O/PedsTsT4vjKSwMsJxbEUGdm2aV
	om2Pz3ex0FY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C1FBC489D;
	Wed, 19 Oct 2011 13:10:44 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4A4D7489B; Wed, 19 Oct 2011
 13:10:44 -0400 (EDT)
In-Reply-To: <4E9EEA4D.50207@alum.mit.edu> (Michael Haggerty's message of
 "Wed, 19 Oct 2011 17:18:37 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 47C7567A-FA75-11E0-AA7F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183937>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 10/19/2011 08:19 AM, Junio C Hamano wrote:
> 
>> A possible alternative might be to leave check_refname_format() and its
>> callers as they are, introduce check_full_refname() function that knows
>> the new restriction on top of check-ref-format-fixup, and use that in
>> lock_ref_sha1(), lock_any_ref_for_update() and is_refname_available()
>> [*2*]. That way, we can keep the potentially useful "ill-formed contents
>> in the ref" warning and avoid possible confusion caused by random files
>> that are directly under $GIT_DIR, which would be far more preferable in
>> the longer term.
>> 
>> Anybody wants to give it a try?
>
> I think that the refs/-or-ALL_CAPS test fits most naturally in
> check_refname_format(), controlled by an option flag.

That is fine too, if a separate function check_full_refname() would end up
being nothing more than a thin wrapper that passes the "we are checking a
full refname" option.

> I'm starting by building parts of the solution, namely something like:
> ...
>
> Hopefully I'll have patches before the end of the (Berlin) day.

It is unclear how these two functions could be related to the issue, but
hopefully we will soon find out when we see your patch.  Thanks.
