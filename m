From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: push race
Date: Mon, 15 Oct 2012 13:05:51 +0200
Message-ID: <vpqd30k806o.fsf@grenoble-inp.fr>
References: <CAB9Jk9Be4gGaBXixWN7Xju7N6RGKH+FonhaTbZFJ6uYsJDk8dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Angelo Borsotti <angelo.borsotti@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 15 13:06:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNiUo-0000Xw-Te
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 13:06:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752124Ab2JOLFz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2012 07:05:55 -0400
Received: from mx1.imag.fr ([129.88.30.5]:38824 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750739Ab2JOLFz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 07:05:55 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q9FAxkMe024646
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 15 Oct 2012 12:59:46 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1TNiUZ-0001Bz-R8; Mon, 15 Oct 2012 13:05:51 +0200
In-Reply-To: <CAB9Jk9Be4gGaBXixWN7Xju7N6RGKH+FonhaTbZFJ6uYsJDk8dg@mail.gmail.com>
	(Angelo Borsotti's message of "Mon, 15 Oct 2012 11:14:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 15 Oct 2012 12:59:46 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q9FAxkMe024646
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1350903587.26163@tCoWM4cNXBpLnOaMJAcURQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207735>

Angelo Borsotti <angelo.borsotti@gmail.com> writes:

> the push command checks first if the tips of the branches match those
> of the remote references, and if it does uploads the snapshot.

The update does two things: upload objects to the database, and then
update the reference. Adding objects to the database does not change the
repository until the objects are reachable from a ref. Updating the ref
is usually done giving the expected old sha1, and locks the ref, so it
can't change in the meantime.

I don't know this part of the code very well, but check refs.c for the C
part, and "git update-ref" for the plumbing interface.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
