From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: What's cooking in git.git (Nov 2010, #03; Wed, 24)
Date: Fri, 3 Dec 2010 14:06:55 +0100
Message-ID: <201012031406.55854.trast@student.ethz.ch>
References: <7vk4k2rt2m.fsf@alter.siamese.dyndns.org> <201012031222.33635.trast@student.ethz.ch> <201012031402.49169.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 03 14:07:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POVLq-0004KU-LM
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 14:07:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754392Ab0LCNG6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 08:06:58 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:26310 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752716Ab0LCNG5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 08:06:57 -0500
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.218.12; Fri, 3 Dec
 2010 14:06:44 +0100
Received: from pctrast.inf.ethz.ch (129.132.153.233) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.218.12; Fri, 3 Dec
 2010 14:06:56 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.37-rc3-git6-8-desktop; KDE/4.5.3; x86_64; ; )
In-Reply-To: <201012031402.49169.jnareb@gmail.com>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162796>

Jakub Narebski wrote:
> Could you add 'exit' just after second test in 
> t/t9502-gitweb-standalone-parse-output.sh test script, or running it
> with `--immediate' option, and show us the results (after 'cd t') of
> 
>   $ file "trash directory.t9502-gitweb-standalone-parse-output/gitweb.body"
>   should be:
> 
>     trash directory.t9502-gitweb-standalone-parse-output/gitweb.body: tar archive

Well, you're onto something...

  trash directory.t9502-gitweb-standalone-parse-output$ file *
  file_list:          empty
  foo:                ASCII text
  gitweb.body:        empty
  gitweb_config.perl: perl script text executable
  gitweb.headers:     ASCII text, with CRLF line terminators
  gitweb.log:         empty
  gitweb.output:      ASCII text, with CRLF line terminators
  GLOB(0xdf18fc0):    tar archive

Huh.  Seems something got confused about what to use as a filename?

> > OTOH if I check out v1.7.3.1-48-g5768176 instead, where the test
> > works ok, it looks like this: [...]
> 
> Could you bisect to commit that introduces breakage?

That's what the automatic tester does by itself (again under
valgrind), and it came back with "gitweb: File based caching layer
(from git.kernel.org)", i.e., 17b15d4.  I should have pointed out that
this was already a bisection in the first mail.

(The manual runs on the server now verified that the bisecter worked
ok, so it really is that commit.)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
