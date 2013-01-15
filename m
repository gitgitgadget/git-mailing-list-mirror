From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote-hg: store converted URL
Date: Tue, 15 Jan 2013 12:10:19 -0800
Message-ID: <7vobgq2ono.fsf@alter.siamese.dyndns.org>
References: <1357760618-81222-1-git-send-email-max@quendi.de>
 <7vmwwbd43o.fsf@alter.siamese.dyndns.org>
 <64C81CD0-960A-47F2-89FC-8D3126B1F4D5@quendi.de>
 <7vzk0a4ekj.fsf@alter.siamese.dyndns.org>
 <7vr4lm4cez.fsf@alter.siamese.dyndns.org>
 <B35B3EA6-F01B-46D8-AC3D-0F7C8A45A06B@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Tue Jan 15 21:10:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvCqN-0001Uv-T8
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 21:10:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756107Ab3AOUK1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 15:10:27 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36970 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752370Ab3AOUK0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 15:10:26 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D65B1AD93;
	Tue, 15 Jan 2013 15:10:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=j2dXqMELO8+kqR6YG7Kp8eXKB7Y=; b=vbH+ro
	ynA3SAidL3c3Ko9dN2JLg/lVsnnbCMJcwA3jrn2qgftwpo/ZFSV5L2i3i1FdgjO4
	ki4uw+AZtm68sW06GEk4k0bFlGXH6ZCmnWVzFp5F6YH1A5uMICgDyIaCm8+e6beF
	TUTisqa56ZUd81NS7dW9XUS1rBfyjrscj/Gog=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sN3atRAjXtO2rppOhLApu3+nsLDy9wDT
	uqAzdL28T3i0Hbk6SfJzYCQDumlFh4NuzCjcALpjwdTT/1j63GoWUgBtdP4dkXVu
	33mkmDam84WHkW2An6swFbvUJWE+tXw2DwjIZUGMSmIBJepRD5lTSy+shzMpFSui
	Ky33QrIcT6o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C9590AD91;
	Tue, 15 Jan 2013 15:10:21 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 46F90AD90; Tue, 15 Jan 2013
 15:10:21 -0500 (EST)
In-Reply-To: <B35B3EA6-F01B-46D8-AC3D-0F7C8A45A06B@quendi.de> (Max Horn's
 message of "Tue, 15 Jan 2013 19:10:01 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 96E217C8-5F4F-11E2-977E-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213669>

Max Horn <max@quendi.de> writes:

> So far, all I look at do not deal with this at all. Any attempts
> to deal with it should be pretty easy to recognize: The
> remote-$backend would have to store something into the git config,
> or else, verify the opaque token and refuse to work with it under
> certain conditions (e.g. when it contains a relative path). But
> they don't. E.g. git-remote-testgit has the exact same problem.

Thanks for confirming what I suspected.  I think the way Felipe's
patch makes remote-hg take responsibility of how $opaqueToken should
look like for future invocations is the simplest and makes the most
sense.  We could try to go fancier and end up over-engineering, but
I'd rather have a simple fix in the tree first.

Thanks.
