Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E389921C182
	for <git@vger.kernel.org>; Thu,  5 Dec 2024 15:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733412563; cv=none; b=CuLn43giqLYpW+ejP+BQp8u/xuOcm5GXgN5Mp//uS5nCWeK4RY2Ts7tNYV2hmlvp3gDMfBHCYpWnXYwEjAtTns47c7xVQ331nvB2k16CLxKIudC+UE3OTcGDbqUaYwdv0MdWFjPAPuoq5Z+McNW9xNmdWlyVcVAa0rocsGPauX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733412563; c=relaxed/simple;
	bh=tBBvBw0ApylK8ox/mF4ZStZwGux8vmdhiiB7xlSbLxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XcYCWRUveP134HOa1k5WyqLQYi5xhFoue8hKkxz8j/qrQeG8vJ71IoZ9lr1IO6522MQ8mzAICN0nKNtHVBDlK0vwt9L1feJefX32szeLjkqqJ8fiwSk9q/gJ36J4X9v5kihMEDg/LWl0Sa+mrlC15j4y9WIW2HmFdDRiGglb/lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fEmAnOYH; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEmAnOYH"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3ea467fda32so332805b6e.1
        for <git@vger.kernel.org>; Thu, 05 Dec 2024 07:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733412561; x=1734017361; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2XFBaQKMdu8DbMi27N0FmhyibQHyO8S01emxt+9KfIo=;
        b=fEmAnOYHZmkRGCfl60eZDZ+THceNdOvJ8dAaGxPMJgaAWs8aNq4l24qW+S+KvGH2T2
         +Vw1a9bN+ILMFZ5jz31K+EKnOoBE4UDJPDzrY4lZSsDaMPUzkJeOGaUopTSRPge98A0t
         UXfVN8CpUzrDROjpDcXmr0CiANQqPYxhy9Q+CgRisK1Cy4f3OD8cuO3GO0xNLdulO5XK
         9gAOMG6daPyzNg5k7OvGM0AcXL3uq963HYrwrPRoGQfRa0ScU5NsFI6lckVQVDw/cV+j
         L7zMs/7x62RyUD0D5gbMAjQX5IRqxoCYrUE8gVhWKzsPPAkc85M60p3+6bMwgVHo84BO
         bH9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733412561; x=1734017361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2XFBaQKMdu8DbMi27N0FmhyibQHyO8S01emxt+9KfIo=;
        b=bNHxrvVaFWUpNoc6QDFzqb2j0Uq/ggCfeGncor0ZAgZSZHtl86FUA+jEaNoLG2N49b
         rCTLem3U4BQlZ7MZ/h3MaJ1jVKCUX6QUZi5Qm9+DNxouu5m9qPb4CX+v2CtvjF4uEBds
         0DZC+/YPys4HfEDxraWYuDgrsrftZmhRd7tCkhKPvAjUPjtW3Ja5GRjKFjMU62Z4z4EH
         59i9BNiB6kqw/zabgAjGEc/97NwuREJyfv1RKTO0x37UYmP7cnxO3TvX5nqRfQgdpVf1
         Rg4Mc3buDWdylopSw0vw8H+2Q/Y3tlIZCn3DsclBaCe3GUCSOcdvsIitdrL1JLQykAN7
         Qcng==
X-Forwarded-Encrypted: i=1; AJvYcCV7mIYXsQ3HbyEtr4QJ1p+aESs7XanshSAVyBdjKBJ7DU+hjRaMGOCxbr6JaLJbQr7NMi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQwXwFFBhBgBhcbdVg1fVHh/WTozhgh+Ub9fgf3TwzOqxbFvkq
	zuwXkrmdU+6fQxXXq/Fy2KsbOwuyEpy61GWx+3uN4n4bIoNLZCBq
X-Gm-Gg: ASbGncvLUjLgrKmlJFs/WVRng3+loYLFglB4PDayUPoVDhFwda8VP/bMHl9VhvZzXTb
	Z0x0wz0DLwhYoxbdUopUMWPTUb/fj2ZhvQURX4ypR4eQQvF3A/ribDOHzFpqtSu45R2SWpvLV47
	Qj0I8j1RcXJCir9CKxX/o4eNhy+u2PItvKKiws4dZPaJ+KI4Bebn8k6lkJmzmxSgS7zBdTJIG9N
	R8/02GqyFxdWKWNq9l3Htj9biZoSlI4mvib4fG+bTs=
X-Google-Smtp-Source: AGHT+IHqAPrTaZ3U2PGDVqMHAL3r3nG5d3c8/+uRBDeV1azxJHhPRQvm7suKhHHEC4RFk35fpvvrVw==
X-Received: by 2002:a05:6830:2a0d:b0:715:4e38:a1ab with SMTP id 46e09a7af769-71dad6d2d70mr7555890a34.22.1733412560860;
        Thu, 05 Dec 2024 07:29:20 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71dc4a02668sm303806a34.50.2024.12.05.07.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 07:29:20 -0800 (PST)
Date: Thu, 5 Dec 2024 09:27:15 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Sainan <sainan@calamity.inc>, 
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Some feedback on 'git clone create'
Message-ID: <6okfwtbgcve77xwjdqjnvsa4yigo5tymlsrypjgztbrmabjtrz@o7dfhaltih35>
References: <AfLIcOv4X1AxLOaODNS89HA-bMeI7bj0xUGsLD-6xmVAS_a_2xOzy2uX-wXxpNA7kCpKYudELCEKv73roW_-HTd83Fcz3FZ_yJQOswQHW48=@calamity.inc>
 <pgz37cgfssouykfqxvmjt6pc2lycta6tmyjkovsceqwibww4fw@424usnt3dlh2>
 <Z1Fma7OLPOkxRncd@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1Fma7OLPOkxRncd@pks.im>

On 24/12/05 09:38AM, Patrick Steinhardt wrote:
> On Wed, Dec 04, 2024 at 05:19:53PM -0600, Justin Tobler wrote:
> > On 24/12/04 05:28AM, Sainan wrote:
> > > Hi, I hope this email finds you well.
> > > 
> > > I think Git bundles/packfiles are an exceptional compression format, but I find there are some rough edges with the tool to create them:
> > > 
> > > 1. There is no way to specify that you want a shallow bundle, instead you are only able to a) pack the entire tree at a given head or b) pack new/updated objects in a specified range. Anecdotally, this could store data in ~67% of the size of an equivalent .zip file.
> > 
> > You can create an incremental bundle covering a specified range.
> > Something like the following example might help you achieve what you are
> > looking for:
> > 
> >   $ git bundle create inc.bundle main~10..main
> 
> Yup. The thing that might not be immediately obvious is that
> git-bundle(1) accepts git-rev-list(1) arguments, so you can influence
> what is and isn't included via that. You can for example even generate
> partial bundles without blobs:
> 
>     $ git bundle create partial.bundle main~10..main \
>         --filter=blob:none
> 
> What you can do with the resulting bundle might be a different story.

When trying to unbundle an incremental bundle into a repository that
lacks the prerequisite objects, Git fails. These prerequisite objects
are also listed in the bundle header. Maybe it would be nice if we were
able to create a shallow repository from this bundle.

> 
> > > 2. It seems that when specifiying a commit hash, it raises an error:
> > > $ git bundle create repo.bundle $(git rev-list HEAD | head -n 1)
> > > > fatal: Refusing to create empty bundle.
> > > This confuses me slightly because I thought a commit hash should also be a valid head _pointer_. 'git rev-list' also seems to agree with me on this.
> > 
> > A bundle is essentially a pack file with a header indicating the
> > references contained within the bundle. If no reference is provided, the
> > bundle is considered empty and git refuses to create it. I think this
> > makes sense in the context of unbundling as you probably would not want
> > to add new objects without updating references in the target repository.
> > 
> > From the git-bundle(1) docs for "create", the usage does say it accepts
> > <git-rev-list-args> which may be a bit misleading because
> > git-rev-list(1) does consider the commit hash as valid. Maybe that
> > should be updated to indicate that proper references are expected.
> 
> That's somewhat weird indeed. I don't see a strong reason why the first
> of the following commands works while the second one doesn't:
> 
>     $ git bundle create inc.bundle master~..master
>     $ git bundle create inc.bundle $(git rev-parse master~)..$(git rev-parse master)
> 
> It's not like the bundle has "master" in its header in the first command
> anyway, it only lists HEAD in there. So I'd claim that we could do the
> same for the second command, as well.

I'm not quite sure I follow. According to gitformat-bundle(5), we should
see "obj-id SP refname LF" in the header. Inspecting the header of a
bundle created from `git bundle create inc.bundle master~..master` also
shows "refs/heads/master" in the header.

Looking at git-bundle(1) docs more closely it also does mention this
limitation:

       A revision name or a range whose right-hand-side cannot be
       resolved to a reference is not accepted:

           $ git bundle create HEAD.bundle $(git rev-parse HEAD)
           fatal: Refusing to create empty bundle.
           $ git bundle create master-yesterday.bundle master~10..master~5
           fatal: Refusing to create empty bundle.

It looks like when creating a bundle in `bundle.c:create_bundle()`, if
the call to `write_bundle_refs()` returns a reference count of 0, git
dies with the error seen. When a commit hash is used for the
rev-list-arg, it is not able to determine a reference from it.

-Justin
