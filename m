Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8890E3E025F
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 06:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783492923; cv=none; b=mcx+Z9i4btF7EAYD7+wX6jsgz7MNd5g5C7y3Hnb23hhxWcqTEXb9D7lWlOqUz3JpmLeE9MC+sdWYG6daaDUkwCE6ep/NkbTwjcDb7WRFpaR2ekNc7pLs/joSuT7wfjg1JOlUWUH2bcANjFcoaQPAPUo8/FrE7rIZDKGNjDweaPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783492923; c=relaxed/simple;
	bh=Q6tO1Pic6FHtcd+6BFvGJh2ZNFUl6bCvvHmnyFrGanc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MGw169BA2CxiwK++vH5hc09U1bXZEUeGmKkm5tycAmDG9CHuxmo456vHyS/w/xI2G1MKIECNhHiJ9YAvWip4S0pq8YcjeW8Mvof2hZgPSr9Im6DoQaBcMFP0bXkP0yp2rGTEOgTr9wetOfkJQ8gF14RTXo//+pX6y81h4GQRyPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=frxyHd3T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DTDWJA8g; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="frxyHd3T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DTDWJA8g"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 5B98FEC0128;
	Wed,  8 Jul 2026 02:41:56 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 08 Jul 2026 02:41:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1783492916; x=1783579316; bh=5kksVOnN3e
	VMa13Csi0aI8kBNYiAGd1HVyrJ/gL/P1M=; b=frxyHd3Tw4jPDcdOLdC4S1jD5h
	AU4Wpm/4lGuNIwpkOPfR5hJfCju8NCT4Ya/be7y5KO0/oFHZDxUplozzU/vNLXaf
	anziwHpKSWhI0xvzS+XKGrwt5zdxE6wyHs7AlN3fmvm0kI/1NZDKm214jjPCHd2u
	dAKnMmUtdzT0QCPbXnxcVelcQuLjVZgaoJNI9MMOOVQPpEkBk7tYExMjtapW2B3C
	wDzGheQwQK5pHWR+5GIFqrChMMGUuLJguc2BbYvDmVcu/UerdAjSKUCQ9LtRKp7q
	8U3ya6XWTuAkNkU/XnGE5HsClrnDNCirfpCdXrQRGCnHTnStEhd/9v8z/cQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783492916; x=1783579316; bh=5kksVOnN3eVMa13Csi0aI8kBNYiAGd1HVyr
	J/gL/P1M=; b=DTDWJA8g6caGmRIxFZNBb8K9q3fhoR8KhMhH5/OL8jOHCrHww1b
	8PfgS6cWu5i+yj6dM+RKdGkDPaYpa0lejMSmygyJ05meDypG/+KY8FgZ30eJr0xy
	szX/cpGBiHlXpbJC/j/E8D+15qtrvsOIv1i2C+XIxedSVRODPqVaxmEf11SYemgm
	/Ms0Q0zjZ7tkzNP6rF12il+jtkEYIvNSrFHbUOW2uOeMGlfnfS60nUZ4gqSOXXXu
	6kY9wknO1YU/mEqZc1orfVZhDOuown4QAx+oJwFKcL1foFCcblc1xUepJHJcZzm7
	jWcPUJ/2vOpdI5af435vkTH2z0Pipq9RI4A==
X-ME-Sender: <xms:NPFNaq_vZF7KlMAW3xaYq55JczNQ38eOfXB8x1S1MlsIR_KSndXVEg>
    <xme:NPFNaiI_d0m3_zjUJs70ugYUVTWyQW_JzD6tht-uTfn7EMoHKxNcsPnsK6q48DuTC
    wj6xeu26n4EuwHsnEqkM64gn9DEvl0rb6HrXOr0SZkYlP8zNH-xig>
X-ME-Received: <xmr:NPFNatZ1VE7_3b6lN0G7hPIHAnVrBsE3Fs4u8OqiGIwwinYjQTDLOI4zXUStebNYCbvMthloe2VgKFn-scFgOzcwvfctcgnAxVSdF6bG>
X-ME-Proxy-Cause: dmFkZTER4oDEsDuZgk7Jxo48Q51qL0wxCuQLafms/oSowy452z1z/Ex57hoNdJqyKmYrDQ
    GMxb4tHH4jz6ZOUNVM3+sJGs5PkqpmZ8qroQQwT4mw224NOv6PG5JrSDpUWsP3nO6GGEOm
    yZdo0E/A7NnrUUcpRZkkuO/1tJGDuuHOnmuwySOa/NAZsTJdS/71gWD6J7c8gzo2r96wJh
    IK117m3//qJhiMbeg1PVnQOBsqwtiIxUo1G57IGgHv4HCIp5cI5NuQtmJP7L3wXd2JPhB2
    uFaBgB+j4RcX5Q1DH+BT647ULrNvZT8FYy/Ahe81f5ZKGqVAfQKKf7+KmURahhZk1lWIkX
    SdjxYbPcaIhgAg+PCKd7YALIQAGRRZ3hfqxJiBV/pVKlUgCh+h8p1GK06l3tYfNW7+VMUK
    EqnG9f3OddXNPfNc+EDgs1Tw1A72ElEinEWU/nHgEHBR+84JSySlxo/3gcZaGmzfyA0RVE
    yhqA/1v78pIuc1/JsWbgL7qJT5vHKZTCqD9me9QEaoI16sR7vVHBAbVSLAoiLb65kQyXvE
    Kn0pKOld6OHROqdVAw7p824k2V/GnRQE+O6J5s2IQbYRsdHWvHCwkvt+m7u0qww1k2lhnx
    oDxw4wsUJr3EQi+GyV8mBv15HpkAzaEnLHP8aNJP/DFmhessNWURXL/TN2Gw
X-ME-Proxy: <xmx:NPFNasLz5lll23Z3WV592D5gQOCbznxLGCmO-pDKRgAzB0PPYiG_xg>
    <xmx:NPFNajCRjyMpFkEUhyCekZqd6t3lrsh7ZvNa3mWr1VEOfLgFtX_mFQ>
    <xmx:NPFNappyY6Mgg64WeRhtn5VysWlHXpfrZRXnkaGPhwvnboSu41tVNA>
    <xmx:NPFNamgxGYq_QRCzkhwkvZ4uPk5COmiYKEe5_TVGB5TIVBrxgnO5uw>
    <xmx:NPFNauJnHCkm-t3Daw393ghxInDAJqJZc8mUUYKJPIo94psoMLPkRWBw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jul 2026 02:41:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 42e46627 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 8 Jul 2026 06:41:54 +0000 (UTC)
Date: Wed, 8 Jul 2026 08:41:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 09/11] odb/transaction: introduce ODB transaction flags
Message-ID: <ak3xMNbhQnGCMe2c@pks.im>
References: <20260624041920.2601961-1-jltobler@gmail.com>
 <20260708041412.1157499-1-jltobler@gmail.com>
 <20260708041412.1157499-10-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708041412.1157499-10-jltobler@gmail.com>

On Tue, Jul 07, 2026 at 11:14:10PM -0500, Justin Tobler wrote:
> diff --git a/object-file.c b/object-file.c
> index 9b8ee6f36c..d95bdabba5 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1710,6 +1712,27 @@ int odb_transaction_files_begin(struct odb_source *source,
>  	transaction->base.commit = odb_transaction_files_commit;
>  	transaction->base.write_object_stream = odb_transaction_files_write_object_stream;
>  	transaction->base.env = odb_transaction_files_env;
> +
> +	transaction->prefix = "bulk-fsync";
> +	if (flags & ODB_TRANSACTION_RECEIVE) {
> +		/*
> +		 * ODB transactions for git-receive-pack(1) eagerly create a
> +		 * temporary directory and use a different temporary directory
> +		 * prefix.
> +		 *
> +		 * NEEDSWORK: This transaction flag is only used by the "files"
> +		 * backend to special case temporary directory set up and
> +		 * handling. Ideally transaction users should not have to care
> +		 * though. To avoid this, we could eagerly create the temporary
> +		 * directory and use the same prefix name for all transactions.
> +		 */

Yup, agreed, thanks for noting this here.

> diff --git a/odb/transaction.h b/odb/transaction.h
> index 1c6c97a53e..b19f180aee 100644
> --- a/odb/transaction.h
> +++ b/odb/transaction.h
> @@ -4,7 +4,6 @@
>  #include "git-compat-util.h"
>  #include "gettext.h"
>  #include "odb.h"
> -#include "odb/source.h"

This is curious, and likely a result of you adding "odb/transaction.h"
to "odb/source.h".

> @@ -45,6 +44,12 @@ struct odb_transaction {
>  	int (*env)(struct odb_transaction *transaction, struct strvec *env);
>  };
>  
> +/* Flags used to configure an ODB transaction. */
> +enum odb_transaction_flags {
> +	/* Configures the transaction for use with git-receive-pack(1). */
> +	ODB_TRANSACTION_RECEIVE = (1 << 0),
> +};
> +
>  /*
>   * Starts an ODB transaction and returns it via `out`. Subsequent objects are
>   * written to the transaction and not committed until odb_transaction_commit()

And this is the reason you have to add the include, so that the flags
are visible in both "odb/source.h" and in "odb/transaction.h".

This makes me wonder whether there's really much value in having this
header here be split out of "odb/source.h".

Patrick
