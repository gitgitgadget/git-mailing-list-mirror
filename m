From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v6 25/25] refs: break out ref conflict checks
Date: Thu, 05 Nov 2015 05:00:18 +0100
Message-ID: <563AD452.2030301@alum.mit.edu>
References: <cover.1446534991.git.mhagger@alum.mit.edu>	 <3060e6410e8798064ef84cd31645021d1b84fbb9.1446534991.git.mhagger@alum.mit.edu> <1446670884.4131.42.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Nov 05 05:00:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZuBis-0006vR-A0
	for gcvg-git-2@plane.gmane.org; Thu, 05 Nov 2015 05:00:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754063AbbKEEAW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2015 23:00:22 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:47612 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750746AbbKEEAV (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Nov 2015 23:00:21 -0500
X-AuditID: 12074413-f79bd6d000007ac2-51-563ad454e1f8
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 3C.3A.31426.454DA365; Wed,  4 Nov 2015 23:00:20 -0500 (EST)
Received: from [192.168.69.130] (p4FC96F81.dip0.t-ipconnect.de [79.201.111.129])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id tA540I7E023027
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 4 Nov 2015 23:00:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <1446670884.4131.42.camel@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsUixO6iqBtyxSrMYM1LPYv5m04wWnRd6Way
	aOi9wuzA7HHxkrLHguf32T0+b5ILYI7itklKLCkLzkzP07dL4M5Y03GRtWAqR0XDCsEGxm1s
	XYycHBICJhJtM89C2WISF+6tB7K5OIQELjNKHL34gh3COc8kMffLT0aQKl4BbYmXlx+xgtgs
	AqoSl3f1sIDYbAK6Eot6mplAbFGBIIkVy19A1QtKnJz5BKxGBKh39pEesF5mAWuJFa8Pg9UL
	CzhK/HrymBli2WZGiW1bzoOdxClgIfFwyhV2iAZ1iT/zLjFD2PISzVtnM09gFJiFZMcsJGWz
	kJQtYGRexSiXmFOaq5ubmJlTnJqsW5ycmJeXWqRrrpebWaKXmlK6iRESvMI7GHedlDvEKMDB
	qMTDa1BtFSbEmlhWXJl7iFGSg0lJlNfqHFCILyk/pTIjsTgjvqg0J7X4EKMEB7OSCG/BTKAc
	b0piZVVqUT5MSpqDRUmcV22Jup+QQHpiSWp2ampBahFMVoaDQ0mCt+MSUKNgUWp6akVaZk4J
	QpqJgxNkOJeUSHFqXkpqUWJpSUY8KFbji4HRCpLiAdp7BqSdt7ggMRcoCtF6ilFRSpz3O0hC
	ACSRUZoHNxaWkl4xigN9KczLeBmoigeYzuC6XwENZgIazNRqATK4JBEhJdXAmGAQrVj1nJ1t
	ngWLKPOsrdsybdI1RGocNntanHfdcv3doptLuv7vTw/PUGgN/8yjuKWo4EOA77qDLZuLok13
	RU2Tz06V6/22Yw6Ta3AK+2OeC7MSlv/mnm/98C/br5tnysQ7OHPVmv6HqGXmXLPd 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280897>

On 11/04/2015 10:01 PM, David Turner wrote:
> On Tue, 2015-11-03 at 08:40 +0100, Michael Haggerty wrote:
>> + * extras and skip must be sorted lists of reference names. Either one
>> + * can be NULL, signifying the empty list.
>> + */
> 
> My version had:
> 
> "skip can be NULL; extras cannot."
> 
> The first thing that function does is:
> string_list_find_insert_index(extras, dirname, 0)
> 
> And that crashes when extras is null.  So I think my version is correct
> here.

We're talking about the function find_descendant_ref(), which was added
in this patch, right? Because the first thing that function does is

+	if (!extras)
+		return NULL;

(This guard was in your version, too.) Also, the callsite doesn't
protect against extras==NULL. So either we're talking about two
different things here, or I disagree with you.

> Other than that, I've reviewed both the patches themselves and the
> overall diff and everything looks good to me.

Thanks!

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
