From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: Incremental updates to What's cooking
Date: Wed, 29 Feb 2012 08:37:37 +0100
Message-ID: <4F4DD5C1.60604@in.waw.pl>
References: <7vy5rn1mar.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 29 08:37:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2e6f-0001mE-Mi
	for gcvg-git-2@plane.gmane.org; Wed, 29 Feb 2012 08:37:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030858Ab2B2Hhq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Feb 2012 02:37:46 -0500
Received: from kawka.in.waw.pl ([178.63.212.103]:55309 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755766Ab2B2Hho (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Feb 2012 02:37:44 -0500
Received: from 89-78-221-60.dynamic.chello.pl ([89.78.221.60] helo=[192.168.0.12])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1S2e6Z-00084b-4w; Wed, 29 Feb 2012 08:37:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:8.0) Gecko/20120104 Icedove/8.0
In-Reply-To: <7vy5rn1mar.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191814>

On 02/28/2012 07:53 AM, Junio C Hamano wrote:

> * zj/diff-stat-dyncol (2012-02-27) 11 commits
>   - diff --stat: add config option to limit graph width
>   - diff --stat: enable limiting of the graph part
>   - diff --stat: add a test for output with COLUMNS=40
>   - diff --stat: use a maximum of 5/8 for the filename part
>   - merge --stat: use the full terminal width
>   - log --stat: use the full terminal width
>   - show --stat: use the full terminal width
>   - diff --stat: use the full terminal width
>   - diff --stat: tests for long filenames and big change counts
>   - t4014: addtional format-patch test vectors
>   - Merge branches zj/decimal-width, zj/term-columns and jc/diff-stat-scaler
>
> I resurrected the additional tests for format-patch from an earlier round,
> as it illustrates the behaviour change brought by "5/8 split" very well.
Hi,
the resurrected tests are partly duplicated in 4052-stat-output.sh:

t4014:
ok 75 - small change with long name gives more space to the name
ok 76 - a long name is given more room when the bar is short
ok 77 - format patch --stat-width=width works with long name        *
ok 78 - format patch --stat=...,name-width with long name           *
ok 79 - format patch --stat-name-width with long name               *
ok 81 - format patch graph part width                               *
ok 82 - format patch ignores COLUMNS                                *
ok 83 - format patch --stat=width with big change                   *
ok 84 - format patch --stat-width=width with big change             *
ok 85 - partition between long name and big change is more balanced

t4052:
ok 3 - format-patch graph width defaults to 80 columns
ok 4 - format-patch --stat=width with long name
ok 5 - format-patch --stat-width=width with long name
ok 6 - format-patch --stat=...,name-width with long name
ok 7 - format-patch --stat-name-width with long name
ok 24 - format-patch ignores too many COLUMNS (big change)
ok 28 - format-patch ignores not enough COLUMNS (big change)
ok 29 - format-patch ignores statGraphWidth config
ok 36 - format-patch --stat=width with big change
ok 37 - format-patch --stat-width=width with big change
ok 38 - format-patch --stat-graph--width with big change
ok 49 - format-patch --stat=width with big change and long name
ok 53 - format-patch ignores COLUMNS (long filename)

The ones with * are duplicated exactly. They tests run very fast, but 
maybe the duplicated ones should be culled.

Zbyszek
