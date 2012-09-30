From: Junio C Hamano <gitster@pobox.com>
Subject: Re: bug report, v1.7.12.1 -- user-manual.xml:3739: parser error
Date: Sun, 30 Sep 2012 00:04:33 -0700
Message-ID: <7vpq54gfem.fsf@alter.siamese.dyndns.org>
References: <20120930021524.01d314d5.hesco@campaignfoundations.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: hesco@campaignfoundations.com
X-From: git-owner@vger.kernel.org Sun Sep 30 09:04:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIDa1-0007sV-VZ
	for gcvg-git-2@plane.gmane.org; Sun, 30 Sep 2012 09:04:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751924Ab2I3HEh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2012 03:04:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43952 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751616Ab2I3HEg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2012 03:04:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C9759A8B;
	Sun, 30 Sep 2012 03:04:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ggk5hDocleNJNU8k/XwcU6z7478=; b=HaX4U1
	38LiM9saOO4S6vPdEVBFlnPhvUDY41+ayxHyGj9C3TTFOeQo7ts+wqHKPMYrCegx
	k3hLsjlmlRVlOJkPd5Z0VNh3MGSYA/EnEGqGu9cCZqkbic4k3L1OWVs9A0hvnw1G
	4H5cfvNDjxdC8ouHFALPqlB1nrNg4OEurcZYE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=p5N52SLqlVTXXBdfD4PHEM2Cba0VOp4l
	P5u9RFFGLJAcD1hF5okJ65D4Yx+G/N6Ldkgg/RNf9RMCHfaDALZjJvn3DxJ6rf3P
	Nyv9Hs6RuSxYjHLyvCRJEyMXJCW9bbrN9t10CWTxySXVufAAi7Q6cAisOuJRiMth
	vB0O+Z4sxSo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 70C3E9A8A;
	Sun, 30 Sep 2012 03:04:35 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BDEAC9A89; Sun, 30 Sep 2012
 03:04:34 -0400 (EDT)
In-Reply-To: <20120930021524.01d314d5.hesco@campaignfoundations.com> (Hugh
 Esco's message of "Sun, 30 Sep 2012 02:15:24 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 172BBEF2-0ACD-11E2-BE58-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206669>

Hugh Esco <hesco@campaignfoundations.com> writes:

> doing a source install of git v1.7.12.1, 
> on the `make all doc` step, I get:
>
> user-manual.xml:3739: parser error : Opening and ending tag mismatch: emphasis line 3739 and literal
>   char <emphasis role="strong"></literal>, but is actually expected to be a poin
>                                          ^
> user-manual.xml:3741: parser error : Opening and ending tag mismatch: literal line 3741 and emphasis
> mit.  Note that whenever a SHA-1 is passed as <literal>unsigned char </emphasis>
>                                                                                ^
> unable to parse user-manual.xml
> make[1]: *** [user-manual.html] Error 6
> make[1]: Leaving directory `/usr/local/git-git-51993a4/Documentation'
> make: *** [doc] Error 2

Thanks for a report.

I and other regulars on the list who run "make doc" are not getting
that error (otherwise the source wouldn't have tagged as a release),
so there must be some difference between the environments that are
supported and your setting.

As described in the INSTALL document at the top-level of the source
tree, our documentation toolchain has external dependencies on
asciidoc, xmlto, and docbook-xsl among other things.  My quick check
seems indicate that I am using asciidoc 8.5.2-1, xmlto 0.0.23-2, and
docbook-xsl 1.75.2.

What version are you using?  It could be you are using a newer
version of something that is backward incompatible we haven't
encountered (or you could be using a version that is too stale).
