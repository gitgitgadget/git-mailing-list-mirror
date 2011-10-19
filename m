From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Restrict ref-like names immediately below $GIT_DIR
Date: Tue, 18 Oct 2011 22:28:33 -0700
Message-ID: <7v39epft32.fsf@alter.siamese.dyndns.org>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org, cmn@elego.de,
	A Large Angry SCM <gitzilla@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Oct 19 07:28:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGOhm-00008c-8U
	for gcvg-git-2@lo.gmane.org; Wed, 19 Oct 2011 07:28:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755220Ab1JSF2h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Oct 2011 01:28:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33213 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752526Ab1JSF2g (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2011 01:28:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E2CE72101;
	Wed, 19 Oct 2011 01:28:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UtEKVKhY/M2e4QJgysDT3BmzaQs=; b=JZw+d0
	CFy4QHuiqk7P6bjiCut+reV7pw1wuQeMxke4SD+824i7HTo/BRdSFZgoGRztzzVN
	50ZLnZn/cSpxL9ry3zgECmGfWstnRL9krIDXlmuWYlt2wvnt21TSYhBMzR8ir4kY
	kL5yDF9XiTd9Hax28oImJsVlQF9bPWqn2V5dA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yTwCbGStQNkTCVKh5eAR/8MPCitJZgJC
	18dEfU2OPH5XfzJZ3HXj0K775PZp5A1d5k8caXCgq42Y45k4EpEiaGwrwy/RGdK4
	rUwx4hKpdQ8/dWh3nCfrY1RokI+b56jVB+SIy0SvYX8oA7yAKQ9QISe+EuOZ8lUq
	1M7ufZGzIi0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D82B72100;
	Wed, 19 Oct 2011 01:28:35 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 364D720FF; Wed, 19 Oct 2011
 01:28:35 -0400 (EDT)
In-Reply-To: <4E9609E3.1000300@alum.mit.edu> (Michael Haggerty's message of
 "Wed, 12 Oct 2011 23:42:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 30DEDBCA-FA13-11E0-982F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183916>

Michael Haggerty <mhagger@alum.mit.edu> writes:

>>> Nit: the seen_non_root_char variable can be replaced by an early "return
>>> 0" from the loop and "return 1" if the loop falls through.
>> 
>> Hmm, I thought that would fail when you feed "refs/heads/master" to the
>> function.
>
> You're right.  My brain must be scrambled from all of the rebasing that
> I have been doing ;-)
>
> How about adding
>
> /*
>  * Accept strings that are either ALL_CAPS or include a '/'.
>  */
>
> (I think the underscore is implied by the example, but the comment could
> be expanded if necessary to be explicit.)

I was trying to summarize this topic for Release Notes.

  Possibly incompatible changes
  -----------------------------

   * Special refs such as "HEAD", "MERGE_HEAD", and "FETCH_HEAD" are now
     restricted to names with only uppercase letters and underscore. All
     other refs must live under refs/ namespace. Earlier, you could
     confuse git by storing an object name in $GIT_DIR/tmp/junk and say
     "git show tmp/junk", but this will no longer work.

But noticed that "git update-ref tmp/junk HEAD" does create such a ref
that won't be recognized, and "git check-ref-format tmp/junk" is happy.

I think we would need to restrict check_ref_format() so that these
commands (and possibly others, but I think that single function will cover
pretty much everything) also reject "tmp/junk" immediately below $GIT_DIR
as a bad string. Otherwise we cannot merge these fixups, which would mean
we would have to revert the "Clean up refname checks and normalization"
series, at least the part that started emitting the "warning", which is a
mess I would rather want to avoid.

Opinions on how to get us out of this mess?
