From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/7] t/t5503-tagfollow: change from skip_all=* to prereq
 skip
Date: Wed, 11 Aug 2010 11:32:09 -0700
Message-ID: <7vtyn1xaom.fsf@alter.siamese.dyndns.org>
References: <1281469968-25670-1-git-send-email-avarab@gmail.com>
 <1281469968-25670-5-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Aug 11 20:32:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjG6H-0001vp-Mq
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 20:32:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755300Ab0HKScU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Aug 2010 14:32:20 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47212 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755226Ab0HKScS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Aug 2010 14:32:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 81DA1CC3DE;
	Wed, 11 Aug 2010 14:32:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=tWhs+ovFhkR6lr5mVMfis5pvO
	NA=; b=tOF9LqL6UtNXC5+fYxh8MvqYP6imOeHV1Kou08J3mSe30XNTVCk10vM+c
	XlJvDdeEz3WQQcKeIu7uc9n5Shh/5icyd96OFjxRXrPOzwab4A2skfgqML9RNKlF
	x5Pz70gXgQdmSQyEjLauz4EdNOelDg4rUxUcPgceb2QuStuzOw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=Y1vLdw7hRTaC6SjEtFX
	qbdgnNuozR2dQWWMXDicBNR7vjh4ZocZnOU0dw7RRxpE/gmqtOAdFKJCqP6AYphH
	8JlMdQHqkwablHKGnLa1imn9iEnarJAxjzJTZX+8VgdSGpE/mKOMqpu1qf8fM/eg
	6CX7ku7fh5I6v4A1ef/iViEI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 283E5CC3D3;
	Wed, 11 Aug 2010 14:32:15 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D5DAECC3CB; Wed, 11 Aug
 2010 14:32:10 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C3921F1A-A576-11DF-839C-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153272>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> diff --git a/t/t5503-tagfollow.sh b/t/t5503-tagfollow.sh
> index bab1a53..8a298a6 100755
> --- a/t/t5503-tagfollow.sh
> +++ b/t/t5503-tagfollow.sh
> @@ -6,8 +6,11 @@ test_description=3D'test automatic tag following'
> =20
>  case $(uname -s) in
>  *MINGW*)
> -	skip_all=3D"GIT_DEBUG_SEND_PACK not supported - skipping tests"
> -	test_done
> +	say "GIT_DEBUG_SEND_PACK not supported - skipping tests"
> +	;;
> +*)
> +	test_set_prereq NOT_MINGW
> +	;;
>  esac

To =C3=86var; isn't the prerequisite for these tests "does our git supp=
ort send
pack debugging?" not "are we not running on mingw?"  Let's call it
DEBUG_SEND_PACK or something.

To J6t; does the assumption here still hold, or do we support send pack
debugging these days?
