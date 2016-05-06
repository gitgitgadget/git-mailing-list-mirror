From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: /* compiler workaround */ - what was the issue?
Date: Fri, 6 May 2016 19:33:13 +0100
Organization: OPDS
Message-ID: <0727E275927743DF94CFEC8615D7E90B@PhilipOakley>
References: <AA5B2B1715BAF7438221293187A417A7BDE9D11D@desmdswms002.des.grplnk.net> <17E04501C9474282B87758C7998A1F5B@PhilipOakley> <xmqqtwic9o88.fsf@gitster.mtv.corp.google.com> <CACsJy8CBuU8H8r_f4KsnLkhLtfRv0nDo4hGS31LVn0e1Y_3OAQ@mail.gmail.com> <51C902B1F7464CF2B58EB0E495F86BB5@PhilipOakley> <572CDCFF.9050607@ramsayjones.plus.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Git List" <git@vger.kernel.org>
To: "Duy Nguyen" <pclouds@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Ramsay Jones" <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Fri May 06 20:33:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aykYw-0001Fh-SX
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 20:33:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758397AbcEFSdP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 14:33:15 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:32859 "EHLO
	smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755867AbcEFSdO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2016 14:33:14 -0400
Received: from PhilipOakley ([92.22.46.244])
	by smtp.talktalk.net with SMTP
	id ykYpafzU6UaZtykYpatdKG; Fri, 06 May 2016 19:33:12 +0100
X-Originating-IP: [92.22.46.244]
X-Spam: 0
X-OAuthority: v=2.2 cv=M4MPEG4s c=1 sm=1 tr=0 a=mT+4QNHrLP0fZcn6BgyYDQ==:117
 a=mT+4QNHrLP0fZcn6BgyYDQ==:17 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8
 a=pGLkceISAAAA:8 a=ybZZDoGAAAAA:8 a=xtxXYLxNAAAA:8 a=VwQbUJbxAAAA:8
 a=9cA-FBq-5ee3QkNXIcEA:9 a=x8gzFH9gYPwA:10 a=yJM6EZoI5SlJf8ks9Ge_:22
 a=6kGIvZw6iX1k4Y-7sg4_:22 a=0RhZnL1DYvcuLYC8JZ5M:22 a=xts0dhWdiJbonKbuqhAr:22
 a=AjGcO6oz07-iQ99wixmX:22
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfBuvf1P7b3/6Ha4ajfMiK5qylkIvNoeUdc8PRDK1lCMIJrQZKUzz5Y94FZ0sWgMX2Ah6E4wJ1S3tsM7AGWKnSKzBih+/2tBlyvlKNsFCSPA8qfn2DtJ1
 7shWTtLMWo2p1vqjQLTxq5D817ssReeobp76GA705K4+VAgQxfqGo6rJEvSeSRS/9ZkEAiTlW/S8r4+xO1MsMzcdK4H/lcRIJYla9jf2Rc3vqcAV2W7Ki535
 BpZNS2pJatqZUCY3OPpn8fAd3y4OWeMCkDttLz2NnRc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293845>

From: "Ramsay Jones" <ramsay@ramsayjones.plus.com>
> On 06/05/16 14:15, Philip Oakley wrote:
>> From: "Duy Nguyen" <pclouds@gmail.com>
>>> On Fri, May 6, 2016 at 4:41 AM, Junio C Hamano <gitster@pobox.com> 
>>> wrote:
>>>> "Philip Oakley" <philipoakley@iee.org> writes:
>>>>
>>>>>     int saved_namelen = saved_namelen; /* compiler workaround */
>>>>>
>>>>> Which then becomes an MSVC compile warning C4700: uninitialized local
>>>>> variable.
>>>>>
>>>>> I'm wondering what was the compiler workaround being referred to? i.e. 
>>>>> why
>>>>> does it need that tweak? There's no mention of the reason in the 
>>>>> commit
>>>>> message.
>>>>
>>>> That was a fairly well-known workaround for GCC that issues a false
>>>> warning that variable is used before initialized.  I thought we
>>>> stopped using it several years ago in new code after doing a bulk
>>>> sanitizing
>>>
>>> I guess that's 803a777 (cat-file: Fix an gcc -Wuninitialized warning -
>>> 2013-03-26) and more commits around that time. The split-index commit
>>> is in 2014. I must have missed the trend.
>>>
>>>> (I think the new recommended workaround was to initialise
>>>> such a variable to the nil value like '0' for integers).
>>>
>>> Yep. First Jeff removed the " = xxx" part from "xxx = xxx" then Ramsay
>>> added the " = NULL" back. So we probably just do "int saved_namelen =
>>> 0;" in this case.
>>> -- 
>> Thanks,
>>
>> I'll try and work up a patch - probably next week as I'm away for the 
>> weekend.
>
> Yeah, I don't remember why these were left over from the previous
> attempt to clean these up (maybe they conflicted with in-flight
> topics?), but I have had a patch hanging around ... :-D
>
> The patch below applies to master (I haven't checked for any more
> additions).

Looks good to me. Catches those I've seen.

Have a good weekend all.

>
> ATB,
> Ramsay Jones
>
> -- >8 --
> From: Ramsay Jones <ramsay@ramsayjones.plus.com>
> Subject: [PATCH] -Wuninitialized: remove a gcc specific workaround
>
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
> builtin/rev-list.c | 2 +-
> fast-import.c      | 4 ++--
> merge-recursive.c  | 2 +-
> read-cache.c       | 2 +-
> 4 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/rev-list.c b/builtin/rev-list.c
> index 275da0d..deae1f3 100644
> --- a/builtin/rev-list.c
> +++ b/builtin/rev-list.c
> @@ -377,7 +377,7 @@ int cmd_rev_list(int argc, const char **argv, const 
> char *prefix)
>  mark_edges_uninteresting(&revs, show_edge);
>
>  if (bisect_list) {
> - int reaches = reaches, all = all;
> + int reaches = 0, all = 0;
>
>  revs.commits = find_bisection(revs.commits, &reaches, &all,
>        bisect_find_all);
> diff --git a/fast-import.c b/fast-import.c
> index 9fc7093..ca66d80 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -2935,7 +2935,7 @@ static void cat_blob(struct object_entry *oe, 
> unsigned char sha1[20])
>
> static void parse_get_mark(const char *p)
> {
> - struct object_entry *oe = oe;
> + struct object_entry *oe = NULL;
>  char output[42];
>
>  /* get-mark SP <object> LF */
> @@ -2952,7 +2952,7 @@ static void parse_get_mark(const char *p)
>
> static void parse_cat_blob(const char *p)
> {
> - struct object_entry *oe = oe;
> + struct object_entry *oe = NULL;
>  unsigned char sha1[20];
>
>  /* cat-blob SP <object> LF */
> diff --git a/merge-recursive.c b/merge-recursive.c
> index 06d31ed..9cecc24 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -1897,7 +1897,7 @@ int merge_recursive(struct merge_options *o,
> {
>  struct commit_list *iter;
>  struct commit *merged_common_ancestors;
> - struct tree *mrtree = mrtree;
> + struct tree *mrtree = NULL;
>  int clean;
>
>  if (show(o, 4)) {
> diff --git a/read-cache.c b/read-cache.c
> index d9fb78b..978d6b6 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1870,7 +1870,7 @@ static int ce_write_entry(git_SHA_CTX *c, int fd, 
> struct cache_entry *ce,
> {
>  int size;
>  struct ondisk_cache_entry *ondisk;
> - int saved_namelen = saved_namelen; /* compiler workaround */
> + int saved_namelen = 0;
>  char *name;
>  int result;
>
> -- 
> 2.8.0
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
