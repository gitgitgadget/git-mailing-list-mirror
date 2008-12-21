From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make git revert warn the user when reverting a merge
 commit.
Date: Sun, 21 Dec 2008 14:46:45 -0800
Message-ID: <7vd4flkuy2.fsf@gitster.siamese.dyndns.org>
References: <200812182039.15169.bss@iguanasuicide.net>
 <200812211513.26808.bss@iguanasuicide.net>
 <7vprjlkwbb.fsf@gitster.siamese.dyndns.org>
 <200812212340.46375.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sun Dec 21 23:48:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEX5n-0006fw-FD
	for gcvg-git-2@gmane.org; Sun, 21 Dec 2008 23:48:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751747AbYLUWqx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Dec 2008 17:46:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751516AbYLUWqx
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Dec 2008 17:46:53 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58660 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751393AbYLUWqw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Dec 2008 17:46:52 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 896671AD0A;
	Sun, 21 Dec 2008 17:46:52 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1EC121AD09; Sun,
 21 Dec 2008 17:46:47 -0500 (EST)
In-Reply-To: <200812212340.46375.robin.rosenberg.lists@dewire.com> (Robin
 Rosenberg's message of "Sun, 21 Dec 2008 23:40:45 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 42A8E86C-CFB1-11DD-A943-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103729>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> writes:

> s=C3=B6ndag 21 december 2008 23:17:12 skrev Junio C Hamano:
>> From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
>> Subject: git-revert: record the parent against which a revert was ma=
de
>>=20
>> As described in Documentation/howto/revert-a-faulty-merge.txt, re-me=
rging
>> from a previously reverted a merge of a side branch may need a rever=
t of
>> the revert beforehand.  Record against which parent the revert was m=
ade in
>> the commit, so that later the user can figure out what went on.
>>=20
>> [jc: original had the logic in the message reversed, so I tweaked it=
=2E]
> No need for this comment.

Ok.

>> +			add_to_msg(",\nreverting damages made to %s");
> maybe "changes" is more neutrral language. I also think you break
> the line too early.

The above (without %s which shouldn't have been there) would give:=20

    This reverts commit efe05b019ca19328d27c07ef32b4698a7f36166f,
    reverting damages made to ec9f0ea3e6ecf1237223dec8428e7bb73d339320.
=20
Do you want:

    This reverts commit efe05b019ca19328d27c07ef32b4698a7f36166f, rever=
sing
    changes made to ec9f0ea3e6ecf1237223dec8428e7bb73d339320.

this instead?
