From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/3] submodule: add test to demonstrate that shallow recursive clones fail
Date: Tue, 15 Mar 2016 13:12:34 -0700
Message-ID: <xmqqpouv7b65.fsf@gitster.mtv.corp.google.com>
References: <1450653595-22676-1-git-send-email-larsxschneider@gmail.com>
	<1450653595-22676-2-git-send-email-larsxschneider@gmail.com>
	<CAGZ79kYzbmzK1UwvWheugkqG0FwhpGMU0_K_jyCKOnoKb5oTxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Lars Schneider <larsxschneider@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 21:12:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afvKd-0002pJ-71
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 21:12:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755422AbcCOUMj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 16:12:39 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:55709 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753807AbcCOUMi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 16:12:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 930794D11E;
	Tue, 15 Mar 2016 16:12:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=M/yTZebKhGB2GovWaDePR4EucXo=; b=WfeVze
	UGpTIT81N2k84o7vfXRLOHrADxejlhDKZTi0ABDnnhgUe7C8AAL5hz+N7q6iU2Yx
	HLSLhb/D8UdSJqEtv12Ukql+954ynuGB6CTBgz6juw5sCRotRdr/JuTjclX6WE0F
	PkMtUiJ0luHhgNpr1haVQg82KKLOABCIZPhTk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=P//soPfqhWarOf+a10nJ53V2irToVI0Z
	lZLLfuvLTbP5/f2Je5P+Ttg1fGmNnGH2OlM99OJevTJ9k52T17lWs55i69kJFtxc
	RJkhiMUJCmE5Btn0+iyJs8TBa+3A+tm5dVR/L3EyjmQF+zMstQf7Viv8M9Bky0cg
	eSa2mtXPc/o=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8A42D4D11D;
	Tue, 15 Mar 2016 16:12:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id F31974D11C;
	Tue, 15 Mar 2016 16:12:35 -0400 (EDT)
In-Reply-To: <CAGZ79kYzbmzK1UwvWheugkqG0FwhpGMU0_K_jyCKOnoKb5oTxQ@mail.gmail.com>
	(Stefan Beller's message of "Tue, 15 Mar 2016 12:50:35 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4255ED36-EAEA-11E5-A162-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288905>

Stefan Beller <sbeller@google.com> writes:

>> +test_expect_failure shallow-clone-recursive '
>> +       URL="file://$(pwd | sed "s/[[:space:]]/%20/g")/repo" &&
>
> This would break if the test suite is in a path containing any other white space
> than U+0020 such as a tab? (Not that I am encouraging using such paths...)

Good spotting.

I thought use of [[:named character classes:]] is explicitly
disallowed by CodingGuidelines.
