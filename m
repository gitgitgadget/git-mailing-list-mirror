From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: erratic behavior commit --allow-empty
Date: Wed, 03 Oct 2012 10:04:49 +0200
Message-ID: <vpq626s6kwu.fsf@grenoble-inp.fr>
References: <CAB9Jk9BynCunFHRFhGKoyDA-qof1iu6w952sAgSs2_JWb8+U3A@mail.gmail.com>
	<506AA51E.9010209@viscovery.net>
	<7vzk449449.fsf@alter.siamese.dyndns.org>
	<CAB9Jk9CSW0ObJtgsfSwjf+k438=V8i7dP0p+YUehqdh2Z0k6tA@mail.gmail.com>
	<7vhaqc7in6.fsf@alter.siamese.dyndns.org>
	<CAB9Jk9D-eJ8goYx7LWqGcWcLgRDS8+qLZVUsvvJ+QOtryP9-zg@mail.gmail.com>
	<90464C79DA97415C9D66846A77ECAA4A@PhilipOakley>
	<CAB9Jk9ARWnE-cWVjqMUFiua21QjqGEX3VhYjKQMBSotVYXXK1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Philip Oakley <philipoakley@iee.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git <git@vger.kernel.org>
To: Angelo Borsotti <angelo.borsotti@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 03 10:06:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJJxK-0007k6-2R
	for gcvg-git-2@plane.gmane.org; Wed, 03 Oct 2012 10:05:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755790Ab2JCIFE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 04:05:04 -0400
Received: from mx1.imag.fr ([129.88.30.5]:33040 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755772Ab2JCIE4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 04:04:56 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q937xKOG019892
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 3 Oct 2012 09:59:20 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1TJJwo-000557-4a; Wed, 03 Oct 2012 10:04:50 +0200
In-Reply-To: <CAB9Jk9ARWnE-cWVjqMUFiua21QjqGEX3VhYjKQMBSotVYXXK1Q@mail.gmail.com>
	(Angelo Borsotti's message of "Wed, 3 Oct 2012 09:45:36 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 03 Oct 2012 09:59:21 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q937xKOG019892
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1349855963.22035@iHZpr40akZtTXT5myB+3BQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206867>

Angelo Borsotti <angelo.borsotti@gmail.com> writes:

> I think that you would agree with me that this is not a nice
> behaviour.

This is fundamentally how Git works. You probably didn't notice it, but
if you do

echo 'some content' > file1.txt
git add file1.txt
git commit -m "file1"

echo 'some content' > file2.txt
git add file2.txt
git commit -m "file2"

Then the second commit does not "create" a new blob object for
file2.txt, because it has the same content as an existing one. But the
point is: you really don't care, or indeed, you care about sharing the
blob objects to save disk space.

> How could a user ever use a command that is not predictable?

It is predictible: give it twice the same inputs in the same conditions,
and it will yield the same output.

You still didn't tell us where the problem was. You are unhappy with
having twice the same sha1 for the same object, but what concrete bad
consequence does this have? (except for saving bandwidth in addition to
disk space when trying to push your commit)

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
