Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFE11D131B
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 21:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727905330; cv=none; b=pRtwOlEctyYnjTd0WA18iD0xZD6QN3SRp5D1uRxMJ3x4EZa33bbhxtOoJ5jwI+zL9OejoZSwJf4OXWVvotsGh4xvJ7dx5i3s4YfBgySwKTlmFlXw9NP7ihJe1gikFAK1vflNq5MLOIbeNHNG+yWb91vHpdnP3qXuICTYUbu2zSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727905330; c=relaxed/simple;
	bh=OFl3amOPRIbd8rBPyG5kUwsQsJvP1tpSVaYZTlZn6ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SXQ01aM1eJC7ziaqEUAULNud1h7NNR/lJ8P5t/Wn/zovzq/r27xY8YgKyWp29ChvIhHvZnEDM/yWn7Qj/WdNk8GEeXPlO/SsetDCxT4/ms6JJ7gQPbdRkDc2gyYWTwjd/HaDqUNDD1lXa1EQWpr8yHHzJWlD3GnGMnXS+oOR1Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WZeaJiMW; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WZeaJiMW"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20b3d1a77bbso61875ad.0
        for <git@vger.kernel.org>; Wed, 02 Oct 2024 14:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727905328; x=1728510128; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zk7slGii1Q9WEyRUVE0qbyXT56sRryCf1/FQAfnGBGM=;
        b=WZeaJiMWPyPmqxvyYPs9pJcP+csCOWFY2kawVnI8W0UdBzqRaoAB76m8mRRmvL9R7i
         krPeAzSGFxqdCKkParX+ewRukEOsRU4FVYDueZBwdufV3ewYxaIQXUN5deoaXcWRaBQI
         aHuW9U4fFfeJ30NUG5UQgW6TkVKZmO/9l84XWurbE219zxpzqCwS9gOTAe9z0/3Ni4T1
         uYhVx3a1/UmDhju5YNKlqYSJeegactdIScw9GVMRwUXMPTO0tKn5Mjmd+raPWv68WPh9
         iDSHk/lFUHBVwnRvZ2EDghotPicZdL8KA2BQ9s3Y6DfroVnxwT0QSJdqdrqN3hjg811Y
         Av8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727905328; x=1728510128;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zk7slGii1Q9WEyRUVE0qbyXT56sRryCf1/FQAfnGBGM=;
        b=ofdCYX7qTBJPj26T68E+1glyjiREc28WpdrI4FBlKP4A/LLQcT8OYw9fwl8fweksHR
         +knCcw9B37LHH0jS6cSufThKjLxTdOfwYIFlEsKG53yJktb/qNmP3jUZmHNmYeeL8Cgh
         II+7N+hxMhNK2ZAiCSMHq+XFz41p7g7qCPbRYXUTfAHc7ztkK867YfHUyHc5F7mzsjLV
         T41PEFvbMzPHel+nLKogznWx3lu+o4Ul1xcBnvATyOFDK2FeQiSTpX0oBspLJDY8adVR
         xTcFImNQdyhPbuu8zU21Gs1AwXjSUe8SG4B5c6tIJCkHX5aPw1Xiq4uHCP+C7iEHmhK4
         +sQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVO0BQ8hUflpPpbPR36KdurhLQDY3nBRPzjVMMJE4rtZzVxomwRAzKV1MF8aO7jFKk7W+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW3C0vP01mQU+7T9craxkiSv/WAkX1dAKa3OTX8sFwmuABDXUe
	lzv8QqZ0YcVmzOuAhEzsOMGWkGWJVsOUSbp95cP6+M4WlcXxLzMr3/PfKUycAg==
X-Google-Smtp-Source: AGHT+IGGxY1b8lzyjmiZI59/K3u+/w9a0AdYqtRPvj3SLiFk5Z1peeiLiS38oAKweDbRPGjxxC51oQ==
X-Received: by 2002:a17:903:1c2:b0:20b:bf5a:c8 with SMTP id d9443c01a7336-20be4cbe909mr887015ad.10.1727905328248;
        Wed, 02 Oct 2024 14:42:08 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:2dd:9410:f675:e07f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e18fa6b937sm2118356a91.56.2024.10.02.14.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 14:42:05 -0700 (PDT)
Date: Wed, 2 Oct 2024 14:41:58 -0700
From: Josh Steadmon <steadmon@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>, 
	=?utf-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>, 
	Chris Torek <chris.torek@gmail.com>, =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH v5 0/3] doc: introducing synopsis para
Message-ID: <wuxy3oit7bculbpct3xnmpzxrfnsgaeoh2gvp5fsaaszchktoy@5ygjwbkdvozh>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Junio C Hamano <gitster@pobox.com>, Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>, 
	=?utf-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>, 
	Chris Torek <chris.torek@gmail.com>, =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
References: <pull.1766.v4.git.1725573126.gitgitgadget@gmail.com>
 <pull.1766.v5.git.1727161730.gitgitgadget@gmail.com>
 <xmqq5xqlug4l.fsf@gitster.g>
 <20240924193004.GA20138@tb-raspi4>
 <xmqqbk0cssel.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqbk0cssel.fsf@gitster.g>

On 2024.09.24 13:33, Junio C Hamano wrote:
> Torsten Bögershausen <tboegi@web.de> writes:
> 
> > On Tue, Sep 24, 2024 at 10:16:10AM -0700, Junio C Hamano wrote:
> >> "Jean-Noël Avila via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >>
> >> > Changes since V4:
> >> >
> >> >  * used BRE in sed filter
> >> >  * rework the processing of three dots
> >> ...
> >> Josh (or whoever is taking over this week from him at Google), can
> >> you see if the breakage you saw that stopped us merging the topic
> >> before it causes us trouble on 'master' reproduces with this version
> >> (either by running "make doc" on the topic branch by itself, or on
> >> 'seen' that merges the topic) in your environment that had trouble
> >> with the previous round?
> >>
> >> It would also be highly appreciated if other macOS users try "make
> >> doc" and see the resulting git-init and git-clone documentation
> >> pages are reasonable, both for the previous round that has been
> >> cooking in 'next' and for this latest round.  Inputs from folks on
> >> more mainstream platforms with modern asciidoc/asciidoctor toolchain
> >> would also help.  The more people we have who look at how the new
> >> way the synopsis section is written and how the resulting documents
> >> get rendered, the more fairly we can assess the value of this topic.
> >>
> > Here a report from a MacOs user,
> > asciidoc --version
> > asciidoc 10.2.0
> >
> > installed via macports.
> >
> > No problems seen in the seen branch.
> >
> > I diffed git-init.html from seen of today against both master and next,
> > some (minor) improvements (like GIT_OBJECT_DIRECTORY vs $GIT_OBJECT_DIRECTORY)
> > All in all it looks all sensible.
> > (and yes, `sed` understands -E)
> 
> Since I haven't pushed out the 'seen' branch with latest iteration,
> your sucess report is about the previous iteration that Josh said
> "still breaks on MacOS" [*].  The plot thickens...
> 
> Thanks.
> 
> 
> [Reference]
> 
>  * https://lore.kernel.org/git/4ww5v253vz2g4i3z2x3dmgkrot7mcn2qm6ckjcxbyky6yvrozy@mr5hnrsfj6sn/

I finally got the chance to test this version on $DAYJOB's build
infrastructure, and I verified that it works (I also got a much more
recent version of sed installed).
