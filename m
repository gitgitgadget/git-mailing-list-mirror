From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH en/cascade-tests] tests: add missing &&
Date: Sat, 30 Oct 2010 20:31:48 -0700
Message-ID: <7vr5f73umz.fsf@alter.siamese.dyndns.org>
References: <1286136014-7728-1-git-send-email-newren@gmail.com>
 <1286136014-7728-16-git-send-email-newren@gmail.com>
 <20101031014654.GC29456@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
	avarab@gmail.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 31 04:32:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCOeV-0002t4-Ot
	for gcvg-git-2@lo.gmane.org; Sun, 31 Oct 2010 04:32:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754657Ab0JaDcB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Oct 2010 23:32:01 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53194 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753764Ab0JaDcA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Oct 2010 23:32:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CE9202FA1;
	Sat, 30 Oct 2010 23:31:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PKgPzA+pmCdAUIv0KNGBCePvvgc=; b=k5rt5R
	6IvT0j6+j2q6X8EZ+VsTJSlaH8o44vbBEkufX1DCPcJKKpw8mijIjSKewXH1+rpJ
	LM6VhdxvGl4F0kHt/m+dwCWQPfkiQBzonyxc30rpPALvl3uySgagSfSzs6aCmgx5
	RtvQVIU2852xiQIVoiSm2jF7hpqElYUVcLMVE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=t05ccjCSnTqkLFjKYErcoJNMCSxuOxfu
	W1s+dLZsVM2cbSoa7IFoVSHFkoCkGIKl25A39T7W1qy9Fieky8oJXCPZkDnB8I8t
	zrG/zQT9sGpDDXrf05bDC7PAa9/w+XHqzUgtzRqWLUCFrH6zXOu8d00g0xMYhkYE
	MeipQWLAd+o=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F1082FA0;
	Sat, 30 Oct 2010 23:31:55 -0400 (EDT)
Received: from pobox.com (unknown [76.102.169.49]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C39A72F9F; Sat, 30 Oct
 2010 23:31:50 -0400 (EDT)
In-Reply-To: <20101031014654.GC29456@burratino> (Jonathan Nieder's message of
 "Sat\, 30 Oct 2010 20\:46\:54 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 68EB37BE-E49F-11DF-AFE0-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160411>

Jonathan Nieder <jrnieder@gmail.com> writes:

> @@ -27,7 +27,7 @@ test_expect_success 'see what we expect' '
>  	>junk/"$auml" &&
>  	case "$(cd junk && echo *)" in
>  	"$aumlcdiar")
> -		test_unicode=test_expect_failure
> +		test_unicode=test_expect_failure &&
>  		unibad=t
>  		;;
>  	*)	;;

This seems to prepare for a case where a simple variable assignment fails
for whategver reason, which is not too bad, but ...

> @@ -36,7 +36,7 @@ test_expect_success 'see what we expect' '
>  	{
>  		ln -s x y 2> /dev/null &&
>  		test -h y 2> /dev/null ||
> -		no_symlinks=1
> +		no_symlinks=1 &&
>  		rm -f y

... if you allowed such a simple assignment failure, no_symlinks=1 may
fail, and we end up not running "rm -f y" to clean up, which might be
somewhat undesirable ;-)

Looked up to but not including t5302 and all looked Ok.
