Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C2C191F92
	for <git@vger.kernel.org>; Tue, 13 May 2025 19:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747164542; cv=none; b=pxSL4qTlav4Hak6dclukzMciBfOUbrAlzzeGl0E1YwrqqFXu/rTp7DSAn9dqg3wwNM4zoSbXjUPByQOCSRSDy+3wsTtJF1KJ2AoVBCjnL8WfCwOCI6l2hYW2AfYSoBK2wcKY+g+F0oEboDBvYT8/VFl42EctKgXvfRZSNrcllvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747164542; c=relaxed/simple;
	bh=k4gN/uY2twwZjhu1+DOLL8JTc3dVrsrGXO1J7yNfZ80=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Hke6ANSY4++8Vi4VMZuqQjnsx9La9uVvIOPyDqKhT247q69574Y0OIODhojsOZK1QF+7ZJjsOnwfvzRDHtzIyMn1yc66gxkzo0AJILfhLKlkusEixegFFoElEhGDg0ceeiVIo6Mk5XcD8JaB99Mf0BJ6are8FLBJzKjrBGgq7PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=lIqdwEEo; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="lIqdwEEo"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1747164538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k4gN/uY2twwZjhu1+DOLL8JTc3dVrsrGXO1J7yNfZ80=;
	b=lIqdwEEowkrjU83MmlzQ9Oa+iOrDGkqmqS5zjUgyh+gfiwQ/Egx0NUf2+iildq8MD3VaRA
	9PaYds+YVeUcvXNZ0d1jqeRc7obrhSJ/wBCWOcPSxYN1UFY27Uo6a9TfgCDP5nEUUUcfdX
	LAh7BbMcoU8JyO0Q/eSOg+IXa6G/f0A=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 03/17] object-store: rename files to "odb.{c,h}"
In-Reply-To: <20250509-pks-object-store-wo-the-repository-v2-3-103f59bf8e28@pks.im>
References: <20250509-pks-object-store-wo-the-repository-v2-0-103f59bf8e28@pks.im>
 <20250509-pks-object-store-wo-the-repository-v2-3-103f59bf8e28@pks.im>
Date: Tue, 13 May 2025 21:28:50 +0200
Message-ID: <878qn0jonh.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> In the preceding commits we have renamed the structures contained in
> "object-store.h" to `struct object_database` and `struct odb_backend`.
> As such, the code files "object-store.{c,h}" are confusingly named now.
> Rename them to "odb.{c,h}" accordingly.

Do we have plans to extract the object database subsystem into a
subdirectory? With us adding multiple backends in the future, I can
image us having a dozen files at some point. So since we're renaming,
shall we prepare for that at once? Or will `odb.h` always be the root-level
entry point for the object database, and only live backends live in
`odb/` for example?

--
Toon
