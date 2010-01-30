From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFH] rpm packaging failure
Date: Sat, 30 Jan 2010 14:22:03 -0800
Message-ID: <7vd40rjks4.fsf@alter.siamese.dyndns.org>
References: <7v8wbgueqz.fsf@alter.siamese.dyndns.org>
 <20100130151921.GM29188@inocybe.localdomain>
 <7vsk9nsemh.fsf@alter.siamese.dyndns.org>
 <20100130194746.GN29188@inocybe.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Todd Zullinger <tmz@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 30 23:22:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbLhw-0004vi-JN
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 23:22:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754055Ab0A3WWS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2010 17:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754047Ab0A3WWS
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 17:22:18 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34906 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754002Ab0A3WWS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2010 17:22:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C1FA4952FB;
	Sat, 30 Jan 2010 17:22:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3Bqe/RnTUjWbhcumNsD7PqrnPuw=; b=TnJeWr
	lKTq18tIihjiosiGs+jVBxujlHOIDvjLZK9WdkBmpKofWtDCU+d9eLkebh801jTk
	qioTd13c9F+e00bh0PJn0g+4HErLxpg9LjyCsZR+RiqORaUIYDplvdgh9r3orGVQ
	+Uv32AC+ZJCCtEBHMZlwY5V4uwN6w/FiEo08k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OHv/ejg4qktLuA1DkMQHgO1Y9tjJzC1B
	G7iJGEWRPPovmsF0iOJe7nLpX8UfpbN4LMcXO4DNZCMj2T5C5toXsF2zvJ82L6aK
	VABiErqjSCph6l5K20tU+48wEjpyNa+jBY1H6QsGOduPMzy5pD8KSjd171A/ZC9K
	orwCsaLMfD8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7BADB952FA;
	Sat, 30 Jan 2010 17:22:10 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7B969952F9; Sat, 30 Jan
 2010 17:22:05 -0500 (EST)
In-Reply-To: <20100130194746.GN29188@inocybe.localdomain> (Todd Zullinger's
 message of "Sat\, 30 Jan 2010 14\:47\:46 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E891D574-0DED-11DF-9C77-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138503>

Todd Zullinger <tmz@pobox.com> writes:

> Not shipping them if they aren't yet used/needed for anything other
> than folks working on remote helpers seems reasonable and the rm in
> the spec file should do the trick nicely.

Thanks.

To allow us to go forward a bit easier, I am planning to use the attached,
as we would need some parts of it when we do start generating a separate
package, I think.

-- >8 --
Subject: [PATCH] RPM packaging: don't include foreign-scm-helper bits yet

The files in /usr/lib/python* are only the support infrastructure for
foreign scm interface yet to be written and/or shipped with git.  Don't
include them in the binary package (this will also free us from Python
dependency).

When we ship with foreign scm interface, we will need to package these
files with it in a separate subpackage, but we are not there yet.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git.spec.in |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/git.spec.in b/git.spec.in
index ab224f7..0a03108 100644
--- a/git.spec.in
+++ b/git.spec.in
@@ -98,6 +98,7 @@ BuildRequires:  perl(Error)
 Perl interface to Git
 
 %define path_settings ETC_GITCONFIG=/etc/gitconfig prefix=%{_prefix} mandir=%{_mandir} htmldir=%{_docdir}/%{name}-%{version}
+%{!?python_sitelib: %define python_sitelib %(%{__python} -c "from distutils.sysconfig import get_python_lib; print get_python_lib()")}
 
 %prep
 %setup -q
@@ -112,6 +113,7 @@ rm -rf $RPM_BUILD_ROOT
 make %{_smp_mflags} CFLAGS="$RPM_OPT_FLAGS" DESTDIR=$RPM_BUILD_ROOT \
      %{path_settings} \
      INSTALLDIRS=vendor install %{!?_without_docs: install-doc}
+test ! -d $RPM_BUILD_ROOT%{python_sitelib} || rm -fr $RPM_BUILD_ROOT%{python_sitelib}
 find $RPM_BUILD_ROOT -type f -name .packlist -exec rm -f {} ';'
 find $RPM_BUILD_ROOT -type f -name '*.bs' -empty -exec rm -f {} ';'
 find $RPM_BUILD_ROOT -type f -name perllocal.pod -exec rm -f {} ';'
@@ -190,6 +192,9 @@ rm -rf $RPM_BUILD_ROOT
 # No files for you!
 
 %changelog
+* Sat Jan 30 2010 Junio C Hamano <gitster@pobox.com>
+- We don't ship Python bits until a real foreign scm interface comes.
+
 * Mon Feb 04 2009 David J. Mellor <dmellor@whistlingcat.com>
 - fixed broken git help -w after renaming the git-core package to git.
 
-- 
1.7.0.rc1.141.gd3fd2
