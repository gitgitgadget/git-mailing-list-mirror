From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v3 02/24] read-cache: use fixed width integer types
Date: Wed, 21 Aug 2013 05:05:07 +0200
Message-ID: <87r4dn4ucc.fsf@gmail.com>
References: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com> <1376854933-31241-3-git-send-email-t.gummerer@gmail.com> <xmqqr4do5fd8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, trast@inf.ethz.ch, mhagger@alum.mit.edu,
	pclouds@gmail.com, robin.rosenberg@dewire.com,
	sunshine@sunshineco.com, ramsay@ramsay1.demon.co.uk
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 21 05:05:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VByja-0007hx-Te
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 05:05:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752108Ab3HUDFT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Aug 2013 23:05:19 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:57920 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752045Ab3HUDFR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Aug 2013 23:05:17 -0400
Received: by mail-pa0-f41.google.com with SMTP id bj1so260027pad.0
        for <git@vger.kernel.org>; Tue, 20 Aug 2013 20:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type;
        bh=B2+ER7kMvW3ixu7p4JfwfhOfdffmyr5eKKNvQWiOYn8=;
        b=e8sYbPxL4smUPsDb3InNtBXVbRpyMveJrg0QW2t3/fO6T4aY8+yuNERqF99TmUPgXw
         5xcPMWRhRuh8C29exhscILnSu5QGMDQZOrlsXa9BVVXFltPIfEN/bvF/MbW4RGLN5jgR
         zu8L4ZIm2jnCOqgLeM1njEz86MjVccc2RSGuo7jrH5exEmj+YvbWeHg7V2AnJI7iSUQg
         E3ffWzlvJqUwJo+Zbe4gfLTPSoIOF9RqRvqKdhmyll/pgEjJz5n3plFkyFuiLUpNss6p
         htA7tK8aO3f2UWVpZ5zy1pDcVGvA1T1b1vZpTAo8viwq55ebHNAFMHyNKEUELZtShPqs
         Es2w==
X-Received: by 10.67.23.164 with SMTP id ib4mr7276163pad.42.1377054317133;
        Tue, 20 Aug 2013 20:05:17 -0700 (PDT)
Received: from localhost ([2001:470:6d:596:7e6d:62ff:fe8c:90ce])
        by mx.google.com with ESMTPSA id xs1sm7001775pac.7.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 20 Aug 2013 20:05:16 -0700 (PDT)
In-Reply-To: <xmqqr4do5fd8.fsf@gitster.dls.corp.google.com>
User-Agent: Notmuch/0.15.2+119~gf0dfda5 (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232681>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Gummerer <t.gummerer@gmail.com> writes:
>
>> Use the fixed width integer types uint16_t and uint32_t for ondisk
>> structures, because unsigned short and unsigned int do not hae a
>> guaranteed size.
>
> This sounds like an independent fix to me.  I'd queue this early
> independent from the rest of the series.
>
> Thanks.

Sounds good to me.  Thanks.

>>
>> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
>> ---
>>  cache.h      | 10 +++++-----
>>  read-cache.c | 30 +++++++++++++++---------------
>>  2 files changed, 20 insertions(+), 20 deletions(-)
>>
>> diff --git a/cache.h b/cache.h
>> index bd6fb9f..9ef778a 100644
>> --- a/cache.h
>> +++ b/cache.h
>> @@ -101,9 +101,9 @@ unsigned long git_deflate_bound(git_zstream *, unsigned long);
>>  
>>  #define CACHE_SIGNATURE 0x44495243	/* "DIRC" */
>>  struct cache_header {
>> -	unsigned int hdr_signature;
>> -	unsigned int hdr_version;
>> -	unsigned int hdr_entries;
>> +	uint32_t hdr_signature;
>> +	uint32_t hdr_version;
>> +	uint32_t hdr_entries;
>>  };
>>  
>>  #define INDEX_FORMAT_LB 2
>> @@ -115,8 +115,8 @@ struct cache_header {
>>   * check it for equality in the 32 bits we save.
>>   */
>>  struct cache_time {
>> -	unsigned int sec;
>> -	unsigned int nsec;
>> +	uint32_t sec;
>> +	uint32_t nsec;
>>  };
>>  
>>  struct stat_data {
>> diff --git a/read-cache.c b/read-cache.c
>> index ceaf207..0df5b31 100644
>> --- a/read-cache.c
>> +++ b/read-cache.c
>> @@ -1230,14 +1230,14 @@ static struct cache_entry *refresh_cache_entry(struct cache_entry *ce, int reall
>>  struct ondisk_cache_entry {
>>  	struct cache_time ctime;
>>  	struct cache_time mtime;
>> -	unsigned int dev;
>> -	unsigned int ino;
>> -	unsigned int mode;
>> -	unsigned int uid;
>> -	unsigned int gid;
>> -	unsigned int size;
>> +	uint32_t dev;
>> +	uint32_t ino;
>> +	uint32_t mode;
>> +	uint32_t uid;
>> +	uint32_t gid;
>> +	uint32_t size;
>>  	unsigned char sha1[20];
>> -	unsigned short flags;
>> +	uint16_t flags;
>>  	char name[FLEX_ARRAY]; /* more */
>>  };
>>  
>> @@ -1249,15 +1249,15 @@ struct ondisk_cache_entry {
>>  struct ondisk_cache_entry_extended {
>>  	struct cache_time ctime;
>>  	struct cache_time mtime;
>> -	unsigned int dev;
>> -	unsigned int ino;
>> -	unsigned int mode;
>> -	unsigned int uid;
>> -	unsigned int gid;
>> -	unsigned int size;
>> +	uint32_t dev;
>> +	uint32_t ino;
>> +	uint32_t mode;
>> +	uint32_t uid;
>> +	uint32_t gid;
>> +	uint32_t size;
>>  	unsigned char sha1[20];
>> -	unsigned short flags;
>> -	unsigned short flags2;
>> +	uint16_t flags;
>> +	uint16_t flags2;
>>  	char name[FLEX_ARRAY]; /* more */
>>  };
