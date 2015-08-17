From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v11 11/13] tag.c: use 'ref-filter' APIs
Date: Tue, 18 Aug 2015 00:44:49 +0530
Message-ID: <CAOLa=ZRxKRsVv5ieJMzxvLUEZRNj-xX7R8-bgi+GaX3y2X9kPA@mail.gmail.com>
References: <1439661643-16094-12-git-send-email-Karthik.188@gmail.com> <xmqq1tf1eo4w.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 21:15:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRPsV-0007mI-Nw
	for gcvg-git-2@plane.gmane.org; Mon, 17 Aug 2015 21:15:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751621AbbHQTPW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2015 15:15:22 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:36393 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750923AbbHQTPV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2015 15:15:21 -0400
Received: by obnw1 with SMTP id w1so120679942obn.3
        for <git@vger.kernel.org>; Mon, 17 Aug 2015 12:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=NdA4pAYhXBn41gHa6ZrROKFErlriACU4tal1ZGKr85U=;
        b=cZXZoUUIGWYWBbdbUYmFRanrRnSpHe+2tVm+5x5QF0o7BPFwB6TI5gXPkWi99pz/Dn
         vNKDfzOtCJZ/ccGQWUSdD7vVDOJ3BBx3UcIkjt2ZDGsMahY63lgLU4oRCOtH18g7dnW8
         QS8R22fr4BC1CagK3r70HT2VjdLc7F0mWFTmpSlNHs5EvCQm9xf3G8DmNRF/z+1GWH3F
         1zglVvdTbj1C8EGgbnarou0MjIQoYWWjAK/AIG0Er5uSYDZ/OkhGVHD1l3Ud3VkKq8Pl
         YWdDHhGcOp4CgfBfUCozPQvTCZvn325sP63IEaDgCEbO4ysVeqCugTRX6obEizcY3ps9
         HO4g==
X-Received: by 10.182.60.130 with SMTP id h2mr2502182obr.42.1439838920776;
 Mon, 17 Aug 2015 12:15:20 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Mon, 17 Aug 2015 12:14:49 -0700 (PDT)
In-Reply-To: <xmqq1tf1eo4w.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276079>

On Tue, Aug 18, 2015 at 12:30 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> We improve the sorting option provided by 'tag.c' by using the sorting
>> options provided by 'ref-filter'. This causes the test 'invalid sort
>> parameter on command line' in t7004 to fail, as 'ref-filter' throws an
>> error for all sorting fields which are incorrect. The test is changed
>> to reflect the same.
>> ...
>> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
>> index d31788c..1f066aa 100755
>> --- a/t/t7004-tag.sh
>> +++ b/t/t7004-tag.sh
>> @@ -1462,13 +1462,7 @@ test_expect_success 'invalid sort parameter on command line' '
>>
>>  test_expect_success 'invalid sort parameter in configuratoin' '
>>       git config tag.sort "v:notvalid" &&
>> -     git tag -l "foo*" >actual &&
>> -     cat >expect <<-\EOF &&
>> -     foo1.10
>> -     foo1.3
>> -     foo1.6
>> -     EOF
>> -     test_cmp expect actual
>> +     test_must_fail git tag -l "foo*" >actual
>>  '
>
> You don't have to redirect the output to "actual", then.

Ah okay, will remove that. Thanks

-- 
Regards,
Karthik Nayak
