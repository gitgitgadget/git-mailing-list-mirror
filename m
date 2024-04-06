Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B657122EED
	for <git@vger.kernel.org>; Sat,  6 Apr 2024 10:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712398717; cv=none; b=m39fhN50AgbPBMzpNMyqlCyihpGnWjUKlI5nJoe4U7I2YEp+nHAAd3xLhl7qJG8uDsE5QDTXnM2fAjLXWg5g9F/dkJk0Usc/gA9AR9v8eiG/7RB+DlfrUSvLXz/yUP51d5UuWvPjstVjxQ0syga9VUf8beeUAxf5/7k2BMOkQKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712398717; c=relaxed/simple;
	bh=z5q3KgNFp2TfnFmQ+f82R/OXC0QkRqCu/Z27l9Sd6h4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=eWoApRZLTWoSR+Y+99wE2NWiBlGOBtPYWpCHht5MvtjhKAJwUlFnnAqzgFg0Pn16ZKflgB7EOfIVwQT3z/6Yag/QT/8Kp823Ej9F/Ye4GIq1NR2A5z8O1HOxm0MtdUZdoFF/Vy/+fPL0K8yeG2tWNNGI9SdeGNZesqUmXAWV/3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=MEY5LFpH; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="MEY5LFpH"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1712398711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mz9EjUfH6mc4ZhtOttVfHWYylu0htr2B5EEJgUO869A=;
	b=MEY5LFpHUW2RJ3Rtu4y4LVNeOHXk7kUdi/khadpmRTDZtdNsfGI7oMvx5GrYvmtttcqVEW
	jhHD/tF2GnSJeq1s1PeCmNNbIMoVMQ8V9Vax5gHgMjUnj7I9K3gbDyzHNkPlEvEj1NNwtK
	DbSDqEGAzvRTx+jv2qzBnCiIqCUwHUdYuuhR/xHbcugb+ba6klEJikras1Q1AY7dYuMei3
	3Juk9eZOvjh5t+pNo7Y0Iv18USlCTG3enkw5uX6Mo4rf1HM1Er1dgWLMVpgYIlra4gegNo
	nQq6KhXypGZaR2MQvMJSfn1gtvsIAluUU7mL/vdPGGlQPnQNFAJObG+VZVMFDw==
Date: Sat, 06 Apr 2024 12:18:31 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, code@khaugsbakk.name
Subject: Re: [PATCH v4] send-email: make it easy to discern the messages for
 each patch
In-Reply-To: <e90f6c80be33b2b54e20992f19e417dc@manjaro.org>
References: <8a9f4927aab96f2f62e2467e59fb6150d7e931fc.1712367983.git.dsimic@manjaro.org>
 <xmqqwmpbm4lp.fsf@gitster.g> <e90f6c80be33b2b54e20992f19e417dc@manjaro.org>
Message-ID: <713c28cfc9dff2d01159105ddd2fd0f5@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-04-06 10:56, Dragan Simic wrote:
> On 2024-04-06 07:40, Junio C Hamano wrote:
>> Dragan Simic <dsimic@manjaro.org> writes:
>> 
>>> Following the approach of making the produced output more readable, 
>>> also
>>> emit additional vertical whitespace after the "Send this email 
>>> [y/n/...]?"
>>> prompt.
>> 
>> Hmph.  I'd prefer to see you try not to endlessly extend the scope
>> of a topic.
>> 
>> By including the above change, the patch no longer is small and
>> focused enough, which was the reason why we said that the "let's
>> move the final newline out of the translatable string" can be done
>> as a "while at it" change.
>> 
>> Besides, because of the switch to separator semantics, that hunk
>> lost the reason to exist as part of the "use a blank line between
>> output for each message"---the change no longer is needed to support
>> the feature.
>> 
>> Even though it is a good change to have, and it deserves to be
>> justified by its merit alone.
>> 
>> The whole thing deserves to be a three-patch series, the first one
>> being a preliminarly "let's move the final newline out of the
>> translatable string" step, followed by "let's have a gap between
>> output for each patch sent out".  Perhaps another "even during
>> sending a single patch, we may want extra blank lines when use of
>> editor and other user interation is involved" patch on top.
>> 
>> I haven't formed an opinion on that last step, and I do not think I
>> can spend any time to think about that new part of the feature for
>> some time (others can review that part and give their opinion on it,
>> of course, while I'll be working on other topics).  It would mean
>> you are adding yet another feature to delay the base improvement to
>> stabilize.  You really do not want to do that.
> 
> Quite frankly, I think all these changes are small enough and
> understandable enough to be fine for being squashed into a single
> patch.  See, I love perfection and I'm also kind of a perfectionist,
> but such an approach can sometimes actually become counterproductive.
> That's what I usually refer to as being pragmatic, in the sense of
> making things a bit less perfect but still fine, in the interest
> of "getting things done", so to speak.  I hope it makes sense.
> 
> However, if you insist I'm also perfectly fine with splitting this
> patch into a three-patch series.  That would make it perfect, there's
> no doubt about it, but would it be a pragmatic approach, worth the
> additional time and effort?  Perhaps not.

After thinking a bit more about it, I agree that splitting this
patch into a three-patch series is the right thing to do.  As
you described it above, changes introduced in some versions of
the patch made the original assumptions about squashing the changes
together no longer apply.  I'll split this patch into three separate
patches and send those over.

As a note, I think that making the outputs of "git send-mail" more
readable is quite important, because we've seen people complaining
about the whole process of sending patches to mailing lists.  Making
the outputs more readable can only help, if you agree.

>> In any case, this [v4], as a single ball of wax, is not something I
>> can confidently say "I reviewed this and looks OK".
