From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] t0027: Add repoMIX and LF_nul
Date: Sat, 25 Apr 2015 21:32:32 -0700
Message-ID: <xmqqbnibzezj.fsf@gitster.dls.corp.google.com>
References: <553B3871.6050904@web.de>
	<xmqqegn817pr.fsf@gitster.dls.corp.google.com>
	<553C0A9B.7060407@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Apr 26 06:32:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YmEFG-0007Uw-8M
	for gcvg-git-2@plane.gmane.org; Sun, 26 Apr 2015 06:32:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbbDZEcf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Apr 2015 00:32:35 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58450 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751004AbbDZEcf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Apr 2015 00:32:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6979B4CAAE;
	Sun, 26 Apr 2015 00:32:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=e5bzlhimRA0/
	uF8OidQ6lCjivlg=; b=T5uKX88bCKjdLxq7jXaH//F2G7RPsPX/h6akNqss8A/T
	zkPfl8Ua/XgIu3OxGnzz3f9AauUTiu1ZpWIejJdfO25xLlhu5frl9PSJcJNiU6C2
	nBUqoWS5OxdvCuQC4j+H++ilPwk+8O3EFTfoo5Fv39cfNiTVO6uJTULO71xtANA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=QbA4t4
	VE7nAsfMLICQ5vsx7aXmKeHAOkwHGgl0cwJzzK4+mqOzLUdX9p99ZmdCzjmrSXVu
	+glhCVAffSsmPL5zk/DgOhK7XL3nqFAaeSeLmoi56eMBL5xj4e5bJWXYwTp7yGUa
	eJoaqQWcvzHwIITH9B88PkRoqin4PK0GMMdk8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 57EFE4CAAD;
	Sun, 26 Apr 2015 00:32:34 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D0C304CAAB;
	Sun, 26 Apr 2015 00:32:33 -0400 (EDT)
In-Reply-To: <553C0A9B.7060407@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Sat, 25 Apr 2015 23:43:55 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 42279412-EBCD-11E4-AE54-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267806>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

>> Hmph, would it still make sense to make sure that CRLF will stay CRL=
=46
>> so that future changes to break this expectation can be caught?  Not
>> that such a breakage is likely...
>
> Thanks for amending.
>
> We have the file CRLF (and CRLFmixLF), where we check that CRLF stays=
 CRLF and is not
> converted into CRLFLF.
>
> The LF_nul is to test the "auto text detection":
> It should not be converted into CRLF_nul in "auto mode",
> but should be converted when declared as "text" in .gitattributes.

The two paragraphs above may explain why the test would pass with
the current code, but is that sufficient assurance that other people
in future changes would not break the "It should not be" with their
bugs that you do not foresee at this moment?  Whenever you say "it
should not be", I hear "if the code somehow does that, somebody
broke our code", which in turn suggests me that catching that
condition with tests is a good thing.

Or am I hearing you incorrectly?
