From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Strange effect merging empty file
Date: Thu, 22 Mar 2012 12:12:06 -0700
Message-ID: <7vwr6cwiux.fsf@alter.siamese.dyndns.org>
References: <4F69AD3C.4070203@ericsson.com> <4F69B375.5050205@in.waw.pl>
 <86iphwomnq.fsf@red.stonehenge.com> <4F6B1F48.3040007@in.waw.pl>
 <20120322140140.GA8803@sigill.intra.peff.net>
 <7vty1gy3eh.fsf@alter.siamese.dyndns.org>
 <20120322175952.GA13069@sigill.intra.peff.net>
 <20120322182533.GA20360@sigill.intra.peff.net>
 <7v62dwxybd.fsf@alter.siamese.dyndns.org>
 <20120322190303.GA32756@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Ralf Nyren <ralf.nyren@ericsson.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 22 20:12:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAnQm-00055L-21
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 20:12:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127Ab2CVTML (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 15:12:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48290 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757448Ab2CVTMJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 15:12:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B07766885;
	Thu, 22 Mar 2012 15:12:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=w7mtQve7N5rz9/WwElHreOtPuZE=; b=mcJayH
	sYN1Adp4quzNWCU3v6189ctkijbFhlOea6GEPb+RzpK0hmmKNZEl5HzgQVjALrDz
	rISpb8qaroi5f69A/qBodiFofcpMhOO1RtUpv3eKTlLbSOqyOrRjlH3UBF092Dl2
	BTh7p9QMPmycwDOiZ7IYXsfjKFHTb8Y6U8yAw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HPfE8W0C1BCKZhzi4Cauw1f05HIxgOv+
	XeVNPrsyqrHPp7CNNRvmc2PxqrVsALvJgRsivlkk/TR97A/bjd2Wm0MXTqKMoZON
	EKj+Vn7SGSuqzriaGlHbKwOcJcncTG1rERkBPLe/hb8Yd7Vm6IqzurbCkCBU7aqz
	X8TVNo4OsWc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A09F26884;
	Thu, 22 Mar 2012 15:12:08 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B2751687F; Thu, 22 Mar 2012
 15:12:07 -0400 (EDT)
In-Reply-To: <20120322190303.GA32756@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 22 Mar 2012 15:03:03 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EB0C9C44-7452-11E1-B2FD-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193691>

Jeff King <peff@peff.net> writes:

> That is a slight layering violation, in that we are making assumptions
> about how the diffcore-rename subsystem works.

I do not think I have to say any more than that.  The special case we want
to have is for the "empty to empty" case and nothing else, and I do not
want to see people having to remember to look at the merge-recursive code
if/when rename detection starts to treat "empty to small" as "rename with
minor modification."
