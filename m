From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 19/29] refs: don't dereference on rename
Date: Fri, 29 Apr 2016 09:38:25 +0200
Message-ID: <57230F71.2020401@alum.mit.edu>
References: <cover.1461768689.git.mhagger@alum.mit.edu>
 <27f8b223e42dcf1cf3c010833e0aff7baa4559c2.1461768690.git.mhagger@alum.mit.edu>
 <xmqqy47y98zx.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Apr 29 09:38:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aw30a-00055g-Cx
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 09:38:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751954AbcD2Hig (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 03:38:36 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:46395 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750782AbcD2Hig (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2016 03:38:36 -0400
X-AuditID: 12074414-62bff700000008e6-6d-57230f756e28
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id CF.25.02278.57F03275; Fri, 29 Apr 2016 03:38:29 -0400 (EDT)
Received: from [192.168.69.130] (p548D6182.dip0.t-ipconnect.de [84.141.97.130])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u3T7cQpE012210
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 29 Apr 2016 03:38:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.7.0
In-Reply-To: <xmqqy47y98zx.fsf@gitster.mtv.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsUixO6iqFvKrxxuMOshu8X8TScYLbqudDNZ
	NPReYbbonvKW0eJHSw+zxcyr1g5sHjtn3WX3eNa7h9Hj4iVlj/1Lt7F5LHh+n93j8ya5ALYo
	bpukxJKy4Mz0PH27BO6M2V2TmAp2cle0fOpiamCcz9nFyMkhIWAiMbPpD0sXIxeHkMBWRomr
	M7YzQTjnmSQ2/pjMCFIlLGAjsafvCjuILSIQIdHwqoURomgno8SHabfB2pkFdjBK3HrYxQZS
	xSagK7Gop5kJxOYV0JY49Ok9WJxFQFVi0eplYFNFBUIktq37xgpRIyhxcuYTFhCbU8Ba4tSb
	KWD1zAJ6Ejuu/2KFsOUltr+dwzyBkX8WkpZZSMpmISlbwMi8ilEuMac0Vzc3MTOnODVZtzg5
	MS8vtUjXQi83s0QvNaV0EyMkxEV2MB45KXeIUYCDUYmHd8Y9pXAh1sSy4srcQ4ySHExKorwh
	nMrhQnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR4X4DkeFMSK6tSi/JhUtIcLErivN8Wq/sJCaQn
	lqRmp6YWpBbBZGU4OJQkeNn4gBoFi1LTUyvSMnNKENJMHJwgw7mkRIpT81JSixJLSzLiQXEZ
	XwyMTJAUD9BeDZB23uKCxFygKETrKUZFKXFeBV6ghABIIqM0D24sLHG9YhQH+lKYVwuknQeY
	9OC6XwENZgIaLLBJEWRwSSJCSqqBUS/R/dHRWm0npjnPz+fdWeMeFOTu2m6Qw9B6WdrWzMu0
	Ydnsx2vnarvpNMV43tnJzSHOw670uDW39mvRnMr4+Guv/I7vu9ff1FZwYFaifTKL 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292976>

On 04/27/2016 08:55 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> @@ -2380,8 +2381,8 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
>>  		goto rollback;
>>  	}
>>  
>> -	if (!read_ref_full(newrefname, RESOLVE_REF_READING, sha1, NULL) &&
>> -	    delete_ref(newrefname, sha1, REF_NODEREF)) {
>> +	if (!read_ref_full(newrefname, resolve_flags, sha1, NULL) &&
>> +	    delete_ref(newrefname, NULL, REF_NODEREF)) {
> 
> Could you explain s/sha1/NULL/ here in the proposed log message?

Good question.

Passing sha1 to delete_ref() doesn't add any safety, because the same
sha1 was just read a moment before, and it is not used for anything
else. So the check only protects us from a concurrent update to
newrefname between the call to read_ref_full() and the call to
delete_ref(). But such a race is indistinguishable from the case that a
modification to newrefname happens just before the call to
read_ref_full(), which would have the same outcome as the new code. So
the "sha1" check only adds ways for the rename() to fail in situations
where nothing harmful would have happened anyway.

That being said, this is a very unlikely race, and I don't think it
matters much either way. In any case, the change s/sha1/NULL/ here seems
orthogonal to the rest of the patch.

David, you wrote the original version of this patch. Am I overlooking
something?

Michael
