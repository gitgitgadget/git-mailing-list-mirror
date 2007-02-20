From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: git installation (as private user) should NEVER write site_perl
Date: Tue, 20 Feb 2007 09:18:15 -0800
Message-ID: <86sld0sq7c.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 20 18:18:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJYdS-0006dX-2S
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 18:18:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030333AbXBTRS1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Feb 2007 12:18:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030330AbXBTRS0
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Feb 2007 12:18:26 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:49001 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030318AbXBTRSQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Feb 2007 12:18:16 -0500
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id E99101DE781; Tue, 20 Feb 2007 09:18:15 -0800 (PST)
x-mayan-date: Long count = 12.19.14.1.9; tzolkin = 5 Muluc; haab = 2 Kayab
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40242>


I tried to install git on a system where I was a normal user.  Of course,
this step fails:

     Installing /usr/perl5/site_perl/5.6.1/Error.pm
     Installing /usr/perl5/site_perl/5.6.1/Git.pm

But on a larger level, this should never have even been attempted, whether I
was a private user OR the box administrator.  The git installation should NOT
be installing things into the site_perl directory, which is owned by the CPAN
installation tools, and also by the various packaging tools, and is also seen
by non-git users of Perl on the machine.  (It would be bad to have two
different versions of Error.pm now being seen by all users.)

If git wants to add local Perl modules, they belong in ${prefix}/lib/perl/
or something, with the appropriate "use lib" added to the Perl scripts.

No patches attached, but this is a showstopper for my client, and a bit of a
shocker for me.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
