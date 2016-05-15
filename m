From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 0/4] pathspec labels [WAS: submodule groups]
Date: Sun, 15 May 2016 12:33:04 -0700
Message-ID: <xmqqfutj5d73.fsf@gitster.mtv.corp.google.com>
References: <20160513001936.7623-1-sbeller@google.com>
	<CACsJy8BK-u2VV3kkq3ANHCanYqMwphqgxZmooQfewA_J7e8MPw@mail.gmail.com>
	<xmqq60uf6v5d.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 15 21:33:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b21ms-00085V-L6
	for gcvg-git-2@plane.gmane.org; Sun, 15 May 2016 21:33:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751618AbcEOTdJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2016 15:33:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54865 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751139AbcEOTdI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2016 15:33:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0AED418544;
	Sun, 15 May 2016 15:33:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=76IPPOx8UE6NUXh8w1gr7OB/x5o=; b=JUlZWt
	OajFVJZJzQleWc3/s0RTl8Po4fEHGi75TvUCRVRXNpH72Eev029olRaKEKuVyuWf
	roa4wVoX7LDP02YgoVz4Ua3dmp5FvXlnQ88BYrpqdt9zXP5wHcASIRUqUSTPsdiR
	nAlVNotE3SnnRuYGiiQE1u+AD6rbASyBsQhhM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L3Sgin7SrACx8mD2rCA8OF1VQQBgUWiz
	01WmHFuP7MsMkhOEy2vRu9Pe+VQ/NRLChP/p0KAgB/4XCLptUxh2Ug85ifgrJ4VJ
	wFrjUCH/OP6wGaHg6HsLMzncO578Per/OEr8RBOMfrvTUqD4h0QAyqpRriSpcme1
	p+E0Ac7Wv4Y=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0145A18541;
	Sun, 15 May 2016 15:33:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 71B921853D;
	Sun, 15 May 2016 15:33:06 -0400 (EDT)
In-Reply-To: <xmqq60uf6v5d.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Sun, 15 May 2016 11:19:58 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D9236F9A-1AD3-11E6-9ACB-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294681>

Junio C Hamano <gitster@pobox.com> writes:

> Duy Nguyen <pclouds@gmail.com> writes:
>
>> Instead of putting everything in under the same attribute name
>> "label", make one attribute per label? Would this work?
>>
>> *.[ch] c-group code-group
>
> The attribute subsystem expects that there will not be unbounded
> large number of attributes, so this is not a good direction to go.

Having said that, I do not mind too much if it turns out that it is
necessary to use an unbounded set of random attributes to solve a
specific problem, if the use case is good.

But even then, in order to avoid confusion and name clashes, I'd
prefer to see more like

	*.[ch] group-c group-code

that is matched by

	git cmd ':(group:c code)

i.e. reserve a single prefix that is not and will not be used for
other purposes.
