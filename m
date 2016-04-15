From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH, WAS: "weird diff output?" 0/2] implement better chunk heuristics
Date: Fri, 15 Apr 2016 10:48:07 -0700
Message-ID: <xmqqshymbw6g.fsf@gitster.mtv.corp.google.com>
References: <20160415165141.4712-1-jacob.e.keller@intel.com>
	<CAGZ79kbCHA3L6mUfYn6OfVXLDEyhv70PwxXo-YHP_QZXXAB8ig@mail.gmail.com>
	<CAGZ79kZs33sJj+DPSS4FPoJTLqbCLpvSe_h9UUQM-dBe=8ExKw@mail.gmail.com>
	<xmqq1t66dbp8.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZPsGuimv3pFAFdwuhD1ps74qx7Q6d1kqxxRX6VPwNYGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Jens Lehmann <Jens.Lehmann@web.de>,
	Davide Libenzi <davidel@xmailserver.org>,
	Jacob Keller <jacob.keller@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 19:48:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ar7qp-0001wT-VM
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 19:48:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378AbcDORsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 13:48:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63777 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751315AbcDORsL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 13:48:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 69CAC14305;
	Fri, 15 Apr 2016 13:48:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lYvIUNJ4LTmnKM9b7GZu2Qgo85E=; b=bUe6H1
	YuY/MFlViTrP1VwqkURGAAYDXw21lpaRy9JM7bFAzYHUWW2Qpm8wwYp4NVC5grRl
	cqR8hger1AbEcbvibDlBdqWkoSVFTa6GwLgja8a6Hahk14JlUuF0mEsIJpq2ZsUW
	RrT7h1ZDMAjkNkx1YfGkod0rwoCvMFrBYqtvc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Fn92DG6J2GiKEblrnCzNW8z1bl/DY0lM
	taodH/I4ZrL1s8H4/6oSBy/An3pS1AQ7lLFRcef46vRikXrhpw35tLHlasTjbA4z
	e0ox7Z7D36WWkK6YAhl042PyX3s+X5XwKvKh0Zyb8AtUV/73jcoKl1ZIcqZLWQn+
	nkfvU4WBTBc=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5FE9614304;
	Fri, 15 Apr 2016 13:48:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A4FA914303;
	Fri, 15 Apr 2016 13:48:08 -0400 (EDT)
In-Reply-To: <CAGZ79kZPsGuimv3pFAFdwuhD1ps74qx7Q6d1kqxxRX6VPwNYGQ@mail.gmail.com>
	(Stefan Beller's message of "Fri, 15 Apr 2016 10:33:41 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 370287E0-0332-11E6-9746-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291629>

Stefan Beller <sbeller@google.com> writes:

> I think we need to be aggressive to find adjacent groups and only after
> that is done we should think about optimizing look&feel?

OK.  I was just gauging to see if those involved in the codepath
thought things through, and apparently you did, so I'm happy ;-)

Thanks.
