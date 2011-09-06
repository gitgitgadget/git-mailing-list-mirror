From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] Makefile: abort on shells that do not support ${parameter%word}
 expansion
Date: Tue, 06 Sep 2011 15:20:53 -0500
Message-ID: <P8L-gIYkRp9VP2hZA6C9Q0Ka-vFda8JLDmCkZvI-HruWKjjPYWAg-PmIrbpKE20ORu1qtoL33A2B9_m2ojl0754hk4q4quHgQXx3-S5StEk@cipher.nrlssc.navy.mil>
References: <7vbouzxy7g.fsf@alter.siamese.dyndns.org> <RSBDfxxpq50B8raodg0TA26S3QuHAy1YIJsAy6F4U0luolR_nfBc83hs9i2B3xAWjXI-EHymM00@cipher.nrlssc.navy.mil> <7v1uvt8ml6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Naohiro Aota <naota@elisp.net>, git@vger.kernel.org,
	tarmigan+git@gmail.com, David Barr <davidbarr@google.com>,
	Brandon Casey <drafnel@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 06 22:21:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R128u-0001So-6q
	for gcvg-git-2@lo.gmane.org; Tue, 06 Sep 2011 22:21:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755109Ab1IFUVH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Sep 2011 16:21:07 -0400
Received: from mail3.nrlssc.navy.mil ([128.160.11.249]:42824 "EHLO
	mail3.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755043Ab1IFUVF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2011 16:21:05 -0400
Received: by mail3.nrlssc.navy.mil id p86KKsVB024288; Tue, 6 Sep 2011 15:20:54 -0500
In-Reply-To: <7v1uvt8ml6.fsf@alter.siamese.dyndns.org>
X-OriginalArrivalTime: 06 Sep 2011 20:20:53.0351 (UTC) FILETIME=[7A0D0F70:01CC6CD2]
X-Virus-Scanned: clamav-milter 0.97.2 at mail3
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180830>

On 09/06/2011 03:03 PM, Junio C Hamano wrote:
> Brandon Casey <casey@nrlssc.navy.mil> writes:
> 
>> diff --git a/Makefile b/Makefile
>> index 8d6d451..46d9c5d 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -1738,6 +1738,7 @@ endif
>>  
>>  please_set_SHELL_PATH_to_a_more_modern_shell:
>>  	@$$(:)
>> +	@foo=bar_suffix && test bar = "$${foo%_*}"
>>  
>>  shell_compatibility_test: please_set_SHELL_PATH_to_a_more_modern_shell
> 
> Perhaps
> 
> 	@foo='bar?suffix' && test bar = "$${foo%\?*}"
> 
> instead?

Looks right.

Naohiro, can you test?  Or someone else with FreeBSD?

make should produce an error message like this:

   gmake: *** [please_set_SHELL_PATH_to_a_more_modern_shell] Error 1

-Brandon
