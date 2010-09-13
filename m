From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] tests: use test_cmp instead of piping to diff(1)
Date: Mon, 13 Sep 2010 16:31:45 -0700
Message-ID: <7vy6b59q5a.fsf@alter.siamese.dyndns.org>
References: <1284411582-1088-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 14 01:32:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvIVR-0004t7-0z
	for gcvg-git-2@lo.gmane.org; Tue, 14 Sep 2010 01:32:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751906Ab0IMXb4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Sep 2010 19:31:56 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57520 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751585Ab0IMXbz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Sep 2010 19:31:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BE295D658E;
	Mon, 13 Sep 2010 19:31:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=wW6kx1oXYTsv
	D7vyafB0ZJOzSM0=; b=KLjo84Jd3drfFto6bIh+buLKSS6E60wW9JvPJZBE16Xp
	Ct5ehkr3voRQxyUkhhLvo523tnnS7mwOvhlF4BToWbvJ3WnqLq5WkryNBBOyals4
	4tsu1qQPP3H5zNZv65QlGSFtLcGt9MfMfzjkftGbu7rNXqRa/am4sEvgSyoLpgw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=XI4EC9
	fC52otMR4fiHJ3Vm1G9TC4KnGZOij4hfXwrZUQL9cfwg1/WRsU/+B9eAxgdY9Xk5
	CIFgCCb6M5GaOfx+fN1Ziwc4EKgQPqHv9+/l05YUuiRHM3XBko8QNIlCzES7QI00
	Nh0HtSpFmgIMOsXLArJ9rwEBRAeryuZ1BixGQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 89816D6589;
	Mon, 13 Sep 2010 19:31:50 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CD7A6D6588; Mon, 13 Sep
 2010 19:31:46 -0400 (EDT)
In-Reply-To: <1284411582-1088-1-git-send-email-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon\, 13 Sep
 2010 20\:59\:42 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1570F84C-BF8F-11DF-B60B-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156152>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> @@ -37,9 +37,10 @@ head1=3D$(add_file sm1 foo1 foo2)
>  test_expect_success 'added submodule' "
>  	git add sm1 &&
>  	git diff-index -p --submodule=3Dlog HEAD >actual &&
> -	diff actual - <<-EOF
> +	cat >expected <<-EOF &&
>  Submodule sm1 0000000...$head1 (new submodule)
>  EOF
> +    test_cmp expected actual
>  "

Nit.  Did you really mean <<-EOF, not <<EOF, here, especially you are
writing the here document without indentation with any TAB?
