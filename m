From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 4/4] Use git_mkstemp_mode and xmkstemp_mode in odb_mkstemp, not chmod later.
Date: Mon, 22 Feb 2010 23:11:15 +0100
Message-ID: <vpqaav0or98.fsf@bauges.imag.fr>
References: <1266597207-32036-1-git-send-email-Matthieu.Moy@imag.fr>
	<1266597207-32036-5-git-send-email-Matthieu.Moy@imag.fr>
	<7vy6inekxq.fsf@alter.siamese.dyndns.org>
	<vpqfx4tln64.fsf@bauges.imag.fr>
	<7veikdau4i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 23:15:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjgYl-00027C-JU
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 23:15:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754414Ab0BVWPR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 17:15:17 -0500
Received: from mx1.imag.fr ([129.88.30.5]:52757 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753431Ab0BVWPP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 17:15:15 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o1MM8rQi022639
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 22 Feb 2010 23:08:53 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NjgUl-0007b2-LR; Mon, 22 Feb 2010 23:11:15 +0100
In-Reply-To: <7veikdau4i.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Mon\, 22 Feb 2010 12\:33\:01 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 22 Feb 2010 23:08:54 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140718>

Junio C Hamano <gitster@pobox.com> writes:

> On another box with FC11 (git.git directory is on an ext4 partition), here
> is what "sh -x t1304-default.acl.sh -i -v" gives me when run in
> 'pu'.

Actually, it wasn't such a subtle configuration. You have umask=022 on
your machine, and I had umask=077 on the one I did the test. My test
script was setting umask after . test-lib.sh, it should have done it
before (so that the created repository is created with restrictive
umask right away).

While I was there, I also added a testcase for object files.

> By the way, here is what the same command gets when run on FreeBSD 8.0
> [...]
> + setfacl -Rm u:root:rwx .
> setfacl: illegal option -- R

Thanks. I fixed the script not to use -R. But that's without any
warranty, I don't have a FreeBSD machine for testing ...

New serie comming soon, which should adress all your comments.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
