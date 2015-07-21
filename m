From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v9 6/7] update-ref and tag: add --create-reflog arg
Date: Tue, 21 Jul 2015 13:02:36 -0700
Message-ID: <55AEA55C.2020501@alum.mit.edu>
References: <1437493504-3699-1-git-send-email-dturner@twopensource.com>	<1437493504-3699-7-git-send-email-dturner@twopensource.com> <xmqqio9dwjh6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Jul 21 22:03:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHdkl-0005ol-Mv
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jul 2015 22:03:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933247AbbGUUC7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2015 16:02:59 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:45714 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755574AbbGUUCt (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Jul 2015 16:02:49 -0400
X-AuditID: 1207440f-f79df6d000007c0f-69-55aea5609997
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 56.8D.31759.065AEA55; Tue, 21 Jul 2015 16:02:40 -0400 (EDT)
Received: from [172.20.208.234] ([66.251.117.141])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t6LK2bcK027802
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 21 Jul 2015 16:02:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <xmqqio9dwjh6.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsUixO6iqJuwdF2owYHz7BbzN51gtOi60s1k
	0dB7hdmB2ePiJWWPBc/vs3t83iQXwBzFbZOUWFIWnJmep2+XwJ1x4tAN5oI5bBUbJ21ha2D8
	z9LFyMkhIWAi8evyRihbTOLCvfVsXYxcHEIClxkl5q97ywThbGKSeDLjK5DDwcEroC1xrj0a
	pIFFQFXi6tnzzCA2m4CuxKKeZrASUYEgidcvc0HCvAKCEidnPgGbLyIQIdHwqoURpIRZQFyi
	/x9YWFjAXeLl9KnMUJsYJc7t28MGkuAUsJZ4vH4XO4jNLKAnseP6L1YIW15i+9s5zBMYBWYh
	WTELSdksJGULGJlXMcol5pTm6uYmZuYUpybrFicn5uWlFuma6OVmluilppRuYoQELv8Oxq71
	MocYBTgYlXh4L7StDRViTSwrrsw9xCjJwaQkyhu/cF2oEF9SfkplRmJxRnxRaU5q8SFGCQ5m
	JRHeE5FAOd6UxMqq1KJ8mJQ0B4uSOK/6EnU/IYH0xJLU7NTUgtQimKwMB4eSBO/PxUCNgkWp
	6akVaZk5JQhpJg5OkOFcUiLFqXkpqUWJpSUZ8aA4jS8GRipIigdor9sSkL3FBYm5QFGI1lOM
	uhwLftxeyyTEkpeflyolzisAUiQAUpRRmge3ApamXjGKA30szBsOUsUDTHFwk14BLWECWnJr
	1hqQJSWJCCmpBkatEsvcORJaf7fweDA3Wf6S91l248XqkthDh097TzhSsF6Ge8GOD1L7q0Lz
	mavjZlzouVhl61jkzyG9nfFX5SypGaeWSv3sdpRjOW7KkSH5cJ/L9/u3KooMVNrP 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274410>

On 07/21/2015 09:42 AM, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
> 
>> diff --git a/builtin/update-ref.c b/builtin/update-ref.c
>> index 6763cf1..d9646ef 100644
>> --- a/builtin/update-ref.c
>> +++ b/builtin/update-ref.c
>> @@ -14,6 +14,7 @@ static const char * const git_update_ref_usage[] = {
>>  
>>  static char line_termination = '\n';
>>  static int update_flags;
>> +int create_reflog_flag;
> 
> No need to reroll only for this, but I'll s/^int/static &/; while
> queuing.
> 
> I may have more comments later; this was found in the first pass.

In fact, this variable is used as the "flags" argument to
ref_transaction_create(), so it should be

    s/^int/static unsigned &/

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
