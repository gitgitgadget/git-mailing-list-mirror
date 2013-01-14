From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 09/14] imap-send.c: remove namespace fields from struct
 imap
Date: Mon, 14 Jan 2013 10:31:49 +0100
Message-ID: <50F3D085.9080102@alum.mit.edu>
References: <1358141566-26081-1-git-send-email-mhagger@alum.mit.edu> <1358141566-26081-10-git-send-email-mhagger@alum.mit.edu> <20130114064347.GH3125@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 10:32:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TugOq-0003jY-Ph
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 10:32:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756136Ab3ANJbw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 04:31:52 -0500
Received: from ALUM-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.19]:61353 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756087Ab3ANJbw (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Jan 2013 04:31:52 -0500
X-AuditID: 12074413-b7f786d0000008bb-63-50f3d0871561
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 73.8D.02235.780D3F05; Mon, 14 Jan 2013 04:31:51 -0500 (EST)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r0E9Vn0w003007
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 14 Jan 2013 04:31:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <20130114064347.GH3125@elie.Belkin>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsUixO6iqNt+4XOAwadPghZdV7qZLBp6rzBb
	vL25hNHiR0sPswOLx85Zd9k9nvXuYfS4eEnZ4/MmuQCWKG6bpMSSsuDM9Dx9uwTujB1zTjIV
	/OKoaFlr3cD4j62LkYNDQsBEYuqp/C5GTiBTTOLCvfVsILaQwGVGie6TXF2MXED2cSaJLf9O
	gSV4BbQlrp6fDWazCKhKbJy9kRnEZhPQlVjU08wEYosKBEgsXnKOHaJeUOLkzCcsILaIgIbE
	80/fwHqZBeIlNk2eANYrLBAksbJtDSPEskWMEv9WTwNLcAoYSDyYtJAVokFH4l3fA2YIW15i
	+9s5zBMYBWYh2TELSdksJGULGJlXMcol5pTm6uYmZuYUpybrFicn5uWlFuma6+VmluilppRu
	YoQEs/AOxl0n5Q4xCnAwKvHwbiz5HCDEmlhWXJl7iFGSg0lJlLf4DFCILyk/pTIjsTgjvqg0
	J7X4EKMEB7OSCO+000A53pTEyqrUonyYlDQHi5I4r9oSdT8hgfTEktTs1NSC1CKYrAwHh5IE
	b9t5oEbBotT01Iq0zJwShDQTByfIcC4pkeLUvJTUosTSkox4UJzGFwMjFSTFA7R3MUg7b3FB
	Yi5QFKL1FKMux/bf7c8ZhVjy8vNSpcR5F4AUCYAUZZTmwa2Apa5XjOJAHwvzFoNU8QDTHtyk
	V0BLmICWbNoLtqQkESEl1cDoub+8eWa98bKi5MlVl+4selmrm3NewD7QYV+P3x2DJ5wC4p+i
	vt57rTn3ee+64xIMJx50ni17MGlr543cF+Ud12uvR8a0We1Mezc9vv29efeu1ybi 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213478>

On 01/14/2013 07:43 AM, Jonathan Nieder wrote:
> Michael Haggerty wrote:
> 
> [...]
>> @@ -722,9 +667,9 @@ static int get_cmd_result(struct imap_store *ctx, struct imap_cmd *tcmd)
>>  			}
>>  
>>  			if (!strcmp("NAMESPACE", arg)) {
>> -				imap->ns_personal = parse_list(&cmd);
>> -				imap->ns_other = parse_list(&cmd);
>> -				imap->ns_shared = parse_list(&cmd);
>> +				skip_list(&cmd);
>> +				skip_list(&cmd);
>> +				skip_list(&cmd);
> 
> This codepath would only be triggered if we emit a NAMESPACE command,
> right?  If I am understanding correctly, a comment could make this
> less mystifying:
> 
> 				/* rfc2342 NAMESPACE response. */
> 				skip_list(&cmd);	/* Personal mailboxes */
> 				skip_list(&cmd);	/* Others' mailboxes */
> 				skip_list(&cmd);	/* Shared mailboxes */

Yes, the comments are useful.

> Though that's probably academic since hopefully this if branch
> will die soon. :)

Not by my hand :-)  Maybe somebody more familiar with the IMAP protocol
wants to take the code culling further...

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
