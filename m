From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v6 1/7] refs.c: add err arguments to reflog functions
Date: Thu, 09 Jul 2015 08:47:51 +0200
Message-ID: <559E1917.6000205@alum.mit.edu>
References: <1435609076-8592-1-git-send-email-dturner@twopensource.com>	<1435609076-8592-2-git-send-email-dturner@twopensource.com>	<559AA490.3080605@alum.mit.edu>	<1436308882.5521.15.camel@twopensource.com>	<559D0281.6040908@alum.mit.edu> <xmqqr3oiy3pm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: David Turner <dturner@twopensource.com>, git@vger.kernel.org,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 09 08:48:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZD5cp-0000Fc-LC
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jul 2015 08:48:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbbGIGr7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2015 02:47:59 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:46378 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750955AbbGIGr5 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jul 2015 02:47:57 -0400
X-AuditID: 12074412-f79a76d000007c8b-5d-559e19194b34
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id ED.FA.31883.9191E955; Thu,  9 Jul 2015 02:47:54 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB11DA.dip0.t-ipconnect.de [93.219.17.218])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t696lpvE028157
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 9 Jul 2015 02:47:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <xmqqr3oiy3pm.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsUixO6iqCslOS/U4PoBZov5m04wWnRd6Way
	aOi9wmzR2/eJ1YHFY+esu+weFy8peyx4fp/d4/MmuQCWKG6bpMSSsuDM9Dx9uwTujB87vrIU
	vBSueLBcrIHxKX8XIyeHhICJRNvlCywQtpjEhXvr2boYuTiEBC4zSmxq/8gC4Zxjkvh56zEj
	SBWvgLbEo4tzwTpYBFQlJmzfyAxiswnoSizqaWbqYuTgEBUIknj9MheiXFDi5MwnYOUiAmoS
	E9sOgdnMAqUSTTM+sYGUCwt4Sqw5YAWxah6TxOODh1hBajgFrCX+X33GBlGvJ7Hj+i9WCFte
	onnrbOYJjAKzkKyYhaRsFpKyBYzMqxjlEnNKc3VzEzNzilOTdYuTE/PyUot0zfRyM0v0UlNK
	NzFCglloB+P6k3KHGAU4GJV4eDW2zw0VYk0sK67MPcQoycGkJMq76ydQiC8pP6UyI7E4I76o
	NCe1+BCjBAezkgivxkqgHG9KYmVValE+TEqag0VJnPfnYnU/IYH0xJLU7NTUgtQimKwMB4eS
	BK+2xLxQIcGi1PTUirTMnBKENBMHJ8hwLimR4tS8lNSixNKSjHhQnMYXAyMVJMUDtPetOFA7
	b3FBYi5QFKL1FKOilDjvF5CEAEgiozQPbiwsRb1iFAf6Upj3EUgVDzC9wXW/AhrMBDR4ue4s
	kMEliQgpqQbGyN0tFXtqVHRbVtfusDvv8WLSiYBDUkvurHjicvfr6T+PI2NOejued5PQ/NIq
	UumzIUF+g/u/q/HOIpeOe13csiHWMJ1bpj72j/2iGuGGq/rsH05J1XVls+0+M2n3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273728>

On 07/08/2015 07:11 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> I think your v7 of this patch goes too far, by turning a failure to
>> write to the reflog into a failure of the whole transaction. The problem
>> is that this failure comes too late, in the commit phase of the
>> transaction. Aborting at this late stage can leave some references
>> changed and others rolled back, violating the promise of atomicity.
> 
> Yeah, that sounds problematic.
> 
>> The old code reported a failure to write the reflog to stderr but didn't
>> fail the transaction. I think that behavior is more appropriate. The
>> reflog is of lower importance than the references themselves. Junio, do
>> you agree?
> 
> That is actually a loaded question.
> 
> Do I agree that the current (i.e. before this change) behaviour is
> more appropriate given the current choice of representation of refs
> and reflogs on the filesystem, treating a failure to update reflog
> as lower importance event and accept it as a limitation that it
> cannot abort the whole transaction atomically?  Compared to leaving
> the repository in a half-updated state where some refs and their
> logs are updated already, other remaining proposed updates are
> ignored, and the transaction claims to have failed even though some
> things have already changed and we cannot rollback, I would say that
> is a better compromise to treat reflog update as a lower importance.
> 
> Do I agree that reflog writing should stay to be best-effort in the
> longer term?  Not really.  If we are moving the ref API in the
> direction where we can plug a backend that is different from the
> traditional filesystem based one for storing refs, I think the
> backend should also be responsible for storing logs for the refs it
> stores, and if the backend wants to promise atomicity, then we
> should be able to fail the whole transaction when updates to refs
> could proceed but updates to the log of one of these updated refs
> cannot.  So I do not agree to cast in stone "the reflog is of lower
> importance" as a general rule.

Junio,

You make a good distinction. I was describing a compromise that we have
to make now due to the limitations of the current ref/reflog backend.
But I agree 100% that a future storage backend that can do correct
rollback of refs *and* reflogs can fail a transaction if the reflog
updates cannot be committed.

Thanks,
Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
