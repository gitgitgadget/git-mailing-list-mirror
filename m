From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: "./t0001-init.sh --valgrind" is broken
Date: Thu, 3 Mar 2016 19:17:34 +0100
Message-ID: <56D87FBE.5050908@kdbg.org>
References: <CAP8UFD0-FxoPe5-35NAKSkegFBoRPy1+BOsqN-y+QJUoXAqR3g@mail.gmail.com>
 <CACsJy8AL_RGEb2z44-yoL+3yF7n1+FMLqZkmWwUDFJnEPYS_nw@mail.gmail.com>
 <56D7DFD5.8010108@kdbg.org>
 <CACsJy8CVfJdCmwWo50wHsc6DP6ft71d5bfBaFSJpv9XcNRwdSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 03 19:17:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abXok-0000zO-8w
	for gcvg-git-2@plane.gmane.org; Thu, 03 Mar 2016 19:17:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbcCCSRj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2016 13:17:39 -0500
Received: from bsmtp8.bon.at ([213.33.87.20]:37823 "EHLO bsmtp8.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758108AbcCCSRi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2016 13:17:38 -0500
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp8.bon.at (Postfix) with ESMTPSA id 3qGL5W6lqxz5tlC;
	Thu,  3 Mar 2016 19:17:35 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 1D3EC5221;
	Thu,  3 Mar 2016 19:17:35 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <CACsJy8CVfJdCmwWo50wHsc6DP6ft71d5bfBaFSJpv9XcNRwdSQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288199>

Am 03.03.2016 um 13:09 schrieb Duy Nguyen:
> +the-other-Johannes who added valgrind support.
>
> On Thu, Mar 3, 2016 at 1:55 PM, Johannes Sixt <j6t@kdbg.org> wrote:
>> ---- 8< ----
>> Subject: [PATCH] t0001: fix GIT_* environment variable check under --valgrind
>>
>> When a test case is run without --valgrind, the wrap-for-bin.sh
>> helper script inserts the environment variable GIT_TEXTDOMAINDIR, but
>> when run with --valgrind, the variable is missing. A recently
>> introduced test case expects the presence of the variable, though, and
>> fails under --valgrind.
>
> Yep.
>
> It's interesting though that valgrind sets up some variables without
> going through bin-wrappers. That's understandable because valgrind
> support is added (in 4e1be63) 10 months before bin-wrappers (in
> ea92519).  But it's probably better that we inject valgrind command
> from inside bin-wrappers script, the same way we inject gdb, I think.
>
>> Rewrite the test case to strip conditially defined environment variables
>> from both expected and actual output.
>
> Or we could set GIT_TEXTDOMAINDIR in the "if test -n $valgrind" code
> in test-lib.sh, which makes the two more consistent. Also simpler
> patch.

My fix (or something along its lines) is needed nevertheless. Just 
s/--valgrind/--with-dashes/g in the commit message if you want to fix 
the --valgrind case differently ;-)

I run tests on Windows --with-dashes in the hopes that it saves a fork 
and exec or two on every git invocation.

-- Hannes
