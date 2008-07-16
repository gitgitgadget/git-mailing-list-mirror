From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Use SHELL_PATH
Date: Wed, 16 Jul 2008 08:46:05 -0700
Message-ID: <7vr69tu91e.fsf@gitster.siamese.dyndns.org>
References: <g5jj21$bsp$1@ger.gmane.org>
 <bd6139dc0807160347n2ebcd64fy7a15fe94bfabe580@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: namsh@posdata.co.kr, git@vger.kernel.org
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Wed Jul 16 17:47:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJ9E7-0001NI-9q
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 17:47:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758012AbYGPPqR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 11:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757715AbYGPPqP
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 11:46:15 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:65020 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758508AbYGPPqO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 11:46:14 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 8662B2E9F7;
	Wed, 16 Jul 2008 11:46:12 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id ACCA62E9F6; Wed, 16 Jul 2008 11:46:07 -0400 (EDT)
In-Reply-To: <bd6139dc0807160347n2ebcd64fy7a15fe94bfabe580@mail.gmail.com>
 (Sverre Rabbelier's message of "Wed, 16 Jul 2008 12:47:43 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 512C3A72-534E-11DD-8F60-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88692>

"Sverre Rabbelier" <alturin@gmail.com> writes:

> On Wed, Jul 16, 2008 at 3:31 AM, SungHyun Nam <goweol@gmail.com> wrote:
>>
>> Signed-off-by: SungHyun Nam <goweol@gmail.com>
>> ---
>>  t/Makefile |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/t/Makefile b/t/Makefile
>> index a778865..0d65ced 100644
>> --- a/t/Makefile
>> +++ b/t/Makefile
>> @@ -26,7 +26,7 @@ clean:
>>        $(RM) -r 'trash directory' test-results
>>
>>  aggregate-results:
>> -       ./aggregate-results.sh test-results/t*-*
>> +       '$(SHELL_PATH_SQ)' ./aggregate-results.sh test-results/t*-*
>>
>>  # we can test NO_OPTIMIZE_COMMITS independently of LC_ALL
>>  full-svn-test:
>> --
>> 1.5.6.3.350.g6c11a
>
> It is not clear to me what this patch does, there is no justification
> in the commit msg either. Instead you say what is being done, which we
> can see from the commit diff. Please clarify?

It wants to make sure that the shell specified from the toplevel Makefile
(or from make command line) is used to run the aggregation script.  It is
often necessary when platform /bin/sh is not quite POSIX (e.g. the script
in question uses arithmetic expansion "$(( $var1 + $var2 ))").

Just saying "Use specified shell to run shell scripts" on the title line
would be sufficient, but I wonder if this is the only remaining place...
