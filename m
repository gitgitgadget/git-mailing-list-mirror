From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] fetch: bigger forced-update warnings
Date: Wed, 07 Sep 2011 14:53:32 -0700
Message-ID: <7vty8o10kj.fsf@alter.siamese.dyndns.org>
References: <20110902000039.GB9339@sigill.intra.peff.net>
 <4E6088F9.5070102@drmicha.warpmail.net>
 <20110902152947.GB19213@sigill.intra.peff.net>
 <7v4o0uncq0.fsf@alter.siamese.dyndns.org>
 <20110902162524.GC19690@sigill.intra.peff.net>
 <CAJo=hJtuUe1ajjW9dNU4JzjE+P94a42W7ZvC+iQBQTeGXVvS8Q@mail.gmail.com>
 <20110905204729.GB4221@sigill.intra.peff.net>
 <CAJo=hJtvU+ujYBMvrgVJpBdaTUq+NOsQwVFkL-A4pHv-CRPdDg@mail.gmail.com>
 <20110905205735.GA5578@sigill.intra.peff.net>
 <CAJo=hJvFSegSzTOMj824PoG=soj75JMChfRnjyz4rNgUcVM=Jw@mail.gmail.com>
 <20110907212042.GG13364@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Pearce <spearce@spearce.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 07 23:53:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1Q3z-0004TE-KM
	for gcvg-git-2@lo.gmane.org; Wed, 07 Sep 2011 23:53:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757285Ab1IGVxh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Sep 2011 17:53:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62103 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757274Ab1IGVxf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Sep 2011 17:53:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B8423549A;
	Wed,  7 Sep 2011 17:53:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0oO8UlpOkdWJ4uMk3wE+ayAsIgU=; b=kbUS+4
	GuRCxF4eRXHofhOZE2lei4T7wmb/6mANCljtJ0SqoiE3umm8DrZLMRkqqZyZHoB4
	Mc5DfnBHMsKS0WS1C8EK9aAL3OydznTuSdXrDVY32BOnwN3a90fGzcpIFRPwJmWn
	mEnqi+bay/h9FLroVecsaHO1NyNrOlre0g2dk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IA8JsKDz3mZQD5PNIfPvqOCo3yp070d7
	XxEEvQN5P8iMK2XOZS3uzCpgRzeOHAdGeLmugyxdMyHuL63wEBx5MKwt3E/I0ZyH
	x5ImJpkGEguXDZ9cp+yvCjeVo9HUHlVHcur6sixQ46elcrUdOUoXhWn94ys/2DSh
	moAQ1nmhZlE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AF7C45499;
	Wed,  7 Sep 2011 17:53:34 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 413665497; Wed,  7 Sep 2011
 17:53:34 -0400 (EDT)
In-Reply-To: <20110907212042.GG13364@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 7 Sep 2011 17:20:42 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D54BBA2C-D99B-11E0-8481-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180919>

Jeff King <peff@peff.net> writes:

> Subject: fetch: bigger forced-update warnings
>
> The default fetch refspec allows forced-updates. We already
> print "forced update" in the status table, but it's easy to
> miss. Let's make the warning a little more prominent.
>
> Some branches are expected to rewind, so the prominent
> warning would be annoying. However, git doesn't know what
> the expectation is for a particular branch. We can have it
> guess by peeking at the lost couple of reflog entries. If we

s/lost/last/

> see all fast forwards, then a new forced-update is probably
> noteworthy. If we see something that force-updates all the
> time, it's probably boring and not worth displaying the big
> warning (we keep the status table "forced update" note, of
> course).
>
> Signed-off-by: Jeff King <peff@peff.net>

This is slightly offtopic, but I have been wondering if this approach do
the right thing for "git pull". Wouldn't the underlying "git fetch" give a
warning, and then the calling "git pull" go ahead and make a merge,
scrolling the warning away with the merge/update summary diffstat? That
would be a larger change if "git pull" needs to stash away the warning
message, do its thing and then spit out the warning later.

> +static int forced_update_is_uncommon(const char *ref)
> +{
> +	struct update_counts uc;
> +	memset(&uc, 0, sizeof(&uc));
> +	if (for_each_recent_reflog_ent(ref, count_updates, 4096, &uc) < 0)
> +		for_each_reflog_ent(ref, count_updates, &uc);
> +	return uc.fastforward && uc.forced <= 1; /* 1 for the one we just did */
> +}

Looks sensible.
