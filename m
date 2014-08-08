From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH v2 04/23] rebase -i: hide interactive command messages in verbose mode
Date: Fri, 08 Aug 2014 21:09:44 +0200
Message-ID: <87y4uyajd3.fsf@thomasrast.ch>
References: <53A258D2.7080806@gmail.com>
	<cover.1407368621.git.bafain@gmail.com>
	<6d4f66b21315661e4f267f59341ebb798232a381.1407368621.git.bafain@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>
To: Fabian Ruch <bafain@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 08 21:10:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFpYM-00039A-63
	for gcvg-git-2@plane.gmane.org; Fri, 08 Aug 2014 21:10:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbaHHTJ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2014 15:09:59 -0400
Received: from ip1.thgersdorf.net ([148.251.9.194]:57802 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751034AbaHHTJ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2014 15:09:59 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 40BD94D6664;
	Fri,  8 Aug 2014 21:09:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 3n3Yiey7xNZZ; Fri,  8 Aug 2014 21:09:45 +0200 (CEST)
Received: from linux-1gf2.thomasrast.ch (173-161-212-225-Philadelphia.hfc.comcastbusiness.net [173.161.212.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id BCFF14D6572;
	Fri,  8 Aug 2014 21:09:44 +0200 (CEST)
In-Reply-To: <6d4f66b21315661e4f267f59341ebb798232a381.1407368621.git.bafain@gmail.com>
	(Fabian Ruch's message of "Thu, 7 Aug 2014 01:59:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255063>

Fabian Ruch <bafain@gmail.com> writes:

> @@ -923,6 +923,8 @@ EOF
>  	;;
>  esac
>  
> +mkdir -p "$state_dir" || die "Could not create temporary $state_dir"
> +
>  git var GIT_COMMITTER_IDENT >/dev/null ||
>  	die "You need to set your committer info first"
>  
> @@ -938,7 +940,6 @@ then
>  fi
>  
>  orig_head=$(git rev-parse --verify HEAD) || die "No HEAD?"
> -mkdir -p "$state_dir" || die "Could not create temporary $state_dir"
>  
>  : > "$state_dir"/interactive || die "Could not mark as interactive"
>  write_basic_state

Why this change?  I can't figure out how it relates to the output
change.

> @@ -873,9 +873,8 @@ test_expect_success 'running "git rebase -i --exec git show HEAD"' '
>  	(
>  		FAKE_LINES="1 exec_git_show_HEAD 2 exec_git_show_HEAD" &&
>  		export FAKE_LINES &&
> -		git rebase -i HEAD~2 >expect
> +		git rebase -i HEAD~2 >expected
>  	) &&
> -	sed -e "1,9d" expect >expected &&
>  	test_cmp expected actual
>  '

Getting rid of these magic removals is a very nice change, thank you.

-- 
Thomas Rast
tr@thomasrast.ch
