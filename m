From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/7] Tying loose ends on grep-pcre
Date: Wed, 10 Oct 2012 09:52:34 -0700
Message-ID: <7vlifeclrh.fsf@alter.siamese.dyndns.org>
References: <1349855714-17008-1-git-send-email-gitster@pobox.com>
 <5075919F.5030306@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Oct 10 18:52:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLzWb-0005XX-IG
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 18:52:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752905Ab2JJQwj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2012 12:52:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65316 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750784Ab2JJQwi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2012 12:52:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 718669314;
	Wed, 10 Oct 2012 12:52:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8A2477HMEKVbfhnZGLp2cQI8/6o=; b=SUzeD9
	ohxqKy3JwUGqaQbE/HrC4iqJOyyZG806CVK+4WNpdbIDxKevADd539M2lNorfXmh
	n26DCsJz6ccoXC168+yTI5IAMTKBsS/aBxCTW/8w1uEpXlddWvE7HbXAHhHw/RkQ
	vRB9GxtHa2bw7coWT6o4bWfq28q8BKsXuTA7U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OLpuE6PFL19Gac8AVgBVMhhTAfVML8lj
	ae3oKiTFdlJ1So+STAko66nmuRTwnSotE1n2JKojgvirYrlng6ZVoVDjTGTh5PdN
	7Tdy2ylMzAnc12F1qKa6UyUfiB5k+pzfVeQjNCwKP8MmMx4r0gW7l081B5/VmpL6
	UF3pbU1uuiM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F74C9313;
	Wed, 10 Oct 2012 12:52:37 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AF68A9311; Wed, 10 Oct 2012
 12:52:36 -0400 (EDT)
In-Reply-To: <5075919F.5030306@alum.mit.edu> (Michael Haggerty's message of
 "Wed, 10 Oct 2012 17:17:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E4FA3B94-12FA-11E2-9DF6-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207417>

Michael Haggerty <mhagger@alum.mit.edu> writes:

>> The last one teaches "git log" family to honor the "grep.*"
>> configuration variables, e.g. "grep.patterntype", so that you can
>> say "git -c grep.patterntype=perl log --grep='(?:pcre)'".
>
> Maybe this has been discussed already, but it seems to me that adding a
> persistent setting that affects how "git log --grep" interprets the
> pattern argument could break some scripts that assume that the "old"
> interpretation is always used.  Shouldn't this at least be documented as
> a backwards incompatibility?

If somebody scripts around "log" with hardcoded query "--grep=..."
strings, they can force a particular variant from such a command
line at the same time.  But as always, responsibility of doing so is
on the person who writes such a script; "log" being a Porcelain, we
value ease-of-use in interactive case more than cast-in-stone
interface stability like we do for plumbing commands.

And that is exactly why the series avoids changing the behaviour for
the "rev-list" plumbing.
