From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] rerere forget: grok files containing NUL
Date: Tue, 02 Apr 2013 21:34:30 +0200
Message-ID: <515B32C6.4060005@kdbg.org>
References: <5159FDE4.2090409@kdbg.org> <7vhajpj294.fsf@alter.siamese.dyndns.org> <515B2B6D.4050801@kdbg.org> <7vmwtgd9lq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 02 21:35:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN6zF-0002aM-Q4
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 21:35:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762191Ab3DBTed (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 15:34:33 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:13178 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1762152Ab3DBTec (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 15:34:32 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id EA46CA7EB7;
	Tue,  2 Apr 2013 21:34:30 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 3D53219F312;
	Tue,  2 Apr 2013 21:34:30 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <7vmwtgd9lq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219861>

Am 02.04.2013 21:18, schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
>>> Does the three-way merge machinery replay recorded resolution for
>>> such a binary file correctly (after your fix, that is)?
>>
>> Yes, it does. It recognizes the binary-ness and picks 'our' side. Only
>> then comes rerere_mem_getline into play.
> 
> Surely getline() needs to be fixed not to loop forever regardless of
> the binary-ness, but I was more worried about our additions of lines
> that satisfy is_cmarker(), counting of them in the callchain from
> handle_file() to handle_path() to decide if a path has already been
> resolved by the user, and recording of an resolution based on the
> return value of that callchain, all of which relies on the merged
> contents being textual and marked with the conflict marker.

Of course, it would make sense to exclude binary files from rerere's
operation. But that's an independent issue, and it is not new.

-- Hannes
