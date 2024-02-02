Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875541FCA
	for <git@vger.kernel.org>; Fri,  2 Feb 2024 13:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706881562; cv=none; b=aARo0hQb7LbNGgealjLVjx5N3iEoMsR+P81CzRzhZ3PRd//LlwF+Ong8ItubWT1Fgz+/nPzceWbIRc0xmGJiNule6p+DfAuKBHGPoKLPcBb9RcByvkw0GBGcqMWQYOL6T2Dc40+rtOx4UgzWdFrPhmDWb7x97jHbcobnqkOe6nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706881562; c=relaxed/simple;
	bh=4nT8wsieZNSbo3DhhUzjg8fvNNVzBwPR9KiVYRdbpoc=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=lsQkVIJ7xFXpNFLeTdG1I8uNHhWK6eg+jVd0n+P1bG2wM45NIpNC1HeXA23DgqaO6Fqkho17B/oLDOY062Z6FdAIt7H59WWTIDcmzEipxTddOADlX/CgpYZI8IEJIdOIG1q3skjvg0fuYYSHYmtbzNPWTwbOLvdJFFLg7HkZMJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KwjJVsMF; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwjJVsMF"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-51121637524so3129611e87.1
        for <git@vger.kernel.org>; Fri, 02 Feb 2024 05:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706881557; x=1707486357; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:date:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vSatjwGdY+jO1diFqAjrDB1CxsYkWhl3PCB1Zzxa368=;
        b=KwjJVsMFU5iiIdl/TPshg4VJKOvesgqD0QhSaeyFeu0l+zbXF6EaOz4nefJBRYE8SA
         Doha5HjnoAtejA2KxAyobzKnP5EdoQ1Uv5Unc/L3hTnFlMwr0froLEg9GSrd/UxkOX6I
         xW9K3HQ1geVF5Ynqkp4IPRglLzm0KuC7k7S4HLDEe5Avv0k8IaGdHH6rlj38pJCBBzIS
         oja7J/8casFxybOcH+4STRgmNDWyL0SFYv+6EeMOMSIwt/DK5umJTV6+z3HnRabeXqx3
         zoIxxZZ2C1E83bXd3zT3LgXi7PT0fm+qg1mM9tf5FSBv/2USbNi+1JajqTLgWceFraVw
         MifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706881557; x=1707486357;
        h=mime-version:user-agent:content-transfer-encoding:date:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vSatjwGdY+jO1diFqAjrDB1CxsYkWhl3PCB1Zzxa368=;
        b=sNsopjFvkkrv3GculjulN2fty4rwz0+2jU5ErMNkWyfgLqMjXvMR88mPAPgiyTskcT
         Agv+ZAIUXdSg2JCuEsp9MToBsDefRf6W5Ow6KQU8/Q/+J5mCAqMUuynhA37ncka6unfB
         UelOOrSx91H6vzBgqfb0tvSw4h2FkQGYU1gNHiYOja9MqOszuumwEtoEY7Muj7rrPsz1
         RxKu80O0JkjFtnSjT0x0x0sGsMVkf8jhZ5QJAbTPcff/kdTyZQXX4KfPZ27AUgQRvoKZ
         DjwtCDlH4tOPmE7ip8PwvRmsIyALpsqRt17HdJTg47JoNvv+F++yzt/edtH8576auCXF
         4B8g==
X-Gm-Message-State: AOJu0Yz/qAL7nTPbZchVus6fQLwguT+BeWgwCVC0qwJl3aBt77JMn5jc
	O1YouGgyWM5kGvllJuldYTOIMoT9iSPYfNFgIhFF9X2zP3sUMNpCCW+Z/IXQlbE=
X-Google-Smtp-Source: AGHT+IFOpRY2Q8zVosuIJpvOIHqGv+lOZ9JusqzdvFyEJCxw/CLi0m5ppLJi8kWalbaPxlNQqSpKyA==
X-Received: by 2002:ac2:558a:0:b0:511:22ba:c0a7 with SMTP id v10-20020ac2558a000000b0051122bac0a7mr3905867lfg.17.1706881557484;
        Fri, 02 Feb 2024 05:45:57 -0800 (PST)
Received: from [192.168.2.3] (mob-5-91-249-116.net.vodafone.it. [5.91.249.116])
        by smtp.gmail.com with ESMTPSA id z2-20020a05600c0a0200b0040f0219c371sm2730221wmp.19.2024.02.02.05.45.56
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 05:45:56 -0800 (PST)
Message-ID: <0e88ac8ad60d2da689d0a308cc59a02d468bc15f.camel@gmail.com>
Subject: single-char options
From: Martin Guy <martinwguy@gmail.com>
To: git@vger.kernel.org
Date: Fri, 02 Feb 2024 13:45:55 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

I'm sure this must have been thought of before and rejected, but us RSI
sufferers would like to be able to say "git rebase -c" for "--continue"
not only for speed and ease, but for all the other RSI sufferers out
there.

I mean, yes, I can implement them for myself (at least for the most
common long ones) but wondere what the zeitgeist was on this issue - at
least that way they would be the same letters for everybody.

Thanks

    M
