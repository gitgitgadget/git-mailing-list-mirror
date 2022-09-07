Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE5CC6FA8A
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 14:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiIGOp4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 10:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiIGOpn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 10:45:43 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F025C945
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 07:45:42 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id h22so10556249qtu.2
        for <git@vger.kernel.org>; Wed, 07 Sep 2022 07:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=u3cK2vXy9HIxA+opK4poOm82ojwXKi4+Q2dhxcRvfnI=;
        b=ahAM0YLuoDG/QWWXheJw1esIqTJG0dg2jjK55rbT4/gX+GLXqVm0wShzKYOzNAIuYl
         hBVY/Ci1JV6fo12ZfXT3K/c9U6e3eTx6yTgSrh8vPa8BAWP3T91l7o8PviK5a86wYp8o
         /5p9WP9MMgCETHU8K/aKpcGnCKAiUVEYuK+xm/dDOBxR9E/czylWylvQ3lNy/R736ilm
         LfTwRewKHQ+yQ/yZKe0HJpFNWhWVsfk41vzin6SlHNnnPa9cgZ3ppZEfZXSRFDUV8/KX
         tmjQ26XQx6ucqenxRO4JjrpgCUmrHtyrSWec/7fJxU2cJuuv4ZrlKsotFYN0L/1IZwnr
         bojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=u3cK2vXy9HIxA+opK4poOm82ojwXKi4+Q2dhxcRvfnI=;
        b=aku2zQf4dVrr9Yb7bFU2ax/GTbwLhjbmcgaW4Dqz9Sg/Km2v5XNT8+2EUmwxcBQDzu
         EWgC+CC0AVeh9iYrpqUvnqeQmAA/WgHfGUDQOeQCpSuejpZgx+7DfUtBBysUdDShZz3W
         ys33AOrVhuydjoZoGJkOU7F2NiC4n3SEf5zbXc6BuXWk38lfCEwosl8PcAcVRthuyoZb
         9elCnpIrJGtq3Qm0r5rndKC2Mjxl/v+8u4vmuEewZSQ6cJ/9KHVoHi9zmJ/6E6sbefpS
         XZA7zLbPfF+69usIeQP+s4H1r/TLEPyhBe2gmZqAgBQ7ajbcJUd7R7yvxAOHXa38X+IB
         j1yQ==
X-Gm-Message-State: ACgBeo3XnPZdgB+tH+66C4lrnKZHVRBGst3wWzSIci26gHXL5omEw/m5
        H2OSM/JfjAONfnb8Lb6HL4VD
X-Google-Smtp-Source: AA6agR7rpzERjGbx0mVcqP0PTBZGvNKhF5aQdMicJ3zL4dqvNNgNkF127mEK6Yr9CWwHU2WnrIzAWA==
X-Received: by 2002:ac8:5c8b:0:b0:344:7135:1392 with SMTP id r11-20020ac85c8b000000b0034471351392mr3633301qta.352.1662561941373;
        Wed, 07 Sep 2022 07:45:41 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id c12-20020ac8518c000000b00342f4fc290esm12080728qtn.71.2022.09.07.07.45.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 07:45:41 -0700 (PDT)
Message-ID: <3f901613-72c6-b644-079a-f74e3024a8fe@github.com>
Date:   Wed, 7 Sep 2022 10:45:39 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 2/3] upload-pack: skip parse-object re-hashing of "want"
 objects
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
To:     Jeff King <peff@peff.net>,
        =?UTF-8?B?56iL5rSL?= <chengyang@xiaomi.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        =?UTF-8?B?5L2V5rWp?= <hehao@xiaomi.com>,
        =?UTF-8?B?WGluNyBNYSDpqazpkas=?= <maxin7@xiaomi.com>,
        =?UTF-8?B?55+z5aWJ5YW1?= <shifengbing@xiaomi.com>,
        =?UTF-8?B?5Yeh5Yab6L6J?= <fanjunhui@xiaomi.com>,
        =?UTF-8?B?546L5rGJ5Z+6?= <wanghanji@xiaomi.com>
References: <YxfQi4qg8uJHs7Gp@coredump.intra.peff.net>
 <YxfSRkEiiP4TyZTM@coredump.intra.peff.net>
 <6018c526-4641-8374-8802-cfda5be330c3@github.com>
In-Reply-To: <6018c526-4641-8374-8802-cfda5be330c3@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/7/2022 10:36 AM, Derrick Stolee wrote:
> On 9/6/2022 7:05 PM, Jeff King wrote:

>> There is one thing to note, though: the
>> change in get_reference() affects not just pack-objects, but rev-list,
>> git-log, etc. We could use a flag to limit to index-pack here, but we
>> may already skip hash checks in this instance. For commits, we'd skip
>> anything we load via the commit-graph. And while before this commit we
>> would check a blob fed directly to rev-list on the command-line, we'd
>> skip checking that same blob if we found it by traversing a tree.
> 
> It's worth also mentioning that since you isolated the change to
> get_reference(), it is only skipping the parse for the requested tips
> of the revision walk. As we follow commits and trees to other objects
> we do not use parse_object() but instead use the appropriate method
> (parse_commit(), parse_tree(), and do not even parse blobs).

After writing this, it was bothering me that 'rev-list --verify' should
be checking for corruption throughout the history, not just at the tips.

This is done via the condition in builtin/rev-list.c:finish_object():

static int finish_object(struct object *obj, const char *name, void *cb_data)
{
	struct rev_list_info *info = cb_data;
	if (oid_object_info_extended(the_repository, &obj->oid, NULL, 0) < 0) {
		finish_object__ma(obj);
		return 1;
	}
	if (info->revs->verify_objects && !obj->parsed && obj->type != OBJ_COMMIT)
		parse_object(the_repository, &obj->oid);
	return 0;
}

So this call is the one that is used most-often by the rev-list command,
but isn't necessary to update for the purpose of our desired speedup. This
is another place where we would want to use read_object_file(). (It may even
be the _only_ place, since finish_object() should be called even for the
tip objects.)

In case you think it is valuable to ensure we test both cases ("tip" and
"not tip") I modified your test to have a third commit and test two rev-list
calls:

# An actual bit corruption is more likely than swapped commits, but
# this provides an easy way to have commits which don't match their purported
# hashes, but which aren't so broken we can't read them at all.
test_expect_success 'rev-list --verify-objects notices swapped commits' '
	git init swapped-commits &&
	(
		cd swapped-commits &&
		test_commit one &&
		test_commit two &&
		test_commit three &&
		one_oid=$(git rev-parse HEAD) &&
		two_oid=$(git rev-parse HEAD^) &&
		one=.git/objects/$(test_oid_to_path $one_oid) &&
		two=.git/objects/$(test_oid_to_path $two_oid) &&
		mv $one tmp &&
		mv $two $one &&
		mv tmp $two &&
		test_must_fail git rev-list --verify-objects HEAD &&
		test_must_fail git rev-list --verify-objects HEAD^
	)
'

But this is likely overkill.

Thanks,
-Stolee
