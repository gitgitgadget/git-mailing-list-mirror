From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] t4011: illustrate "diff-index -p" on stat-dirty
 paths
Date: Thu, 01 Mar 2012 08:10:55 -0800
Message-ID: <7v4nu8pai8.fsf@alter.siamese.dyndns.org>
References: <1330568057-27304-1-git-send-email-gitster@pobox.com>
 <1330568057-27304-3-git-send-email-gitster@pobox.com>
 <4F4F49FD.3090504@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Thu Mar 01 17:11:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S38bH-0002HL-Oe
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 17:11:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753709Ab2CAQLA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Mar 2012 11:11:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36844 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752557Ab2CAQK7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Mar 2012 11:10:59 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 692C86ABB;
	Thu,  1 Mar 2012 11:10:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=xadSsdTx+Yj9
	I8OanPiI1XSnreQ=; b=SvfH9cipoXqQm9CfSXGuRs0we7/ghEUp9KJzyMH7Igek
	ix5KPJxRyfMCaeNWAO/DQrw1CmlXtNJijF5QG9tinnaXtsatrjnlrkdoz55xQ6yt
	67tb3SXTC843BELjHMykpYR3WxIQBgxCBVu0ptvsLLUNNmLmfg88FPEPRYywa58=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ATIicF
	sGhjrO+SXZGFpab4lilwVM37EGTp/R0OIY8Y07nInIm2p3V5RRZngLWV+Bvu0cUu
	i9Po/LXoKu8AkvsA2CoiM9cy1AMcexYJSFJ3G1T/KX1lVfdVPAwHh9aQtYxacCR7
	DZ8lJyryl9zgjA+fYfOqpxTAOiOsFY1WBn/rw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5FE386ABA;
	Thu,  1 Mar 2012 11:10:58 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C07C16AB9; Thu,  1 Mar 2012
 11:10:57 -0500 (EST)
In-Reply-To: <4F4F49FD.3090504@in.waw.pl> ("Zbigniew =?utf-8?Q?J=C4=99drze?=
 =?utf-8?Q?jewski-Szmek=22's?= message of "Thu, 01 Mar 2012 11:05:49 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2161F514-63B9-11E1-B01F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191940>

Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl> writes:

> On 03/01/2012 03:14 AM, Junio C Hamano wrote:
>> -test_expect_success SYMLINKS 'diff unchanged symlink'  '
>> +test_expect_success SYMLINKS 'diff unchanged symlink and file'  '
>>   	tree=3D$(git write-tree)&&
>> -	git update-index frotz&&
>> +	git update-index frotz nitfol&&
>>   	test -z "$(git diff-index --name-only $tree)"
>>   '
> why modify and extend an existing test instead of adding a new
> separate one?

If you are talking about assigning a new test number for a new script, =
it
is better to avoid it when you can.  If on the other hand you meant to =
add
a new "test_expect_success" block, yes, that is one of the right things=
 to
consider when adding tests, and I tried it both ways.

The result was easier to read when done the way it was posted.

=46or this update, you could keep the later test that originally checke=
d
symlink intact and add an identical check for regular file, but the thi=
ng
is, the behaviour change brought by the update in this series affect bo=
th
symlink and regular file comes from the same underlying mechanism, and
demonstrating the change in a single hunk that makes two phantom output
lines disappear was far easier to review than two hunks each of which
shows one phantom output line disapper.
