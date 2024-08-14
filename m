Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C667762D2
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 04:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723611433; cv=none; b=tynIxeEAFMkoQ81prFABVQPF+/KymOzZLr9nwRXqj2oC1JT7Mv3/sP54lTHzh8wOXsgTkQKXXCF48eseCn9aMrD0cQSqzHcnV7i04Z+OmJAsDlZaqeb1GqwguC9fTb4DWgj95dI4qcflyO8hcduSGeL4b5kOha9ZGy9qcnw8ygU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723611433; c=relaxed/simple;
	bh=D3FcXCTFwVqlcTRGRjLHBfzD9q6NBSj+s95YwHwIsTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d/5GonDTwmaW3HRKpqVVr9WyXSG4fegl6hfRYRHZi04tVkOyXNKWyaNiSx1Hs4ZhoRhCFIn6KN69fzqaV9xw3pB0l6QqzImehkaJ7ltOi8dNl+MANbFLWhaauqahikVR11HsDLRmiY/ZFiKhuz3Z4GTkAcayZRP2GXdegyokKWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XMJf3GLQ; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XMJf3GLQ"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a7ad02501c3so743821866b.2
        for <git@vger.kernel.org>; Tue, 13 Aug 2024 21:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723611430; x=1724216230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D3FcXCTFwVqlcTRGRjLHBfzD9q6NBSj+s95YwHwIsTM=;
        b=XMJf3GLQnj6qmur10P2Q/AUJcbjWh0/B8e0pUcC8NePlpjArnBtS0EcAR0vWXxeB5+
         FXOfZqOMU5RHCvOG97PATX2gpC2WCZn3LwhyJTiIYKLVW13IXzYpkuvPjvQkHibvTPMw
         4GT8sb2cJsR/vf6n1i/hF2ocHiwfDJ69D1FanicxSmql5f+fuyXv2eH3+JdtEd2/AqUO
         fp7jGXtJ96PM9Zhf/EQyzOYfesjGNerdeMXHX0nbVrwcDboIprMUMPxpQUDeRDo00J38
         tR6iMDr+Ps6BIaVYjqup8lFaIpQ5inntjgJIceSbFxX5+ExAiDGSlnKF+j2FK1TH6W8e
         p68Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723611430; x=1724216230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D3FcXCTFwVqlcTRGRjLHBfzD9q6NBSj+s95YwHwIsTM=;
        b=fBikUD67R4Qe4ajd5SQ3MYZ0qS/aywaOchxz+8q9s4D6LZUJ+VB3RzR3Tb9rodkiFJ
         C3AT80n6xY0aJTD+30RfNGlKY0Mm0wjryrXVUUAKasoKtUkI4dzRZHmJsk5shi4XIftu
         XHETJN5sG+hMcS4m2eJaOJ9+yrP9r/MuJ9eU7SCGoErJ0skh5XdD5dsFRPd+KqUmz0vn
         GgKB1o91TbCWXcgA9bigQz7iXGjaV0zBnojtes5grmK5WUX6RuxJDcqAROJ/mSyMtlYj
         Wp1NHLjV8lYb1jBGy+giM7gWza5dHOGZZpMhT1NtrLYqFWByVj3+AAQxTCzXcqhMZAsY
         Klrw==
X-Gm-Message-State: AOJu0YyumAzSihjMiRj+u+CtWJMULb1CiSjBfAQYgZ9Fw/btg1AoFg2T
	iBvBz75WfjAMvj1VVRsTd8vaRLu1/9UDG81f5XDaY8ef1/4JvImWWwXid8/Xi/Xa4k/11TDEtZA
	lSJPnXL9MQvkgFsIHutIcHp5Cla30V8oy
X-Google-Smtp-Source: AGHT+IHG9ev6th9XNFTY9PNDxrhumqqXofQcPj+05KOydVOmzapMk+PgGfBFFkknhdGnJAUp20Pxf1Ex2Ghx8nKDK7Q=
X-Received: by 2002:a17:907:c7d8:b0:a7a:ab8a:38a with SMTP id
 a640c23a62f3a-a8366d39b60mr105485366b.27.1723611429414; Tue, 13 Aug 2024
 21:57:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANrWfmR2sB8abN3tjuavu-sDwuENMh3DPdFKS9fXan_1kYURPA@mail.gmail.com>
 <20240813131614.GF968816@coredump.intra.peff.net>
In-Reply-To: <20240813131614.GF968816@coredump.intra.peff.net>
From: Han Jiang <jhcarl0814@gmail.com>
Date: Wed, 14 Aug 2024 16:56:58 +1200
Message-ID: <CANrWfmQw4pG6Dz3kCPqc-P4wLKm_VqyHmb+4MwKgfCUUaN5bzw@mail.gmail.com>
Subject: Re: git clone --reference=<repository> (without --dissociate),
 forgets to copy/get_pack_of objects from <repository> when
 "--no-local"/"file://" is present
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you for pointing out the error! My commands' use of git is
incorrect, so the results don't make sense.
I will post the corrected commands here in case anyone needs them.

1. git clone --reference=3D<repository>, then the referenced repository
is updated (e.g. amend/rebase), how to keep up to date:

cd '/'; cd '/'; rm --force --recursive -- './test_git'; mkdir "$_"; cd "$_"=
;
mkdir --parents -- './server' './client';

git -C './server' init --bare './repo.git'
git --git-dir=3D'./server/repo.git' --work-tree=3D'.' commit --allow-empty
-m "$((++number))"
find './server/repo.git/objects' -printf '%p %n\n'

git -C './client' clone --shared '../server/repo.git' './repo1'
find './server/repo.git/objects' -printf '%p %n\n'

git -C './client' clone --shared --local '../server/repo.git' './repo2'
find './server/repo.git/objects' -printf '%p %n\n'

git -C './client' clone --shared --no-local '../server/repo.git' './repo3'
find './server/repo.git/objects' -printf '%p %n\n'

git -C './client' clone --shared 'file://'"$(realpath
'./server/repo.git')" './repo4'
find './server/repo.git/objects' -printf '%p %n\n'

cp --recursive --no-target-directory -- './server/repo.git'
'./client/mirror.git/'

git -C './client' clone --reference=3D'./mirror.git'
'../server/repo.git' './repo5'
find './server/repo.git/objects' -printf '%p %n\n'

git -C './client' clone --reference=3D'./mirror.git' --local
'../server/repo.git' './repo6'
find './server/repo.git/objects' -printf '%p %n\n'

git -C './client' clone --reference=3D'./mirror.git' --no-local
'../server/repo.git' './repo7'
find './server/repo.git/objects' -printf '%p %n\n'

git -C './client' clone --reference=3D'./mirror.git'
'file://'"$(realpath './server/repo.git')" './repo8'
find './server/repo.git/objects' -printf '%p %n\n'

git -C './client' clone --reference=3D'./mirror.git' --dissociate
'../server/repo.git' './repo9'
find './server/repo.git/objects' -printf '%p %n\n'

git -C './client' clone --reference=3D'./mirror.git' --dissociate
--local '../server/repo.git' './repo10'
find './server/repo.git/objects' -printf '%p %n\n'

git -C './client' clone --reference=3D'./mirror.git' --dissociate
--no-local '../server/repo.git' './repo11'
find './server/repo.git/objects' -printf '%p %n\n'

git -C './client' clone --reference=3D'./mirror.git' --dissociate
'file://'"$(realpath './server/repo.git')" './repo12'
find './server/repo.git/objects' -printf '%p %n\n'

tree './client/repo1/.git/objects'
tree './client/repo2/.git/objects'
tree './client/repo3/.git/objects'
tree './client/repo4/.git/objects'
tree './client/repo5/.git/objects'
tree './client/repo6/.git/objects'
tree './client/repo7/.git/objects'
tree './client/repo8/.git/objects'
tree './client/repo9/.git/objects'
tree './client/repo10/.git/objects'
tree './client/repo11/.git/objects'
tree './client/repo12/.git/objects'

git -C './client/repo1' log
git -C './client/repo2' log
git -C './client/repo3' log
git -C './client/repo4' log
git -C './client/repo5' log
git -C './client/repo6' log
git -C './client/repo7' log
git -C './client/repo8' log
git -C './client/repo9' log
git -C './client/repo10' log
git -C './client/repo11' log
git -C './client/repo12' log

git -C './server/repo.git' cat-file --batch-check --batch-all-objects
git --git-dir=3D'./server/repo.git' --work-tree=3D'.' commit --amend
--allow-empty -m "$((++number))"
git -C './server/repo.git' cat-file --batch-check --batch-all-objects
git -C './server/repo.git' -c 'gc.pruneExpire=3Dnow' -c
'gc.reflogExpireUnreachable=3Dnow' gc
git -C './server/repo.git' cat-file --batch-check --batch-all-objects
git -C './client/repo1' log
git -C './client/repo2' log
git -C './client/repo3' log
git -C './client/repo4' log
git -C './client/repo5' log
git -C './client/repo6' log
git -C './client/repo7' log
git -C './client/repo8' log
git -C './client/repo9' log
git -C './client/repo10' log
git -C './client/repo11' log
git -C './client/repo12' log

rm --force --recursive -- './client/mirror.git/'
cp --recursive --no-target-directory -- './server/repo.git'
'./client/mirror.git/'
git -C './client/repo1' log
git -C './client/repo2' log
git -C './client/repo3' log
git -C './client/repo4' log
git -C './client/repo5' log
git -C './client/repo6' log
git -C './client/repo7' log
git -C './client/repo8' log
git -C './client/repo9' log
git -C './client/repo10' log
git -C './client/repo11' log
git -C './client/repo12' log

git -C './client/repo7' branch --all --verbose --verbose
git -C './client/repo7' branch --all --verbose
git -C './client/repo7' branch --all
git -C './client/repo7' update-ref -d 'refs/heads/main'
git -C './client/repo7' update-ref -d 'refs/remotes/origin/main'
git -C './client/repo7' pull
git -C './client/repo7' branch --all --verbose --verbose
tree './client/repo7/.git/objects'

git -C './client/repo8' branch --all --verbose --verbose
git -C './client/repo8' branch --all --verbose
git -C './client/repo8' branch --all
git -C './client/repo8' update-ref -d 'refs/heads/main'
git -C './client/repo8' update-ref -d 'refs/remotes/origin/main'
git -C './client/repo8' pull
git -C './client/repo8' branch --all --verbose --verbose
tree './client/repo8/.git/objects'

2. git clone --reference=3D<repository>, then the referenced repository
is removed (e.g. rm), how to switch back to
not-referencing-the-repository mode:

cd '/'; cd '/'; rm --force --recursive -- './test_git'; mkdir "$_"; cd "$_"=
;
mkdir --parents -- './server' './client';

git -C './server' init --bare './repo.git'
git --git-dir=3D'./server/repo.git' --work-tree=3D'.' commit --allow-empty
-m "$((++number))"
find './server/repo.git/objects' -printf '%p %n\n'

git -C './client' clone --shared '../server/repo.git' './repo1'
find './server/repo.git/objects' -printf '%p %n\n'

git -C './client' clone --shared --local '../server/repo.git' './repo2'
find './server/repo.git/objects' -printf '%p %n\n'

git -C './client' clone --shared --no-local '../server/repo.git' './repo3'
find './server/repo.git/objects' -printf '%p %n\n'

git -C './client' clone --shared 'file://'"$(realpath
'./server/repo.git')" './repo4'
find './server/repo.git/objects' -printf '%p %n\n'

cp --recursive --no-target-directory -- './server/repo.git'
'./client/mirror.git/'

git -C './client' clone --reference=3D'./mirror.git'
'../server/repo.git' './repo5'
find './server/repo.git/objects' -printf '%p %n\n'

git -C './client' clone --reference=3D'./mirror.git' --local
'../server/repo.git' './repo6'
find './server/repo.git/objects' -printf '%p %n\n'

git -C './client' clone --reference=3D'./mirror.git' --no-local
'../server/repo.git' './repo7'
find './server/repo.git/objects' -printf '%p %n\n'

git -C './client' clone --reference=3D'./mirror.git'
'file://'"$(realpath './server/repo.git')" './repo8'
find './server/repo.git/objects' -printf '%p %n\n'

git -C './client' clone --reference=3D'./mirror.git' --dissociate
'../server/repo.git' './repo9'
find './server/repo.git/objects' -printf '%p %n\n'

git -C './client' clone --reference=3D'./mirror.git' --dissociate
--local '../server/repo.git' './repo10'
find './server/repo.git/objects' -printf '%p %n\n'

git -C './client' clone --reference=3D'./mirror.git' --dissociate
--no-local '../server/repo.git' './repo11'
find './server/repo.git/objects' -printf '%p %n\n'

git -C './client' clone --reference=3D'./mirror.git' --dissociate
'file://'"$(realpath './server/repo.git')" './repo12'
find './server/repo.git/objects' -printf '%p %n\n'

tree './client/repo1/.git/objects'
tree './client/repo2/.git/objects'
tree './client/repo3/.git/objects'
tree './client/repo4/.git/objects'
tree './client/repo5/.git/objects'
tree './client/repo6/.git/objects'
tree './client/repo7/.git/objects'
tree './client/repo8/.git/objects'
tree './client/repo9/.git/objects'
tree './client/repo10/.git/objects'
tree './client/repo11/.git/objects'
tree './client/repo12/.git/objects'

git -C './client/repo1' log
git -C './client/repo2' log
git -C './client/repo3' log
git -C './client/repo4' log
git -C './client/repo5' log
git -C './client/repo6' log
git -C './client/repo7' log
git -C './client/repo8' log
git -C './client/repo9' log
git -C './client/repo10' log
git -C './client/repo11' log
git -C './client/repo12' log

rm --force --recursive -- './client/mirror.git/'
git -C './client/repo1' log
git -C './client/repo2' log
git -C './client/repo3' log
git -C './client/repo4' log
git -C './client/repo5' log
git -C './client/repo6' log
git -C './client/repo7' log
git -C './client/repo8' log
git -C './client/repo9' log
git -C './client/repo10' log
git -C './client/repo11' log
git -C './client/repo12' log

git -C './client/repo7' branch --all --verbose --verbose
git -C './client/repo7' branch --all --verbose
git -C './client/repo7' branch --all
rm './client/repo7/.git/objects/info/alternates'
git -C './client/repo7' branch --all --verbose --verbose
git -C './client/repo7' branch --all --verbose
git -C './client/repo7' branch --all
git -C './client/repo7' update-ref -d 'refs/heads/main'
git -C './client/repo7' pull
git -C './client/repo7' branch --all --verbose --verbose
tree './client/repo7/.git/objects'

git -C './client/repo8' branch --all --verbose --verbose
git -C './client/repo8' branch --all --verbose
git -C './client/repo8' branch --all
rm './client/repo8/.git/objects/info/alternates'
git -C './client/repo8' branch --all --verbose --verbose
git -C './client/repo8' branch --all --verbose
git -C './client/repo8' branch --all
git -C './client/repo8' update-ref -d 'refs/heads/main'
git -C './client/repo8' pull
git -C './client/repo8' branch --all --verbose --verbose
tree './client/repo8/.git/objects'

On Wed, Aug 14, 2024 at 1:16=E2=80=AFAM Jeff King <peff@peff.net> wrote:
>
> On Tue, Aug 06, 2024 at 09:37:33AM +1200, Han Jiang wrote:
>
> > What did you do before the bug happened? (Steps to reproduce your issue=
)
> >
> > (repo7 and repo8 should behave similar to repo5 and repo6, i.e. setup
> > ".git/objects/info/alternates" && copy/get_pack_of objects;)
> > (repo7 and repo8 shouldn't: forget to copy/get_pack_of objects.)
> > (The problem only surfaces after "./client/mirror.git/" is removed:
> > repo7 and repo8 should have the original objects (so git log shouldn't
> > give error) but they don't have.)
>
> I don't think this expectation is correct. Using "--reference" without
> "-dissociate" creates a dependency on the mirror repository. It's not
> safe to delete it. This is discussed in the "--shared" description of
> git-clone(1), and the "--reference" description refers to it.
>
> So in your example:
>
> > git -C './client' clone --reference=3D'./mirror.git' --no-local '../ser=
ver/repo.git' './repo7'
>
> I would not expect repo7 to have any objects. Its needs were satisfied
> by the mirror, and when it told the upload-pack process running in
> server/repo.git what it had, that process knew that it did not need to
> send any objects.
>
> It's actually your repo5 and repo6 that are the oddballs:
>
> > git -C './client' clone --reference=3D'./mirror.git' '../server/repo.gi=
t' './repo5'
>
> Here since we are cloning a local-file repo, we take a shortcut and do
> not do any object negotiation at all! Instead, we just take all of the
> objects from server/repo.git as hardlinks, since doing so is less work
> than figuring out what we might need.
>
> It makes us robust to mirror.git being removed (since we ended up with
> duplicates of all of its objects anyway). But it's still not safe in the
> long run. If the mirror gets new objects, we'd rely on them for
> subsequent fetches (rather than getting new copies), and the same
> dependency is created.
>
> -Peff
