From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add new @ shortcut for HEAD
Date: Tue, 30 Apr 2013 10:22:02 -0700
Message-ID: <7vppxcdjd1.fsf@alter.siamese.dyndns.org>
References: <1367264106-2351-1-git-send-email-felipe.contreras@gmail.com>
	<CACsJy8D_gPpprETkAxf+eYp5DMt7uVt6nanCwthZO=vVfBT28Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Seymour <jon.seymour@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 19:22:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXEFo-0001IH-72
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 19:22:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932644Ab3D3RWH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 13:22:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62989 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932593Ab3D3RWG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 13:22:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 704961A233;
	Tue, 30 Apr 2013 17:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HodIhS55/mfiH+SBK1UXz4R3cHo=; b=H9v492
	JBJOgb6Ch0xB9k5hozzfBYKYEhFNIwYl4TM83ErD8WXDdLBM0QwNt6H0LgnMfmip
	KGIKjXN+orw0+DOdJjppbHLoyAkj6sL9oyapeGH9T8wIUBlUoHVxkob1dbODCAoI
	anutzwJtnTYRIYkBcbp6YDZGpyBqG/IZ+QTg8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oVXUrekHlFc2mU/vkl7xyN6vQm+BVG04
	upuP/1sntGn1P54PvFqEF+GfN9WfaOfM5ydHYi1EsSygarRSFHAWZpxhfJL9vdYO
	sQUjqzB6GEZYvlVEJSqqRPRK1pZqFj5O+eC9JusbLW+2gu2Uz55CQCecliS5EF+U
	gDElU1MXYUM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 659871A232;
	Tue, 30 Apr 2013 17:22:04 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B9AE61A230;
	Tue, 30 Apr 2013 17:22:03 +0000 (UTC)
In-Reply-To: <CACsJy8D_gPpprETkAxf+eYp5DMt7uVt6nanCwthZO=vVfBT28Q@mail.gmail.com>
	(Duy Nguyen's message of "Tue, 30 Apr 2013 12:54:39 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 79A95B4A-B1BA-11E2-AA72-A3355732AFBB-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222953>

Duy Nguyen <pclouds@gmail.com> writes:

> On Tue, Apr 30, 2013 at 2:35 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> So we can type '@' instead of 'HEAD@', or rather 'HEAD'. So now we can
>> use 'git show @~1', and all that goody goodness.
>
> I like this. I haven't spent a lot of time on thinking about
> ambiguation. But I think we're safe there. '@' is not overloaded much
> like ':', '^' or '~'.
>
>> This patch allows 'HEAD@' to be the same as 'HEAD@{0}', and similarly with
>> 'master@'.
>
> I'm a bit reluctant to this. It looks like incomplete syntax to me as
> '@' has always been followed by '{'. Can we have the lone '@' candy
> but reject master@ and HEAD@? There's no actual gain in writing
> master@ vs master@{0}.

Originally I was going to say the same, but after thinking about it
a bit more, I changed my mind.

If you accept only "@" but not "master@", that behaviour needs a
wrong world model to understand and justify (one of which is "@ is a
synonym for HEAD").  If your rule is "In $anything@{$n}, you can
drop {$n} when $n==0", then HEAD@{0} becomes HEAD@ and master@{0}
becomes master@, and @{0} becomes @ naturally.

We should make sure that the code rejects "git update-ref @ foo"
because that is "git update-ref @{0} ref", by the way.  I didn't
check with Felipe's patch.

>> +'@'::
>> +  '@' alone is a shortcut for 'HEAD'
>> +

I think this explanation sends a wrong message, hinting as if you
can expect "update-ref @ master", "symbolic-ref @ refs/heads/next"
etc. to do something sensible to HEAD.

Felipe's original justification in the log message "I want to drop
{0}" sounds closer to what is going on here.
