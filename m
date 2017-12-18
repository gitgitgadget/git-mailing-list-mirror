Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DEF41F424
	for <e@80x24.org>; Mon, 18 Dec 2017 19:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935327AbdLRTS3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Dec 2017 14:18:29 -0500
Received: from mout.web.de ([212.227.15.3]:55835 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932756AbdLRTS2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Dec 2017 14:18:28 -0500
Received: from [192.168.178.36] ([91.20.60.211]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M2ZtN-1fJOAL3t8H-00sNqo; Mon, 18
 Dec 2017 20:18:20 +0100
Subject: Re: [PATCH] fmt-merge-msg: avoid leaking strbuf in shortlog()
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
References: <b2238da3-9eba-1521-f4ca-3b805f103555@web.de>
 <xmqq4lp2cisd.fsf@gitster.mtv.corp.google.com>
 <20171208101455.GC1899@sigill.intra.peff.net>
 <1654a696-73d5-c9ef-0fc2-bd82aaf2cabb@web.de>
 <xmqqd13p83sb.fsf@gitster.mtv.corp.google.com>
 <20171208212832.GC7355@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <f1584860-d0d6-db82-0a49-021924c3e2b7@web.de>
Date:   Mon, 18 Dec 2017 20:18:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20171208212832.GC7355@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:RN5mnbxAiVibKwj53faG9JHg21NpquugcQpUeZSOrWoTSiYOEev
 mANvSwf+tDqizRyi4zDBSyAJ/vIKdxnAtIj91AIJCajfQlMLowzeNicmeYXQFkpaqmNLfay
 dulSfLCS3E0bsLjEmPKkh4synU6vExPDVGcSoJc8TPk4yJrMR0rtcZCzaqfokoVqduLUiaO
 ggQYng9weWn3w7Uovj1Hw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LYoW/Yry/zw=:6rrUnKK2EGVgV2zzvIw5yF
 dpni9D/fcKXm7zJ8iI+5keSx1PxCnUITDCnKDlUAUgJYbq+vG6b/GE34ljPwz8oosGAfWFnzR
 Nlkiihbk+MlQvVZKLWA3YiYfczPWdOoSWMj1pbFhcNXF5tEFYbSVOi8gP7QvDX5ep3pe2NKEI
 tTxj626uS8Z/1z6+OMIoT41EQYseYhiUzslQZEmDekCTmZ6aSBOsLcsH+J+XEcKXEANyK6zOH
 Vo3sYr7QGUYa1NzNEy9mYvcU5CVHQoKRqe3OCK699T5O3p28fS6YE3bnz8aa44EdCzGy9v+wB
 EHYrVItUOtpWa+ddNTAKkNrMO4M44BdqP4GO9Xw+VktRBc0XV+ZIhArgqVRI5vrNyCf4hj1ec
 88DYfbQ4CLccKih1J577CAI1ASd4kmGJXUfEpkepFktyTjkzOYsAXHooA8cxJmoDiIMFObQFr
 WSNi1DP4zkHfg3gBBByeEjUO+R75S9hHnPrauf+FycLNIwmb1R2t7JUrpkp7hCfKwSWp0Ondc
 pVCgc2Lmb8bWhyQMvqokFwDLaRwQJJMdb6o2VoBVyG3cY/uApb2zgf2nDr2qVqQj60LIK6ZGw
 PTtg7HMvtupY2CTCDPCF9CxIdeGc/1XtejzlHmJfClml0gHzsTJcpN1p92bPLXSO7Heos2pHD
 v4h+OHjFiLKVKkmzjUz4fsQRhQ4AEux1ls3fiM/mLQtG8RVAVOu65kztuqPwMnvAmamqW+dnD
 PaExUmVEeuZ7xZTJ6FXOKCKtld9YWWnbhbSdDFp4lhCSD6kYB2N5Catp9bfvOOPWQbgZ8S7Us
 CNEG47kKHlq5039W1mveFay326Q4b8gkvyRKFa52AvzY9FEH5c=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 08.12.2017 um 22:28 schrieb Jeff King:
> On Fri, Dec 08, 2017 at 10:37:08AM -0800, Junio C Hamano wrote:
> 
>>> The two modes (dup/nodup) make string_list code tricky.  Not sure
>>> how far we'd get with something simpler (e.g. an array of char pointers),
>>> but having the caller do all string allocations would make the code
>>> easier to analyze.
>>
>> Yes.
>>
>> It probably would have been more sensible if the API did not have
>> two modes (instead, have the caller pass whatever string to be
>> stored, *and* make the caller responsible for freeing them *if* it
>> passed an allocated string).
> 
> I'd actually argue the other way: the simplest interface is one where
> the string list owns all of its pointers. That keeps the
> ownership/lifetime issues clear, and it's one less step for the caller
> to have to remember to do at the end (they do have to clear() the list,
> but they must do that anyway to free the array of items).
> 
> It does mean that some callers may have to remember to free a temporary
> buffer right after adding its contents to the list. But that's a lesser
> evil, I think, since the memory ownership issues are all clearly
> resolved at the time of add.
> 
> The big cost is just extra copies/allocations.

An interface requiring callers to allocate can be used to implement a
wrapper that does all allocations for them -- the other way around is
harder.  It can be used to avoid object duplication, but duplicates
functions.  No idea if that's worth it.
 
>> For the push_refs_with_push() patch you sent, another possible fix
>> would be to make cas_options a nodup kind so that the result of
>> strbuf_detach() does not get an extra strdup to be lost when placed
>> in cas_options.  With the current string-list API that would not
>> quite work, because freeing done in _release() is tied to the
>> "dup/nodup" ness of the string list.  I think there even is a
>> codepath that initializes a string_list as nodup kind, stuffs string
>> in it giving the ownership, and then flips it into dup kind just
>> before calling _release() only to have it free the strings, or
>> something silly/ugly like that.
> 
> Yes, the first grep hit for NODUP is bisect_clean_state(), which does
> this. I think it would be more clear if we could do:
> 
> diff --git a/bisect.c b/bisect.c
> index 0fca17c02b..7c59408a13 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -1060,8 +1060,7 @@ static int mark_for_removal(const char *refname, const struct object_id *oid,
>   			    int flag, void *cb_data)
>   {
>   	struct string_list *refs = cb_data;
> -	char *ref = xstrfmt("refs/bisect%s", refname);
> -	string_list_append(refs, ref);
> +	string_list_appendf(refs, "refs/bisect%s", refname);
>   	return 0;
>   }
>   
> @@ -1070,11 +1069,10 @@ int bisect_clean_state(void)
>   	int result = 0;
>   
>   	/* There may be some refs packed during bisection */
> -	struct string_list refs_for_removal = STRING_LIST_INIT_NODUP;
> +	struct string_list refs_for_removal = STRING_LIST_INIT_DUP;
>   	for_each_ref_in("refs/bisect", mark_for_removal, (void *) &refs_for_removal);
>   	string_list_append(&refs_for_removal, xstrdup("BISECT_HEAD"));

The xstrdup() here would have to go.

>   	result = delete_refs("bisect: remove", &refs_for_removal, REF_NO_DEREF);
> -	refs_for_removal.strdup_strings = 1;
>   	string_list_clear(&refs_for_removal, 0);
>   	unlink_or_warn(git_path_bisect_expected_rev());
>   	unlink_or_warn(git_path_bisect_ancestors_ok());
> 
> 
> Having a "format into a string" wrapper doesn't cover _every_ string you
> might want to add to a list, but my experience with argv_array_pushf
> leads me to believe that it covers quite a lot of cases.

It would fit in with the rest of the API -- we have string_list_append()
as a wrapper for string_list_append_nodup()+xstrdup() already.  We also
have similar functions for strbuf and argv_array.  I find it a bit sad
to reimplement xstrfmt() yet again instead of using it directly, though.

René
