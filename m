From: Jonathon Mah <me@JonathonMah.com>
Subject: Re: [PATCH] stash: Don't fail if work dir contains file named 'HEAD'
Date: Fri, 30 Dec 2011 16:01:53 -0800
Message-ID: <117AA87B-FDCA-48B3-B5A3-02AF392332E9@JonathonMah.com>
References: <913BB2F9-3C51-44D0-BFEC-3A49A5EC9E15@JonathonMah.com> <8739c28iwh.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sat Dec 31 01:02:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RgmOm-0007L4-7f
	for gcvg-git-2@lo.gmane.org; Sat, 31 Dec 2011 01:02:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752347Ab1LaACD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Dec 2011 19:02:03 -0500
Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:33458 "EHLO
	ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752203Ab1LaACC convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Dec 2011 19:02:02 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApIBALxO/k5M5FL2/2dsb2JhbAAMN69LAQEBAwE6PwULCw44VwYTh3q1OIssYwSIN5pLhFU
Received: from adsl-76-228-82-246.dsl.pltn13.sbcglobal.net (HELO [10.0.90.86]) ([76.228.82.246])
  by ipmail06.adl6.internode.on.net with ESMTP; 31 Dec 2011 10:31:56 +1030
In-Reply-To: <8739c28iwh.fsf@thomas.inf.ethz.ch>
X-Mailer: Apple Mail (2.1251.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187810>

Thanks for the feedback, Thomas. I should note, this bug initially came up on #git several days ago.

I've tried to take on all your suggestions; patch v2 imminent.

On 2011-12-30, at 02:15, Thomas Rast wrote:

> Jonathon Mah <me@JonathonMah.com> writes:
>> diff --git a/t/t3904-stash-patch.sh b/t/t3904-stash-patch.sh
> [...]
> 
> Other reviewers may want to read these hunks in word diff mode, where it
> is far easier to verify that the functionality tested is a superset:
> 
>  test_expect_success PERL 'saying "n" does nothing' '
>          {+set_state HEAD HEADfile_work HEADfile_index &&+}
>          set_state dir/foo work index &&
>          (echo n; echo {+n; echo+} n) | test_must_fail git stash save -p &&
>          verify_state [-dir/foo work index-]{+HEAD HEADfile_work HEADfile_index+} &&
>          verify_saved_state bar {+&&+}
>  {+      verify_state dir/foo work index+}
>  '

I added a note to the message: In t3904, checks and operations on each file are in the order they'll appear when interactively staging.

That is, "echo y/n; echo y/n; ..." for the three files corresponds to the surrounding checks.



Jonathon Mah
me@JonathonMah.com
