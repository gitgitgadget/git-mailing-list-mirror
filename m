From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: What's cooking in git.git (Jan 2010, #01; Mon, 04)
Date: Wed, 06 Jan 2010 10:08:34 +0100
Message-ID: <4B445312.9090507@kdbg.org>
References: <7vljgei7rs.fsf@alter.siamese.dyndns.org> <4B421766.4040506@kdbg.org> <7vhbr1bagk.fsf@alter.siamese.dyndns.org> <4B43A5CA.7090104@kdbg.org> <7vzl4r7jyu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 06 10:08:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSRsl-0004Di-Te
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 10:08:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754713Ab0AFJIm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2010 04:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754204Ab0AFJIm
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jan 2010 04:08:42 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:18437 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752987Ab0AFJIl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2010 04:08:41 -0500
Received: from [77.117.162.206] (77.117.162.206.wireless.dyn.drei.com [77.117.162.206])
	by bsmtp.bon.at (Postfix) with ESMTP id 7742A2C4014;
	Wed,  6 Jan 2010 10:08:37 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <7vzl4r7jyu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136253>

Junio C Hamano schrieb:
> Regarding your "[PATCH 8/6] t4030, t4031", I have two questions:
> 
>     Recall that MSYS bash converts POSIX style absolute paths to Windows style
>     absolute paths. Unfortunately, it converts a program argument that begins
>     with a double-quote and otherwise looks like an absolute POSIX path, but
>     in doing so, it strips everything past the second double-quote[*]. This
>     case is triggered in the two test scripts. The work-around is to place the
>     Windows style path between the quotes to avoid the path conversion.
> 
> (1) Does "Windows style path" here mean what $(pwd) returns as opposed to
>     what is in $PWD?

Yes. $PWD is of the form /c/foo/bar; pwd is a function in test-lib.sh that 
ensures it returns the form c:/foo/bar.

> (2) The patch reads like this:
> 
> -	git config diff.foo.textconv "\"$PWD\""/hexdump &&
> +	git config diff.foo.textconv "\"$(pwd)\""/hexdump &&
> 
>     Does "strips everything past the second dq" mean "drops '/hexdump'"?

Yes.

>     If so, would this also work (I am not suggesting to change it, just
>     asking for information)?
> 
> -	git config diff.foo.textconv "\"$PWD\""/hexdump &&
> +	git config diff.foo.textconv "\"$PWD/hexdump\"" &&

It would work, too, but it would depend on very bogus behavior of the MSYS 
bash.

-- Hannes
