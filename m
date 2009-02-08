From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase: do not fail silently when the HEAD could not be
 detached
Date: Sat, 07 Feb 2009 18:26:18 -0800
Message-ID: <7v7i414qb9.fsf@gitster.siamese.dyndns.org>
References: <cover.1234027102u.git.johannes.schindelin@gmx.de>
 <679be9321b4cf4f694917cb9eebba70376a43a0a.1234027102u.git.johannes.schindelin@gmx.de> <20090207233524.GD11623@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 08 03:27:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVzOj-00064e-5H
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 03:27:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752511AbZBHC00 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Feb 2009 21:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752460AbZBHC0Z
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 21:26:25 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:39663 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752445AbZBHC0Z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Feb 2009 21:26:25 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 136E72AA9D;
	Sat,  7 Feb 2009 21:26:24 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 360F12AA94; Sat, 
 7 Feb 2009 21:26:20 -0500 (EST)
In-Reply-To: <20090207233524.GD11623@atjola.homenet> (=?utf-8?Q?Bj=C3=B6rn?=
 Steinbrink's message of "Sun, 8 Feb 2009 00:35:24 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E1521E1A-F587-11DD-8280-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108912>

Bj=C3=B6rn Steinbrink <B.Steinbrink@gmx.de> writes:

> On 2009.02.07 18:20:09 +0100, Johannes Schindelin wrote:
>> Since 6fd2f5e(rebase: operate on a detached HEAD), rebase operates o=
n a
>> detached HEAD.  However, it used "checkout -q" to detach the HEAD, w=
hich
>> hid an error message when, say, an untracked file would have to be
>> overwritten to detach the HEAD.
>
> Hm, in 324c2c317 "git-rebase: report checkout failure", that was
> switched from a stdout/stderr redirect to -q, so that those error
> messages are shown. And with a quick test, rebase/checkout complains
> just fine:

Very interesting.

Dscho, how did you get the "important part of error information is hidd=
en"
failure that led to this patch?  Did it come from code inspection and
speculation alone, or was there an actual failure case?

If I apply the patch t/t3400-rebase.sh from your message alone to
'master', it does seem to pass.
