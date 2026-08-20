Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD55B389114
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 19:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787252756; cv=none; b=RLn04swRU29rzNty02yVLrS2oQXuerbUGXyFprAC/dCyGzfgvuQP4O1EPQpHUdj/KRanSkPjaOVJB2SxG3SObFOsn2elu123JiYtyM87c1dPzYMxhyX3SJmezPbF7WkSG9DbBIQw63kLOVjxw2YsL7tYCVqZdZOx5wMykuqfzKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787252756; c=relaxed/simple;
	bh=vpkKkUc3IaaAOeSgMbm/mjltmBTlMJQNkYPa9nzyzlQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XRrhKX0NN11Utmp8TxWH5ZRIFf53vfpShil+lumjQLXqu2TK1u/+FuCraeToq35KHxrWaFzCa9OaLvEt53DnQMyFveSccIOX3TDjsE5FPFo5gJmhxtXDzHDvPtqNcWHwXIc/j50Vu6DP91FzMRbwtJoOJ3BW26eTOVGrgnz+VqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AqXESOi+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B5E6h9K5; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AqXESOi+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B5E6h9K5"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id DC2E6EC00D2;
	Thu, 20 Aug 2026 15:05:53 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 20 Aug 2026 15:05:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1787252753;
	 x=1787339153; bh=QpTfmMlswc8CMQWReGoCKGabdfEMcHmbBqq0AwwFuUM=; b=
	AqXESOi+SV5ckARtO9hUXsdG865X3VUPzoc6BXcOckarekjrJxCavO7nICrPBAi2
	z/awuG8D4ULJriBePTxjXyjHCD9YCoffMNhQCvUWeZvP19ouyMPVgmxAReTll20J
	CN/qPynoWPab4QaFXkyCWk8UNXniwNuHvxDMQ+ufH6//uNDrFuiAnup0attncz/V
	AjZHIHhLnhbvC7779WJgnTnTvlclOnHOF73pK8naPZSPe7X3koVbyQBxRAWhEpgz
	R8JP2C1v5jUL+JT0/PRO00s/H+nepFMLk1LV2TbuU8iM5ZaS166ZZoGno4fGr5No
	5h4OeDo1XbzxXrCUs1vIvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787252753; x=
	1787339153; bh=QpTfmMlswc8CMQWReGoCKGabdfEMcHmbBqq0AwwFuUM=; b=B
	5E6h9K5Zlp8EpLS7PIDAfc7jL4TaGo37VBZi7Cnmp6fryrESCI9qluruOqCyYmZB
	K7kdWi4xAKb/eR10X5MFvcKyMCyEWqSmbF0IMHK8xn8ClLqYPQWY29kuMXj+Zkf+
	38QqW5jr81j55IF0YsREwcJb0Y6+VtCvVtWRl8Zy/TsZKvSMXgaXjU2t9JFGwT5q
	W+2hmon9WDTMQziBDMm8ULkgliW6J+HWGWVCrnKgXdBKxKoxdAuPB5uuzb9s0hqw
	2a1rAkdeLEI+QG+3u9rixgQ/U7K/OXFdw9kP83XTQRCHbKlvMJHALks3OwMk4BCg
	QzMPW5UOl2N5o/YY30GhQ==
X-ME-Sender: <xms:EVCHasVSzLr2-OKMlkSEjafLjDwYGs7ivPiSjsBwCbWMgDuCe-7s5g>
    <xme:EVCHai1Axj25aMV468MhauNawLJJ9hOnukvSR_Re-9MxmCaCNhovgtcMj0NiID3IP
    j1E9OWhODaucItjy4pMk2oYzJoyGBBBdyini5hzAii3ovBHrsMUPJM>
X-ME-Received: <xmr:EVCHaiqd0YVP1uxYwAzp_kcvi2Lp7jJ79uVS67HuH-AEOkFhY5VtoGlzluGZ4tVEzM3EVPemc2eCNmuCt730tv3ulR7sEfWxZQ>
X-ME-Proxy-Cause: dmFkZTFNLztRw6mgbI6ADa3qTa+NIzXttWzQODjOdJoccxrefh5h4ECjPBvnakknrgwK4s
    4/4wAIdjo+QzOCQbluP0tjgJM2W3LaZLeILs6mqDe3otWbIiooI9fjuowDV8K3uMf8xe5/
    KBiiL5WXto//kS8UikHF52iCnjbM8gTGLnVD8ijXp/qAcEg0YIFz1q99TSOFDDaJpGtra6
    ALO8RxCtJzTbxyw1Xsw332TE4YYVh04d3QHfMiq/RtalI+dqCMytLxHQoGiNKo8TrVSCdv
    kySVkZFbHjt0wQHgm6pTfAd9ZMolRFzekAdyCBiYgBvXiho0LigvJsZPvdgFd41OO05qSs
    WBoDKA/FinRo39hVYqn4U14EzOr2LYqdvf1/0vBcUDtV0SCbeZI7oVQKF83ZuQDnNZbxcc
    cnkmkH07nMJdCkt/LDxRY41JYR/2TXZ1YfZgjAGl8VWvck+KA9BXwWTwGrGp4ZVk73gKvS
    /YUVAV1As4cs0zJXv19oCHBvvVgzIMabjDR8bzdPTSR8f9MR8LPPSh8N/85pur2RKTUqed
    AhOCmsVtXI3LWzQzAfy4SndnKj8CBlJDtqPT2rTXq2rtSusphhM5fEUDXYTSaj+sdmFT9x
    5Q2r0oT6RiKJocFSLhzpmFEIT4HiPy4MEbdjHAeLHk6PClXc0wmgjvccf77g
X-ME-Proxy: <xmx:EVCHahUV2yq5Tif8n3eCF3IYBCcAga7cXuEHmjWA47kekLehz0-qJg>
    <xmx:EVCHalasSQGLtls3yBCuTRtJERrKis_50BjjFI5KeSoL_uoTXjoZRQ>
    <xmx:EVCHamcEyYImR1EDGkdTVn4Fv2TmpEKeFXkt5FgGuOIPk_p5kEzj3w>
    <xmx:EVCHan3FWR7F8zEtDin4u3QI8MbeYUd1w8jb-iccv435LVqnQSU4mw>
    <xmx:EVCHaod60BOvi1rWIYrKMi6GOHTcBU6aoPy7XcxHmLsLZYUbkL9bU5WC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Aug 2026 15:05:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Daniel =?utf-8?Q?Mart=C3=AD?= <mvdan@mvdan.cc>
Cc: Daniel =?utf-8?Q?Mart=C3=AD?= via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  M Hickford <mirth.hickford@gmail.com>,  Mantas
 =?utf-8?Q?Mikul=C4=97nas?= <grawity@gmail.com>,  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH] credential/libsecret: load secrets explicitly
In-Reply-To: <331e94ec-c07a-4d56-938d-d12c9a0cc5c9@mvdan.cc> ("Daniel
	=?utf-8?Q?Mart=C3=AD=22's?= message of "Thu, 20 Aug 2026 16:00:12 +0100")
References: <pull.2372.git.git.1785883217733.gitgitgadget@gmail.com>
	<331e94ec-c07a-4d56-938d-d12c9a0cc5c9@mvdan.cc>
Date: Thu, 20 Aug 2026 12:05:51 -0700
Message-ID: <xmqq33w8sjcg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Daniel Martí <mvdan@mvdan.cc> writes:

> Gentle nudge on this, anything I can do to assist in getting it reviewed?
>
> I still run into the error a few times per week :)
>
> On 8/4/26 11:40 PM, Daniel Martí via GitGitGadget wrote:
>> From: =?UTF-8?q?Daniel=20Mart=C3=AD?= <mvdan@mvdan.cc>
>>
>> secret_service_search_sync() can return an item whose secret is not
>> loaded, despite SECRET_SEARCH_LOAD_SECRETS being set: the search
>> silently discards secret-loading failures, and the GNOME keyring
>> daemon silently omits from its GetSecrets reply any item that is
>> locked or that was deleted after the search matched it, e.g. by a
>> concurrent "credential erase" from another git process.
>>
>> secret_item_get_secret() then returns NULL, which we pass unchecked
>> to secret_value_get_text() and secret_value_unref(), producing

I do not program Gnome so I am not exactly qualified to review this,
but anyway.

The above makes it sound like we can just request with
secret_service_search_sync() exactly the same way as before (i.e.,
with LOAD_SECRETS), and then check with secret_item_get_secret()
to see if it has secret value in it.  The problem with the current
code is that we do not validate what that secrete value is (iow, we
do not say "ah, NULL, we should not assume we do have secret already
obtained here").

So does the first hunk to drop _LOAD_SECRETS really needed?  Rather,
would it be more straight-forward to do

	item = items->data;

	secret = secret_item_get_secret(item);
	if (!secret &&
            !secret_item_load_secret_sync(item, NULL, &error)) {
		... your error handling here ...
		return EXIT_FAILURE;
	} 
        if (!secret)
		secret = secret_item_get_secret(item);

instead?  I am assuming that it is rare (like, only a few times a
week) to race with other activities that unloads the secret and most
of the time the first secret_service_search_sync() gets everything
needed in a single call.

I am also assuming that this is a race condition that is not very
easy to reliably reproduce in the test, so I wouldn't expect it to
come with a test to ensure that the fix will not regress in the
future (in other words, lack of patch to t/ directory is fine).

Thanks.


>>
>>      secret_value_get_text: assertion 'value' failed
>>      secret_value_unref: assertion 'value != NULL' failed
>>
>> and losing the password even when the secret is still retrievable.
>>
>> Drop SECRET_SEARCH_LOAD_SECRETS and instead load the secret of the
>> one item we use with secret_item_load_secret_sync(), which does
>> report errors. A secret the search would have silently dropped is
>> now retrieved normally, and a genuinely inaccessible item produces
>> a useful message instead of assertion spew, with git falling back
>> to prompting either way. Merely guarding against NULL would avoid
>> the assertions, but would forfeit a secret that is still available.
>> The cost is unchanged: the search no longer batch-fetches the
>> secrets of all matching items, and the explicit load fetches the
>> one we use.
>>
>> Signed-off-by: Daniel Martí <mvdan@mvdan.cc>
>> ---
>>      credential/libsecret: load secrets explicitly
>>
>> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2372%2Fmvdan%2Flibsecret-null-secret-v1
>> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2372/mvdan/libsecret-null-secret-v1
>> Pull-Request: https://github.com/git/git/pull/2372
>>
>>   .../libsecret/git-credential-libsecret.c           | 14 +++++++++++++-
>>   1 file changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/contrib/credential/libsecret/git-credential-libsecret.c b/contrib/credential/libsecret/git-credential-libsecret.c
>> index 941b2afd5e..6bbdf2bd45 100644
>> --- a/contrib/credential/libsecret/git-credential-libsecret.c
>> +++ b/contrib/credential/libsecret/git-credential-libsecret.c
>> @@ -126,7 +126,7 @@ static int keyring_get(struct credential *c)
>>   	items = secret_service_search_sync(service,
>>   					   &schema,
>>   					   attributes,
>> -					   SECRET_SEARCH_LOAD_SECRETS | SECRET_SEARCH_UNLOCK,
>> +					   SECRET_SEARCH_UNLOCK,
>>   					   NULL,
>>   					   &error);
>>   	g_hash_table_unref(attributes);
>> @@ -143,6 +143,18 @@ static int keyring_get(struct credential *c)
>>   		gchar **parts;
>>   
>>   		item = items->data;
>> +
>> +		/*
>> +		 * Load the secret explicitly rather than via
>> +		 * SECRET_SEARCH_LOAD_SECRETS, which silently discards load
>> +		 * failures and returns items whose secret is NULL.
>> +		 */
>> +		if (!secret_item_load_secret_sync(item, NULL, &error)) {
>> +			g_critical("could not load secret: %s", error->message);
>> +			g_error_free(error);
>> +			g_list_free_full(items, g_object_unref);
>> +			return EXIT_FAILURE;
>> +		}
>>   		secret = secret_item_get_secret(item);
>>   		attributes = secret_item_get_attributes(item);
>>   
>>
>> base-commit: 5b2471720c93ee30e5764a19f3d3b3ae9ec9712a
