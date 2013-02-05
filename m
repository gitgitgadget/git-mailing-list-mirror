From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tests: turn on test-lint-shell-syntax by default
Date: Tue, 05 Feb 2013 12:52:48 -0800
Message-ID: <7v4nhqsctb.fsf@alter.siamese.dyndns.org>
References: <201301120650.46479.tboegi@web.de>
 <7vvcb37xfe.fsf@alter.siamese.dyndns.org> <50F28BB5.9080607@web.de>
 <20130113173207.GC5973@elie.Belkin> <7v4nikiu81.fsf@alter.siamese.dyndns.org>
 <50F5B83E.9060800@web.de> <7vk3re2ncb.fsf@alter.siamese.dyndns.org>
 <51037E5F.8090506@web.de> <20130127093121.GA4228@elie.Belkin>
 <5105280A.80002@web.de> <7v4ni2y1fm.fsf@alter.siamese.dyndns.org>
 <51116D3E.3070409@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	kraai@ftbfs.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Feb 05 21:53:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2pVy-0008BF-1m
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 21:53:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756496Ab3BEUwv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Feb 2013 15:52:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48403 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755540Ab3BEUwu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Feb 2013 15:52:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A94C94E7;
	Tue,  5 Feb 2013 15:52:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=bMObg6AdjtVP
	C1+nwq3otM5DCKM=; b=FT2LpCWdXpJHI1QgUH+CX//DtQsHnmsfZDM7Nk864OpK
	kWyuxO1OsJK1AVG6URF7Fedb+tIZ8cxsy0mvYsCWgwWLWGYsX2JjRpIGopoyxjId
	IqpuJh4/M6+rFYcedvPazKXnQKINfK/1FfXxYaWsh48kJTQZQ4aPw9rXfJQnQ7o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=YCxTKu
	N+r2wFe4cYDst846QzoxSuemcJFKoSE9Z6GTnErCl+7rB7ZKXCx020QQPmCWKmU5
	0hx/5nCX3gFAzRlyyfPUAXvJuirj2chM6NL6BbLalQzWRPU/kd36KobYi2H5yUpY
	fVc/m3NfmYpXj06ZIsFAO4T+e42v3AEEvtf14=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4EB2394E5;
	Tue,  5 Feb 2013 15:52:50 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C490894E4; Tue,  5 Feb 2013
 15:52:49 -0500 (EST)
In-Reply-To: <51116D3E.3070409@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of "Tue, 05 Feb 2013 21:36:14 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 00972EB0-6FD6-11E2-9FF6-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215538>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> Thanks for the detailed suggestion.
> Instead of using a file for putting out non portable syntax,
> can we can use a similar logic as test_failure ?

Your test_bad_syntax_ function can be called from a subshell, and
its "exit 1" will not exit, no?

	test_expect_success 'prepare a blob with incomplete line' '
		(
			echo first line
                        echo second line
			echo -n final and incomplete line
		) >incomplete.txt
	'
