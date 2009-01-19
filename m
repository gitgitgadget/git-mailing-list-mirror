From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] contrib/workdir: create logs/refs and rr-cache in the
 origin repository
Date: Mon, 19 Jan 2009 11:48:36 -0800
Message-ID: <7vvdsboz57.fsf@gitster.siamese.dyndns.org>
References: <1232208943-31756-1-git-send-email-dato@net.com.org.es>
 <7vbpu54cxe.fsf@gitster.siamese.dyndns.org>
 <20090118113830.GA1394@chistera.yi.org>
 <7vskngwfko.fsf@gitster.siamese.dyndns.org>
 <20090119122018.GA25566@chistera.yi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Adeodato =?utf-8?Q?Sim=C3=B3?= <dato@net.com.org.es>
X-From: git-owner@vger.kernel.org Mon Jan 19 20:50:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LP08s-0008VG-7v
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 20:50:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752680AbZASTsp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Jan 2009 14:48:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752022AbZASTso
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 14:48:44 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64282 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751898AbZASTso convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Jan 2009 14:48:44 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 856201CD09;
	Mon, 19 Jan 2009 14:48:41 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 687101CD07; Mon,
 19 Jan 2009 14:48:38 -0500 (EST)
In-Reply-To: <20090119122018.GA25566@chistera.yi.org> (Adeodato
 =?utf-8?Q?Sim=C3=B3's?= message of "Mon, 19 Jan 2009 13:20:18 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2C4BDE7C-E662-11DD-A078-2E3B113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106386>

Adeodato Sim=C3=B3 <dato@net.com.org.es> writes:

> * Junio C Hamano [Sun, 18 Jan 2009 11:59:35 -0800]:
> ...
>>     A workdir is a new work area that is not a normal "work tree wit=
h a
>>     full repository", but borrows from an existing repository.  Any =
side
>>     effect from the work you do in a workdir will be saved in the or=
iginal
>>     repository, and removing one would lose only the three kind of
>>     information listed above.  Creating a new workdir has the side e=
ffect
>>     of enabling reflogs and rerere in the original repository.
>
>> But the last sentence somehow feels dirty.
>
> I really don't understand that last sentence. Does "mkdir logs/refs r=
r-cache"
> *enable* reflogs and rerere at all? Or, rather, it just gives an empt=
y
> space for the workdirs "connecting" to it to save their reflogs and
> rerere stuff iff they are configured to do so?

I thought rerere does not kick in if rr-cache is absent, and it kicks i=
n
if rr-cache is present when you do not explicitly disable it.  So creat=
ion
of directory is a way to enable it.  Besides, the net effect for a pers=
on
who does not want to have the bare repository contaminated with these
directories is the same.  The original repository aquires them.

As I said already, I suspect that it would be more useful in practice t=
o
create these directories as your patch did, than making the new workdir
inherit the lack of rerere and reflog support if the original repositor=
y
lacked them.  I just wanted to see some documentation that makes it cle=
ar
that the original repository _is_ modified by a creation of a new workd=
ir.
