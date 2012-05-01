From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Choose XDL_FAST_HASH code on sizeof(long) instead of
 __WORDSIZE
Date: Tue, 01 May 2012 10:33:30 -0700
Message-ID: <7vhavzajrp.fsf@alter.siamese.dyndns.org>
References: <7v4ns0cy3l.fsf@alter.siamese.dyndns.org>
 <399c9a1f0dd548da3144eff3c50d04a8f343ab24.1335860033.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gernhardt <brian@gernhardtsoftware.com>,
	<git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue May 01 19:33:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPGxK-0005E7-OV
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 19:33:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758145Ab2EARdi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 May 2012 13:33:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48955 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758034Ab2EARdg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 13:33:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 78C50631F;
	Tue,  1 May 2012 13:33:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9vXpdMOKocUz3OCIGcCoLPu5yQQ=; b=KoQXA9
	I5hoxkiuOqc9WbaFTQKjPMbOJMIEfqMZJjEOmaiF0AARlU56UPgT/fhMwgQsxnf8
	Sfzojp0eBAnOV2Ec2K8q3vgSYnGIAtQbBsbukXVr1ppaUvWM+rzCLh+Se7mtS21N
	73gc8G4W992rM59dRrItvLgQcmKQiHEQtp2xI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NxRhzFMtCGIqWQoOwJWzW3GDaf4t8O59
	X94K0pZtR14i91xLKENDw8owGI+ODx0kk2SfEPzNT4EHqoxc++ZCW3lyi+YUBSsI
	j/+TVX4uJ1LjtHSn45hC6ZWlmCeJRyqPtz8nFVC9T4a9Vk3EW/cXshO9ufOtgiAS
	5dI7jXzzmS4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F9F4631E;
	Tue,  1 May 2012 13:33:35 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CEFA1631D; Tue,  1 May 2012
 13:33:31 -0400 (EDT)
In-Reply-To: <399c9a1f0dd548da3144eff3c50d04a8f343ab24.1335860033.git.trast@student.ethz.ch> (Thomas Rast's message of "Tue, 1 May 2012 10:36:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C56E26BC-93B3-11E1-91EC-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196708>

Thomas Rast <trast@student.ethz.ch> writes:

> Darwin does not define __WORDSIZE, and compiles the 32-bit code path
> on 64-bit systems, resulting in a totally broken git.
>
> I could not find an alternative -- other than the platform symbols
> (__x86_64__ etc.) -- that does the test in the preprocessor.  However,
> we can also just test for the size of a 'long', which is what really
> matters here.  Any compiler worth its salt will leave only the branch
> relevant for its platform, and indeed on Linux/GCC the numbers don't
> change:

Thanks.
