From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git --file doesn't override $HOME in version 1.8.1.2
Date: Tue, 09 Jul 2013 05:00:41 -0700
Message-ID: <7vmwpwvt7a.fsf@alter.siamese.dyndns.org>
References: <C8A88C530F38AE47B22BDC434090CBB0ED26E0@IT-EXMB01-HKI.it.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: =?utf-8?Q?Saraj=C3=A4rvi?= Tony <Tony.Sarajarvi@digia.com>
X-From: git-owner@vger.kernel.org Tue Jul 09 14:00:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwWbC-0000yz-Rw
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 14:00:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753734Ab3GIMAo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Jul 2013 08:00:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37237 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753277Ab3GIMAn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jul 2013 08:00:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 287FF2DC81;
	Tue,  9 Jul 2013 12:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=UrneznPAG3Mt
	q6YE+ccl73afV1k=; b=XVcCkZDuK2SKWQUNz239jTvy+OPuK4CHqAIi0V9QmlS7
	0kHNkXP0lzohLeqxbxyRRPMJ4viPgTMKbpiHUtpHfcVAhl+fVl6sGzdci3Zwq7UO
	wwZ8I3Ijza5+DpgIMwK+KodV1bRr3s85mJedLev5b2Hty7jnJOxwCOBkOw69h/M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=gEI0qn
	l89xtat5wpsOVQuKXyq1N92LLy6qV4umOCet+PjGFRCQVUuHRIEsmgTPE6/uOHNw
	yTfxDQXIbs53QpcuA7LeF3gs3XOzJig23EiUt2rlbi68rIYa5fRf0tfFUoEFsBw1
	MQwQr6qDCsoBwwnzuY9cTm61ie0BUqw34rdLQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C62E2DC80;
	Tue,  9 Jul 2013 12:00:43 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7B5F82DC7E;
	Tue,  9 Jul 2013 12:00:42 +0000 (UTC)
In-Reply-To: <C8A88C530F38AE47B22BDC434090CBB0ED26E0@IT-EXMB01-HKI.it.local>
	(=?utf-8?Q?=22Saraj=C3=A4rvi?= Tony"'s message of "Tue, 9 Jul 2013 11:05:46
 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2E0DB1AC-E88F-11E2-8219-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229949>

Saraj=C3=A4rvi Tony <Tony.Sarajarvi@digia.com> writes:

> Using Ubuntu 13.04 with Git 1.8.1.2 I stumbled upon a problem using P=
uppet.
>
> In Puppet we launch Git with the command: '/usr/bin/git config --file=
 /home/qt/.gitconfig --get "user.name" "Qt Continuous Integration Syste=
m"'

Hmph.  What does this even mean?

    git config --get user.name "Qt CIS"

I have a feeling that the command will exit with an error status 1.

> However, puppet logs: "fatal: unable to access
> '/root/.config/git/config': Permission denied".
>
> Puppet is run as root, so HOME points to /root, but still -file
> should override the environment variable.

Probably.

> If the same command is run directly from terminal as root, it works a=
s well.

I am not sure what you mean by "works as well".  It behaves
differently and does not fail the same way?

> With 1.8.3.2 the problem didn't reoccur.

That is probably due to b1c418e1 (Merge branch
'jn/config-ignore-inaccessible' into maint, 2013-06-09)

But it is puzzling.

The "error out upon an inaccessible configuration file in usual
places" check we had since v1.8.1.1 was meant to make sure that you
will not be missing a basic configuration before running any command
(including "git config" itself).  As "root", you shouldn't even have
triggered the "unable to access: Permission denined" in the first
place.  There is something else going on.
