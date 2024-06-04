Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3D513F45B
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 07:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717485143; cv=none; b=tjVNuLv3x9EGvEmrZIhYOzqKpaws3u+S4e4EDF5BnhRtWp0fDI0BJd5c9eqSV1tUvEcGnV43SEbTENYhu3p6T7rArQGtD0ARH4whpxytVJX3sYihVpoc9buDDeE0yOkafOAIR4Y5Vg0Od2FtfORXpRc9jFMWtNAK1hhF+OXg2oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717485143; c=relaxed/simple;
	bh=V2Z703668RHAen/Gv7VTyhClJW4Osl9nJmMmJVdLiLg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=m/oLW2Y6pFjcCOoOUovzYEOjUXAvFa5nxPDozfMnDmbgjK5OoOA4b7xFdak5W/eGbyDAUDezGxs6FItfo6FEkELcbkXi7LoErvRvovlVSPjfRuVuAVbrO/66EYDAAK2X9mIWDTi2Enm3vaZ7qzsFCYtahjST9ZJK8RWsJSCUNOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YV92lMNy; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YV92lMNy"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-35dceef429bso2240874f8f.1
        for <git@vger.kernel.org>; Tue, 04 Jun 2024 00:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717485140; x=1718089940; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HWbIdPOnClwUGKX1zQSCSC7jFlvEw85s7idEzsbBhNE=;
        b=YV92lMNyA8TqXCfJbxXwOX978Z7hCAa2YW0lygrDuaqhrY2MqPNWQMbRLrothc/3im
         5ZRiEhGsHXL6bxM/sbZgd9dNvLBiB0CuC0u9X6njDd4VxexNUVP6RC05yFUXJznzjNZ0
         duiRCcsIw/sIJjAUTuCovnZ9k0bq4WuI35sjuyiZAKFNXhc6R/UgM3iL3vb7pWCAi89t
         9Gi9uLnFbL451xNIr78RnbPUetJipzXQNvJLkPy3gEOT0mV2Pc8pkxt68bcxNl1ZHTIY
         6+t3xu89YF7ZjMfpQ9hgWOZT6YVH870YXsbLzKGuAVxq38kJ7UY1x3zVmhm45Yj/GvzS
         AXFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717485140; x=1718089940;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HWbIdPOnClwUGKX1zQSCSC7jFlvEw85s7idEzsbBhNE=;
        b=NC7Ez3tuy6bipEaQZibUcXHJgpzEVeLwfajlIuvEga+KBmdhQlLYcrJtQMkFoLcROC
         tVlEmZTMIQ7zBS7O56URejz305Z0Y3CK54Ud9qpSCggS8Bjz/C/c3vCTyHlQDomFnF7h
         w3t1ibYY/HpXlRThg9crAldwEPQ0H5RIjFB6CRLWbWNfSO7Eb73AP18TPPgFOptPKteV
         SZlCZVBiBjbR/+4AvPhMsEx1ZdvMvz20kmEZa9XvQht6tRbORq95ac7a954SrnWojrzR
         bENFclonxtALClNadkmHhixP7Asayf0t7TQWKY7azVeUccQGZpUGnRZbPoTW62tXLUUQ
         jdxw==
X-Gm-Message-State: AOJu0YxsVVmT1SCZHMZWHxUd9RPt5p6lqSXAgPwzDIA/wBJZ7o+oH2KZ
	CAwY0mA3ygc/ZoRmFZtxueNECniPJDzgQP4vMhkaLphgpQTq+aU+sPNvY3py0lVQfXNwXutYb9H
	OpGbfPkO62E1R7qOV237Lnkrdp+GBTV/j
X-Google-Smtp-Source: AGHT+IFn48DoPgNnN30uJKPeERG/dSq6l/AHzgo06BvOd5MVtTadgKzmrVoldt+8XB6MrkcGavdRQvhFrDHJxtkWNYc=
X-Received: by 2002:a5d:6752:0:b0:34c:7ed4:55a with SMTP id
 ffacd0b85a97d-35e7c591331mr1306259f8f.33.1717485139873; Tue, 04 Jun 2024
 00:12:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Fadhil Mandaga <firodj@gmail.com>
Date: Tue, 4 Jun 2024 14:12:08 +0700
Message-ID: <CADV-Dy+dU+t=MCy5mwrMZ7LBvOh0T1zKos=-YpNk0EzXZN78tw@mail.gmail.com>
Subject: builtin/stash - segmentation fault
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

When `git  stash` on detached HEAD I  got a segmentation fault. I am
using git 2.45.2 on OSX/Darwin. Furthermore the culprit is
EXC_BAD_ACCESS on `repo_find_unique_abbrev_r` because `oid` is
invalid. The `oid` was obtained from NULL `lookup_commit` in
`do_create_stash`. The result from `lookup_commit` should be checked
for validation to avoid null access.

https://github.com/git/git/blob/7b0defb3915eaa0bd118f0996e8c00b4eb2dc1ca/builtin/stash.c#L1380

Thanks.
