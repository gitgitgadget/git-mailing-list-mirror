Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4274C28C019
	for <git@vger.kernel.org>; Tue, 10 Jun 2025 09:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749548765; cv=none; b=qJ1UB68qVrnvOKPY7bZ0p/uZ1vTPRXxiRCVw7B4BRS8ex3KBjS0j3XI+6fo5LPvIRXtff33c/366I3SwGq/rM2jd2bOwr+APifbGaZL1xooIs3pyOUa8VqFbu6DOBIInUqyN+QVVrXJz8S/fDxXW6ZLloFNBah+2Bnbasl7X4jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749548765; c=relaxed/simple;
	bh=BdVDSoQbnHJIIQOctkIxTVgNV7GZEiuWBANLTp7naqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O5Na1traAFc3BygI4Ox8ERo8opbJptlpodpto+3+dwxfJ33EaMuR49bWbiYva6E6TRIGjfMFJrhWh+11u7e4j4HJLQGHDuZLc1Q/rRopfhYZjRWJchZKE8xRS51zThqfRMu3u0RLeVO/w1NcU5Sp+pj2iaXWc/lKmnaow0Y255U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PIbd3lXC; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PIbd3lXC"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b2f645eba5dso2285537a12.1
        for <git@vger.kernel.org>; Tue, 10 Jun 2025 02:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749548762; x=1750153562; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BdVDSoQbnHJIIQOctkIxTVgNV7GZEiuWBANLTp7naqU=;
        b=PIbd3lXCK5UdJefmlwpg0jd4AG7k49VI2qv4iwao9n1jdoe5v81a6XUB1ICl6C8oy0
         N2jEh9jjbptq9yHVS0Fjt2j0y9beFdtnfgnBP/c1ThM7w3u+rnToiDC7uEhEVPRlakGF
         FLSLWvnbrnQBfWNEhCIiy7IcTreXpn+bpwiWN1otAqG81ffumFz7LYZXecY+LNjRMx83
         6x/QToNSzz7hS6EJL+q6stfXF6y3fpNu4Biqb0miSudcQ3ambUPUtDdzrV6dZxTBdsK4
         HHitrswdynDyDlMoQxBcb9yV6eP/nyRATBt/O4BFPbhUhlXsFEE0RqIponyBGaFhIGqu
         MWIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749548762; x=1750153562;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BdVDSoQbnHJIIQOctkIxTVgNV7GZEiuWBANLTp7naqU=;
        b=RhSGvlKrOIiwoVw1XJhONDsqF2uZ7zqpTQZYy2R8nEjNRZFmcJTLAHT23aNgp+Tet1
         3NFu/+TxhK1EgkzrzjETVagQWj+26laJSVRTRYlC2SykA3B0YKWrykHLfYjVkMExwxyX
         sfD/EbxRUW8kVeIOPqY8scTyJ5Co5NVon1RdWjq3bFtaBeDTy++pcX8IONeKeMjA7ohR
         Fu2QY/+ylI4yXghAxp/er++76mKBq8iS5KUT36nAaDhYHcr3Td3lHqAMIglAblb/s7C0
         JkcSzQ+zENUECEp+RsrYDKZ6ZdNismwdL8XWbWjm7hQxE6rFrpvVFbhTM02qCwrusolw
         vQpw==
X-Forwarded-Encrypted: i=1; AJvYcCVGGN8GDODtWh4IryEQOElBqAzH776vsFIUnZpEAMSz3rxD7Tul7yftL0B7EAbLSC7+rWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrAmUcrONnZzCfIoFwtYcJz88Hhh7qEXyrA2RFwFr9XDxe6ilz
	wRM+J29+VxvDCeFNUsAkIuae+WwFtKCr42sCZtuHOFyw31CA86Yo3EZAxFydBDYk897/+PsuY4U
	r109KaoZvXMMHKkQigbBNjuIXID+SjpjZb6SS
X-Gm-Gg: ASbGnctOiUz5FS9979DotFZOwbz8PA+yqJ91PdFZvzj+gSEmUPIePMiRwSS2UJEsae3
	+6GUrzmBZsEUuADMczHFQpyTXtO85Cjaz1s2zMkny2fqmAmQ3Kxt7+2pNl/xK1RHApkWrYNl5P5
	H2JBZxf2fJhPArXOYGprDGTwzhCVwTpxMyi94rBN3EGWm7
X-Google-Smtp-Source: AGHT+IE+YZQviHMhVDVxHJ+IX29X8ArmemsjImA+zQ8veksdKVV60a6zv63iPWT+8oCsmyBowF7+l3J6HEs0wtJTozc=
X-Received: by 2002:a17:90b:2544:b0:311:9cdf:a8a4 with SMTP id
 98e67ed59e1d1-3139dfe2b71mr4506218a91.8.1749548762316; Tue, 10 Jun 2025
 02:46:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM0=yCcOAGsUE8tX-o8ioihr+oWrORD6Tz=WH1OnmhpO+uqrA@mail.gmail.com>
 <e790367c-6777-4b4b-97f1-3b3a2cbdb177@gmail.com> <xmqq34ciupll.fsf@gitster.g> <CAPM0=yCScvtJ=v=xZeH6ZqGtnuGeQbHn+Dj6OCiP4Ci=z_Hf+g@mail.gmail.com>
In-Reply-To: <CAPM0=yCScvtJ=v=xZeH6ZqGtnuGeQbHn+Dj6OCiP4Ci=z_Hf+g@mail.gmail.com>
From: Piotr Siupa <piotrsiupa@gmail.com>
Date: Tue, 10 Jun 2025 11:45:45 +0200
X-Gm-Features: AX0GCFvuSUKLOACEWZ2HEWZcrFNG8PSPIXs7KhaVJSLdplkBdU_Gup4DaVlQ3zA
Message-ID: <CAPM0=yDe2gZhtQUX-uszbYYibMQrSbCf0c=hrqEiLp53VGk41w@mail.gmail.com>
Subject: Re: [BUG]: Non-matching exclude pathspec causes an error in empty
 repository when the flag "--update" is present
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I'm sorry. I don't know what happened in the previous message. I've
explicitly chosen the plain text mode and removed the unnecessary
quoted text. I hope this mail will be normal.
