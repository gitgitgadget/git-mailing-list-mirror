From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] new --dirty option for git describe
Date: Tue, 20 Oct 2009 09:30:38 -0700
Message-ID: <7vmy3mownl.fsf@alter.siamese.dyndns.org>
References: <1255800990-7806-1-git-send-email-jean@pryen.org>
 <dffdbd190910200727r30e161ffka0b3cf764be26cd8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Jean Privat <jean@pryen.org>
X-From: git-owner@vger.kernel.org Tue Oct 20 18:32:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0Hct-0008Rd-5l
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 18:31:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752639AbZJTQbn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 12:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752522AbZJTQbn
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 12:31:43 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55296 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751352AbZJTQbm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 12:31:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2175B7E018;
	Tue, 20 Oct 2009 12:31:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YzWscrUhXJzJmBXSa1D1d2Cl4hI=; b=JQHbPe
	Pcj3xCSq7364wAFinpgzAh8ESNNxabIHRBlZ6VBDWo7W/8x8LWk0tmWuydB3fl04
	jtOSloDAWEIu6rk1HM2A7tOfGb0BdBfhBRRgJgZQBmi35xRXdw6lNw0hH1G6FrAf
	FBhgT5k9BHk2u3V39udqV5qhtN07tfWUacpMA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=adiH7QWCWONpJtngNUA6tlfGHiwBVKTY
	QjIK39M/nqB3Y2gQzJTBe2pEbceGCRg0gC24GFyvKY71NTxhJtHUb4IFYSM6DnH8
	T2TofnDQRwZcfGEBGtFatcV86ukQVegDmfhXr5zEAje6x8qx6i1DP85IIRZ9qF+F
	89o2J8EhBJU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E8D1A7E00D;
	Tue, 20 Oct 2009 12:31:41 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CFD937FFF2; Tue, 20 Oct 2009
 12:30:39 -0400 (EDT)
In-Reply-To: <dffdbd190910200727r30e161ffka0b3cf764be26cd8@mail.gmail.com>
 (Jean Privat's message of "Tue\, 20 Oct 2009 10\:27\:11 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0C6FC0EE-BD96-11DE-ADF2-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130807>

Jean Privat <jean@pryen.org> writes:

> +test_expect_success 'describe --dirty HEAD' '
> +	git describe --dirty HEAD
> +	test $? != 0
> +'

We tend to write this as

	test_expect_success '...' '
        	test_must_fail git describe --dirty HEAD
	'

The difference is when the tested command segfaults or dies in an
uncontrolled fashion; test_must_fail diagnoses it as a failure,
while "test $? != 0" at the end will say "ok, the command correctly
failed".
