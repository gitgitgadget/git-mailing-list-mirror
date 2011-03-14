From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git workflow for beta/production
Date: Mon, 14 Mar 2011 16:11:45 -0700
Message-ID: <7vlj0hb8lq.fsf@alter.siamese.dyndns.org>
References: <324BE2A8-5987-4324-AE27-D5CC01341710@appnexus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Joseph Huttner <jhuttner@appnexus.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 00:12:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzGvf-0002DZ-OA
	for gcvg-git-2@lo.gmane.org; Tue, 15 Mar 2011 00:12:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756749Ab1CNXLy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2011 19:11:54 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48288 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756412Ab1CNXLx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2011 19:11:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D56CC41FA;
	Mon, 14 Mar 2011 19:13:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/gW+5E72ewWFPcxYPic5Tg/Hz54=; b=WGdigq
	DcIyaqnRffRzakC2O+gX7n+GsPuaOQtpdd3uI7+XSlIHhEsVPd0HOWERXegugJgN
	GwHCQWbS79oGwNO64zOzCz64safjTfzhOpAkDkhyFp9p4SYXREfr1qMIdyf61ihh
	rOyQFApYh4fTZzYxJ7thZo5hbE8wr71ZVeQ8c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YbcDQsc4l0CLhalfpfZbzNQoZK0kz9sJ
	iA67Ml23no+TdpQRmml2xE9nEsMOfjx+mGpAR+KIT0KhQvRhZfHMbRPPuShRTwMo
	mMd9GsPps5YAg36B2ur29ZdfBjmrJLE6EpKIOd5Y4StoBAZRBzRv9cB42nKvF7Sq
	aKx/4qKz5zY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B433441F9;
	Mon, 14 Mar 2011 19:13:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C19FD41F4; Mon, 14 Mar 2011
 19:13:18 -0400 (EDT)
In-Reply-To: <324BE2A8-5987-4324-AE27-D5CC01341710@appnexus.com> (Joseph
 Huttner's message of "Mon, 14 Mar 2011 15:27:22 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A7AE382E-4E90-11E0-9CF8-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169034>

Joseph Huttner <jhuttner@appnexus.com> writes:

> I am in search of a new Git workflow.  Previously, my team was
> essentially using using gitflow by Vincent Driessen (nvie).  It worked
> very well, but the needs of project have changed, so here are the new
> requirements:
>
> 1.  A "Beta" environment that contains stable code for all features
> being considered for "Production."
> 2.  A "Production" environment.  Rock-solid, well-tested code only.  
>
> The catch is that after a feature has been stomped on in Beta, it
> **may** go to Production, but only if Product Managers still think it is
> an important feature.  In other words, there is no guarantee that a
> feature in Beta will ever make it to Production.  It may be axed
> completely, in which case it would never get to Production and would be
> taken out of Beta.  Also, there is no guarantee that features that do
> make it to Production will go in in the order that they went in to Beta.

Is it just me, or does the above sound exactly like how git itself is
managed, when "Beta" and "Production" are read as "next" and "master"?

> A few notes that may matter:
>
> a) Six developers on team and growing.  Will be 9 by the summer.

120 active developers on team for the last 6 months, among which 35 people
have more than 5 commits.

> b) Codebase is 110K in-house lines.

157k lines counting only '*.[ch]' files.

> c) Typically, a feature is worked on by 1-3 developers at a time.  Total
> development work on a feature can be anywhere from two hours to two
> months.  The median is about two weeks.

Quite similar.

> d) Currently, per week, about 15 bug reports come in for today's
> equivalent of the Beta branch.

Git being a volunteer project it is probably harder to compare; we have
busy weeks and quiet weeks.  For the past 6 months, I count 230 merges to
the 'mater' that merges fully cooked topics, so that is roughly 8-9 topics
a week.

> Ideally, using the new workflow, releases to Beta would be a few times
> per week.  Releases to Production would be once per month.  This is the
> same as our current release cycle.

I do merges to 'next' roughly once per day (sometimes twice a day,
sometimes once every other day), and 'master' roughly twice a week.

All of the above makes me suspect that imitating what I do and other
people work with me might be one possible approach.
