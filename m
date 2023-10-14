Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A2C1A262
	for <git@vger.kernel.org>; Sat, 14 Oct 2023 16:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="q7OyoKVk"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CAEBC9
	for <git@vger.kernel.org>; Sat, 14 Oct 2023 09:33:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1697301235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UXR5QSBwHV45sujbeK5bL1pBAagwnqLASji5ydXc83Q=;
	b=q7OyoKVkb64Tx6RoffY8H3/BOngYVOxM1BtLWhj4OONRtOnFf/eW4vDkknX7dZyKaTbJ+2
	rhd9V58+eW3vGEz6oHR9Td/5qO0uvAlS8SmBu67To2c9ay/feesEZfHpJwMUceTOA2i9qP
	VWNdJKLFYYJ/8Y4YewJcX2WAVOWWnZqrUoZ5AqLVIPMbnS+S4aT/6s7jTXuCk0VjvWiiwD
	ADrpHGr+Tf/u+sDDepIIO0FOTPMeZfwTzvYVNoNzZ1HPxJrkjZm9E22ZQdpE53+sayrZub
	Z3XFmdIX4ffjjFDgjawteFdRmv/qpfyHpDRgOHrGkEIySV3dpsO/w5vZL6VlHg==
Date: Sat, 14 Oct 2023 18:33:54 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jacob Stopak <jacob@initialcommit.io>, git@vger.kernel.org
Subject: Re: [PATCH] bugreport: add 'seconds' to default outfile name
In-Reply-To: <xmqq4jitw4nk.fsf@gitster.g>
References: <20231014040101.8333-1-jacob@initialcommit.io>
 <xmqq4jitw4nk.fsf@gitster.g>
Message-ID: <833da2d05d4b1dfa8e561aa638a927b0@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-10-14 18:27, Junio C Hamano wrote:
> Jacob Stopak <jacob@initialcommit.io> writes:
>> If a user runs the bugreport command more than once within a calendar
>> minute, a filename conflict with an existing file occurs and the 
>> program
>> errors, since the new output filename was already used for the 
>> previous
>> file.
> 
> This is totally expected and you made an excellent observation.
> 
> I personally do not think it is a problem, simply because a quality
> bug report that would capture information necessary to diagnose any
> issue concisely in a readable fashion would take at least 90 seconds
> or more to produce, though.
> 
> Instead of lengthening the filename for all files by 2 digits, the
> command can retry by adding say "+1", "+2", etc. after the failed
> filename to find a unique suffix within the same minute.  It would
> mean that after writing git-bugreport-2023-10-14-0920.txt and you
> start another one without spending enough time, the new one may
> become git-bugreport-2023-10-14-0920+1.txt or something unique.

How about making the filename a bit shorter first, to make room for the 
additional two digits, so the example mentioned above would end up being 
named "git-bugreport-20231014-092037.txt"?
