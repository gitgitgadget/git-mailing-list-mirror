Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE6B2599
	for <git@vger.kernel.org>; Mon, 12 Aug 2024 06:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723444558; cv=none; b=IrbBXtgRl+xpaoaUAUE/AMf6sxqayKzMIwAxBCUIsmYrAb8zlYTSiJ4SLcQcyIOZF0xORHKe5jXwTlU07sDKoY703apqs7Y91Gou7/MQq79Ujk4HMoo/TaR8BbjbWxwuxSYsLKT7O4Q2IQaSsAvzaugCTqBHsNFbN517oYtTU9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723444558; c=relaxed/simple;
	bh=Y5cORqUjPs6l3DqLAyDYxZpYzG5ti3hfsidI7418keI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=GtehYDnAdOYKPqZqE95wK89T2fOSLp4MvJwSa8ux1A5COGjok4SWSAPeP+iaHsnoBnvkZJzoCgoMjhWtKlhN2zbmeNArArA+9uQLoEOfTLsbrBwPdVV4MxMXoIg0GRquDyLAnn92JvhcxDkzYtvvZhKsby/8IJ9AlxNaNTgS+Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp2.bon.at (unknown [192.168.181.105])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4Wj4XP3psgz5vLL
	for <git@vger.kernel.org>; Mon, 12 Aug 2024 08:35:49 +0200 (CEST)
Received: from [192.168.0.104] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4Wj4XC5DbBzRnmN;
	Mon, 12 Aug 2024 08:35:39 +0200 (CEST)
Message-ID: <f44c253d-9b37-451d-902d-486adb8e3d72@kdbg.org>
Date: Mon, 12 Aug 2024 08:35:39 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [RFC] formatting macro
To: =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>
Cc: =?UTF-8?Q?Jean-No=C3=ABl_Avila_via_GitGitGadget?=
 <gitgitgadget@gmail.com>, git@vger.kernel.org,
 Junio C Hamano <gitster@pobox.com>
References: <pull.1769.git.1722801936.gitgitgadget@gmail.com>
 <5ef4a7bd-3b9f-4e71-9a22-e22012f815ce@kdbg.org> <xmqqcymn3qc8.fsf@gitster.g>
 <4617471.LvFx2qVVIh@cayenne>
Content-Language: en-US
In-Reply-To: <4617471.LvFx2qVVIh@cayenne>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 07.08.24 um 22:43 schrieb Jean-Noël AVILA:
> On Monday, 5 August 2024 18:08:07 CEST Junio C Hamano wrote:
>> Johannes Sixt <j6t@kdbg.org> writes:
>>
>>> I've a strong aversion to the formatting that this series applies,
>>> because it introduces many (IMHO) unnecessary punctuation that
>>> vandalizes the perfectly readable plain text. And this hunk now shows
>>> where it goes too far. These lines under the new [synopsis] header just
>>> aren't syopsis; they are comamnd output. The updated version abuses a
>>> semantic token to achieve syntactic highlighting.
>>>
>>> To me this series looks too much like "we must adapt to the tool" when
>>> the correct stance should be "the tool must adapt to us". If the tool
>>> (one of asciidoc and asciidoctor, I presume) does not cooperate well
>>> with out documents, then it is the tool that must be changed, not our
>>> documents.
>>>
>>> I understand that some compromises are needed, but with this extent of
>>> changes we give in to a sub-par tool too far.
>>
>> Thanks for placing this into words a lot better than how I could
>> have done.  I share the same feeling.
>>
> 
> I'm working on a form of macro that would work almost the same way as the 
> synopsis paragraph. You would have some markup, but it would be surrounding 
> the text to typeset: 
> 
> s:["--ignore-matching-lines=<regex>"]
> 
> In this snippet the macro part (which is recognized by a regex) is  s:[ ]
> The inside part is managed the same. If you need additional markup, it is 
> possible:
> 
> s:["<commit1>`...`<commit2>"] to have the three dots rendered as <code>, 
> because they are part of the tokens.
> 
> Square brackets are possible inside the double-quotes:
> s:["--ignore-submodules[=<when>]"]
> 
> Is this something that wouldn't repel you?

You argued elsewhere in this thread:

>  * The fact that the source of the pages should be "perfectly readable" is a 
> moot argument. Fair enough, it is not the objective to make it impossible to 
> understand, but in the end, this is not what is consumed: these pages are 
> compiled into other formats where the markup has been translated into styling. 

I buy this argument, in particular, since not even I read the plain text
files, but use the rendered version.

I would like tone down my harsh opposition to mild opposition. IMO, it
should still be easy to *write* the documentation. It should not be
necessary that authors remember to use macros all over the place.

And I still think that we should not introduce macros just to please all
renderers. Let's just pick the one renderer that can do the job best. If
it means that some distribution cannot render the documentation
perfectly themselves (Debian? I don't know), they can always use the
pre-rendered version that Junio kindly produces.

-- Hannes
