Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B25B60896
	for <git@vger.kernel.org>; Wed, 13 Mar 2024 18:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710353819; cv=none; b=YrYhSoXglidBvZY73w8B3kBj4T4wvzWySvpMI4cmM709vI64n3rctp102LWhliW6GG6I+8tw6Ktwx4Akgk2PIXgF92a6gDYunNhuha4PbK3SUzizheHKM0+uH1U3fEQKsvvE7yfUkpo+ZbhcqLB4wvdt0us/BllKOmcCZkUWF5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710353819; c=relaxed/simple;
	bh=t11s9hkRtxLpcrNc3suVoV4vKTvQWqzpITD/d17ne9I=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=U1M2I9dvJvDJZ1xrXJPtynK6h80cxckGalZnGs61dX7JOUVoH4JS/bQM9ungbuRoyHt67uiiKAukXqKDQsJ/toKzsFGMnPZz15RxR2sgIH40FJTPTYIKiGuXd7PwFG9ssHaMnkTZagqSSHOYbKm4myjQK+IyRzHbdu1djDwrNHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZlIh9NUN; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZlIh9NUN"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-364f791a428so542835ab.3
        for <git@vger.kernel.org>; Wed, 13 Mar 2024 11:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710353816; x=1710958616; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=plfMRU97kN38XJE9dspcWFZrzsmeQjp3345BZqaJ4Jc=;
        b=ZlIh9NUNNcvpcKm/pIYXPg5uPzLZhvU3UhDB5WckyB3PbMq5kMD+GuzjXwHyPiZQ1x
         y7EOQ/FFYiEgchrvsDXxyFQkllR0L0b+Ybn6+UGFtLFjhILhsRT3YM1eWjk+qd4gNzof
         QKsg5msuVhmx+0mEhZcoRNxS+vZ+/8HPZoYnWIJHzk1dEbAUpqiU6Yin2qy757PgIjAK
         lsGsxQYmCWq+oyDqnVsQ3XuXxKomVgT+LklBlSOoEWw1B0zeGO4FgC4sBrIlEK7tNTyN
         5/GA9n5VWiVtSVjHaJ92BAxrk+d4s6VhwkOH8KpqpWAWiZuP2zNFG9Ge8YbH1s00BCIg
         Oabw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710353816; x=1710958616;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=plfMRU97kN38XJE9dspcWFZrzsmeQjp3345BZqaJ4Jc=;
        b=go5+fqLYEiqUQh5CJLNc3tjB8XpiqJxKlJx06wVtWNtLAqULzke/gsYgv/K4VBSb2R
         OQQQ4oaWdbbAe8L5hwTlqG4K1JSBS0XYLqpid7G/hAWryRBkCcGV41aKsuHF8D3uMvrk
         hH9aTXJQgZVHdLVzKDU8lQ8wPsamoQDAsH71YcWLRlmzfK5NrQ/3SoDbvy8I4qPV3jy+
         WOmanvv+i0Io8bG57Xc8qLdJUq8uQ/as3JnyhBKgU0VeUSe2pnTTLl93m3c2aEPcn8cn
         HAEw3R33fC2Sjs5/YFFtje4DbAzQr74/cmv4qa7jMFeT5iMx85JoAMTKMaTVGF8Rl1C3
         U/Ag==
X-Gm-Message-State: AOJu0Ywni6Tc5fik6TmKuIDHNApexJOTjsNxF6GFzQ+HscREH5vqURFk
	x4UN8nq2uDa0M/vnqxIeb666vcfoZknLmY98NYTsMmA4o7WDhTZufsmG09GiVSaE9b4u1ta/QGb
	+kEQpfODiHMKEMTdcdVRWrKCYPCz3K5YMlMA=
X-Google-Smtp-Source: AGHT+IH+wOaJSWDz2dsoSuqUV3ZGA3Y5idZoA3g4QpIGnzyARw5Yw6u8cPHNnqozsIL5FOn67gMVN4yR0aAKzJ8OTzA=
X-Received: by 2002:a05:6e02:1d11:b0:365:5f55:4ae6 with SMTP id
 i17-20020a056e021d1100b003655f554ae6mr922110ila.12.1710353816360; Wed, 13 Mar
 2024 11:16:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?SmVwcGUgw5hsYW5k?= <joland@gmail.com>
Date: Wed, 13 Mar 2024 11:16:46 -0700
Message-ID: <CA+osTZWsGv01xinFPKbTQOF9mpvfwWs4wJczHSZXLdRxf1OmwA@mail.gmail.com>
Subject: Sparse worktree always contains root files
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi there,

I'm trying to use sparse checkouts in a large project, and one oddity
(bug?) came up.

If I do a normal full clone of a repository, then do:
    git worktree add ../sparse --no-checkout
    cd ../sparse
    git sparse-checkout set somepath
    git checkout
Now indeed it is a sparse worktree, but the files from the root
directory are also there.

This also happens with traditional (non-worktree) partial clones.
(I did both shallow, blob-less and tree-less, and all of them behave
the same way)

Regards,
-Jeppe
