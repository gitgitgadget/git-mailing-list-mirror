From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Path character encodings
Date: Mon, 05 Mar 2012 14:18:27 -0800
Message-ID: <7v62eizo7g.fsf@alter.siamese.dyndns.org>
References: <20120305212657.GA17903@jupiter.local>
 <7vipiizpyn.fsf@alter.siamese.dyndns.org>
 <20120305220232.GA18247@jupiter.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Betts <paul@paulbetts.org>
X-From: git-owner@vger.kernel.org Mon Mar 05 23:18:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4gEo-0000Dh-6q
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 23:18:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756807Ab2CEWSd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Mar 2012 17:18:33 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53136 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755178Ab2CEWSc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2012 17:18:32 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ED6D273A2;
	Mon,  5 Mar 2012 17:18:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9x9I/gPpT6qlUSlWXUxdEyo1NhI=; b=tB/bSG
	RWro5qPDYtDptnuOGpIi7x1xYFy52qIDdO35l7mF1M0ylFNdO48OMP6+1xASna4X
	Xccjc2/Ns1W9C3VprTtSWrrViDkmPnFQkuceguQ3ohgK1R6IB1o5BVjOmryeTrgU
	lCF+T5iZuhjK+31oubTufij1x9ABs0AT7N+kM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VY0vK0NyaHudl0y0bNhc5cztmYAxSEto
	YeqDKqHT5JQ3ppD1DJd/eUZJkGx4Xryd5Nmn+Yg8tWdHMgZX0tbXk/sw9SfbzIHB
	Y5LgKJCz9D9kOh+MX92ZydjzV+lopRN6Map29hf9rEv5qEaqUgqCKC45utwrsnVn
	0IwPV5gd4O0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E4B5973A1;
	Mon,  5 Mar 2012 17:18:29 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F3F14739F; Mon,  5 Mar 2012
 17:18:28 -0500 (EST)
In-Reply-To: <20120305220232.GA18247@jupiter.local> (Paul Betts's message of
 "Mon, 5 Mar 2012 14:02:32 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2294AB9C-6711-11E1-8071-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192280>

Paul Betts <paul@paulbetts.org> writes:

> On Mon, Mar 05, 2012 at 01:40:32PM -0800, Junio C Hamano wrote:
>> Hmph, I do not see a reason to make a huge molehill in this. The
>> pathnames are of unspecified encoding, and if a project declares
>> that they always use UTF-8, that would be great. 
>
> I would like to propose, that Git codifies-as-required the majority case
> today, that trees should *only* be encoded in UTF-8 going forward. 

I am afraid that that would be a hard sell.

As the pathnames are uninterpreted strings, an older project that
has been using 8859-1 (or EUC for various locales, or anything that
is superset of ASCII) has no good incentive or reason to follow such
a unilateral decision made outside their project, only to get their
participants inconvenienced.  Even giving a "warning" will trigger
"Yeah we know our paths are in latin-1 and everybody in our project
has happily been using that, thankyouverymuch!" and annoy them.

It is not an argument that their history can be re-coded to UTF-8
without losing information, if they still have to go through the
conversion process that their project do not benefit from.

Can we make this per-project opt-*in* somehow?
