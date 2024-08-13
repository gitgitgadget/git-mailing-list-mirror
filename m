Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8E37F8
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 00:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723509914; cv=none; b=Imo2VsOSyPDMyEpkGtSWuM+4Dx5/LLWu9wzIuQSP4lsPNdent1Ly8pegE+OkNUOJjZ/Ur+ZQYi2sW+bsfMt0QyGoL9CXlwD4J0/DCDauWR4mNasf+e3GGpkR2QZ+OmUD82X2FePRF3ggi/HeiGKXayQWQa4Hg7+bW3qxjGTa6Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723509914; c=relaxed/simple;
	bh=Hzf6afEb2u6r0kLtVp3rowyQTMAjsBY/GFWX2CzdGKU=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=QvUkjpo43WDZbQTCM0T31vxiXndv0yZt6a9uu/eCowP3WmCtk3lUSxI9XKYzBNetaMPLAvSMfgGgpTnVqOGgdHXJQQsPhzVSyn5U4ty0+LIgegeqztjYinhH+vJ48BkffZvDkLuq8Po9/NLs/Z2TOJ33djqJiz6rnSdFhONggLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0w4IBCUs; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0w4IBCUs"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0e78047c98so7974565276.3
        for <git@vger.kernel.org>; Mon, 12 Aug 2024 17:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723509912; x=1724114712; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ST9uH8Nz45LVH4pBFvbVMwaFCIRRxuSwUMVl3k+ln3g=;
        b=0w4IBCUs/fv/jSY6h7lFfzDJXQ2+GvgskfLIuUyvy0rJFPAU97MloClWY+qMwE46oo
         K9LxWPwZsZ2VBAPnWJSD84CYClTY6X7F8yo3oftJSZFKGfH2uiMofyhw5w51jPaziC1S
         3vnpXGEjU7MqOm1t7Nx07/H2xtN9FAoVZyYRylFiFtyM05K8I30SdKiJrqIL1gYjC0gs
         604tZ5i/ih8M0Z14mMoO4BJer+v7pQ0/9999zemDhe5uCTnfGAVXl3+odLf1ppvBCpCf
         f7wp1IdciakA/9Hh8ZcjZwB0fdlQzZ7fQpjM0nyFycTYNSfd/2o467Dh3h1TTtKtzASW
         H7IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723509912; x=1724114712;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ST9uH8Nz45LVH4pBFvbVMwaFCIRRxuSwUMVl3k+ln3g=;
        b=u3D+x9PpO5fKpshe6WJmQZ+ME1YTSl9fMU/mGKHNItXvdzxctQae70mbQOWra6muPF
         cew7kdnpOII7fyj8cansj49tH3YvLrIcY54MhHwC3jb5R0t5JdA9swHqFEn7ZdxXDzL3
         FFYoQkXHRjLkDz7Rkln7T3pu/ICwDyjVpQzoE0d7IQXNGtDc0fkfMkkork90qYwzzi0s
         piNy+ndLlpWXnjcUITrlzuvNukisbiJAP/IB/qYgb1QbbMmio6tgJxZwn4nr4Fw7JJ5t
         dP1VvhJJIUdIOMjynoDUQHHVjfZY2Egt8hQwKOv8E3fltIF4/AQR3EGLpLKG9DalqfGG
         DVOw==
X-Forwarded-Encrypted: i=1; AJvYcCXBKdqmCWp3VI0CiUwE2TOagLqw/LgXEqexUBt+niK0cfv7ExtVTCm2+y7lrSIs+/VxhjjpIg6xvmhnj8O+tus544GZ
X-Gm-Message-State: AOJu0YzXvgvB/GDstF3kUePRWK2yVr+apJGyLS8Fo2tJZf70C6zmoTSL
	aY5DHc09Uz4jVUrsHEtBNOnaKbARwnrsqUhnOPpE9Qiv8CCXVyoO4t/6KJalI+hjNx1+vNva4KO
	j/1Ko9/0ZW2liBJJMtbAOEjY4ZpbvhA==
X-Google-Smtp-Source: AGHT+IFilqs+5PUVd2Gx+lRcZM5D9DVUo7OGQ+Gl/BouA6wdqsl/dFGV1F0yG0+si7fCS14qzv/KzkEwCAdYvpHZVSF2
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:95c1:e6e6:7744:c903])
 (user=jonathantanmy job=sendgmr) by 2002:a25:48c6:0:b0:e0e:a784:2957 with
 SMTP id 3f1490d57ef6-e113cd54e27mr52065276.1.1723509911786; Mon, 12 Aug 2024
 17:45:11 -0700 (PDT)
Date: Mon, 12 Aug 2024 17:45:08 -0700
In-Reply-To: <20240802073143.56731-1-hanyang.tony@bytedance.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240813004508.2768102-1-jonathantanmy@google.com>
Subject: Re: [PATCH 0/1] revision: fix reachable objects being gc'ed in no
 blob clone repo
From: Jonathan Tan <jonathantanmy@google.com>
To: Han Young <hanyang.tony@bytedance.com>
Cc: Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org, gitster@pobox.com, 
	xingxin.xx@bytedance.com, jeffhostetler@github.com
Content-Type: text/plain; charset="UTF-8"

Han Young <hanyang.tony@bytedance.com> writes:
> Here are the minimal steps to recreate issue.
[snip]

I think the following is what is happening. Before the final gc, the
repo looks as follows:

  commit  tree  blob
   C3 ---- T3 -- B3 (fetched from remote, in promisor pack)
   |
   C2 ---- T2 -- B2 (created locally, in non-promisor pack)
   |
   C1 ---- T1 -- B1 (fetched from remote, in promisor pack)

After the final gc, {C,T,B}3 and {C,T,B}1 are in a promisor pack, but
all of {C,T,B}2 are deleted because they are thought to be promisor
objects.

> The last `git gc` will error out on fsck with error message like this:
> 
>   error: Could not read d3fbfea9e448461c2b72a79a95a220ae10defd94
>   error: Could not read d3fbfea9e448461c2b72a79a95a220ae10defd94

I'm not sure how `git gc` (or `git fsck`) knows the name of this
object (what is the type of this object, and which object refers to
this object?) but I think that if we implement one of the solutions I
describe below, this problem will go away.

> `git gc` will call `git repack`, which will call `git pack-objects`
> twice on a partially cloned repo. The first call to pack-objects 
> combines all the promisor packfiles, and the second pack-objects 
> command packs all reachable non-promisor objects into a normal packfile.

Yes, this is what I remember.

> However, a bug in setup_revision caused some non-promisor objects 
> to be mistakenly marked as in promisor packfiles in the second call 
> to pack-objects.

I think they ({C,T,B}2 in the example above) should be considered as
promisor objects, actually. From the partial clone doc, it says of a
promisor object: "the local repository has that object in one of its
promisor packfiles, or because another promisor object refers to it".
C3 (in a promisor packfile) refers to C2, so C2 is a promisor object. It
refers to T2, which refers to B2, so all of them are promisor objects.
However, in the Git code, I don't think this definition is applied
recursively - if I remember correctly, we made the assumption (e.g.
in is_promisor_object() in packfile.c) that we only need to care about
objects in promisor packfiles and the objects they directly reference,
because how would we know what objects they indirectly reference?
But this does not cover the case in which we know what objects they
indirectly reference because we pushed them to the server in the first
place.

Solutions I can think of:

 - When fetching from a promisor remote, never declare commits that are
   not in promisor packfiles as HAVE. This means that we would refetch
   C2 and T2 as being in promisor packfiles. But it's wasteful in
   network bandwidth, and does not repair problems in Git repos created
   by Git versions that do not have this solution.

 - When fetching from a promisor remote, parse every object and repack
   any local objects referenced (directly or indirectly) into a promisor
   packfile. Also does not repair problems.

 - When repacking all objects in promisor packfiles, if any object they
   refer to is present in a non-promisor packfile, do a revwalk on that
   object and pack those objects too. The repack will probably be slower
   because each object now has to be parsed. The revwalks themselves
   probably will not take too long, since they can stop at known promisor
   objects.

(One other thing that might be considered is, whenever pushing to a
promisor remote, to write the pack that's pushed as a promisor packfile.
But I don't think this is a good idea - the server may not retain any
packs that were pushed.)
