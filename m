Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B55341AB8
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 14:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783694246; cv=none; b=o7ZAlkB2rjf9sMnnOECdv0LUQTkSVU1zhvLMrO852hKjnAryqOT7YDRSQWhAtAtSGLt81b2J4/5l5+gDUbf+uJwntpEpJ4Zk925HHPchoGnd2eoPSaFW3jZdJjX5YKgsK0CkZyq0F80DPyRYHUz1wrM+/D0CR7d/MGfKiukY+wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783694246; c=relaxed/simple;
	bh=9A+/PuULkOOXDmhxmDwjUYvurXHspH3eZAemHqY95yM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lp/2NOG0SKnFqr/0C1sHR+Tt5/8evnZ70/+eDEXwSf3vxl3nlZMa0pQVbpFnQUuGhk749R0Lf0aCIybItmANIVyg9AjUg4skyaYHpgZhiVvX4rkVP8J0MVyPnZ9Svu0wTnLBBkCnKpDTyk8zklIb+7SlkN4JS26W26rK+uHiZUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UV3zfM0w; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UV3zfM0w"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7eb34c17b96so665324a34.2
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 07:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783694244; x=1784299044; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mRYOQuoj4rE196pzgJaIelLalCCAfXKqm8yISJo5lco=;
        b=UV3zfM0w8ZKrydm9drSXVkpSx9og1LpeqGOWVoEXWIUZeT0CpwBmE0sIvJ6RkUNY0d
         JLwReIMfCVRbthrAMyRdDKuIDkogaCOveYKJq3si5wGaCKsn02b0S3JfXd/rzJZa4/cQ
         jkWKuaODFIVYVoU8AZqoNZfnXtAralWtsk2Ko58rww8k+IBOwxwvsxHlkHsTEC398O1t
         Zy6Cq7QxnznYIC2zqlPuv55wOfT1s6PSvGUi68EHkm1ihq6ONEb1jyD/Hr69lSRCOTAP
         1L8MDJO8FnQ9lMuaZQ3GqbdALIvIxg7iosFXdjGUdhMhz+naZ1R0kw+amPnEIidy0Ujy
         6Xhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783694244; x=1784299044;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mRYOQuoj4rE196pzgJaIelLalCCAfXKqm8yISJo5lco=;
        b=hwQyna9ZdIrwGuqw8pFcxYg27ADQZNoImlAETvAyCKSw3iwfbuPo+zHuZzhbpJgTek
         pptGEMxnC8AuzPLgjhp2cPkLGPu6pZnw0I8ciqRuCnU9m8T15jPShK/BJt2NlVLOyDKW
         wtkK2PENm7fmTydcdavI1j/lZwFluq+o3BNLhcMUpL5uFecVn7GiOX86ZiXrUKW+uFTF
         fszbISo7iw6iidg5vMYkvhmOaOcVLOb6pYq2YX07Hri4ZgBpnrk9qc3DFZ70LBtNFbXw
         FSsuCLNL6D6ZkatWcu1/IFe83QXyPtfYq2yY5HqJSyE3XHuKoqYMbvBVqKPOpDzYJ43n
         jMqQ==
X-Gm-Message-State: AOJu0YzvXMSkKZNWySuE/vh+0lWYXrPaCwHVtKAwllmF5if5SlwKFnQI
	njbzB0rFbTBq9+D7KNZKaEBsFIuBtr1yZacUvcNL4pVpY65Gb3BgE3Iu
X-Gm-Gg: AfdE7ckotZAhYcFWV95plfWrZQglZ9IlIy6c2jl29yFJP6PyvviWMvkSINXbYcSUEPR
	wfXAdDY0Ci4rQQ0AHeS/w7hYD03E8if49K8VYUv27kUIGhaAyEeWmcgAByZXCEhVB9B7qryN9/2
	jE9LWY8EeH+Fb4JVLOUfXdssCXng223Fa2tGdg7WixXq0xHtCEvXOgDEcHTDVz+dgjJasUvUNDP
	tSzOSFzaZmy36WW3QHujh0XBBW+1kQDd5K1KlwFnWpajUtmUJkrZEcbl6jML+s26uHvay4gTd0w
	RAiVB1J7Wppu6YMVHHSsyHAunrSdP9LTnEUnvpHLY4rC+c7q2fppYUd8oSTJqC9sKHpN3k3JCa6
	P2cxoTGQ7B6ryBNZhN1dCoiTmEQdohCn92yfGScW63EXk9AWMuMTaK1y6fEJRi8ry3iX4LsvyIx
	8r7M9Bkw==
X-Received: by 2002:a05:6830:81d3:b0:7e9:b4d0:539c with SMTP id 46e09a7af769-7ebd013a2cbmr7426355a34.29.1783694243929;
        Fri, 10 Jul 2026 07:37:23 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcb262da7sm6429018a34.17.2026.07.10.07.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 07:37:23 -0700 (PDT)
Date: Fri, 10 Jul 2026 09:37:19 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH v3 11/11] builtin/receive-pack: stage incoming objects
 via ODB transactions
Message-ID: <alEBEbwOMFkVfuk9@denethor>
References: <20260708041412.1157499-1-jltobler@gmail.com>
 <20260708235925.3992097-1-jltobler@gmail.com>
 <20260708235925.3992097-12-jltobler@gmail.com>
 <xmqq33xsrfeu.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq33xsrfeu.fsf@gitster.g>

On 26/07/08 08:49PM, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> >  			update_shallow_info(commands, &si, &ref);
> >  		}
> >  		use_keepalive = KEEPALIVE_ALWAYS;
> > -		execute_commands(commands, unpack_status, &si,
> > +		execute_commands(commands, unpack_status, &si, transaction,
> >  				 &push_options);
> 
> And in such a case, execute_commands() returns without committing
> the transaction.  Is there a need to add and make an
> odb_transaction_abort() call or something in such a case?
> Everything should be cleaned up upon process exit, and on file based
> backends, we probably let the tempfile/lockfile API do their thing
> to clean up, but are there other things we may want to clean up?

As you mentioned, if we exit before committing the ODB transaction, the
temporary directory will get cleaned up when the process exits. I don't
think there is anything else we need to cleanup that wouldn't be handled
at exit though. Regardless, I do plan to add `odb_transaction_abort()`
in a followup series and I think it would be nice to have an explicit
"abort" here when we know that we are not going to commit anyways. I
would like to defer this to my next series though.

-Justin
