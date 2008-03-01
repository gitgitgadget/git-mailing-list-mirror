From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] git-submodule: New subcommand 'summary' (3) -
 limit summary size
Date: Sat, 01 Mar 2008 12:26:14 -0800
Message-ID: <7vpruexkbd.fsf@gitster.siamese.dyndns.org>
References: <1204306487-15849-1-git-send-email-pkufranky@gmail.com>
 <80aa1c46ced6f0b92ca2fca3b917d383343b3161.1204306070.git.pkufranky@gmail.com>
 <d6e82710452985611fb75c9d32a1b772bf0cb529.1204306070.git.pkufranky@gmail.com>
 <18af168b52a735c33612c9c9e4778d8b8bef1cbc.1204306070.git.pkufranky@gmail.com>
 <7v1w6u7vhf.fsf@gitster.siamese.dyndns.org>
 <46dff0320803010442y12c1326dk45f53ce17453b53c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Ping Yin" <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 01 21:27:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVYIS-0002fZ-VC
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 21:27:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758275AbYCAU00 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 15:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758246AbYCAU00
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 15:26:26 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:65181 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758195AbYCAU0Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 15:26:25 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E7A45161F;
	Sat,  1 Mar 2008 15:26:23 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 440F7161E; Sat,  1 Mar 2008 15:26:18 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75698>

"Ping Yin" <pkufranky@gmail.com> writes:

> On Sat, Mar 1, 2008 at 3:29 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> expr is portable?

It's not just portable but is a very old fashioned and time-proven way to
do things like this.

>>         if summary_limit=$(( $2 + 0 )) 2>/dev/null ||
>>            test "$2" != "$summary_limit"
>>         then
>>                 usage
>>         fi
>>
>
> summary_limit=$(( $2 + 0 )) will always has return status 0

Ah, there's a typo there.  The intention was to reject non numbers

	for two in 43 -32 'deadbeef' ' -27' HEAD ''
        do
		if sl=$(( $two + 0 )) 2>/dev/null && test "$two" == "$sl"
                then
                	echo Ah, "$two", that is a number.
		else
                	echo You gave me an un-number "'$two' (vs '$sl')".
		fi
	done
