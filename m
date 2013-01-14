From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 01/14] imap-send.c: remove msg_data::flags, which was
 always zero
Date: Mon, 14 Jan 2013 10:10:02 +0100
Message-ID: <50F3CB6A.40203@alum.mit.edu>
References: <1358141566-26081-1-git-send-email-mhagger@alum.mit.edu> <1358141566-26081-2-git-send-email-mhagger@alum.mit.edu> <20130114055721.GD3125@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 10:10:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tug3r-0001JA-ET
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 10:10:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756079Ab3ANJKJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 04:10:09 -0500
Received: from ALUM-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.18]:50789 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755659Ab3ANJKH (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Jan 2013 04:10:07 -0500
X-AuditID: 12074412-b7f216d0000008e3-b8-50f3cb6d06b2
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 27.F8.02275.D6BC3F05; Mon, 14 Jan 2013 04:10:05 -0500 (EST)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r0E9A3Vi002138
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 14 Jan 2013 04:10:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <20130114055721.GD3125@elie.Belkin>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsUixO6iqJt7+nOAQfcDS4uuK91MFg29V5gt
	3t5cwmjxo6WH2YHFY+esu+wez3r3MHpcvKTs8XmTXABLFLdNUmJJWXBmep6+XQJ3xuQJfxkL
	OgUrWq97NTB28nYxcnJICJhIHJ/Qww5hi0lcuLeerYuRi0NI4DKjxPnHP5khnONMEhsXdDKC
	VPEKaEocfrOYGcRmEVCVOHDvDlicTUBXYlFPMxOILSoQILF4yTl2iHpBiZMzn7CA2CICGhLP
	P31jA7GZBeIlNk2eADZHWCBcYtGrtewQyxYySjTe+ATWwClgIDGz7Q8LRIOOxLu+B8wQtrzE
	9rdzmCcwCsxCsmMWkrJZSMoWMDKvYpRLzCnN1c1NzMwpTk3WLU5OzMtLLdI108vNLNFLTSnd
	xAgJaKEdjOtPyh1iFOBgVOLh3VjyOUCINbGsuDL3EKMkB5OSKG/GSaAQX1J+SmVGYnFGfFFp
	TmrxIUYJDmYlEd7QOqAcb0piZVVqUT5MSpqDRUmc9+didT8hgfTEktTs1NSC1CKYrAwHh5IE
	b+QpoEbBotT01Iq0zJwShDQTByfIcC4pkeLUvJTUosTSkox4UKzGFwOjFSTFA7S3BKSdt7gg
	MRcoCtF6ilGXY/vv9ueMQix5+XmpUuK8tSBFAiBFGaV5cCtg6esVozjQx8K8vSBVPMDUBzfp
	FdASJqAlm/aCLSlJREhJNTBu9Vr9RqPx2sO9XFNEje4FX/fXPqHZ5FnzK0EqofzxqrDsOaEf
	mZ0V1VKPt2lHtn6dt15O5tBZWy+XHccn3/66RzeT6+Gh0tNeYZ++HxObraEutL/g 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213475>

On 01/14/2013 06:57 AM, Jonathan Nieder wrote:
> Michael Haggerty wrote:
> 
>> This removes the need for function imap_make_flags(), so delete it,
>> too.
> [...]
>> --- a/imap-send.c
>> +++ b/imap-send.c
> [...]
>>  	box = gctx->name;
>>  	prefix = !strcmp(box, "INBOX") ? "" : ctx->prefix;
>>  	cb.create = 0;
>> -	ret = imap_exec_m(ctx, &cb, "APPEND \"%s%s\" %s", prefix, box, flagstr);
>> +	ret = imap_exec_m(ctx, &cb, "APPEND \"%s%s\"", prefix, box);
> 
> Before this change, the command is
> 
> 	"APPEND" SP mailbox SP "{" msglen "}" CRLF
> 
> .  After this change, it leaves out the space before the brace.  If I
> understand RFC3501 correctly, the space is required.  Intentional?

No, not intentional.  I simply didn't follow far enough how the string
was used and mistakenly thought it was an entire command.  Thanks for
finding and fixing this.

(It probably would be less error-prone if v_issue_imap_cmd() would be
responsible for adding the extra space in the second branch of the
following if statement:

    if (!cmd->cb.data)
            bufl = nfsnprintf(buf, sizeof(buf), "%d %s\r\n", cmd->tag,
cmd->cmd);
    else
            bufl = nfsnprintf(buf, sizeof(buf), "%d %s{%d%s}\r\n",
                              cmd->tag, cmd->cmd, cmd->cb.dlen,
                              CAP(LITERALPLUS) ? "+" : "");

but that's a design choice that was already in the original version and
I don't care enough to change it.)

> With the below squashed in,
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
> 
> diff --git i/imap-send.c w/imap-send.c
> index 451d5027..f1c8f5a5 100644
> --- i/imap-send.c
> +++ w/imap-send.c
> @@ -1296,7 +1296,7 @@ static int imap_store_msg(struct store *gctx, struct msg_data *msg)
>  	box = gctx->name;
>  	prefix = !strcmp(box, "INBOX") ? "" : ctx->prefix;
>  	cb.create = 0;
> -	ret = imap_exec_m(ctx, &cb, "APPEND \"%s%s\"", prefix, box);
> +	ret = imap_exec_m(ctx, &cb, "APPEND \"%s%s\" ", prefix, box);
>  	imap->caps = imap->rcaps;
>  	if (ret != DRV_OK)
>  		return ret;
> 

ACK.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
