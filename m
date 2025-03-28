Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D6319259E
	for <git@vger.kernel.org>; Fri, 28 Mar 2025 14:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743170890; cv=none; b=l43wl3LDIVU6dFbORHok1mHIrHJ8/0DE5YJPBmB2bqRz9MplXcPJidwGsUoRRM5Hmf3L4ivaYWbDOybUFi2xsDAigwzNzU9VvpUI0MMxM4B+pL31feztvP7Z5FcpPX5uA69o6IoaXPU6o7g7CQ5Kv+Dstsy3FgmJB5mnXnjOjYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743170890; c=relaxed/simple;
	bh=cxxCBPgRc+3P25FiGBXmy7x+1PebRCQh3X8uTfoF1C4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kEjZ0sYVmTquXN+/TWaRt3FT3zohUmmT0R89qeq4ldhfSOvlEoJ8Ix78Z3kHwgxy0p8JU/nzyAeUN2nERwBH68Xsp+P8bbcOZE1lxd4ij3KsTCRZizOTS1YImeab5thBqpWd8YfEsgwbnwmaLbSu43RHC4zL9RInP1y4/qFl898=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jqCBTFzw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lkWX5M6m; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jqCBTFzw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lkWX5M6m"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4AFB82540105;
	Fri, 28 Mar 2025 10:08:07 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 28 Mar 2025 10:08:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1743170887;
	 x=1743257287; bh=VuuzCSHzIF8EWOH+9iuuP0GfRG1fD7y3oj+4eB97/B8=; b=
	jqCBTFzwusUAWzsMlJO7QJnlMCzmpY3vovoqMm++EgFU5xmKAmML0X1y+RqilXEr
	XcJn9abZgxjzStkz8DEhdcSJJTsBRVH/KvjhwtYo/HKQr9SUv1SQJkgf5UK1ZZxL
	frlTUX8bf02fcwq2XfUwTIPEYiHDU/qNMVS2vqrG0fmafyAz8uvFwPLWt7OMJ1cm
	WcOkIxk5QW5sew994SXcAWz3INrtnD3cgfWSqVjUKvIsaISoHKf1skOgy662ozka
	V5BfJQPQ5OvY2CvbSc/DD90B54UNIzho8AqkuCmWIv/PZgvgyEMuq4yWqxcBy235
	CIVZSeddGz+uohlSJhI+iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743170887; x=
	1743257287; bh=VuuzCSHzIF8EWOH+9iuuP0GfRG1fD7y3oj+4eB97/B8=; b=l
	kWX5M6mxSP2kEsvzGcTr3jh+ASYZduWqkENKFkR++K/W/nD3M+rZHw6NPqUwZWKz
	Jqqe8c7ANPbVCFNWoYztlElUbuY+EgZl2iZ40PWB7ICUdrWP9SMUOKBYbhD38fPI
	UYNNn9h6AjmLCMvf+0Jyahp557N9ARrm6kdBFMT0PIO0WDcXcCGaeA10omwnkGZU
	jvm+LUr336gFV6SYQae8PmwnXVHY+UtnQ/s/2vLWS/ik0qi0iEHuyU1Y3wY7dSsc
	jMg/kWvhAoFzz+Tr9geCDeJwrgH7142pkglnm6Wk+1elu1WxOf3GO/Eo22mQbMUa
	FdhgGaYCkFwUTAlK0XGKQ==
X-ME-Sender: <xms:Rq3mZ0eGVo4lsOaTqzRcinRVUksc8CoPMatZDUF--mTat01GfgVumg>
    <xme:Rq3mZ2MS5foghospeohHIUyr_5UVgbiB62trlLLX10ztHrP6QISkU-v63VXa4JpT-
    Z3I8cRpqLYgMVBmSA>
X-ME-Received: <xmr:Rq3mZ1gesmala6nAaY3T57mXUe6eehUSJouhNDtzmuDLI4a0m8pFQf84w2RojE3J654rwkCn1jK3cECGZfDxdxmwE3cl0IqGs1toX6jff-gTMKKjo2yd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujedugeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tddunecuhfhrohhmpefvohguugcukghulhhlihhnghgvrhcuoehtmhiisehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeejheduleegkeehtedvheeiheehheeigeeivedu
    veejiefhkeeukedujeetleektdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhfvg
    guohhrrghprhhojhgvtghtrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepthhmiiesphhosghogidrtghomhdpnhgspghrtghpthhtoh
    epgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhlrghusghithiisehphhih
    shhikhdrfhhuqdgsvghrlhhinhdruggvpdhrtghpthhtohepphhssehpkhhsrdhimhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggv
    rhhrihgtkhhsthholhgvvgesghhithhhuhgsrdgtohhm
X-ME-Proxy: <xmx:Rq3mZ59nHU--6w88a8PrZpKMRZXtOaRJM1eGUvj2oX1SvjYXAIbkeg>
    <xmx:Rq3mZwu9db-t7UDz92YsfopbmViNwJzeeWJclaMfsgAV5kVwoRZ0hA>
    <xmx:Rq3mZwH8A57-66VXoMzrt8ot1qnf8CYns_WIoc6-P_9B9MjMf4rubQ>
    <xmx:Rq3mZ_PDpH1h-LiR1FExsk9hh1bIzb_4AEBSjiW0xtSIFAFQvFniFQ>
    <xmx:R63mZyK-ARxW7ZGAt4UJJhv-HJvgV-2G4ZKCRPpnD_Jh2T0CUQjaPMWr>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Mar 2025 10:08:06 -0400 (EDT)
Date: Fri, 28 Mar 2025 10:08:04 -0400
From: Todd Zullinger <tmz@pobox.com>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Patrick Steinhardt <ps@pks.im>, git <git@vger.kernel.org>,
	Derrick Stolee <derrickstolee@github.com>
Subject: Re: Testsuite failure on s390x and sparc64 after 6840fe9ee2
Message-ID: <Z-atRMGXHilZRTEL@teonanacatl.net>
References: <89257ab82cd60d135cce02d51eacee7ec35c1c37.camel@physik.fu-berlin.de>
 <Z-R_Zmr6kxCPLm-O@teonanacatl.net>
 <Z-Zr7BZL1UGqVxKu@pks.im>
 <4276c8d0b72f11f325482756d3bc251327d0ac47.camel@physik.fu-berlin.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4276c8d0b72f11f325482756d3bc251327d0ac47.camel@physik.fu-berlin.de>

John Paul Adrian Glaubitz wrote:
> Hi Patrick,
> 
> On Fri, 2025-03-28 at 10:29 +0100, Patrick Steinhardt wrote:
>>> I reported this during the rc period.  I didn't hear back on
>>> it, but hopefully your message will arrive at a more
>>> convenient time. :)
>>> 
>>> https://lore.kernel.org/git/Z8HW6petWuMRWSXf@teonanacatl.net/
>> 
>> Copy-pasting the test logs from that mail:
>> 
>>     expecting success of 5620.4 'do partial clone 2, backfill min batch size':
>>             git clone --no-checkout --filter=blob:none      \
>>                     --single-branch --branch=main           \
>>                     "file://$(pwd)/srv.bare" backfill2 &&
>>             GIT_TRACE2_EVENT="$(pwd)/batch-trace" git \
>>                     -C backfill2 backfill --min-batch-size=20 &&
>>             # Batches were used
>>             test_trace2_data promisor fetch_count 20 <batch-trace >matches &&
>>             test_line_count = 2 matches &&
>>             test_trace2_data promisor fetch_count 8 <batch-trace &&
>>             # No more missing objects!
>>             git -C backfill2 rev-list --quiet --objects --missing=print HEAD >revs2 &&
>>             test_line_count = 0 revs2
>>     +++ pwd
>>     ++ git clone --no-checkout --filter=blob:none --single-branch --branch=main 'file:///tmp/git-t.sYdo/trash directory.t5620-backfill/srv.bare' backfill2
>>     Cloning into 'backfill2'...
>>     +++ pwd
>>     ++ GIT_TRACE2_EVENT='/tmp/git-t.sYdo/trash directory.t5620-backfill/batch-trace'
>>     ++ git -C backfill2 backfill --min-batch-size=20
>>     ++ test_trace2_data promisor fetch_count 20
>>     ++ grep -e '"category":"promisor","key":"fetch_count","value":"20"'
>>     error: last command exited with $?=1
>>     not ok 4 - do partial clone 2, backfill min batch size
>> 
>> It would be nice to learn what the file contains instead of the expected
>> string, which might give us a bit more of a hint what's wrong. You can
>> for example apply the following patch:
>> 
>> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
>> index 79377bc0fc2..197494cd28c 100644
>> --- a/t/test-lib-functions.sh
>> +++ b/t/test-lib-functions.sh
>> @@ -1975,7 +1975,7 @@ test_region () {
>>  #	GIT_TRACE2_EVENT="$(pwd)/trace.txt" git pack-objects ... &&
>>  #	test_trace2_data pack-objects reused N <trace2.txt
>>  test_trace2_data () {
>> -	grep -e '"category":"'"$1"'","key":"'"$2"'","value":"'"$3"'"'
>> +	test_grep -e '"category":"'"$1"'","key":"'"$2"'","value":"'"$3"'"'
>>  }
>>  
>>  # Given a GIT_TRACE2_EVENT log over stdin, writes to stdout a list of URLs
>> 
>> If you then re-run the test with `-ix` we should end up printing the
>> contents of that non-matching file.
> 
> Could you please post the complete command line? I have no clue where to pass "-ix".
> 
> I was previously running the tests with "make test".

You'd do something like:

    cd t && ./t5620-backfill.sh -ix

Though the patch to change grep to test_grep is incomplete,
I believe.  Using that, you get an error:

    error: bug in the test script: test_grep requires a file
    to read as the last parameter

I don't have a lot of time to poke at this today, but I'll
make another test run on an s390x build host without that
patch, but where I can save the output and post it
somewhere.

For the Fedora packaging, it will be something like this:

    make -C t all || {
        (cd t && ./t5620-backfill.sh -ix);
        ./print-failed-test-output;
    }

Where print-failed-test-output is a script¹ which snarfs up
the output files in t/test-results and the test directory,
since there is not direct shell access to the build host(s).

¹ https://src.fedoraproject.org/rpms/git/raw/0af3adf/f/print-failed-test-output

-- 
Todd
