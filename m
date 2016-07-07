Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 217842070D
	for <e@80x24.org>; Thu,  7 Jul 2016 17:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753288AbcGGRRu (ORCPT <rfc822;e@80x24.org>);
	Thu, 7 Jul 2016 13:17:50 -0400
Received: from mout.web.de ([212.227.15.4]:63470 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932177AbcGGRQs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2016 13:16:48 -0400
Received: from macce.local ([195.252.60.88]) by smtp.web.de (mrweb001) with
 ESMTPSA (Nemesis) id 0MFtKQ-1b6P4C2Wz0-00EvCb; Thu, 07 Jul 2016 19:16:14
 +0200
From:	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v3 3/3] correct ce_compare_data() in a middle of a merge
To:	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
References: <xmqq37nyb4kp.fsf@gitster.mtv.corp.google.com>
 <1467100876-2803-1-git-send-email-tboegi@web.de>
 <xmqqh9cc55wm.fsf@gitster.mtv.corp.google.com>
 <62eb3d75-126e-427b-8701-d490e80e3501@web.de>
 <xmqq8txlvwip.fsf@gitster.mtv.corp.google.com>
 <574692d1-c8ae-9c2f-6b99-a01545b15051@telia.com>
 <xmqqa8huvmpv.fsf@gitster.mtv.corp.google.com>
Cc:	git@vger.kernel.org
Message-ID: <c36fe487-b8dc-9767-7fae-bee513dac0b2@web.de>
Date:	Thu, 7 Jul 2016 19:16:09 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:45.0)
 Gecko/20100101 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <xmqqa8huvmpv.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:exOYcdAzGErlNk3veR2BiGPfHmgpmRgW2xE2VQu9CoZ80uib2Dw
 uOgB5HNlOZgxyxLe+CA3T6qArxNM1hcRuLeNg+BYnhaKt4Pi2SnvHp/ei1Cb/VfIMIireBw
 QetCer6DOrlkYLrrRH6jB0D17kHesVeenkYvbXsTpSPn6qhjyz57JZ63hS5v6pqWxK4357A
 0KWlayjn5KQkKq72KS/GA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:FJaaH5KTccM=:ZZBvBkilhKOMEMgMY/A4bj
 OroXSMM4R4OwDWYh+8ayRajB2yHRgvRbFDfwAFn+ovBzYzlnJ0Y197/ZCG3lMgc2bb0tpiDzE
 7EjUtAR3P60J+MGJKfpgbnSUUp8Ld6GCxTd2vxR0nuTxvYzkEpsiwnlXmGrE3fEA6UGgSWcxf
 Rf59Tmm/3nluoCGouYNwSN+Kgyo/NaBuYSwcuxHlGGzxx6h/B5O8DwaMtWEAmT4p+h99FCupP
 Udh3ABRTE2mG1/00sCwgLnXCk4Fj5S+E60hP58TRisrg2jqchEbZ7dQwHd0KzNuDaq23vZy6a
 aJUAxOLg1rYdOemt2hAKqcoht0ZNmrbMrvnDiOHFfY/SGZH6pqtcKJEFlX9HB4Q+4p5o1B3ie
 UVTBc60OHNCChXwRs8R64RMKDAQ7zzxig22eaaCJWOdi2D13UBV6Cm54fABuE92G3vkjSlTGs
 zIJaRnY6oEdPIxhnsTc29ZW4zi+DODXe5NVC60l7RIGu+zCx7DeofyBQXJIkzuTJb/Or+Ap1F
 agnF9fwTdGMS7uPadyqJDgkvx6KvOBSM78esRabzGjfyxKiNwH/lMxeJ+qEACiD3oIcuCv+sc
 iDdCWoTD7dqCdsvzSAheXpvRK1rxcvVJ52se0rYmbALXKPCEZHlj4b1G21tkl4O+sPo7+VXI1
 Du/FhVwQr6y7VUML9BHIsbVh+rudsHTGyG2azyRD8BhDTtKQamLig91OFosWqoZTRHJcFel9Q
 24fqT9suQ04scd802DOwNbT7vpSNCDVQONjv3/K0sTqIITNk/QCMnQ74YptgzjybcP232MPgf
 qmOqZNb
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 2016-07-06 16.57, Junio C Hamano wrote:
> Torsten Bögershausen <tboegi@web.de> writes:
> 
>> At some point inside the merge, Git calls read-cache.c/ce_compare_data(),
>>   to check if the path named "file" is clean.
>>   According to the tree information, the path "file" has the sha1 99b633.
>>   #Note:
>>   #sha1 99b633 is "first line\nsame line\n"
> 
> I thought your scenario was that our side had CRLF both in the blob
> and in the working tree.  So this is a different example?  Our side
> has LF in the blob that is checked out with CRLF in the working tree,
> and their side has CRLF in the blob?
> 
That was probably to confuse myself, and the rest of the world,
sorry for confusion.

This is the callstack:

merge-recursive.c/add_cacheinfo(unsigned int mode, const unsigned char *sha1,
		const char *path, int stage, int refresh, int options)
{
	struct cache_entry *ce;
	ce = make_cache_entry
	if (!ce)
		return error(_("addinfo_cache failed for path '%s'"), path);
	return add_cache_entry(ce, options);
}
#Calls
read-cache.c/make_cache_entry(path=file sha1=0x99b633 stage=0)


struct cache_entry *make_cache_entry(unsigned int mode,
		const unsigned char *sha1, const char *path, int stage,
		unsigned int refresh_options)
{
        [snip]
	ret = refresh_cache_entry(ce, refresh_options);
	if (ret != ce)
		free(ce);
	return ret;
}

#Calls
refresh_cache_ent(&the_index, ce, options, NULL, NULL);

#Calls
ie_modified()

#Calls
read-cache.c/ie_match_stat()

#Calls
changed |= ce_modified_check_fs(ce, st);

#Calls
ce_compare_data(path=file sha1=0x99b633)

#Calls
index_fd(..., ..., ce->name, ...)
#Note the sha is lost here, the parameter sha is the output.

Deep down, has_cr_in_index(path) will look at ad55e2 instead,
which is wrong.


>> ce_compare_data() starts the work:
>> OK, lets run index_fd(...,ce->name,...)
>> # index_fd will simulate a "git add"  and return the sha1 (via the sha1 pointer)
>> # after the hashing.
>>
>> # ce_compare_data() will later compare ce->sha1 with the result stored in
>> # the local sha1. That's why a sha1 is in the parameter list.
>> # To return the resulting hash:
>>
>> ce_compare_data() calls index_fd(sha1, ..., ce->name, ...)
>>
>> #Down in index_fd():
>>
>> sha1_file.c/index_fd() calls index_core() (after consulting the attributes)
>> index_core() reads the file from the working tree into memory using
>> read_in_full(), and after that index_mem() calls hash_sha1_file(buf)
>> to calculate the sha1.
>>
>> Before the hashing is done, index_mem() runs
>> convert_to_git(path, buf, size, &nbuf, SAFE_CRLF_FALSE)
>> to convert  "blobs to git internal format".
>>
>>
>> Here, convert_to_git() consults the .gitattributes (again) to find out that
>> crlf_action is CRLF_AUTO in our case.
>> The "new safer autocrlf handling" says that if a blob as any CR, don't convert
>> CRLFs at "git add".
>>
>> convert.c/crlf_to_git() starts to do it's job:
>> - look at buf (It has CRLF, conversion may be needed)
>> - consult blob_has_cr()
>>   # Note: Before this patch, has_cr_in_index(path)) was used
>>
>> #Again, before this patch,
>> has_cr_in_index(path) calls read_blob_data_from_cache(path, &sz) to read the
>> blob into memory.
>>
>> Now read_blob_data_from_cache() is a macro, and we end up in
>> read_blob_data_from_index(&the_index, (path), (sz))
>>
>> read-cache.c/read_blob_data_from_index() starts its work:
>> 	pos = index_name_pos(istate, path, len);
>> 	if (pos < 0) {
>> 		/*
>> 		 * We might be in the middle of a merge, in which
>> 		 * case we would read stage #2 (ours).
>> 		 */
>>
>> # And here, and this is important to notice, "ours" is sha1 ad55e2,
>> # which corresponds to "first line\r\nsame line\r\n"
> 
> Where did 99b633 come from then?  There still is something missing
> in this description.
> 
> Puzzled...
This is an unfinished attempt for a commit message:
--------------------------------------------------
correct ce_compare_data() at the end of a merge

The following didn't work as expected:

 - At the end of a merge
 - merge.renormalize is true,
 - .gitattributes = "* text=auto"
 - core.eol = crlf

Merge a blob with CRLF "first line\r\nsame line\r\n" and a blob
with LF "first line\nsame line\n".

The expected result of the merge is "first line\nsame line\n".

The content in the working tree is "first line\r\nsame line\r\n",
and ce_compare_data() should find that the content is clean and return 0.

The following callstack does not work:
merge-recursive.c/add_cacheinfo(path=file sha1=0x99b633)
#Calls
refresh_cache_ent(&the_index, ce, options, NULL, NULL);

#Calls
ie_modified()

#Calls
read-cache.c/ie_match_stat()

#Calls
changed |= ce_modified_check_fs(ce, st);

#Calls
ce_compare_data(path=file sha1=0x99b633)

#Calls
index_fd(..., ..., ce->name, ...)
#Note the sha is lost here.

#Calls
index_core()

index_core() reads the file from the working tree into memory using
read_in_full(), and after that index_mem() calls hash_sha1_file(buf)
to calculate the sha1.
Before the hashing is done, index_mem() runs
convert_to_git(path, buf, size, &nbuf, SAFE_CRLF_FALSE)
to convert  "blobs to git internal format".

Here, convert_to_git() consults the .gitattributes (again) to find out that
crlf_action is CRLF_AUTO in our case.
The "new safer autocrlf handling" says that if a blob as any CR, don't convert
CRLFs at "git add".

convert.c/crlf_to_git() starts to do it's job:
- look at buf (It has CRLF, conversion may be needed)
- consult blob_has_cr()
  # Note: Before this patch, has_cr_in_index(path)) was used

#Before this patch,
has_cr_in_index(path)
#Calls
read_blob_data_from_cache(path, &sz) to read the blob into memory.

Now read_blob_data_from_cache() is a macro, and we end up in
read_blob_data_from_index(&the_index, (path), (sz))

read-cache.c/read_blob_data_from_index() starts its work:
	pos = index_name_pos(istate, path, len);
	if (pos < 0) {
		/*
		 * We might be in the middle of a merge, in which
		 * case we would read stage #2 (ours).
		 */

# And here, and this is important to notice, "ours" is sha1 ad55e2,
# which corresponds to "first line\r\nsame line\r\n"

The result of the check is that the blob 99b633 doesn't seem
to match the working tree, and the whold merge is aborted:
  error: addinfo_cache failed for path 'file'

Solution:
Make sure that ce_compare_data() forwards the source sha1 into crlf_to_git().

Replace has_cr_in_index(path) with blob_has_cr(sha1), and forward
the source sha1 from ce_compare_data() into blob_has_cr(sha1).

While at it, rename has_cr_in_index() into blob_has_cr()
and replace 0 with SAFE_CRLF_FALSE.

Add a TC in t6038 to have a test coverage under Linux.









