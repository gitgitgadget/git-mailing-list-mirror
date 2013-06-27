From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i: fixup fixup! fixup!
Date: Thu, 27 Jun 2013 13:52:33 -0700
Message-ID: <7vr4fnqnse.fsf@alter.siamese.dyndns.org>
References: <20130611180530.GA18488@oinkpad.pimlott.net>
	<87obbc8otc.fsf@hexa.v.cablecom.net> <1371237209-sup-639@pimlott.net>
	<1371278908-sup-1930@pimlott.net>
	<7vk3lvlmat.fsf@alter.siamese.dyndns.org>
	<87ip1e2tzx.fsf@hexa.v.cablecom.net>
	<7v7ghtjwbb.fsf@alter.siamese.dyndns.org>
	<8738shi2ht.fsf@linux-k42r.v.cablecom.net>
	<7vwqpshkxj.fsf@alter.siamese.dyndns.org>
	<1372190294-sup-1398@pimlott.net>
	<7v61x127bw.fsf@alter.siamese.dyndns.org>
	<1372198415-sup-2114@pimlott.net> <1372283778-sup-5704@pimlott.net>
	<7vd2r8v3fa.fsf@alter.siamese.dyndns.org>
	<1372291877-sup-8201@pimlott.net> <1372359783-sup-4507@pimlott.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@inf.ethz.ch>, git <git@vger.kernel.org>
To: Andrew Pimlott <andrew@pimlott.net>
X-From: git-owner@vger.kernel.org Thu Jun 27 22:52:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsJBK-0002PR-UN
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 22:52:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754042Ab3F0Uwh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Jun 2013 16:52:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55217 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754017Ab3F0Uwf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jun 2013 16:52:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 67B67298F5;
	Thu, 27 Jun 2013 20:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MHfFG1eSO8zZTN78bMI2R6lH/uY=; b=cxEfqv
	46d1xYQdgqNfIG5Yyf0PGoscJLVOfKc5FdOlvyhx2SUkqFcxT3wvi2bqdLHVgDWE
	50ti9dz+uQZCSLDv0zwkBcKFhrVMDrFPmMDWYyGXKM+wLEKDIyKbILV6pC0lr7sj
	xl8hTdMUfsZxbFih0o2yvmZSG76lDoeantp8I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TFxSyKUzWfJHdKzVn6HAqIGLTxblJOfI
	6n2wVaiBjQToKVMzBkRVRcm9EcN8t7hPIR/3rca6SAtdnPqTHUej7GmmQwAqINxA
	4K/ItnWeK/cHleTxtc9jGhIJd+iNyhPt+mTfSl791WB+4+ujH4cWHjcGEhBzNzp3
	pWgP3qxjbgM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C498298F4;
	Thu, 27 Jun 2013 20:52:35 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D5553298F2;
	Thu, 27 Jun 2013 20:52:34 +0000 (UTC)
In-Reply-To: <1372359783-sup-4507@pimlott.net> (Andrew Pimlott's message of
	"Thu, 27 Jun 2013 12:26:31 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7E594BEE-DF6B-11E2-947A-E636B1368C5F-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229156>

Andrew Pimlott <andrew@pimlott.net> writes:

> Updated for recommended here-doc style.

Thanks.

> +test_auto_fixup_fixup () {
> +	git reset --hard base &&
> +	echo 1 >file1 &&
> +	git add -u &&
> +	test_tick &&
> +	git commit -m "$1! first" &&
> +	echo 2 >file1 &&
> +	git add -u &&
> +	test_tick &&
> +	git commit -m "$1! $2! first" &&
> +	git tag "final-$1-$2" &&
> +	test_tick &&
> +	(
> +		set_cat_todo_editor &&
> +		test_must_fail git rebase --autosquash -i HEAD^^^^ >actual &&
> +		cat >expected <<EOF
> +pick $(git rev-parse --short HEAD^^^) first commit
> +$1 $(git rev-parse --short HEAD^) $1! first
> +$1 $(git rev-parse --short HEAD) $1! $2! first
> +pick $(git rev-parse --short HEAD^^) second commit
> +EOF
> +		test_cmp expected actual

Two issues here, which I'll locally amend (no need to resend):

		cat >expected <<-EOF &&
		pick ...
		...
                EOF
		test_cmp expected actual
