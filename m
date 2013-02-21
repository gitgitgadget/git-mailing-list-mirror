From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 4/4] t7800: "defaults" is no longer a builtin tool
 name
Date: Wed, 20 Feb 2013 21:00:01 -0800
Message-ID: <7vzjyyw9bi.fsf@alter.siamese.dyndns.org>
References: <1361419428-22410-1-git-send-email-davvid@gmail.com>
 <1361419428-22410-2-git-send-email-davvid@gmail.com>
 <1361419428-22410-3-git-send-email-davvid@gmail.com>
 <1361419428-22410-4-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 21 06:00:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8OGt-0008B3-M3
	for gcvg-git-2@plane.gmane.org; Thu, 21 Feb 2013 06:00:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952Ab3BUFAM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2013 00:00:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63469 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750705Ab3BUFAK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2013 00:00:10 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 36597B0AB;
	Thu, 21 Feb 2013 00:00:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oSGnkIW0s2uCLaCcwR3gpRnT/sM=; b=TN1iUz
	ALfecn2DZVDFnSCxFFVBzh2tLCZcY5yG8yROmxumolVps0JE5qiJKJ5PqAABKtZj
	Qnrzd0ptIJPimX5rPg2I1InN1ifga6k5eLaIkJYrBfKwyzHHsA5mjalYZvJrtbdW
	rOrsxr4OPQbjkW+Q27a4dM81LcSxGWgXFklbY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uQ5LAhCDzbiFXC8dFNM2pEgtwMb1JQsU
	ga8ALYd/vuBMuoAWFFpcQvZNB/k7x00pMuJ31bXTVcNaRf0xGoPoyDQ0aoiBIm2n
	YPzOSNScy9gGlPwHYAf5TFfSeuPXCyZysNx8xlbLUiTdsFg53Z19//0kPMl51faI
	B1vD2WNftds=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 29BBEB0AA;
	Thu, 21 Feb 2013 00:00:10 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 562E2B0A5; Thu, 21 Feb 2013
 00:00:09 -0500 (EST)
In-Reply-To: <1361419428-22410-4-git-send-email-davvid@gmail.com> (David
 Aguilar's message of "Wed, 20 Feb 2013 20:03:48 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 90EA7846-7BE3-11E2-914C-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216752>

David Aguilar <davvid@gmail.com> writes:

> diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
> index fb00273..21fbba9 100755
> --- a/t/t7800-difftool.sh
> +++ b/t/t7800-difftool.sh
> @@ -60,9 +60,9 @@ test_expect_success PERL 'custom commands' '
>  '
>  
>  test_expect_success PERL 'custom tool commands override built-ins' '
> -	test_config difftool.defaults.cmd "cat \"\$REMOTE\"" &&
> +	test_config difftool.vimdiff "cat \"\$REMOTE\"" &&
>  	echo master >expect &&
> -	git difftool --tool defaults --no-prompt branch >actual &&
> +	git difftool --tool vimdiff --no-prompt branch >actual &&
>  	test_cmp expect actual
>  '

Eek.

$ sh t7800-difftool.sh -i
ok 1 - setup
ok 2 - custom commands
not ok 3 - custom tool commands override built-ins
#
#               test_config difftool.vimdiff "cat \"\$REMOTE\"" &&
#               echo master >expect &&
#               git difftool --tool vimdiff --no-prompt branch >actual &&
#               test_cmp expect actual
#

Running the same test with "-v" seems to get stuck with this
forever:

expecting success:
        test_config difftool.vimdiff "cat \"\$REMOTE\"" &&
        echo master >expect &&
        git difftool --tool vimdiff --no-prompt branch >actual &&
        test_cmp expect actual

Vim: Warning: Output is not to a terminal
Vim: Warning: Input is not from a terminal
