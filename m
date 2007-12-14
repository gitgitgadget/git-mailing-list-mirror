From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Fix config lockfile handling.
Date: Fri, 14 Dec 2007 12:07:33 -0800
Message-ID: <7vmysdqbui.fsf@gitster.siamese.dyndns.org>
References: <1197660157-24109-1-git-send-email-krh@redhat.com>
	<1197660157-24109-2-git-send-email-krh@redhat.com>
	<Pine.LNX.4.64.0712141928240.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>,
	gitster@pobox.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Dec 14 21:09:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3GpN-00019v-1m
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 21:08:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753594AbXLNUHq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Dec 2007 15:07:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753954AbXLNUHq
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 15:07:46 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53777 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752800AbXLNUHq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Dec 2007 15:07:46 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 68A9D8D96;
	Fri, 14 Dec 2007 15:07:40 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id DBF228D93;
	Fri, 14 Dec 2007 15:07:35 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0712141928240.27959@racer.site> (Johannes
	Schindelin's message of "Fri, 14 Dec 2007 19:29:03 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68335>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Fri, 14 Dec 2007, Kristian H=C3=B8gsberg wrote:
>
>> -	struct lock_file *lock =3D NULL;
>> +	struct lock_file lock;
>
> AFAICT this cannot work.  At least not reliably.  An atexit() handler=
 will=20
> access all (even closed) lockfiles.

Correct.  It cannot be on the stack.
