From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] merge-base: "--is-ancestor A B"
Date: Fri, 31 Aug 2012 11:45:20 -0700
Message-ID: <7v3932oq7z.fsf@alter.siamese.dyndns.org>
References: <1346368388-23576-1-git-send-email-gitster@pobox.com>
 <1346368388-23576-3-git-send-email-gitster@pobox.com>
 <CANiSa6iy60Ts5Rdss6EwGN5Vp9KCqn35BzMC+Aacm+zqWjp4-w@mail.gmail.com>
 <7vtxvjnfcu.fsf@alter.siamese.dyndns.org>
 <CANiSa6i5tY_V_dhK0wSaKzy0xwvN9uTqRJUJ7ZvgqCG7Ta5rsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 31 20:45:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7WDm-0006qr-FO
	for gcvg-git-2@plane.gmane.org; Fri, 31 Aug 2012 20:45:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754646Ab2HaSp1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Aug 2012 14:45:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61986 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754275Ab2HaSp0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2012 14:45:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 65BA8858A;
	Fri, 31 Aug 2012 14:45:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=r27YKZ582iasM9uQ3/BptPtkPdM=; b=HTdgTw
	fl3IEopMWnkZCO6vEqzryjFqgvdN0e3f+YPhhok3/h/1O5aUMVSNOs254CjailJx
	WxhAROSWrjwc6qzZR8ZExW/CDxn+fQbwrIaX/X8pM3RFZedit3/pXoECES4nO1i6
	sYpIg3Iz+atBl/fV3X+auTWnIACpjfiB3xg8c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vS8ycKeSzYOGMLewOE6FxjUUQ4H/QExY
	eAiKSNrFyvWdDJj4d3jsEj9MxGzrmdNTua8Sg9hZ8c878flT5BzGCUlkirrznOEa
	4ox9K2xKaWogf0ondWwA0zGskJzVFD2UyDXwSBjFGPH6nM28zMwztI67A8A0hpkK
	Q1yMr4TdaWU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 537808589;
	Fri, 31 Aug 2012 14:45:23 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DFDC58587; Fri, 31 Aug 2012
 14:45:21 -0400 (EDT)
In-Reply-To: <CANiSa6i5tY_V_dhK0wSaKzy0xwvN9uTqRJUJ7ZvgqCG7Ta5rsQ@mail.gmail.com> (Martin
 von Zweigbergk's message of "Fri, 31 Aug 2012 11:03:28 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 04D37F08-F39C-11E1-A9F9-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204603>

Martin von Zweigbergk <martinvonz@gmail.com> writes:

> On Fri, Aug 31, 2012 at 10:25 AM, Junio C Hamano <gitster@pobox.com> wrote:
> ...
>> I think "merge-base -h" will get this for free thanks to parseopt.
>
> It seems not, or maybe I'm using the wrong terminology; I meant to
> include it in the first part of the below.
>
> usage: git merge-base [-a|--all] <commit> <commit>...
>    or: git merge-base [-a|--all] --octopus <commit>...
>    or: git merge-base --independent <commit>...
>
>     -a, --all             output all common ancestors
>     --octopus             find ancestors for a single n-way merge
>     --independent         list revs not reachable from others
>     --is-ancestor         is the first one ancestor of the other?

Ahh.

As most of the modern parse-optified ones just say "git cmd <args>"
or something like that, I wasn't paying attention to the upper part.

Will amend again.  Thanks.
