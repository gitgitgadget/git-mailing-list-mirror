From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-scm.com
Date: Sat, 26 Jul 2008 11:51:17 -0700
Message-ID: <7vsktweaxm.fsf@gitster.siamese.dyndns.org>
References: <d411cc4a0807251035i7aed2ec9wef7e8f1b3ae4c585@mail.gmail.com>
 <m3hcadul6j.fsf@localhost.localdomain> <20080726130757.GY32184@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Scott Chacon <schacon@gmail.com>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sat Jul 26 20:52:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMosV-0006EE-C1
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 20:52:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752170AbYGZSv2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 14:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752095AbYGZSv2
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 14:51:28 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:39759 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752083AbYGZSv1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 14:51:27 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 4B3263D5AA;
	Sat, 26 Jul 2008 14:51:26 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 1EF6E3D5A9; Sat, 26 Jul 2008 14:51:19 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D99ECE18-5B43-11DD-80D5-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90273>

Petr Baudis <pasky@suse.cz> writes:

> One Scott's concern that didn't occur to me was that a the time of
> release, we could have broken links between the time tag is created and
> tarballs are wrapped up. I *think* that in practice, this happens at the
> same time, I wonder if Junio could confirm that.

Heh, and you did not Cc: me ;-)?

There is a mirroring process involved between the public machines and the
machine I push the tag into and place the tarballs.  I do not have control
over that mirroring.  But modulo that, the tarballs and RPMs are made
public before the tag and the tips of branches are pushed into the public
repository.

The release procedure goes like this (extend this as an addendum to
Documentation/howto/maintain-git.txt if somebody feels like it):

 * On the development machine outside k.org, create the tag, and prepare
   RPM for i386;

 * scp i386 RPM to a private staging area at k.org, and push the tag to a
   private building area also at k.org;

 * run the release procedure in the private building area at k.org, which:

   - builds x86_64 RPM and deposits it to the same private staging area
     i386 RPM were scp'ed to earlier;

   - builds the source tarball and documentation tarballs;

   - puts all of the above in /pub/software/scm/git/ to be mirrored out;

   - extracts html documentation tarball in /pub/software/scm/git/docs/v*
     to be mirrored out;

         http://www.kernel.org/pub/software/scm/git/docs/, the "current"
         documentation page, has links to these "documentation for
         released versions" and they point at these docs/v* areas.

 * push the tag and branch tips out to the public repository, so that it
   will be mirrored to /pub/scm/git/git.git/ (this updates the "current"
   documentation pages as a side effect);

 * send out the release announcement message to the list.

The 1.4.4.5 backport was an oddball.  I do not think I did anything other
than simply pushing the tag out.
