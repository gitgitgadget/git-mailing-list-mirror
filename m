From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv5 2/6] Gitweb: add support for minifying gitweb.css
Date: Wed, 14 Apr 2010 17:46:27 -0700
Message-ID: <7veiihmtjw.fsf@alter.siamese.dyndns.org>
References: <4BB430C3.9030000@mailservices.uwaterloo.ca>
 <201004140030.47222.jnareb@gmail.com>
 <7viq7tmvsb.fsf@alter.siamese.dyndns.org>
 <201004150225.42101.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Charles Bailey <charles@hashpling.org>,
	Mark Rada <marada@uwaterloo.ca>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 15 02:46:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2DEF-0001st-CM
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 02:46:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755456Ab0DOAqm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Apr 2010 20:46:42 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44002 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755182Ab0DOAql (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Apr 2010 20:46:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E540AB27C;
	Wed, 14 Apr 2010 20:46:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3zXpSMggQzUJ9WO9OUohquxIuXg=; b=SEIXSp
	26CrObBI19RtFjuqrSiwEwvar2RO6OMD38PZr8yoS5Yz9QR6NT+Pe6WZotV+AX+U
	NbmTZdLA5pn2W/R4T25Qf/SfXNuT0o/J6toyVCAQry20Oq8Tc9vD2QYvkLn+Wwgo
	f08HMfHltKaCFuiAIRpgXmsTV5LJ3RP5H5lVE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Q4wYp2XtA7jvHuS3boEOYSx118ZRVNfY
	MfNWVw7YAMy/gHv8aConlbCq8OM1m5JbS4uiZBvj4h39T85mbmWZo6m/6iPQKUVD
	3M7DMxnd36RpmGjQ4o480P3yHNX651fD8cgeMV4Pe8NdqEtO4NjwOOpgD7HitW/v
	ccEd7TgnD8o=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 64E09AB27A;
	Wed, 14 Apr 2010 20:46:33 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9CDBDAB279; Wed, 14 Apr
 2010 20:46:28 -0400 (EDT)
In-Reply-To: <201004150225.42101.jnareb@gmail.com> (Jakub Narebski's message
 of "Thu\, 15 Apr 2010 02\:25\:41 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 56A345A6-4828-11DF-A165-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144935>

Jakub Narebski <jnareb@gmail.com> writes:

>> -gitweb.cgi: gitweb.perl $(GITWEB_JS) $(GITWEB_CSS)
>> +gitweb.cgi: gitweb.perl
> ...
> That makes gitweb.cgi not depend on gitweb.min.js, not gitweb.min.css.

That is what I inteded to do.

Unless you are including gitweb.cgi (iow, the contents of the generated
file depends on the _contents_ of gitweb.min.js (or gitweb.js), gitweb.cgi
does _not_ depend on these files.  Of course if you generate gitweb.cgi
out of gitweb.perl with one setting of GITWEB_JS and then change your
mind, then you need to regenerate it, but that is not something you can do
by comparing file timestamp of gitweb.cgi and the file timestamp of
$(GITWEB_JS) anyway.  You would need to imitate something like how
GIT-BUILD-OPTIONS is used by the primary Makefile.
