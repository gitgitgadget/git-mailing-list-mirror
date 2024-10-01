Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4921CBE9F
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 19:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727810307; cv=none; b=hU76G0Uj/ztu0UPC16ndpznei/2G8I0co7Tf5tyDGyYaML2gS10NaSj/80hKFs40dvgBhpcIs76UhQyDe+FscOTFUS4Z40x7hszC/gawxmDp/87N3gsyeJi8SWwUjNoWPCKD80Mn1HZLe8Zdf+aG3da1eUwgWpb3SFrOURJUPjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727810307; c=relaxed/simple;
	bh=4Gnt0FxEw0Gsm1biJLwuDZpgZL0ZH3grydG42LdpgMI=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=HoxxD9D3g5mi03/cvYvrS0k9i8DXtCJcdF0o4pGJURHYHb7ixSAcMdq5sxTaSxbYpoq/Rsl3lVbpPjuaESughHTKqbz+pUnEM1VpDD4ogfYQA4sHOLWgGq8SIxfZnMiCLIBiemEgOB7qqYryKZcUWrQG5Mea0CTonhjq5vRpXOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--calvinwan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TWfZQKiJ; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--calvinwan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TWfZQKiJ"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7d4fc1a2bb7so5142722a12.1
        for <git@vger.kernel.org>; Tue, 01 Oct 2024 12:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727810305; x=1728415105; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RYWMUEsoLUQJl66nR3y7WJ/TSypqlpNISnaaFTAxPQ4=;
        b=TWfZQKiJ4gLx96368Gl7q8v7bnablL2giOFtXwpzDpBsQorBk2RFnIKMckTALFaER2
         1DY0JmdYzYf3MPdbuiWOeHK2hD2qzgdeLqmYQAhBlPKMNSJ7MaVXlnx+9g1kZmf168xR
         af8IF37yU7DQGAKkIXAg/fcCVO6FhIgTAn+COdigMjrl5qaXBq3V9KjgrdCi63jynUCZ
         EnopUaLTPmoCtGbZ6srvNokIfDEAOUSnu1VV3C6+dmF06Z55qRzK7HJNLS5rDfps4S7V
         DKdBtr1vKQyownEcM1uaQYErfcmEuO/RkHM9rEzA14x0a3OkjVYAmg4VhghNHKj+ByOG
         tkhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727810305; x=1728415105;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RYWMUEsoLUQJl66nR3y7WJ/TSypqlpNISnaaFTAxPQ4=;
        b=k9xGUB1aT0YQFZ0ulJTmk7BHXRO/CyiuISkWLM6Kc8I9oaoAaUC0WcLjtfQ2dHdVn4
         IftH6S/JasWrkg2xeB/MvHu3T66t/kqXDdOwQb4Xt9y4cTyYkee5ABFU42VfLFYV2lf1
         WCAydxTc464Ym7gJRv+xT5sdgUUWvJyUKvHM7R5oZ++2Q8rFPnbWlIJ5b8V+JWQX4Dwy
         yd53WPn/0Y0g3mpbna3vslUX+6J6881hVt3CJPe+jR6L00Vrz8r0VYtUR+0I99TBJ3Iu
         y2yTUgZNbvGqf1EIRMvI85N+H+cnIRAW6GtWbZUPhQbhaOc97Um23bQkpc9P9fs7dAyW
         JJRQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/lVmauqzGJ92d+tPIrAESd03GD/WbVMy49djmQBn6fKswLCIGbHrvLBwwB7wcmlhvBZI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzntf/uh4b7YUeTBR+2dc9zYehXCaR+NUKPuQwWv97f26OxD7kK
	I3etQXIq2CSdYHnxcEu+dJHz5aWn/speodZneiJrhavutpJweJzwpxRv4aRvtH9wJF11F26O4Rx
	gFEu5XsJR04cXMA==
X-Google-Smtp-Source: AGHT+IGfr+E9tNc3oT4xqRi3yMcMedBq/u9Ne/q/+DCZjiDrYfC92z3vOAyytYgnQqceSGAUGGQQBi5338DLlkg=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a63:3d0b:0:b0:785:e3e:38db with SMTP id
 41be03b00d2f7-7e9affa2f63mr406a12.8.1727810304547; Tue, 01 Oct 2024 12:18:24
 -0700 (PDT)
Date: Tue,  1 Oct 2024 19:17:51 +0000
In-Reply-To: <20240802073143.56731-1-hanyang.tony@bytedance.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20241001191811.1934900-1-calvinwan@google.com>
Subject: Missing Promisor Objects in Partial Repo Design Doc
From: Calvin Wan <calvinwan@google.com>
To: Han Young <hanyang.tony@bytedance.com>
Cc: Calvin Wan <calvinwan@google.com>, git@vger.kernel.org, 
	Jonathan Tan <jonathantanmy@google.com>, Phillip Wood <phillip.wood123@gmail.com>, 
	Enrico Mrass <emrass@google.com>, sokcevic@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

It seems that we're at a standstill for the various possible designs
that can solve this problem, so I decided to write up a design document
to discuss the ideas we've come up with so far and new ones. Hopefully
this will get us closer to a viable implementation we can agree on.

Missing Promisor Objects in Partial Repo Design Doc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D

Basic Reproduction Steps
------------------------

 - Partial clone repository
 - Create local commit and push
 - Fetch new changes
 - Garbage collection

State After Reproduction
------------------------

commit  tree  blob
  C3 ---- T3 -- B3 (fetched from remote, in promisor pack)
  |
  C2b ---- T2b -- B2b (created locally, in non-promisor pack)
  |
  C2a ---- T2a -- B2a (created locally, in non-promisor pack)
  |
  C1 ---- T1 -- B1 (fetched from remote, in promisor pack)

Explanation of the Problem
--------------------------

In a partial clone repository, non-promisor commits are locally
committed as children of promisor commits and then pushed up to the
server. Fetches of new history can result in promisor commits that have
non-promisor commits as ancestors. During garbage collection, objects
are repacked in 2 steps. In the first step, if there is more than one
promisor packfile, all objects in promisor packfiles are repacked into a
single promisor packfile. In the second step, a revision walk is made
from all refs (and some other things like HEAD and reflog entries) that
stops whenever it encounters a promisor object. In the example above, if
a ref pointed directly to C2a, it would be returned by the walk (as an
object to be packed). But if we only had a ref pointing to C3, the
revision walk immediately sees that it is a promisor object, does not
return it, and does not iterate through its parents.

(C2b is a bit of a special case. Despite not being in a promisor pack,
it is still considered to be a promisor object since C3 directly
references it.)

If we think this is a bad state, we should propagate the =E2=80=9Cpromisor-=
ness=E2=80=9D
of C3 to its ancestors. Git commands should either prevent this state
from occurring or tolerate it and fix it when we can. If we did run into
this state unexpectedly, then it would be considered a BUG.

If we think it is a valid state, we should NOT propagate the
=E2=80=9Cpromisor-ness=E2=80=9D of C3 to its ancestors. Git commands should=
 respect that
this is a possible state and be able to work around it. Therefore, this
bug would then be strictly caused by garbage collection


Bad State Solutions
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Fetch negotiation
-----------------
Implemented at
https://lore.kernel.org/git/20240919234741.1317946-1-calvinwan@google.com/

During fetch negotiation, if a commit is not in a promisor pack and
therefore local, do not declare it as "have" so they can be fetched into
a promisor pack.

Cost:
- Creation of set of promisor pack objects (by iterating through every
  .idx of promisor packs)
- Refetch number of local commits

Pros: Implementation is simple, client doesn=E2=80=99t have to repack, prev=
ents
state from ever occurring in the repository.

Cons: Network cost of refetching could be high if many local commits
need to be refetched.

commit  tree  blob
  C3 ---- T3 -- B3 (fetched from remote, in promisor pack)
  |
  C2 ---- T2 -- B2 (created locally, refetched into promisor pack)
  |
  C1 ---- T1 -- B1 (fetched from remote, in promisor pack)

Fetch repack
------------
Not yet implemented.

Enumerate the objects in the freshly fetched promisor packs, checking
every outgoing link to see if they reference a non-promisor object that
we have, to get a list of tips where local objects are parents of
promisor objects ("bad history"). After collecting these "tips of bad
history", you then start another traversal from them until you hit an
object in a promisor pack and stop traversal there. You have
successfully enumerated the local objects to be repacked into a promisor
pack.

Cost:
- Traversal through newly fetched promisor trees and commits
- Creation of set of promisor pack objects (for tips of bad history
  traversal to stop at a promisor object)
- Traversal through all local commits and check existence in promisor
  pack set
- Repack all pushed local commits

Pros: Prevents state from ever occurring in the repository, no network
cost.

Cons: Additional cost of repacking is incurred during fetch, more
complex implementation.

commit  tree  blob
  C3 ---- T3 -- B3 (fetched from remote, in promisor pack)
  |
  C2 ---- T2 -- B2 (created locally, packed into promisor pack)
  |
  C1 ---- T1 -- B1 (fetched from remote, in promisor pack)

Garbage Collection repack
-------------------------
Not yet implemented.

Same concept at =E2=80=9Cfetch repack=E2=80=9D, but happens during garbage =
collection
instead. The traversal is more expensive since we no longer have access
to what was recently fetched so we have to traverse through all promisor
packs to collect tips of =E2=80=9Cbad=E2=80=9D history.

Cost:
- Creation of set of promisor pack objects
- Traversal through all promisor commits
- Traversal through all local commits and check existence in promisor
  object set
- Repack all pushed local commits

Pros: Can be run in the background as part of maintenance, no network
cost.

Cons: More expensive than =E2=80=9Cfetch repack=E2=80=9D, state isn=E2=80=
=99t fixed until
garbage collection, more complex implementation

commit  tree  blob
  C3 ---- T3 -- B3 (fetched from remote, in promisor pack)
  |
  C2 ---- T2 -- B2 (created locally, packed into promisor pack)
  |
  C1 ---- T1 -- B1 (fetched from remote, in promisor pack)

Garbage Collection repack all
-----------------------------
Implemented at
https://lore.kernel.org/git/20240925072021.77078-1-hanyang.tony@bytedance.c=
om/=20

Repack all local commits into promisor packs during garbage collection.

Both valid scenarios
commit  tree  blob
  C3 ---- T3 -- B3 (fetched from remote, in promisor pack)
  |
  C2 ---- T2 -- B2 (created locally, packed into promisor pack)
  |
  C1 ---- T1 -- B1 (fetched from remote, in promisor pack)

commit  tree  blob
  C3 ---- T3 -- B3 (created locally, packed into promisor pack)
  |
  C2 ---- T2 -- B2 (created locally, packed into promisor pack)
  |
  C1 ---- T1 -- B1 (fetched from remote, in promisor pack)

Cost:
Repack all local commits

Pros: Can be run in the background as part of maintenance, no network
cost, less complex implementation, and less expensive than =E2=80=9Cgarbage
collection repack=E2=80=9D.

Cons: Packing local objects into promisor packs means that it is no
longer possible to detect if an object is missing due to repository
corruption or because we need to fetch it from a promisor remote.
Packing local objects into promisor packs means that garbage collection
will no longer remove unreachable local objects.

Valid State Solutions
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Garbage Collection check
------------------------
Not yet implemented.

Currently during the garbage collection rev walk, whenever a promisor
commit is reached, it is marked UNINTERESTING, and then subsequently all
ancestors of the promisor commit are traversed and also marked
UNINTERESTING. Therefore, add a check for whether a commit is local or
not during promisor commit ancestor traversal and do not mark local
commits as UNINTERESTING.

commit  tree  blob
  C3 ---- T3 -- B3 (fetched from remote, in promisor pack)
  |
  C2 ---- T2 -- B2 (created locally, in non-promisor pack, gc does not dele=
te)
  |
  C1 ---- T1 -- B1 (fetched from remote, in promisor pack)

Cost:
- Adds an additional check to every ancestor of a promisor commit.

This is practically the only solution if the state is valid. Fsck would
also have to start checking for validity of ancestors of promisor
commits instead of ignoring them as it currently does.

Optimizations
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

The =E2=80=9Ccreation of set of promisor pack objects=E2=80=9D can be repla=
ced with
=E2=80=9Ccreation of set of non-promisor objects=E2=80=9D since the latter =
is almost
always cheaper and we can check for non-existence rather than existence.
This does not work for =E2=80=9Cfetch negotiation=E2=80=9D since if we have=
 a commit
that's in both a promisor pack and a non-promisor pack, the algorithm's
correctness relies on the fact that we report it as a promisor object
(because we really need the server to re-send it).
