Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CEEC00A5A
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 23:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjAQXPN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 18:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjAQXNp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 18:13:45 -0500
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF8623C7A
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 13:00:30 -0800 (PST)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1442977d77dso33365846fac.6
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 13:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yuQFSprubnvcNOBwRxgl7h/WweDmfNNJT/zeUsmZ78w=;
        b=NTFfjlI2Og6ohpmrqSfndoj7/j/jdy0zwx1YJPUvtWGaA/tsRJ86Ua481lTVxXF4/o
         MmnI4KVw61N65IVIrLhWbJI3k/yPrO/rDfiFgIS+r5MMS8VoLLbnSQeaACl8HyVry9R8
         tQ3MRiMlYKk50F+C7cTDBkFJX8o0h8ADVVIKSfSkSX1hyuFRrnw75XaCYjUzWP9az3T7
         9AT/s5ucug2F2HUdJ0Cw2XJ9To8uoeVTCb1G+Imhip26OcMJpjAp1s6pxC8sRcfPS7y2
         jiVVSdfAemv1BYTqjnS3TgV8dUoOz48xI/kD5zrczS4WP/zHkaxzgGtQlWzAjKcxDa5g
         4eSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yuQFSprubnvcNOBwRxgl7h/WweDmfNNJT/zeUsmZ78w=;
        b=yNxBuZZysCX/oIst44u2a/SFJb1xXkeSUJiC2L94iW/Sjqk/gWXqaYz2/KSTJ02PEg
         86qNzVVPooLDHplYapk03BS2wwYuveibmK90xNc9Rm31M4SVpSh5GMds+Q8eQHPvxirC
         e34XHotCZ3CTChvlgOEA6sMgfgmIoc1rUSTdwgFRELjFrY0ZltkLgteCzsTyYeWjkg7A
         cPM9chgGLFOo2ImOfl0QcuEml6skEx9B+gcZbh0AZkRgNu7sTsysDdpdAQm0MAQXQbFF
         sTtxqyvehZ1t+OdRJNncjazuddt2c46qOb0/TKQ97L3pU9xkCUoVPPNtRSTZ8SrJB3UZ
         s/qQ==
X-Gm-Message-State: AFqh2krR8+fHP1rXPwFwPJ4t8U1QQSf03safku3vccBQkptq6H2b4uiT
        BIy4O5++8nJwU5OGXC6H2wUQ
X-Google-Smtp-Source: AMrXdXvrEP6aKhS96o4UiQV+x/ZBS4pHi+ppqEL0PXcIuUIHQEcNprdU0Gbw35OpX726K7U7EMI32g==
X-Received: by 2002:a05:6870:b909:b0:152:f9d3:20a1 with SMTP id gx9-20020a056870b90900b00152f9d320a1mr2546134oab.52.1673989229511;
        Tue, 17 Jan 2023 13:00:29 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:b9ce:4130:c591:f90b? ([2600:1700:e72:80a0:b9ce:4130:c591:f90b])
        by smtp.gmail.com with ESMTPSA id t13-20020a056871020d00b0014435b51ef7sm17058479oad.30.2023.01.17.13.00.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 13:00:29 -0800 (PST)
Message-ID: <be447e59-26be-75b1-65b4-4e976a2e28d4@github.com>
Date:   Tue, 17 Jan 2023 16:00:27 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/8] t5558: add tests for creationToken heuristic
To:     Victoria Dye <vdye@github.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, avarab@gmail.com,
        steadmon@google.com, chooglen@google.com
References: <pull.1454.git.1673037405.gitgitgadget@gmail.com>
 <39eed9148782c37f5184c5fff7d0e4d1a7a2a1fe.1673037405.git.gitgitgadget@gmail.com>
 <4d13cea1-e9f6-381f-14ef-8a5a645e2a8f@github.com>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <4d13cea1-e9f6-381f-14ef-8a5a645e2a8f@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/17/2023 1:17 PM, Victoria Dye wrote:
> Derrick Stolee via GitGitGadget wrote:

>> +	for b in 1 2 3 4
>> +	do
>> +		test_bundle_downloaded bundle-$b.bundle trace-clone.txt ||
>> +			return 1
>> +	done
> 
> Because the current state of bundle list handling is equivalent to "no
> heuristic", this pre-existing test is just updated to verify all bundles are
> downloaded. This isn't new behavior, but it'll be relevant to compare with
> the behavior of the 'creationToken' heuristic. 
> 
> I was going to ask how the tests verify that *only* the expected bundles are
> downloaded, and it looks like later patches [1] handle that with
> '! test_bundle_downloaded' checks. That approach seems a bit fragile (if a
> bundle's name doesn't match the '! test_bundle_downloaded' check for some
> reason, the bundle can be either downloaded or not with no effect on the
> test result). Would something like a 'test_downloaded_bundle_count' work
> instead?

Or, perhaps we could check the exact list _and order_ using this slightly
more generic helper?

# Given a GIT_TRACE2_EVENT log over stdin, writes to stdout a list of URLs
# sent to git-remote-https child processes.
test_remote_https_urls() {
	grep -e '"event":"child_start".*"argv":\["git-remote-https",".*"\]' |
		sed -e 's/{"event":"child_start".*"argv":\["git-remote-https","//g' \
		    -e 's/"\]}//g'
}

With a test example looking a lot like this:

	cat >expect <<-EOF &&
	$HTTPD_URL/newest.bundle
	$HTTPD_URL/new.bundle
	$HTTPD_URL/everything.bundle
	EOF

	test_remote_https_urls <trace-clone.txt >actual &&
	test_cmp expect actual

Thanks for the inspiration.

>> +test_expect_success 'clone bundle list (http, creationToken)' '
>> +	cp clone-from/bundle-*.bundle "$HTTPD_DOCUMENT_ROOT_PATH/" &&
>> +	cat >"$HTTPD_DOCUMENT_ROOT_PATH/bundle-list" <<-EOF &&
>> +	[bundle]
>> +		version = 1
>> +		mode = all
>> +		heuristic = creationToken
>> +
>> +	[bundle "bundle-1"]
>> +		uri = bundle-1.bundle
>> +		creationToken = 1
>> +
>> +	[bundle "bundle-2"]
>> +		uri = bundle-2.bundle
>> +		creationToken = 2
>> +
>> +	[bundle "bundle-3"]
>> +		uri = bundle-3.bundle
>> +		creationToken = 3
>> +
>> +	[bundle "bundle-4"]
>> +		uri = bundle-4.bundle
>> +		creationToken = 4
>> +	EOF
>> +
>> +	git clone --bundle-uri="$HTTPD_URL/bundle-list" . clone-list-http-2 &&
>> +
>> +	git -C clone-from for-each-ref --format="%(objectname)" >oids &&
>> +	git -C clone-list-http-2 cat-file --batch-check <oids
> 
> This test looks like the one that was updated above, but adds the
> 'creationToken' heuristic key. However, the 'test_bundle_downloaded' check
> isn't included - if it were, it would need to verify that all bundles were
> downloaded, with the heuristic being ignored, all bundles will be downloaded
> (which isn't consistent with what the 'creationToken' heuristic will
> *eventually* do).
> 
> As a matter of personal preference (so no pressure to change if you
> disagree), I find this test in its current state a bit misleading; because
> it's a 'test_expect_success' and there's no "NEEDSWORK" or "TODO", I could
> easily assume that cloning from a bundle list with the 'creationToken'
> heuristic is working as-intended at this point (that is, there's no
> indication that it's not implemented). 

It's true that it's not implemented right now, and it is a bit misleading
because of that. At clone time, the only thing that will change with the
implementation is possibly the order of the files being downloaded (and
the order is not predictable before that implementation).

The restriction of _not_ downloading some files comes only for the 'git
fetch' implementation, so these test changes are only foundations for those
future tests.

The only benefit of having these tests right now is that we get some
demonstration that the existing implementation ignores unknown properties
in the bundle list.

> If you did want to change it, adding a 'NEEDSWORK' comment, changing to
> 'test_expect_failure' & including the appropriate 'test_bundle_downloaded'
> check, or moving this test to the patch where the heuristic is implemented
> would mitigate any confusion. That said, this "issue" is resolved by the
> end of the series anyway, so it's really a low priority fix.
I think if we wanted to go this route, we could do it with the "download
the bundles in this order" check, or possibly by adding the 'git fetch'
behavior into the test at this point. I'll consider these options for v2.

Thanks,
-Stolee
