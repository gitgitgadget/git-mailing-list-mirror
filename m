Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350801E5201
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 05:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758693296; cv=none; b=gAU9yQhoTWP9o+fOephZDJKThQ9Mnzkqkqz2oPQrJPgw9rzY6l2NtfjPzOAZwPJijivNCvgtbs7aLxcVqYQVQ10ZdXFnfB8WCnAbYGumM+6kvzMOpVt4XVclYKZYCiCDP8eIeygbVH0Y7avFfHGqFjQRRNK/vraP2OG/zVCkd+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758693296; c=relaxed/simple;
	bh=aURbxjAvPzqNdoXQJRKg/NWkSZ6iqW7bEZfUofj+xnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hmxV+UTP6WPxvi1joWIPz8uVPVyufoPRBDvtmwg3mGufV84fLLe0oLgB03hlJxSgJn5F2MEvcpWLOBxzQsHVuBP0XYgu13ZVmzwrmXerDdu+S2A94LdWl+NUZrToT1UBXNPzw95OiqGWvp8J+9M9T3OnVeG9HCdDO09hOeztDsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZvrUIu/4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WQGgmjEm; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZvrUIu/4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WQGgmjEm"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4E69714000ED;
	Wed, 24 Sep 2025 01:54:54 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 24 Sep 2025 01:54:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758693294; x=1758779694; bh=Hy8otqy7fr
	S0kn6beEpOZGBouqFCcTp9Pryu31wgA+8=; b=ZvrUIu/4PpxaTbGUqssA85Ge2i
	GGDJZrSCpEgzMCPBwkM6IWGUsYH1qsDv2kzMbnXoi7VXzHiDOtXjvodKDLkkoKwU
	W5qADF7TvTxSxei66bNMUJfLbxBbZwNccNb9j3makoZ407W1h7pGe0XiPbLMB2zv
	T08rqBxnQwucjWBkJDQgxqDgeN98GgaMFWjkOAEzVIj4cRaQDDLZc3GVk2Oxcjje
	v8hr+1k6cDF9PRRFDk2opMAc1h1+VfQq58Bg8fPHz40jkAHdNvMN7Lq9qYMnNd0H
	Gcb6MpqteSYjrYVDmF410vGbaJvvxIO2Qt3Ux4aQNBG/ciAVqblB2Swktwvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758693294; x=1758779694; bh=Hy8otqy7frS0kn6beEpOZGBouqFCcTp9Pry
	u31wgA+8=; b=WQGgmjEmj7asTckra4OzSuDfsBoYZ3XiN6mkz42pSbD2xDReedr
	IsNyqsT0rqorv5ymZGYo1XgUxbt5oCMIBwst56ZCl5uOQwI0m18AYYweLFSZAfT2
	4f4mhqcCHE3OQ4Hd3/YO1jysWL8+YozNdmYx4uf2r75UNEJh94yJ6iaVNDohM9F0
	5cvp3zWbCtR3zrMfwPMhXW92u3aVPMG4WyXowZ6t+GTkRG4q9SqzcC2mHLkoBEaC
	blbTTTUhZtLkFwI9ZDZWsTmsiqcSF1jeyaT+Sc3NPOULJXpVir7GDQNRUD5EWA2M
	jpXCTsKKaGEQIfZienyqcIpH54lQ40nlatQ==
X-ME-Sender: <xms:rofTaHSIANQ59dRmLwpUHFdOlNrdWZGB8Z3N2RG1KqHwB0AEglyt6g>
    <xme:rofTaPwR8YQzbTxedaIrj4pFCGVBIGEBI1SFW62ApABuZfSKea4erqdlq7c07iDKs
    NgmW893kFdgG_mjEBnnryPh4anV-fF0G5KHYTg5H2P4_Ntk-1W8Yg>
X-ME-Received: <xmr:rofTaB0eB7ssMwzwXYvn3mBJtWQ_2Jz5mqclQvBiopJ0AJ3_VZaYcmLw-4XsWdaFoO0ZS-MlnftHGgXBZk_kvFspIqmI1hjxsQQt9KJANA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeivdekvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:rofTaF7u8cjkNoIXAUplc_CEqnIPr_8l8pjdUj_7A1OU3H8spLcLAw>
    <xmx:rofTaMUnFNu1FC9J1Mnha_C1jTwu-VRL72KoLehv-Z5eRAuRenWQxw>
    <xmx:rofTaMA6gjGs1jK4Th_6pzDLE5762SUIi8aPGJgXZD83tjihjpzFPw>
    <xmx:rofTaD6XJkbXp_BGnjsQtGiG8bLMxnQbBPPyXF5Q69jKHM9KbEhbYw>
    <xmx:rofTaJUqNXAkxRX2F4m7xA_BTmbzSINbRALGvdf91MJdCCYxOKtyoGkQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 01:54:53 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cf445f0a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 24 Sep 2025 05:54:52 +0000 (UTC)
Date: Wed, 24 Sep 2025 07:54:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, shejialuo@gmail.com
Subject: Re: [PATCH v3 7/8] reftable: add code to facilitate consistency
 checks
Message-ID: <aNOHqEq5qxXrOCX7@pks.im>
References: <20250918-228-reftable-introduce-consistency-checks-v3-0-271af03eb34d@gmail.com>
 <20250918-228-reftable-introduce-consistency-checks-v3-7-271af03eb34d@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918-228-reftable-introduce-consistency-checks-v3-7-271af03eb34d@gmail.com>

On Thu, Sep 18, 2025 at 10:11:48AM +0200, Karthik Nayak wrote:
> diff --git a/reftable/fsck.c b/reftable/fsck.c
> new file mode 100644
> index 0000000000..785e4b43e8
> --- /dev/null
> +++ b/reftable/fsck.c
> @@ -0,0 +1,112 @@
> +#include "basics.h"
> +#include "reftable-fsck.h"
> +#include "stack.h"
> +
> +static bool valid_table_name(const char *name, uint64_t *min_update_index,
> +			     uint64_t *max_update_index)
> +{
> +	const char *ptr = name;
> +	char *endptr;
> +
> +	/* strtoull doesn't set errno on success */
> +	errno = 0;
> +
> +	*min_update_index = strtoull(ptr, &endptr, 16);
> +	if (errno == EINVAL)
> +		return false;

strtoull may also return ERANGE. In general, shouldn't we abort whenever
errno is non-zero here?

> +	ptr = endptr;
> +
> +	if (strncmp(ptr, "-", 1))
> +		return false;

Better:

    if (*ptr != '-')
        return false;

> +	ptr++;
> +
> +	*max_update_index = strtoull(ptr, &endptr, 16);
> +	if (errno == EINVAL)
> +		return false;
> +	ptr = endptr;
> +
> +	if (*ptr != '-')
> +		return false;
> +	ptr++;
> +
> +	strtoul(ptr, &endptr, 16);
> +	if (errno == EINVAL)
> +		return false;
> +	ptr = endptr;
> +
> +	if (strcmp(ptr, ".ref") && strcmp(ptr, ".log"))
> +		return false;

Yup, makes sense. We don't do so ourselves, but in theory it is possible
for tables to have a ".log" suffix. If so, they are expected to only
contain reflog records.

> +	return true;
> +}
> +
> +static int stack_check_all_files_in_dir(struct reftable_stack *stack,
> +					reftable_fsck_report_fn report_fn,
> +					void *cb_data)
> +{
> +	DIR *dir = opendir(stack->reftable_dir);

I think it would make sense to move this function call close to the
conditional.

> +	struct reftable_fsck_info info;
> +	struct dirent *d = NULL;
> +	uint64_t min, max;
> +	int err = 0;
> +
> +	if (!dir)
> +		return 0;
> +
> +	while ((d = readdir(dir))) {
> +		if (!strcmp(d->d_name, "tables.list"))
> +			continue;
> +
> +		if ((d->d_name[0] == '.' &&
> +		     (d->d_name[1] == '\0' ||
> +		      (d->d_name[1] == '.' && d->d_name[2] == '\0'))))
> +			continue;
> +
> +		if (d->d_type == DT_REG) {
> +			if (!valid_table_name(d->d_name, &min, &max)) {
> +				info.error = REFTABLE_FSCK_ERROR_TABLE_NAME;
> +				info.msg = "file with invalid table name";
> +				info.path = d->d_name;
> +
> +				err |= report_fn(&info, cb_data);
> +			}

One problem with this is that this is racy with concurrent writers. We
don't recognize the "tables.list.lock" file, and neither do we recognize
"0x*-0x*.{ref,log}.temp.XXXXXX"-style files.

Would it be a better approach be to instead go through table names as
loaded by the stack? The reftable code already knows to prune unknown
files anyway, so I don't think we should scan for any other files.

> +		} else {
> +			info.error = REFTABLE_FSCK_ERROR_INVALID_FILE_TYPE;
> +			info.msg = "file with unexpected type";
> +			info.path = d->d_name;
> +
> +			err |= report_fn(&info, cb_data);
> +		}
> +	}
> +
> +	closedir(dir);
> +	return err;
> +}
> +
> +static int stack_checks(struct reftable_stack *stack,
> +			reftable_fsck_report_fn report_fn,
> +			void *cb_data)
> +{
> +	struct reftable_buf msg = REFTABLE_BUF_INIT;
> +	char **names = NULL;

This variable is unused.

> +	int err = 0;
> +
> +	if (stack == NULL)
> +		goto out;

Why should someone ever pass a `NULL` stack?

> +	err |= stack_check_all_files_in_dir(stack, report_fn, cb_data);
> +
> +out:
> +	free_names(names);
> +	reftable_buf_release(&msg);
> +	return err;
> +}
> +
> +int reftable_fsck_check(struct reftable_stack *stack,
> +			reftable_fsck_report_fn report_fn,
> +			reftable_fsck_verbose_fn verbose_fn,
> +			void *cb_data)
> +{
> +	verbose_fn("Checking reftable: stack checks", cb_data);
> +	return stack_checks(stack, report_fn, cb_data);

Nit: having this extra function call to `stack_checks()` feels a bit
weird as it could just as well be inlined. Is this preparing for a
future change?

> +}
> diff --git a/reftable/reftable-fsck.h b/reftable/reftable-fsck.h
> new file mode 100644
> index 0000000000..5e13ac9f02
> --- /dev/null
> +++ b/reftable/reftable-fsck.h
> @@ -0,0 +1,42 @@
> +#ifndef REFTABLE_FSCK_H
> +#define REFTABLE_FSCK_H
> +
> +#include "reftable-stack.h"
> +
> +enum reftable_fsck_error {
> +	/* Non regular file in the reftable directory */
> +	REFTABLE_FSCK_ERROR_INVALID_FILE_TYPE = 0,
> +	/* Invalid table name */
> +	REFTABLE_FSCK_ERROR_TABLE_NAME,
> +	/* Used for bounds checking, must be last */
> +	REFTABLE_FSCK_MAX_VALUE

Let's add a trailing comma here.

Patrick
