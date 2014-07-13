From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3 v5] tag: support configuring --sort via .gitconfig
Date: Sun, 13 Jul 2014 10:01:03 -0700
Message-ID: <xmqqk37h19dc.fsf@gitster.dls.corp.google.com>
References: <1405099447-27555-1-git-send-email-jacob.e.keller@intel.com>
	<1405099447-27555-3-git-send-email-jacob.e.keller@intel.com>
	<20140711174628.GC7856@sigill.intra.peff.net>
	<xmqqmwcf36jy.fsf@gitster.dls.corp.google.com>
	<20140712011735.GB17349@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jacob Keller <jacob.e.keller@intel.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jul 13 19:01:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6N9I-0007E9-AW
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jul 2014 19:01:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754073AbaGMRBN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2014 13:01:13 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52747 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753968AbaGMRBL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2014 13:01:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 37E6925E6D;
	Sun, 13 Jul 2014 13:00:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EfcEwMfSQwOWmC13Md0yeBeSTOo=; b=xaLX0M
	qyvH5mwujU9hYsqWTlSol5A8bTUjK1FCOegyRauB0W49f7YhvE+rXbBA+3H6NzTk
	esiKPhWXyTb4X/T6nhDAbXjn4ZS02rY0bVDK+s8aN2+Uy5pTQzbi59FQBsLHyaQd
	jrj+lARlSul3MKN0iK1HxbLcbzYdl+NJErvBE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oSzsnNRWjgnjqE7dG8t9weQfZCY4Xngz
	xxaZSuR1+mF9z5CNzD6FAHtdZtLl7PqeOSis+9pRi9xUD6wT3Ofl0/rWUSc7kKPd
	CvxwAamNtBeIz/2jfFm0OdSuzaD95aBgJslMSRd2Btubrc7sdvxyGlxdgLqbIwzl
	Anoog3b0CoE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2EE2725E6C;
	Sun, 13 Jul 2014 13:00:53 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 891ED25E62;
	Sun, 13 Jul 2014 13:00:47 -0400 (EDT)
In-Reply-To: <20140712011735.GB17349@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 11 Jul 2014 21:17:35 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3C553166-0AAF-11E4-ACA5-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253450>

Jeff King <peff@peff.net> writes:

> On Fri, Jul 11, 2014 at 02:54:25PM -0700, Junio C Hamano wrote:
>
>> > Yeah, we're quite inconsistent there. In some cases we silently ignore
>> > something unknown (e.g., a color.diff.* slot that we do not understand),
>> > but in most cases if it is a config key we understand but a value we do
>> > not, we complain and die.
>> 
>> Hm, that's bad---we've become less and less careful over time,
>> perhaps?
>
> I don't think so. I think we've always been not-very-lenient with
> parsing values. Two examples:
> ...
> So I do not think we have ever had a rule, but if we did, it is probably
> "silently ignore unknown keys, complain on unknown values".

Yeah, somehow I was mixing up these two cases fuzzily in my mind
while responding.  Rejecting unknown keys is bad, but we cannot be
perfectly forward compatible nor behave sensibly on unknown values
while issuing errors against known-to-be-bad values, so your rule
above sounds like the most sensible thing to do.
