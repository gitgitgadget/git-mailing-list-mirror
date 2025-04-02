Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFBA23BD09
	for <git@vger.kernel.org>; Wed,  2 Apr 2025 15:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743606015; cv=none; b=jV5k7JsvfDs15IOq6CtTcRx0mF84rUKKIz7tKP+cxawdN8uT4pO5YQWxMmIhInangDy4g5efPocEXwelr61n9TOLn76TQk2o+pZCcq5uwKQfzz7XzPLryIozGCyU4oos6+xU+FHNE5AdSpcJbl2Oyne5z5wU9WFUU9z1nio/oOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743606015; c=relaxed/simple;
	bh=tTXGYvHFn8GmR8YgTKSbcn/NzfJOJafdNrkptDhptos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ab4QLN3MuQSFB/qFioNZPRZoGjpidyuJiIuq7dOPLZPzz8yVnaA35CpVFRkPI1FgQSUdc2P+VBQZJditvcypc1JMvPmN5jM0weZuYJ/m0n4HQ+HnDVEwKf5Z3npNQ3WtSB8f47xu3wFFHq87/qO/li49fl3UQJfu16KL9iKfJzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UFdEHnT9; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFdEHnT9"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-72b7a53ceb6so525643a34.0
        for <git@vger.kernel.org>; Wed, 02 Apr 2025 08:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743606013; x=1744210813; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2J8joh1VpJXVXk10JwyK7VqgRVaiZvDDPRWTBkdJC/Q=;
        b=UFdEHnT9SqPPyf3stqxF87ksITRSSy4t1Um39fhJqpkCe/HI16xVun4/QH0PNi/VHi
         Ir9vje4XiFof1vz5WzzUQdfO8I0E7LWx3w0NWarJs5jocRv/E2b38AZVfsEq+z6UvDOX
         0AvPab9C4wjgSCHVJOS1M3mdKSZKXEOoYB83jDMKmU/bh7nZMTq9dq0r9Ec+kYUtMj4C
         lDtAEQhv0s9brMuT/6LeaEXaGUGqo1hiAv5L5TcPYEXm1z/3NAczE3ckyxpJVcLHAxRA
         Kc0+U1kaXCeqQgdb/Su7C/2wQbhRY8haUMtC8suNfgnzx0qtsICZqNmWvXOaBasKk7C+
         LAcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743606013; x=1744210813;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2J8joh1VpJXVXk10JwyK7VqgRVaiZvDDPRWTBkdJC/Q=;
        b=nxgUGtzsfUKhUua8K4B/HwQIwymw1+t8W/Rxpkv9vdwS6kEmIokwO8TElsi7Blc0EN
         0RfmSRHK4iqj6rhzbJyPAktjUpkhDrRgeBghZ2v5a4YoT4KFGSgruKGlL05Gf4u2eKfM
         qX0STI+Ix9Mvk5ghLPpdgkNXJ8qVy/ixJRzkQpbBKfE+Dg/kjywvuepJ46s6Qw7ptyjV
         HJYMReNp+pRCUDze01qtbKpnzl8EUW/+8duBpMxvudjWJ4tvgcC6W+frCm4j5uPyIWCK
         Mu5koTGJMVfUmblGRhwOR0gwwBUXfjvSapDleGjcgc9YbMIp3vfg7AVjvPGE2oyUWjPF
         y/nA==
X-Forwarded-Encrypted: i=1; AJvYcCXNhgcZQxH5WUYhwytF1bn8I1WJHvWEcqNLa8qH8y/78UKAx7dBD/eDWhfKSL9luBW2SNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzimWofl3pKu70vaLabUVdaJPMI9SD0M7wX9W1RiJP9E/82rwIb
	yLfFSACLOJmmTEl3sG1i731EbHOdES3l1nDVBLT1RTkzZfzSpsh0
X-Gm-Gg: ASbGncuzUZKAuhFk2yaDQAqQRtLfhtz8blXH3n9HYX9h6LgIxQIDyqtYpuooCdeSbFi
	7VK9N5HGoaYQxFI4vi0UOduf80NtCnjn3q3DR+7BH3k24vE+ExkOIZ4oR2DGSFZ4JdDwvH5OfUY
	FnsAwTy7gvzWXbZRQMC4AyyiWQFSckOxSrMG4dkGO5j+eAP8EhB9g9HmLbmZ/WYNkoqWdw1J9qZ
	Dwvn6xKNL4wtWYn7G91sgrckM7y+IxqYYAPbW0puL9vIxoXl98z+Lq76bmfxHnJ9eok7T7LC5TG
	7uT+lCIHgtWbz83TrtVy9E7r/iCOqAGLFWRR+w==
X-Google-Smtp-Source: AGHT+IG6mqP23cWsV6AjVsgUtM2aPNkrW6jdMH711OY71T8DfxhQiwOdFs3+D5vFPytB6eZBZbH33A==
X-Received: by 2002:a05:6830:61c2:b0:72a:b78:1c5a with SMTP id 46e09a7af769-72e281d72c3mr1178066a34.10.1743606013005;
        Wed, 02 Apr 2025 08:00:13 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-72c5828b43csm2283937a34.59.2025.04.02.08.00.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 08:00:12 -0700 (PDT)
Date: Wed, 2 Apr 2025 09:56:24 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] help: include SHA implementation in version info
Message-ID: <rqytnnncju5pezkfidhd7u7vtaaop5fga7f5nyzwa74eiksezs@4t46ypevaiga>
References: <20250328170121.157563-1-jltobler@gmail.com>
 <20250401203630.285451-1-jltobler@gmail.com>
 <20250401203630.285451-2-jltobler@gmail.com>
 <Z-zpY3D01Fg4q0Je@pks.im>
 <CAP8UFD2UpEpqBYxqeo=vkDHwWdoO9v2RPVtnUBSOUS5MOK6n0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD2UpEpqBYxqeo=vkDHwWdoO9v2RPVtnUBSOUS5MOK6n0Q@mail.gmail.com>

On 25/04/02 01:26PM, Christian Couder wrote:
> On Wed, Apr 2, 2025 at 9:38 AM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > On Tue, Apr 01, 2025 at 03:36:29PM -0500, Justin Tobler wrote:
> > > diff --git a/Documentation/git-version.adoc b/Documentation/git-version.adoc
> > > index 80fa7754a6..f06758a7cf 100644
> > > --- a/Documentation/git-version.adoc
> > > +++ b/Documentation/git-version.adoc
> > > @@ -22,6 +22,9 @@ OPTIONS
> > >  --build-options::
> > >       Include additional information about how git was built for diagnostic
> > >       purposes.
> > > ++
> > > +Note that the SHA1 options `SHA1_APPLE`, `SHA1_OPENSSL`, and `SHA1_BLK` do not
> > > +have collision detection.
> >
> > I think this note is somewhat funny for an unsuspecting reader. On the
> > one hand they're going to be puzzled why you're talking about SHA1 in
> > the first place because it isn't mentioned at all beforehand. And on the
> > other hand they will wonder what collision detection even is in the
> > first place.
> >
> > So I would either drop this paragraph completely or expand it to give a
> > bit more context.
> 
> Yeah, I think it's worth giving more information, like perhaps:
> 
> "For the libraries used to implement the SHA-1 and SHA-2 algorithms
> only symbolic information, like `SHA-1: SHA1_APPLE` or `SHA-256:
> SHA256_NETTLE` is displayed. Note that the SHA1 options `SHA1_APPLE`,
> `SHA1_OPENSSL`, and `SHA1_BLK` mean that no collision detection
> algorithm is used, so known SHA-1 attacks might be possible, see
> https://en.wikipedia.org/wiki/SHA-1."

Ya the documentation here should be expanded to provide some more
context. I'll adapt in my next version to something like this:

"The libraries used to implement the SHA-1 and SHA-256 algorithms are
displayed in the form `SHA-1: <option>` and `SHA-256: <option>`
respectively. Note that the SHA-1 options `SHA1_APPLE`, `SHA1_OPENSSL`,
and `SHA1_BLK` do not use a collision detection algorithm and thus may
be vulnerable to known SHA-1 collision attacks."

-Justin
