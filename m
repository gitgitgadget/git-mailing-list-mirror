From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v9 6/7] update-ref and tag: add --create-reflog arg
Date: Tue, 21 Jul 2015 13:06:42 -0700
Message-ID: <55AEA652.7010600@alum.mit.edu>
References: <1437493504-3699-1-git-send-email-dturner@twopensource.com>	<1437493504-3699-7-git-send-email-dturner@twopensource.com> <xmqqio9dwjh6.fsf@gitster.dls.corp.google.com> <55AEA55C.2020501@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Jul 21 22:07:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHdof-0008Bn-Jm
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jul 2015 22:07:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755112AbbGUUHA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2015 16:07:00 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:56150 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752509AbbGUUG7 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Jul 2015 16:06:59 -0400
X-AuditID: 12074411-f797e6d000007df3-14-55aea656a5b7
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 06.66.32243.656AEA55; Tue, 21 Jul 2015 16:06:46 -0400 (EDT)
Received: from [172.20.208.234] ([66.251.117.141])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t6LK6gsX028042
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 21 Jul 2015 16:06:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <55AEA55C.2020501@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplleLIzCtJLcpLzFFi42IRYndR1A1bti7UYONaHYv5m04wWnRd6Way
	aOi9wuzA7HHxkrLHguf32T0+b5ILYI7itklKLCkLzkzP07dL4M741HaFpeAve8XRn08ZGxh3
	s3UxcnBICJhIHD3L3cXICWSKSVy4tx4ozMUhJHCZUeLPqlcsEM4mJoknq28wgzTwCmhLPJ8g
	C9LAIqAqcWB5JzOIzSagK7Gop5kJpERUIEji9ctckDCvgKDEyZlPWEBsEYEIiYZXLYwgJcwC
	4hL9/8DCwgLuEi+nT2WG2HSJUeLsk6tgYzgFdCR27ykHqWEW0JPYcf0XK4QtL7H97RzmCYwC
	s5BsmIWkbBaSsgWMzKsY5RJzSnN1cxMzc4pTk3WLkxPz8lKLdE31cjNL9FJTSjcxQoJWcAfj
	jJNyhxgFOBiVeHgvtK0NFWJNLCuuzD3EKMnBpCTKG79wXagQX1J+SmVGYnFGfFFpTmrxIUYJ
	DmYlEd4TkUA53pTEyqrUonyYlDQHi5I4L98SdT8hgfTEktTs1NSC1CKYrAwHh5IEL+NSoEbB
	otT01Iq0zJwShDQTByfIcC4pkeLUvJTUosTSkox4UIzGFwOjFCTFA7TXHKSdt7ggMRcoCtF6
	ilFRSpyXASQhAJLIKM2DGwtLRa8YxYG+FOZtBqniAaYxuO5XQIOZgAbfmrUGZHBJIkJKqoFR
	e9HVKUY9uY5CETGnPzQdvMF2sUp81hITOZfXoTJLL+14JvT356WDSaKtmaa/w87v9ouYK3bV
	LL4qSZTx7ev08zMkbO0LP234zS/0wo9Zcs/ioj9x2THLyjIq0vdsvXfI/VRIo/zp 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274412>

On 07/21/2015 01:02 PM, Michael Haggerty wrote:
> On 07/21/2015 09:42 AM, Junio C Hamano wrote:
>> David Turner <dturner@twopensource.com> writes:
>>
>>> diff --git a/builtin/update-ref.c b/builtin/update-ref.c
>>> index 6763cf1..d9646ef 100644
>>> --- a/builtin/update-ref.c
>>> +++ b/builtin/update-ref.c
>>> @@ -14,6 +14,7 @@ static const char * const git_update_ref_usage[] = {
>>>  
>>>  static char line_termination = '\n';
>>>  static int update_flags;
>>> +int create_reflog_flag;
>>
>> No need to reroll only for this, but I'll s/^int/static &/; while
>> queuing.
>>
>> I may have more comments later; this was found in the first pass.
> 
> In fact, this variable is used as the "flags" argument to
> ref_transaction_create(), so it should be
> 
>     s/^int/static unsigned &/

Actually, the same comment applies to "static int update_flags", which I
know was already wrong. Obviously neither of these are terribly critical.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
