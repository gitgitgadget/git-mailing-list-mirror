From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v2 0/3] Easier access to index-v4
Date: Mon, 24 Feb 2014 20:53:14 +0100
Message-ID: <87y510s2xh.fsf@hank.lan>
References: <1393188599-5391-1-git-send-email-t.gummerer@gmail.com> <xmqqios49yyq.fsf@gitster.dls.corp.google.com> <xmqqwqgk8fsq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, pclouds@gmail.com, sunshine@sunshineco.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 24 20:55:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WI1aS-0005jL-Eq
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 20:53:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753294AbaBXTxH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 14:53:07 -0500
Received: from mail-la0-f41.google.com ([209.85.215.41]:45008 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752649AbaBXTxG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Feb 2014 14:53:06 -0500
Received: by mail-la0-f41.google.com with SMTP id gl10so3429169lab.0
        for <git@vger.kernel.org>; Mon, 24 Feb 2014 11:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type;
        bh=eml64CPREUZYn5yVXPRKIBH2q/gbZ0XPPRwxhZyksxo=;
        b=MihuTqcmJgyneSbsn2EY4OYxDVyo5KA8Yt2tNnNsAqSHPjJ09F/FgQNw8s5ybohvtr
         rGrHis96pjhCVIuuHFIoY/MlgpzDEagJGFlVpwUzziJyWvQnruqXJSAEqjwfXye1Dwqw
         cB3rlhsd4w/rR1lyvCoO0i+FpXP0iLfsj/hkYlRxqE4NUHyRPCyISRCSdXOzqJN5K4gZ
         KNJWg1IIcelIyu8XuSA1oZO6NAD846wKlY6NIVogxw8+U2lptzXqP22MCVZzsLF3vd/g
         RtvdAloeP9Vy4p0/QKTKEV5PN8WdSaQUisS8z0eD7YZH7/Wc9KLeX/czIcTpQoWFcwSX
         276g==
X-Received: by 10.153.8.194 with SMTP id dm2mr2490546lad.54.1393271584907;
        Mon, 24 Feb 2014 11:53:04 -0800 (PST)
Received: from localhost (213-66-41-37-no99.tbcn.telia.com. [213.66.41.37])
        by mx.google.com with ESMTPSA id 10sm27057787lan.5.2014.02.24.11.53.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Feb 2014 11:53:03 -0800 (PST)
In-Reply-To: <xmqqwqgk8fsq.fsf@gitster.dls.corp.google.com>
User-Agent: Notmuch/0.17 (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242634>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Thomas Gummerer <t.gummerer@gmail.com> writes:
>>
>>> previous round was at $gmane/242198.
>>>
>>> Since then I've squashed the fixes suggested by Junio, added a test
>>> showing what should happen if an index file is present and
>>> GIT_INDEX_VERSION is set and fixed the typo found by Eric.
>>
>> Looks good; thanks.
>
> Tests, seem to leak these unnecessary diag (not limited to t0010).
>
>     sh t0010-racy-git.sh 
>     warning: GIT_INDEX_VERSION set, but the value is invalid.
>     Using version 3
>     ok 1 - Racy GIT trial #0 part A
>     ok 2 - Racy GIT trial #0 part B
>     warning: GIT_INDEX_VERSION set, but the value is invalid.
>     Using version 3
>     ...
>     # passed all 10 test(s)
>     1..10
>
>
> The same thing under prove.
>
>     *** prove ***
>     t0010-racy-git.sh .. warning: GIT_INDEX_VERSION set, but the value is invalid.
>     Using version 3
>     t0010-racy-git.sh .. 2/? warning: GIT_INDEX_VERSION set, but the value is invalid.
>     Using version 3
>     t0010-racy-git.sh .. 4/? warning: GIT_INDEX_VERSION set, but the value is invalid.
>     Using version 3
>     t0010-racy-git.sh .. 6/? warning: GIT_INDEX_VERSION set, but the value is invalid.
>     Using version 3
>     t0010-racy-git.sh .. 8/? warning: GIT_INDEX_VERSION set, but the value is invalid.
>     Using version 3
>     t0010-racy-git.sh .. ok    
>     All tests successful.
>
>
> I suspect the real culprit is the early part in test-lib.sh that
> sets GIT_INDEX_VERSION explicitly from TEST_GIT_INDEX_VERSION when
> the latter is not even specified.
>
> Something along this line, perhaps?

Sorry about this, I didn't run the test suite without
TEST_GIT_INDEX_VERSION in config.mak which I obviously should have.

Yes, this looks good to me, thanks!

>  t/test-lib.sh | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 492f81f..01a98cb 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -108,8 +108,11 @@ export GIT_AUTHOR_EMAIL GIT_AUTHOR_NAME
>  export GIT_COMMITTER_EMAIL GIT_COMMITTER_NAME
>  export EDITOR
>  
> -GIT_INDEX_VERSION="$TEST_GIT_INDEX_VERSION"
> -export GIT_INDEX_VERSION
> +if test -n "${TEST_GIT_INDEX_VERSION+isset}"
> +then
> +	GIT_INDEX_VERSION="$TEST_GIT_INDEX_VERSION"
> +	export GIT_INDEX_VERSION
> +fi
>  
>  # Add libc MALLOC and MALLOC_PERTURB test
>  # only if we are not executing the test with valgrind
