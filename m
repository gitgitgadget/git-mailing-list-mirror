From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Allow shell scripts to run with non-Bash /bin/sh
Date: Sat, 22 Sep 2007 13:07:04 +0200
Message-ID: <85ps0buffr.fsf@lola.goethe.zz>
References: <20070921214346.GF97288@void.codelabs.ru>
	<7vlkazh1ji.fsf@gitster.siamese.dyndns.org>
	<20070921214346.GF97288@void.codelabs.ru>
	<7v8x6zinjf.fsf@gitster.siamese.dyndns.org>
	<20070922035434.GA99140@void.codelabs.ru>
	<86tzpnwdha.fsf@lola.quinscape.zz>
	<7vd4wbgp9t.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 22 13:07:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZ2pd-0006a6-7x
	for gcvg-git-2@gmane.org; Sat, 22 Sep 2007 13:07:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752440AbXIVLHV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Sep 2007 07:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752340AbXIVLHV
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Sep 2007 07:07:21 -0400
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:47878 "EHLO
	mail-in-06.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751230AbXIVLHT (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Sep 2007 07:07:19 -0400
Received: from mail-in-13-z2.arcor-online.net (mail-in-13-z2.arcor-online.net [151.189.8.30])
	by mail-in-06.arcor-online.net (Postfix) with ESMTP id 45D6631EC83;
	Sat, 22 Sep 2007 13:07:16 +0200 (CEST)
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net [151.189.21.45])
	by mail-in-13-z2.arcor-online.net (Postfix) with ESMTP id 36DE21B8E55;
	Sat, 22 Sep 2007 13:07:16 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-012-197.pools.arcor-ip.net [84.61.12.197])
	by mail-in-05.arcor-online.net (Postfix) with ESMTP id F142B1C36B6;
	Sat, 22 Sep 2007 13:07:07 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id BB0321CD9E3F; Sat, 22 Sep 2007 13:07:04 +0200 (CEST)
In-Reply-To: <7vd4wbgp9t.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Fri\, 21 Sep 2007 23\:58\:22 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/4357/Fri Sep 21 11:55:46 2007 on mail-in-05.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58930>

Junio C Hamano <gitster@pobox.com> writes:

> David Kastrup <dak@gnu.org> writes:
>
>> Eygene Ryabinkin <rea-git@codelabs.ru> writes:
>>
>>>> That is, what does the shell say if you do this?
>>>> 
>>>> 	case Ultra in
>>>>         Super)
>>>>         	false ;;
>>>> 	Hyper)
>>>>         	true ;;
>>>> 	esac &&
>>>>         echo case returned ok
>>>
>>> It says 'case returned ok', so I will try to understand why it
>>> works here and does not work in the 'while' construct.
>>
>> What you actually need to do is
>>
>> false
>> case Ultra in
>>    Super)
>>    	false ;;
>> Hyper)
>>    	true ;;
>> esac && echo case returned ok
>
> AHHHHHH.
>
> Is "case" supposed to be transparent?

Not that I would know.  It is basically a revival of the

false
if false then : ; fi || echo "this fails!?!"

bug that probably has been fixed by now.  For obvious reasons,
conditionals without a taken branch are considered to have an exit
code of 0.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
