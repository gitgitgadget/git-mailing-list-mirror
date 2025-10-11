Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3B51F3FEC
	for <git@vger.kernel.org>; Sat, 11 Oct 2025 14:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760192702; cv=none; b=ujRaIYW2S4+eKD6RwS/z23R8Qxl326cVAvNRS7EXd+4rpFUm7aCj4Uehw8WKrffE3/h+FeLmzuEyhgx6UegRlotopsTf7mHFUnbfvNNA4pJ/syN7hf3PhllHKmJ9vH5nBx5NmLObTWlx21xTXKdJKSY6pkQlUIzpIUZZ0jPHOnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760192702; c=relaxed/simple;
	bh=1Oh6cxuwUfcin6oUM+f04VqkPcZJ3b/tVq0H/q+ZN08=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=On8lBR/JRAovz2wKZB9L0ocO5PJufTqySlTdtND3J1/5dDoilRJ+PHOewp0SX2PvOlCQpvf5iS4iDFvIG7lzFPjxNrf3BrqOv8A72wyQrZ5uv/uzwWpLlX6Tgzk0cmEWelXd4gk/L/OsYJq5TuLtYjPOhypwX2ZQKrQ9wK40nG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K2nT+CZX; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2nT+CZX"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46b303f7469so18008845e9.1
        for <git@vger.kernel.org>; Sat, 11 Oct 2025 07:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760192699; x=1760797499; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Oh6cxuwUfcin6oUM+f04VqkPcZJ3b/tVq0H/q+ZN08=;
        b=K2nT+CZXTI11oozlDkDXjwEDsLqOMoUWnLJ8y1mSPnn9/s7tvHUtHJ/6e8dHUJqGH9
         V5XjQ1olVCnbJXl0Swt9b6Z9f6OA8rSamkhfKx4q0JXC3/EIjIA77f6Ly7IeyhnP8Aes
         5HpSq1DsKTqdUT6o+ezjwOgpYigpG9Cljo/SOPn/2D0lZJ4iRwzsNzrEcPxG+XSF3Rb+
         fiNJeT8pRhJWZMbmBim1bP8D923wlvdTrfqRxZo3N3SHnFMORJ3uQYK2YnLffvCaXwjU
         d+M8uATBi/eBfqCCWb6Dv96NJGrzElfZ6RzJSmZaKcLrxlSyVPYqLIBcyi+29zFd/kl9
         f+gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760192699; x=1760797499;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Oh6cxuwUfcin6oUM+f04VqkPcZJ3b/tVq0H/q+ZN08=;
        b=vVyQzc35VSfYDXFBVrsdWZFrjOu8nlUPCWRCC6Dbo4fGBPmwfu4ARZ4UHq+QQ+zJx7
         0yO7BtLPbqbJcLxmlODfwZ22i4xGSkUMc8cNZaNczgGJEpwneeQt9ayhZoYtEBYazlL5
         o/M3ZmoDeFqPD0wy0uRsw3lGtWP3w0ti3VjKzDKsjJyqzqgTWAky4cyllI/Acg+ZJKZA
         4/2ShCO9BuU64uto6Fo4IZ4WG0FDlhiP0F9EKOmQOTtBEx6RIhg1ZOnl9xjypfw76bCe
         +CPPJxo2FSu/XRenxC03SWqJ9MfNLZ5Y3TUqzxCC4EeV4lfJSFa0iO31FjZTrr4D6O5X
         5gyQ==
X-Gm-Message-State: AOJu0YxG3AIXGOPIQmVPdF8dxgfIecxZq9fv8ClGXxNRQJSpFQVSgyFN
	tjNSoqn5TroJBZmtCcLi3Eb/VdM8Fwz7FZuwE225XXT3cGPViNaeunya
X-Gm-Gg: ASbGncsr5qx9FZ0iChLEKZ4E27kIGaWDXOpaWpiRunPB2lrYwj2H6VbaRUhOIXHB0ES
	6+MI+CJmO9CmocFiGhyJwQ+J6YQnK4UthwJYRxhbORGkypnSlik6JqCB73CpOoXm1DKMW4HcqWk
	s+0+jfrH4ukZrVTHekANsKDI/4XnIpOpPHGy4xjvqVHj7Ouf2Y/0RcKW9XcgaCwVBgTZvVVt1sx
	mJtD6ltWo1Qxsgcf7lLsUmEXWNBCYI6fmEOZi+U8qCsM/KQGEo/PoNJv4jEX9GPWpYVBZaq7tO0
	kEZhP+T+zaeetmAKMdTaGviuX3jNt3PXORTe2PyEzMa/13lL5foy9pJ5f5wlLEMGTUN3jGxRwjP
	stENzqPGmZpdLGsHic4TrCkURhJklp3RWpvzwY9lan6cvlZE9ff5gAw==
X-Google-Smtp-Source: AGHT+IHLr0M160MoWHZqMZaqGzX9ovBpqLse0y1kkY6xctU6jk2ShWOepcrjqJHQCNTva2o/A+/J0w==
X-Received: by 2002:a05:600c:1d1a:b0:46e:3978:ba71 with SMTP id 5b1f17b1804b1-46fa9aefedemr107302835e9.21.1760192698412;
        Sat, 11 Oct 2025 07:24:58 -0700 (PDT)
Received: from ubuntu ([102.88.77.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5cf70fsm8820197f8f.27.2025.10.11.07.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 07:24:57 -0700 (PDT)
Date: Sat, 11 Oct 2025 14:24:45 +0000
From: Bello Caleb Olamide <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com, christian.couder@gmail.com,
	usmanakinyemi202@gmail.com
Subject: [RFC Outreachy] Teach ci/check-whitespace to flag incomplete lines
 as an error
Message-ID: <aOporVVSRRL/v4Lq@ubuntu>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

While going through the mailing list for some #leftoverbits, I stumbled on this converation.
https://public-inbox.org/git/xmqqikla86id.fsf@gitster.g/.

After studying the check-whitespace script, I observed that the script parses each line of the output
of the command `git log --check --pretty=format:"---% h% s" "${baseCommit}"..` and formats the result.

But the output of the git command itself does not flag '\no newline at end of file'
as it is shown in git diff, in a case where the files does not contain a newline at the end of the file.

One approach I propose to take is to check the each file changed in each commit and
check if it has the \n as the last character.

Please, will this be good for a microproject and also I'll appreciate suggestions for the approach.
Thank you.

Bello
