From: karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v10 4/4] t1006: add tests for git cat-file --allow-unknown-type
Date: Tue, 05 May 2015 07:53:00 +0530
Message-ID: <55482984.1000600@gmail.com>
References: <55463094.9040204@gmail.com>	<1430663402-26717-1-git-send-email-karthik.188@gmail.com>	<1430663402-26717-4-git-send-email-karthik.188@gmail.com> <CAPig+cTOVFem74yr4HPqDRU3-4s_B58jQsx14ntp5FsB0WR6SA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue May 05 04:23:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpSWD-0007Zi-P1
	for gcvg-git-2@plane.gmane.org; Tue, 05 May 2015 04:23:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965242AbbEECXR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2015 22:23:17 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:35126 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965223AbbEECXG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2015 22:23:06 -0400
Received: by pdbqd1 with SMTP id qd1so180096666pdb.2
        for <git@vger.kernel.org>; Mon, 04 May 2015 19:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=PVUlq+DIUVNIoXOUKwSNTSO0wD46AhUFZ2YL/Uv7UlU=;
        b=pZ5UOTyq2aVUunPulsV2Cm6/2wkWHhhxV9sQqfSISJtE4gVQgoVr3n07B8KfOuC63y
         y5dpBhGterqtq/sLrFdl1JTBvosdT76TOeEhTjkI/G1z69VU4iBeONDvDfNRHB3aSTpu
         M2XyOiCK7q8mvfMWCa3xUNnkbT7E0PAk8PKw8qTSEXNfQDxsZtYLdTmte6WQHVnUUIXf
         a48YuRDDhyLOsxDMYunjGrInYJtZD/HNrQR5HIld4W2mbOQaDTCfbYrlxkMkndiSqrzj
         pBUJsAqgjcQs95EBTymXE+LudAZWpo9FEhLPA+ocA3V+94laOgnLqQUuuyzT0OOx3jOa
         LsDg==
X-Received: by 10.70.55.165 with SMTP id t5mr46937536pdp.102.1430792584150;
        Mon, 04 May 2015 19:23:04 -0700 (PDT)
Received: from [172.16.0.91] ([182.48.234.2])
        by mx.google.com with ESMTPSA id v6sm14129600pdj.26.2015.05.04.19.23.02
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 May 2015 19:23:03 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <CAPig+cTOVFem74yr4HPqDRU3-4s_B58jQsx14ntp5FsB0WR6SA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268380>



On 05/05/2015 07:03 AM, Eric Sunshine wrote:
> On Sun, May 3, 2015 at 10:30 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>>   t/t1006-cat-file.sh | 45 +++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 45 insertions(+)
>>
>> diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
>> index ab36b1e..de8eaf1 100755
>> --- a/t/t1006-cat-file.sh
>> +++ b/t/t1006-cat-file.sh
>> @@ -47,6 +47,18 @@ $content"
>>          test_cmp expect actual
>>       '
>>
>> +    test_expect_success "Type of $type is correct using --allow-unknown-type" '
>> +       echo $type >expect &&
>> +    git cat-file -t --allow-unknown-type $sha1 >actual &&
>
> Indentation is still botched in this test and the next one (as
> mentioned previously [1]).
>
> [1]: http://article.gmane.org/gmane.comp.version-control.git/268005
It only seems to have affected the test file, I made sure the 
indentation was correct after your previous suggestion, I have to see 
why this is happening. Thanks
>
>> +       test_cmp expect actual
>> +    '
>> +
>> +    test_expect_success "Size of $type is correct using --allow-unknown-type" '
>> +       echo $size >expect &&
>> +    git cat-file -s --allow-unknown-type $sha1 >actual &&
>> +       test_cmp expect actual
>> +    '
>> +
>>       test -z "$content" ||
>>       test_expect_success "Content of $type is correct" '
>>          maybe_remove_timestamp "$content" $no_ts >expect &&
>> @@ -296,4 +308,37 @@ test_expect_success '%(deltabase) reports packed delta bases' '
>>          }
>>   '
>>
>> +bogus_type="bogus"
>> +bogus_content="bogus"
>> +bogus_size=$(strlen "$bogus_content")
>> +bogus_sha1=$(echo_without_newline "$bogus_content" | git hash-object -t $bogus_type --literally -w --stdin)
>> +
>> +test_expect_success "Type of broken object is correct" '
>> +       echo $bogus_type >expect &&
>> +       git cat-file -t --allow-unknown-type $bogus_sha1 >actual &&
>> +       test_cmp expect actual
>> +'
>> +
>> +test_expect_success "Size of broken object is correct" '
>> +       echo $bogus_size >expect &&
>> +       git cat-file -s --allow-unknown-type $bogus_sha1 >actual &&
>> +       test_cmp expect actual
>> +'
>> +bogus_type="abcdefghijklmnopqrstuvwxyz1234679"
>> +bogus_content="bogus"
>> +bogus_size=$(strlen "$bogus_content")
>> +bogus_sha1=$(echo_without_newline "$bogus_content" | git hash-object -t $bogus_type --literally -w --stdin)
>> +
>> +test_expect_success "Type of broken object is correct when type is large" '
>> +       echo $bogus_type >expect &&
>> +       git cat-file -t --allow-unknown-type $bogus_sha1 >actual &&
>> +       test_cmp expect actual
>> +'
>> +
>> +test_expect_success "Size of large broken object is correct when type is large" '
>> +       echo $bogus_size >expect &&
>> +       git cat-file -s --allow-unknown-type $bogus_sha1 >actual &&
>> +       test_cmp expect actual
>> +'
>> +
>>   test_done
>> --
>> 2.4.0.rc1.250.gfbd73bd
