From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Keep original author with git merge --squash?
Date: Fri, 13 Feb 2015 11:30:53 -0800
Message-ID: <xmqq1tltobgy.fsf@gitster.dls.corp.google.com>
References: <CAN7QDoKQAZKUt_MHWjgt1k3PvXQv6XTcjdijh8KRodO3=VD47A@mail.gmail.com>
	<20150212092824.GA19626@peff.net>
	<xmqqpp9erihg.fsf@gitster.dls.corp.google.com>
	<CAN7QDoLKFBCJpFa+QL8dPQtwyAyDNt-ck_sNJ3fS+vTrK_Lg9w@mail.gmail.com>
	<xmqq8ug2rfi2.fsf@gitster.dls.corp.google.com>
	<CAN7QDoJ+hOFqoc54sAbLeSxvj8TQKQRSVKbNQXZYfPv1uOy=WA@mail.gmail.com>
	<xmqq4mqqrc70.fsf@gitster.dls.corp.google.com>
	<20150212225003.GA20763@peff.net>
	<xmqqwq3mogdm.fsf@gitster.dls.corp.google.com>
	<20150213071041.GA26775@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Glasser <glasser@davidglasser.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 13 20:31:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YMLx8-0000At-FB
	for gcvg-git-2@plane.gmane.org; Fri, 13 Feb 2015 20:31:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753216AbbBMTa6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2015 14:30:58 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54534 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753019AbbBMTa5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2015 14:30:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7ABE823988;
	Fri, 13 Feb 2015 14:30:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TNHpJWx7o1GfIwMOHF+swmAY654=; b=f2nCQQ
	rj3XJwOjYyUohd64T5ze+rTiHH6xGbCTfzKpszIfp9ZHQUxDFNqP6D6S9S/OmY5o
	48jSGDREB5gYo0BDrf/uvNl4eOsREXL7TC6lCT/AoheiTJuZycWPqDNKpIUU3oru
	f+zSvLfFB3br/2E42aC9lgYBz/sZBdiEm+H3U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ktfUIdaNFXUUIkldC8kmdMa43swxnj4/
	coRcYwOp/VTTxdAc+zo3rxWH1DfDVI6Vbtaa2+pB7pS+QxuS+97utEAxw/j11jt5
	L2z0mvx+ntkzV+i3HxYbt14cNn25OG9p9UfEBPtYLgqaW3DixZ/tkIJ0Y69jW9z4
	ZQFjDbTxmfM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7259E23987;
	Fri, 13 Feb 2015 14:30:56 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 028EE23985;
	Fri, 13 Feb 2015 14:30:54 -0500 (EST)
In-Reply-To: <20150213071041.GA26775@peff.net> (Jeff King's message of "Fri,
	13 Feb 2015 02:10:41 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D4027F40-B3B6-11E4-94CB-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263824>

Jeff King <peff@peff.net> writes:

> On Thu, Feb 12, 2015 at 03:32:37PM -0800, Junio C Hamano wrote:
>
>> > It also raises a question for the proposal in this thread: if there are
>> > multiple "Author:" lines, which one do we take? The first, or the last?
>> 
>> I was siding with David's "pay attention to in-buffer Author: only
>> when all of them agree".  When squash-merging a branch with two or
>> more authors, we would attribute the authorship silently and
>> automatically to you if you do not do anything special otherwise.
>
> That's probably reasonable. I was thinking more of a case where you made
> some fixups on top of somebody else's branch, and then used "git rebase
> -i" to squash them together. But I think we already use the authorship
> for the root of the squash in that case.
>
> This case collapses nicely if we make a slight tweak to your proposed
> behavior (or maybe this is what you meant). If there are multiple
> authors listed, we behave as if none was listed. That would leave the
> authorship as it behaves today (with the author of the first commit) if
> you do nothing, or you can override it by dropping all but one.

I actually was (and am still) wondering that "silently ignore all of
them if there are multiple ones that contradict with each other" is
a bad idea, and that was why the last item on the "possible
alternatives" list was to error out and ask clarification.
