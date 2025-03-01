Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A406F23F39D
	for <git@vger.kernel.org>; Sat,  1 Mar 2025 10:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740825243; cv=none; b=RIHadWOi6XdGpt6C21tHVaYN5UCh40PFhg13qC2WqzzPS0VyEis+Xq1bscfnLu9wfK4y4Eo7/QHhep1sfyuOCQYw0pS1ubEW0shu1ymRqRbXejZ+RTsXy/So0Ili8ZBftLMMfW8WlVRw2AUi6gwj1EkGQY76x6pOkk9DdM2kW9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740825243; c=relaxed/simple;
	bh=7EZxBVlLKOU4VzKQbEhIt6+w3APUaOImFWKLaYTGnF8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=uarnDLGtbGbZUdwMNYUmOL0spElVzZL3keVZXsBwdO5a8b1DFUpNW68YbtvMz2ZZdT18AYltdFXY9a5OoCkKBR9hG/SWT9jItdqVm3RpldeXTNStbsDd4Qj2bg4/iLjmYkApveR3lv/MVe+u3A683ky4/AVCYEKDtmMJYXAqluU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YbSfsbZ2; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YbSfsbZ2"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-390f5f48eafso456842f8f.0
        for <git@vger.kernel.org>; Sat, 01 Mar 2025 02:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740825239; x=1741430039; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GIwRVbiiccXPyeeo/jn3sSi0ZKrLjRn16tSUZc2n/EI=;
        b=YbSfsbZ2DAzhFuprjmvjQNAa7A8GFDx/CcyRnHmeE7EHBQa1dTYce0fXcy5xQVxsm4
         uMGk9F6vYwale+D4qc89ulW5uq/kDBxliutyGx69JFLpNBNa3YdMxyNh+udKam4uH0Ae
         lLX1RgZtr/T27vu1ftPsw/FqjCRFwOr/+nSO+7wdrORUC89lB6wrZQgOBNE9xueTJSqc
         3/SL0ZxLt0It6905WfOgnU7Gsu8YjbduqWlRQNXL4DxYZo/zpdHVJf3vuo+chucS6d4n
         K4fglkaJCW/I63c3iFPDE/7mulHNrK5NsuHdFrJksLchHjCHtuj6YpBabApxRWjSaLNQ
         D/Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740825239; x=1741430039;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GIwRVbiiccXPyeeo/jn3sSi0ZKrLjRn16tSUZc2n/EI=;
        b=GHtF98d1v39TCaezJeJDzPN0VfL+zAu1jaRHemoieyWbh0Bc9986goqMAoRX5PCgHr
         hTZtjOamlBlkPqYpVyyzM7DHLT9hvB8ZCbI0KD4yL+uDh82HLetXHBE/R94yBiTAWdj2
         QM1QmHDGU6ORks2wcS1rYt5D6DXQ+EwN8yinz8dvIYa5Wzm/lBY2Va69k9YMg+ij1+OX
         ONPu5Kpvc7xwAQpsBbn57OpfzhoAL/ctdHImsBOxmqlQ2mrT/v4BZTdtzJ6PzWSMHMfd
         CM0+MBtKx6PXTcJKrJ+zNWNBI7uhBCmgKw5FOrQ3ZTx3jLte8RtXy4whRfjBsemDrpcS
         BCtQ==
X-Gm-Message-State: AOJu0YzZDFE0qWDegomc0m/yTnSdMffcd0DHCxWN3LvTosOE4rcPjRmA
	aH6mpzayUQE7TCPNwSfCMjLNIlSF/FCF3bR526lsJVwBwiLm7Lt/WInbKQ==
X-Gm-Gg: ASbGncva+ME72fOnPv+bllraZ2crl0mWxLdI3BUgZYjxFbQE+Qkqgvm1NGctw0lAtdI
	lULxnwiqzzeRbkInwAJ8E9R39eBSrniu8PJKeChrToB3kF4Kg7uPfjSZmz6QnKkJnPYdFdZCLUg
	6GgSZP0GCuYuNqvOHhiLdQ8rO2wlQHA9RSLgNjHuwPHZVguTEfAe0dOp39qXscfLbDFMkS1lyTp
	1Bt8o/AxnvvD9rf6OFPPHWVm1JbpvXzfX3C+JMwY0B4LHpZ3FQ53MSpESqQtR2BMCJHVn+Bk5mr
	/LGlcWeYun8D7F1P/f1HrWgc+kUldTfoQIFKJOaFhqAi6Q==
X-Google-Smtp-Source: AGHT+IGl0H55o68OsvMCZiuEaaEyJhSqNVoDCEPOcxhk2FkcEISBH20iOmxyGjGlK3bAeSVOBTfSvA==
X-Received: by 2002:a05:6000:1f86:b0:390:f6aa:4e80 with SMTP id ffacd0b85a97d-390f6aa5102mr2879370f8f.53.1740825239293;
        Sat, 01 Mar 2025 02:33:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b7dcfsm8031981f8f.55.2025.03.01.02.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Mar 2025 02:33:58 -0800 (PST)
Message-Id: <pull.1897.v2.git.git.1740825238.gitgitgadget@gmail.com>
In-Reply-To: <pull.1897.git.git.1740489585344.gitgitgadget@gmail.com>
References: <pull.1897.git.git.1740489585344.gitgitgadget@gmail.com>
From: "Scott Chacon via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 01 Mar 2025 10:33:55 +0000
Subject: [PATCH v2 0/3] bundle-uri: copy all bundle references ino the refs/bundle space
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>,
    Scott Chacon <schacon@gmail.com>

Updating the series by fixing the tests to look in the new space that heads
are placed and added a small test to check for tags.

Scott Chacon (3):
  bundle-uri: copy all bundle references ino the refs/bundle space
  bundle-uri: update bundle clone tests with new refspec path
  bundle-uri: add test for bundle-uri clones with tags

 bundle-uri.c                |   2 +-
 t/t5558-clone-bundle-uri.sh | 203 +++++++++++++++++++++---------------
 2 files changed, 118 insertions(+), 87 deletions(-)


base-commit: cb0ae672aeabefca9704477ea8018ac94f523970
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1897%2Fschacon%2Fsc-more-bundle-refs-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1897/schacon/sc-more-bundle-refs-v2
Pull-Request: https://github.com/git/git/pull/1897

Range-diff vs v1:

 1:  96d78614214 = 1:  b36bc876fe1 bundle-uri: copy all bundle references ino the refs/bundle space
 -:  ----------- > 2:  5e198ba5c66 bundle-uri: update bundle clone tests with new refspec path
 -:  ----------- > 3:  ea204679cb0 bundle-uri: add test for bundle-uri clones with tags

-- 
gitgitgadget
