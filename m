From: Samuel GROOT <samuel.groot@grenoble-inp.org>
Subject: Re: [PATCH v3 1/6] t9001: non order-sensitive file comparison
Date: Wed, 8 Jun 2016 10:23:22 +0200
Message-ID: <f34e3636-ce71-8352-259d-9f723d63e2a8@grenoble-inp.org>
References: <1464369102-7551-1-git-send-email-tom.russello@grenoble-inp.org>
 <20160607140148.23242-1-tom.russello@grenoble-inp.org>
 <20160607140148.23242-2-tom.russello@grenoble-inp.org>
 <xmqqziqwmqth.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, erwan.mathoniere@grenoble-inp.org,
	jordan.de-gea@grenoble-inp.org, matthieu.moy@grenoble-inp.fr,
	e@80x24.org, aaron@schrab.com
To: Junio C Hamano <gitster@pobox.com>,
	Tom Russello <tom.russello@grenoble-inp.org>
X-From: git-owner@vger.kernel.org Wed Jun 08 10:23:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAYlx-0003Qn-AM
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 10:23:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422710AbcFHIX3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 04:23:29 -0400
Received: from zm-smtpout-2.grenet.fr ([130.190.244.98]:33532 "EHLO
	zm-smtpout-2.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161670AbcFHIX1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 04:23:27 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 92B9220BA;
	Wed,  8 Jun 2016 10:23:24 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KWHTbhqvcJRC; Wed,  8 Jun 2016 10:23:24 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 80D3120B4;
	Wed,  8 Jun 2016 10:23:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id 7A85F2066;
	Wed,  8 Jun 2016 10:23:24 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Df_V5OG-abbU; Wed,  8 Jun 2016 10:23:24 +0200 (CEST)
Received: from wificampus-030012.grenet.fr (wificampus-030012.grenet.fr [130.190.30.12])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 4B28F2064;
	Wed,  8 Jun 2016 10:23:22 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
In-Reply-To: <xmqqziqwmqth.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296771>

On 06/08/2016 03:07 AM, Junio C Hamano wrote:
> I am having a hard time guessing what prompted you to sort the
> output, i.e. what problem you were trying to solve.  It cannot be
> because addresses on a list (e.g. Cc:) could come out in an
> indeterministic order, because the address that a test expects to be
> the first (cc@example.com in the above example) may not appear as
> the first one, but in the textual output it _is_ shown differently
> from the remainder (i.e. even if you sort, from "Cc:
> cc@example.com," it is clear it was the first one output for Cc: and
> diferent from "A <author@example.com>".

Actually we had issues when trying to refactor send-email's email 
parsing loop [1]. Email addresses in output file `commandeline1` in 
tests weren't sorted the same way as the reference file it was compared 
to. E.g.:

   !nobody@example.com!
   !author@example.com!
   !one@example.com!
   !two@example.com!

I agree replacing test_cmp with test_cmp_noorder is pointless, I will 
fix it and re-roll.

Thanks.
