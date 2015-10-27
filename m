From: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH] use pop_commit() for consuming the first entry of a
 struct commit_list
Date: Tue, 27 Oct 2015 22:29:50 +0100
Message-ID: <562FECCE.8050207@web.de>
References: <562BB00B.1000704@web.de>
 <xmqqfv0xfh6q.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 27 22:30:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrBoo-0007nQ-Ik
	for gcvg-git-2@plane.gmane.org; Tue, 27 Oct 2015 22:30:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752505AbbJ0VaE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Oct 2015 17:30:04 -0400
Received: from mout.web.de ([212.227.15.4]:63168 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751824AbbJ0VaB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 17:30:01 -0400
Received: from [192.168.178.36] ([79.253.133.32]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0LzmLr-1acXZv1EW3-014xgU; Tue, 27 Oct 2015 22:29:56
 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <xmqqfv0xfh6q.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:PwEweqHF/D/Qiw/z0bCgso+BdorZItRe4M4CDSxlCaPRwZ0Z6yJ
 UVx6Mggh6N0v45pO+z/IQHXkvNlO+fVz1IDllUDPcLsRVNjIbaxpFQGJ+u9/3SiUXguLHHC
 xs5xyfF/bN5uH068uVLiqMUQ1CD4NvKh2GBY+MjNYz2J2ByscFVxJN+3pF87cMoVIkA8Q9X
 CZL89AqMRT2f01YQqCmUA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wO4zPI4YI7Q=:fHlviMXpWZr4Wal3I922sQ
 EsYzw6SCm56IJ2RROJZzuPDaf96ZYwWO8NSEQVB2JvMIqBRugOQEAhklNcq+6zy0JLE7TmMIM
 V4GT0VwkS03PwOSiZARpOrrocxToIFF7gXwuP0Gqh652QlVniOTxTrjJUSVJAcbECiuQKxLPJ
 Q3cWlF4zVo2fpmPhPUmcE2lRqn7yoPEMLxJOMPE4f8pLB+7MjGmskpLZ004EPeipOIx2AXzlu
 XHTVhMtHTm72eAbtCe9oQXsMWO3dqYhKZmZH+CWubEpQM8JX1muZNKSZFA2Klgm8gCS8uJkrd
 nhufaBvohimSOKlVvFs7UNfs02we+ahEyoz5fhpyfKu8tU4PHwhgm6WV+XeGDkmSXUsdnCwf7
 2aOqFTtFK7QCz8kUx4icU5efNicc7zevvwQTouasQQXKJsyVlPI237rvuhno86cMKelPu1Lhx
 MW5oU0Kty7RfrW90sTmZbXyRFnyxCMqyebtt7ahbZ65nVNJ0NOXCbWkxzSPHy8wZHB9xV0X7c
 kO8cA++o2qKMb5V+pZJ0D0lVxIrmwIBW0NWj1NIO7LGQUfuSmYJf51sfSutIK8v9vuRGZWvdi
 G5bnKfxTphP0Ue4ifQJ6UsSjN+vn8Z+ffR5RHtLv9B6C4qQRE0XuJIbL4GkaVMxFgYvfWb8Ti
 6Aupm4tCs1E9kvCAPkk3ObmQSFviPz7RAgL5eZbi321ps5u+P9JSAE1XAaa/ULoHERLCCRXzY
 kgkatf3Wu+3z1klNDX/K1F/fAVjg0oVyfF00DnljdUXbM0fk+DXBGwzETecYuya7UchqNFRE 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280302>

Am 26.10.2015 um 22:33 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> Instead of open-coding the function pop_commit() just call it.  This
>> makes the intent clearer and reduces code size.
>>
>> Signed-off-by: Rene Scharfe <l.s.r@web.de>
>> ---
>>   builtin/fmt-merge-msg.c |  9 +++------
>>   builtin/merge.c         | 12 +++++-------
>>   builtin/reflog.c        |  6 +-----
>>   builtin/rev-parse.c     |  7 ++-----
>>   builtin/show-branch.c   | 17 +++--------------
>>   commit.c                | 27 +++++++--------------------
>>   remote.c                |  6 ++----
>>   revision.c              | 27 +++++----------------------
>>   shallow.c               |  6 +-----
>>   upload-pack.c           |  6 ++----
>>   10 files changed, 31 insertions(+), 92 deletions(-)
>
> While I appreciate this kind of simplification very much, I also
> hate to review this kind of simplification at the same time, as it
> is very easy to make and miss simple mistakes.

Yeah, it's tempting to doze off after a few similar cases.

> Let me try to go through it very carefully.
>
>> diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
>> index 4ba7f28..846004b 100644
>> --- a/builtin/fmt-merge-msg.c
>> +++ b/builtin/fmt-merge-msg.c
>> @@ -537,7 +537,7 @@ static void fmt_merge_msg_sigs(struct strbuf *ou=
t)
>>   static void find_merge_parents(struct merge_parents *result,
>>   			       struct strbuf *in, unsigned char *head)
>>   {
>> -	struct commit_list *parents, *next;
>> +	struct commit_list *parents;
>>   	struct commit *head_commit;
>>   	int pos =3D 0, i, j;
>>
>> @@ -576,13 +576,10 @@ static void find_merge_parents(struct merge_pa=
rents *result,
>>   	parents =3D reduce_heads(parents);
>>
>>   	while (parents) {
>> +		struct commit *cmit =3D pop_commit(&parents);
>>   		for (i =3D 0; i < result->nr; i++)
>> -			if (!hashcmp(result->item[i].commit,
>> -				     parents->item->object.sha1))
>> +			if (!hashcmp(result->item[i].commit, cmit->object.sha1))
>>   				result->item[i].used =3D 1;
>> -		next =3D parents->next;
>> -		free(parents);
>> -		parents =3D next;
>
> OK, I would have called it "commit" not "cmit", but this is
> trivially equivalent to the original.

This is just to keep the line shorter than 80 characters, and it's not=20
the first "cmit" in the tree..

>
>> diff --git a/builtin/merge.c b/builtin/merge.c
>> index a0a9328..31241b8 100644
>> --- a/builtin/merge.c
>> +++ b/builtin/merge.c
>> @@ -1019,7 +1019,7 @@ static struct commit_list *reduce_parents(stru=
ct commit *head_commit,
>>   					  int *head_subsumed,
>>   					  struct commit_list *remoteheads)
>>   {
>> -	struct commit_list *parents, *next, **remotes =3D &remoteheads;
>> +	struct commit_list *parents, **remotes;
>
> Interesting.  I viewed the result of applying this patch with "git
> show -U32" to make sure that this initialization of remotes was
> unnecessary.

With "git show -W" you don't need any magic number. ;)

Thanks for reviewing!

Ren=C3=A9
