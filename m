From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 8/8] wrap_in_html(): process message in bulk rather than
 line-by-line
Date: Sun, 02 Dec 2012 11:35:29 +0100
Message-ID: <50BB2EF1.5020003@alum.mit.edu>
References: <1353841721-16269-1-git-send-email-mhagger@alum.mit.edu> <1353841721-16269-9-git-send-email-mhagger@alum.mit.edu> <7v7gp4p00u.fsf@alter.siamese.dyndns.org> <50B8B73A.4060801@alum.mit.edu> <7vpq2slsb4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeremy White <jwhite@codeweavers.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 02 11:35:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tf6tv-00028s-Bl
	for gcvg-git-2@plane.gmane.org; Sun, 02 Dec 2012 11:35:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752758Ab2LBKfe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2012 05:35:34 -0500
Received: from ALUM-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.20]:48039 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752022Ab2LBKfd (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Dec 2012 05:35:33 -0500
X-AuditID: 12074414-b7f846d0000008b8-de-50bb2ef47092
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id AC.7E.02232.4FE2BB05; Sun,  2 Dec 2012 05:35:32 -0500 (EST)
Received: from [192.168.69.140] (p57A25023.dip.t-dialin.net [87.162.80.35])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id qB2AZTjV014128
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 2 Dec 2012 05:35:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <7vpq2slsb4.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEKsWRmVeSWpSXmKPExsUixO6iqPtFb3eAwZxrYhZdV7qZLBp6rzBb
	9C/vYrO4fHIuo8WPlh5mB1aPL1cbmTw+fIzzeNa7h9Hj4iVlj8+b5AJYo7htkhJLyoIz0/P0
	7RK4M74ffctasJ+t4nF/J1MDYxtrFyMnh4SAicT5FScYIWwxiQv31rN1MXJxCAlcZpS4tnw6
	E4Rzikmic9ZOdpAqXgFtialXNrGB2CwCqhIPlzxhAbHZBHQlFvU0M4HYogIBEouXnIOqF5Q4
	OROiRkRATWJi2yEWkKHMAnMZJX7/ncUMkhAWiJbo73/CCrHtI6PEswMfwRKcAmYSt/vegN3K
	LKAj8a7vATOELS+x/e0c5gmMArOQLJmFpGwWkrIFjMyrGOUSc0pzdXMTM3OKU5N1i5MT8/JS
	i3Qt9HIzS/RSU0o3MULCXGQH45GTcocYBTgYlXh4o+bsChBiTSwrrsw9xCjJwaQkyssAjBIh
	vqT8lMqMxOKM+KLSnNTiQ4wSHMxKIrwsJkDlvCmJlVWpRfkwKWkOFiVx3m+L1f2EBNITS1Kz
	U1MLUotgsjIcHEoSvCd1gYYKFqWmp1akZeaUIKSZODhBhnNJiRSn5qWkFiWWlmTEg+I1vhgY
	sSApHqC9z0DaeYsLEnOBohCtpxh1OTasb3/CKMSSl5+XKiXOuxCkSACkKKM0D24FLKm9YhQH
	+liYtwakigeYEOEmvQJawgS05IUQ2JKSRISUVANjili+2VXOE5kptVrydXfE7J2bPbTXz20v
	PnLh69m/Fv8DQ0zeGk7e/knpS+JsYVk/roi2mUvuLGdP1n3pc8XP0X5Bsym3lN6t 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211008>

On 12/02/2012 10:25 AM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> Nevertheless, the old code was even *more* broken because it added a
>> "</pre>" regardless of whether the separator line had been seen,...
> 
> OK. I'll rewrite the tail-end of the original log message to read:
> 
>     The old code would have created invalid output when there was no
>     body, emitting a closing </pre> without a blank line nor an opening
>     <pre> after the header.  The new code simply returns in this
>     situation without doing harm (even though either would not make much
>     sense in the context of imap-send that is meant to send out patches).
> 
> and squash this in.

ACK.  Thanks.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
