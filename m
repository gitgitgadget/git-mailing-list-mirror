Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AF91E4A6
	for <git@vger.kernel.org>; Tue, 28 May 2024 12:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716900393; cv=none; b=AYfi350pdbYhJOJHin+iF1cHf3HZEyak73jlh4c17tpRnPNX6n52Gd830flPbYVCF734LH/nZOYARSoejtqTIJ73gHcAp52yH6dusruGEy/2XMqQQvnC8ZHvMLexzZ5OG08Vs7YuudLeEI002klpSMTiYjYJiiju91Fg8qBP0XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716900393; c=relaxed/simple;
	bh=G26XmllQYHu2FBp0/68pED17UM16rJFiBWJXotgaQF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bC4XZ50xnCE0DgcwryAIQFaSl9t5HCwKBvdCGk/AmDjC9VOm8/4BDK/m12V39ncATey2YrJi02TMa1kdlOC72WrDFAftC51kasxD/alSfHPQVJWCdxAbxAEBYQ5KlzbyGDJVhHqJ6KJ2i+pfIsG0HhybLxR6ltBAbX9heUQH6jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bSsgA8ZI; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bSsgA8ZI"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a621cb07d8fso95960466b.2
        for <git@vger.kernel.org>; Tue, 28 May 2024 05:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716900390; x=1717505190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G26XmllQYHu2FBp0/68pED17UM16rJFiBWJXotgaQF8=;
        b=bSsgA8ZILmjBrgvpFegQKYAeMQ5lgme5WK2+SIohq8dq6IXP5LtlBS2BtfCcN+Leot
         0Jf2xxoLs/BE8k8hK/n2K3iC4Z6TgfFAX9ITIUzmX3GuSoc1/XA3CRWtx86Xd+M3HB5x
         M6HzbFvoEHgODtnQwbEBwMN1d2t7PhURwA5h13GeOTVKZI0r4XN4y8Oco55roUvGniG6
         8/HuY0bHJiwK8s53PUyhcf2V/wXrn1GUI6YN9HdNCkhVfzGQnhODNLLabYBf344OApeP
         OiIWAvoVdA3TvIdA+guSfQCqioXsv1fTbWj8OCjNRqZMampYfSwCAO7x1qPW3PsuoLoZ
         5YFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716900390; x=1717505190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G26XmllQYHu2FBp0/68pED17UM16rJFiBWJXotgaQF8=;
        b=JyyGDyDTBK+rvudlAk/cN7vEl4H13w0Coi0h6kNBvJBAHMzwbxTNSwPWxVeEVATIIt
         /jLHXZY+acc6cyCphVUDtKhy/2rDc9Qy6/7rOl0sMZ7uYYLjV2oo29smjthItdnLZN1N
         Fmu1Ft3sYIOU6mefwtLM1kN2i2HY+2KcXX/jT+hMgRsUWRz6wF4ujVPZMnP+s/Vuxgmh
         KUXBEVrSaa9Q4EWJRghoJy3qamRHyS4BNa0kacurVGHf1l4LfD6JvFU/UcF0aHK5mCcP
         InmqWSvtZ10O3o8eV8zKomOcf5xlwvqbse5qZH/PJkeQK6LerNR5chHaQ4M+1ILtEZgD
         eFtQ==
X-Gm-Message-State: AOJu0YwKKJh6utemWET9S/rXfQe6ZbWOEEEvybX8KU79yjdRwTcN+EFU
	yqY7t2b4byEK3R1kzW6Nf+4TCZV+4PAu6xEAcsElBILIUvdOttjvsJQETuy077or8XEDxTmp7lh
	volO432MQA3htq9MY5sZYBE16pVWtYugz
X-Google-Smtp-Source: AGHT+IG8H2y+GNAMudSCPyGulIzHRRtf+y/+JNTsWFuVfNtg6KIRq3A1GjI0TleUAGPHRaCtpFY3lFBZbPSDI1EpRLU=
X-Received: by 2002:a17:906:d9c4:b0:a62:9aad:6cb with SMTP id
 a640c23a62f3a-a629aad07fcmr626463466b.45.1716900390183; Tue, 28 May 2024
 05:46:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528113856.8348-1-chandrapratap3519@gmail.com> <20240528113856.8348-3-chandrapratap3519@gmail.com>
In-Reply-To: <20240528113856.8348-3-chandrapratap3519@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 28 May 2024 14:46:17 +0200
Message-ID: <CAP8UFD02Ck0M2AOmTtJO3gHr3w+3Of7BAAa0Rbc=CtMms60nyA@mail.gmail.com>
Subject: Re: [PATCH 2/2] t: improve upon reftable/basics_test.c in the unit
 testing framework
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 1:40=E2=80=AFPM Chandra Pratap
<chandrapratap3519@gmail.com> wrote:
>
> Enhance the new test for reftable/basics.{c, h} in the unit testing
> framework. The enhancements include:
> - Move tests for functions in reftable/basics.{c, h} from
> reftable/record_test.c and reftable/stack_test.c to the new unit test.

It might be easier for readers if one patch moved tests from
reftable/record_test.c and a separate patch moved tests from
reftable/stack_test.c.

> - Add tests for functions that are not currently tested, like put_be16.

This could perhaps be done in a separate patch.

> - Improve the test-cases for the already existing tests.

Are these improvements to tests that were moved in patch 1/2 of this
series? If that's the case, these improvements could be in a separate
patch too.
