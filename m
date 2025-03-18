Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8012520FA9C
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 18:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742321868; cv=none; b=dze+uu2FRfLcGskW2+u8VS1Ea6aXfZFvkJZ5kUPXh4QHaRYbClVvC4WuioH9hzy4oJbq1tiJwQku1mXPsgFvZX8Tb1K31/enPrzXXwfTu/xpqEA19mkyDon+hcR3dILjRafbeHZSGcYk6vXaSH1slJWaJgYuVRbvb5HU8evREn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742321868; c=relaxed/simple;
	bh=Sa5COy3WEloUckYJ0F9GNqMNvYYHFf70OWnrSMn4UcM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mN6zS9AaQd31bhZ0Lg9sm02nzokwEhYsle98ttAwlo5pAuJTVPl7QTG5azj2vUvDmY9/1QRd5LOEtCM+B4Rh100SbajeVXoOXwm2VtEKnTVSfL6e80fBkcGG2hUH1yiqwErOUxkixZ3yvUQmpGn3zE+LZ0QQgpfIYhmwUxHc99w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=RcY36sIE; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="RcY36sIE"
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 52II2W7R021403-52II2W7T021403
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO)
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 20:02:32 +0200
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <taahol@utu.fi>)
	id 1tubGq-000DYw-Dh
	for git@vger.kernel.org; Tue, 18 Mar 2025 20:02:32 +0200
Received: from localhost (194.111.69.129) by ex19-06.utu.fi (130.232.247.46)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.39; Tue, 18 Mar
 2025 20:02:31 +0200
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 1d95a965;
	Tue, 18 Mar 2025 18:02:31 +0000 (UTC)
From: Tuomas Ahola <taahol@utu.fi>
To: <git@vger.kernel.org>
CC: Tuomas Ahola <taahol@utu.fi>
Subject: [PATCH 0/2] approxidate: tweak special date formats
Date: Tue, 18 Mar 2025 20:01:59 +0200
Message-ID: <20250318180201.3653-1-taahol@utu.fi>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ex19-13.utu.fi (130.232.247.53) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWUhZXkguLT4lWFxYWFhYWFBeUVxfSFlbSBwJCQAHBCgdHB1GDgFIWUhZUUgPARwoHg8NGkYDDRoGDQRGBxoPSFhIWkhZXEhZW1hGWltaRlpYX0ZcX0hQSFhIWEhZSFhIWEhYSFlRSA8BHCgeDw0aRgMNGgYNBEYHGg9IWA==
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:mime-version:content-type;
 bh=yy0vVRqlJ2OvdHft5ZPGhrgercMIJkcPDpjtlPe/mT4=;
 b=RcY36sIEd0zZFH5c+kOijtle9tbuyA0bYzos0cPl7YqyIxvXUYKInDHOxjrJ9I0cwuKKgEg2OQh/
	GsLY41lPYG3NI99ktjFDing0E0sfWgbgyXNDWYOZGF85IEACHWznWjEZAg+KbOw0AOtZrIpTow+f
	gbaiOcF39AHX4uIdZCEAUO4ly96gDsyAgXqj/SjCLFBVz5L5IROfd3ppQC7ArwSNRj7I3aHH4a42
	ZWA3DXy/cUteMnUqZrHfkrR5AWdWlz6MrrETSETFRmqtf4Uz//JAdm3Ms38FwhVNdctFKdalP9/D
	rMtyHYRvu2LOYVf2lDwH0tjHolPk745vdrgk0g==

I made a couple of somewhat hacky fixes in approxidate special date
formats after noticing that some tests succeeded only because of the
specified test time which happened to be too late to spot some
irregularities.

Thanks a lot in advance!

Tuomas Ahola (2):
  approxidate: make "specials" respect fixed day-of-month
  approxidate: overwrite tm_mday for `now` and `yesterday`

 date.c          | 5 ++++-
 t/t0006-date.sh | 9 ++++++---
 2 files changed, 10 insertions(+), 4 deletions(-)


base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
-- 
2.30.2

