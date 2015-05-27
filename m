From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] p4: Retrieve the right revision of the UTF-16 file
Date: Wed, 27 May 2015 15:10:01 -0700
Message-ID: <CAPc5daW=BEPiGn6BGbN+JHczV-cPTW7WbZmr8vRRdpb1JL_aLQ@mail.gmail.com>
References: <1432765918-7352-1-git-send-email-miguel.torroja@gmail.com> <55663F72.6010800@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Miguel Torroja <miguel.torroja@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Thu May 28 00:10:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxjWu-00088R-5z
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 00:10:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752614AbbE0WKX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 18:10:23 -0400
Received: from mail-oi0-f44.google.com ([209.85.218.44]:35799 "EHLO
	mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793AbbE0WKW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 18:10:22 -0400
Received: by oihd6 with SMTP id d6so18702652oih.2
        for <git@vger.kernel.org>; Wed, 27 May 2015 15:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=ZbNu50GfamvYEEPZnhsh/UjWJBypD8mzjs15/Ziun4k=;
        b=TvDMPzq9KNDDFFnz9BUzrwPHvqaUf1rV1hIaiNTE60+DARxBPAMq7lAxL7SjKzZUix
         mRDnFjP93qPEzOY0WLb+q9wA+eWhG9tnYJuOG7GBwf/zE89PmtGWmLSmephf3ixmArhD
         P/UBd1bTIRx8BFZVIFsuMedw6TWMdmDJTLgKdFWz2GUjpZsoKOLF86PoyleQE6U1W5Mt
         vS3ANGh4XsN7VtMXG22n4nMzmlj4XCX4thELq9iO0tMdeeiTZWt+BwdEGT3BPV+0UBzw
         xkqgr2uMrBQCKBxi7saYJjTjej6RiP+KhWBV98buluAy+YH6h1yLq/zjT38K/657xnH6
         ijjw==
X-Received: by 10.60.42.161 with SMTP id p1mr28569081oel.7.1432764622209; Wed,
 27 May 2015 15:10:22 -0700 (PDT)
Received: by 10.202.202.131 with HTTP; Wed, 27 May 2015 15:10:01 -0700 (PDT)
In-Reply-To: <55663F72.6010800@diamand.org>
X-Google-Sender-Auth: 7R4TOugmLUoArlFaKh63ETKDiTc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270107>

On Wed, May 27, 2015 at 3:04 PM, Luke Diamand <luke@diamand.org> wrote:
> On 27/05/15 23:31, Miguel Torroja wrote:
>>
>> Fixing bug with UTF-16 files when they are retreived by git-p4.
>> It was always getting the tip version of the file and the history of the
>> file was lost.
>
> This looks sensible to me, and seems to work in some simple testing, thanks!
>
> Ack.
>
> Luke

Thanks; Miguel, please sign-off your patch; otherwise we cannot use it.

Thanks.

>> ---
>>   git-p4.py |    2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/git-p4.py b/git-p4.py
>> index cdfa2df..be2c7da 100755
>> --- a/git-p4.py
>> +++ b/git-p4.py
>> @@ -2098,7 +2098,7 @@ class P4Sync(Command, P4UserMap):
>>               # them back too.  This is not needed to the cygwin windows
>> version,
>>               # just the native "NT" type.
>>               #
>> -            text = p4_read_pipe(['print', '-q', '-o', '-',
>> file['depotFile']])
>> +            text = p4_read_pipe(['print', '-q', '-o', '-', "%s@%s" %
>> (file['depotFile'], file['change']) ])
>>               if p4_version_string().find("/NT") >= 0:
>>                   text = text.replace("\r\n", "\n")
>>               contents = [ text ]
>>
>
