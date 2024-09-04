Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220291DA319
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 18:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725474042; cv=none; b=UYRVwbISP+be1cX0AYIo8eaXP2BceyuqLvMg2MQBaun2kvChinVNIirDPlt6xGiQ4gHjUIMMJY96rtHtWVYNzdglwdm6ZbIkEh0A9EFXjQf2dF3+dE3VGidqzAuc41WSv5Hq6nCBjjGUk93mUZpXCfYQUagTqb+FPqtRVrM28kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725474042; c=relaxed/simple;
	bh=Ob2zHX0Pe3sfySMjSG6IUKm0z7pKAozH/JRWYualOmU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BhHjvoJMo1O+hx6E6O3AxgAGE3EK/nDnclthxthUEk8N/xmiXyQnc5wP+HdlCEO7dhdMwnCps6QOZLXBoi+E6uS1095WtJnGye5xvw9ZgjVb2cp6ATccW+Mva1CIFB1EbH/+TjGMQshx/r1xIwrfWfsQAwtxNW+CtH+yNPGhbEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VrBNyagX; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VrBNyagX"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5bf009cf4c0so7264835a12.1
        for <git@vger.kernel.org>; Wed, 04 Sep 2024 11:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725474039; x=1726078839; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CjIb8OZsgArob0NVKtYiBPznnrVqp3matgt8jEBKQlI=;
        b=VrBNyagXCpPmZXptlHHTVR2Y+dPZR8f5TVMu8+o+Cqqowp8+q+zXozzx4DQ7DxH2RT
         7BaSl5LJibSaYqRJ3/oZgmrEFIi2uAMM/MCFqN6KoFETh3GFBs2bIYvibcBbr9lSZxpH
         dBcIw/qyhrBi0I7CqgJLT7aUhg75UfHgHtHb1Jy/q98xqbLWFPWEBWT8aTMhPvGIo89Z
         hbL8y9F+21fVSnnoyUXN0NnI1aNjyuvLkoXA8xKjMAtyTPnC+WQOpCPxThJZHhlmkM+3
         88CR/0zxPauzBOgP4OAOrSs8ZSUSGC9AsL+MM95QIWt1Xsi0W9doz8exgN/yej7q9638
         HlTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725474039; x=1726078839;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CjIb8OZsgArob0NVKtYiBPznnrVqp3matgt8jEBKQlI=;
        b=TXpiZS9CM2u2sfV0226IcWD45K4dvz/jZ94j8Wgy4c87yMFNd6T+dMEDiQXeFhDNFc
         o41mgJq6BLFtp2y/lqd3uAS22dGlzQ7qev1jyaJI8chWRZjL51qeVEOnXEKYz4uJJTGO
         qzPCPlKFNlYwf3yPMXsytCQeL4BFFGVSsTJYQf8VDdKgESXqwcC+89VP+SRS+yCd80Ge
         /v3po8RDaiJjKWRuAwSEj8BJrI09XYNEve6ttM0Vy2nAPFNZm4FEj4zEzlxaMR2nnEQN
         DbC05ir2H8svux3mc7erjm6Wd8wxPtvxe4JnZFgwQpDr1U491oNnB90K88y8Ky1IOw6b
         Zdxw==
X-Gm-Message-State: AOJu0YzRib1UyyeVbIlvkqflJs3ErZ6RmfOoQkqGWX4b54gGAChBtqc8
	Ex0SkK3NHxd7gGvhCXmPApIa8buxK2wcEuegUmpe600+VXP2t50g
X-Google-Smtp-Source: AGHT+IG7uAl8+Uv9VMLiNIEHWReE0KwBN4pQ+Kl7Lw/iCWs17+4EfszbsLaqjU7OK0QjCuR+4pGqtg==
X-Received: by 2002:a17:907:2d9e:b0:a86:8368:860a with SMTP id a640c23a62f3a-a8a32edcf75mr395510766b.35.1725474039047;
        Wed, 04 Sep 2024 11:20:39 -0700 (PDT)
Received: from gmail.com (211.red-88-14-53.dynamicip.rima-tde.net. [88.14.53.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a623e3401sm20682766b.197.2024.09.04.11.20.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 11:20:38 -0700 (PDT)
Message-ID: <f3f863da-50bd-41e3-981c-df93ae771d24@gmail.com>
Date: Wed, 4 Sep 2024 20:20:37 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] apply: honor `ignore_ws_none` with `correct_ws_error`
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>
References: <6dd964c2-9dee-4257-8f1a-5bc31a73722e@gmail.com>
 <1eb33969-1739-4a27-a77b-3f4268f5519d@gmail.com> <xmqqseuqerb1.fsf@gitster.g>
 <afade304-51e3-441d-9ae6-e0a422d00bc4@gmail.com> <xmqqed66udmd.fsf@gitster.g>
 <50d85a93-6711-4b42-87a5-f26b58b8c5c7@gmail.com> <xmqqseugdo90.fsf@gitster.g>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqseugdo90.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Tue, Sep 03, 2024 at 09:41:31PM -0700, Junio C Hamano wrote:

> ... a new "silent-fix" that makes
> corrections in the same way as "fix" (or "strip"), but wihtout
> giving any warnings.

My main intention is not to make "fix" quieter, although it will
probably be a pleasant consequence.

Let's consider a sequence of patches where some whitespace errors in
one patch are carried over to the next:
    
    $ # underscore (_) is whitespace for readability
    $ cat >file <<END
    a
    END
    $ cat >patch1 <<END # this adds a whitespace error
    --- v/file
    +++ m/file
    @@ -1 +1,2 @@
     a
    +b_
    END
    $ cat >patch2 <<END # this adds another one
    --- v/file
    +++ m/file
    @@ -1,2 +1,3 @@
     a
     b_
    +c_
    END

When applying "patch1" with `--whitespace=fix`, we'll fix the
whitespace error in "b ".  Consequently, when applying "patch2" we'll
need to fix that line in the patch before applying it, so that it
matches the context line, now with "b".  Makes sense.

This applies not only to:

    $ git apply --whitespace=fix patch1 && \
      git apply --whitespace=fix patch2
    
But to:

    $ git apply --whitespace=fix patch1 patch2
    
Even to:

    $ git apply --whitespace=fix <(cat patch1 patch2)

So far, so good.

However, a legit question is: Why "a " is being modified here?:

    $ cat >foo <<END
    a_
    b_
    END
    $ cat >patch <<END
    --- v/foo
    +++ m/foo
    @@ -1,2 +1,2 @@
     a
    -b_
    +b
    END
    $ git apply -v --whitespace=fix patch
    Checking patch foo...
    Applied patch foo cleanly.
    $ xxd foo
    00000000: 610a                                     a.

Is this a bug?  I don't think so.  But the result, IMHO, is
questionable, and "git apply" rejecting the patch could also be an
expected outcome.

We are assuming an implicit, and perhaps unwanted, step:

    --- v/foo
    +++ m/foo
    @@ -1,2 +1,2 @@
    -a_
    +a
     b_
    END

We cannot change the default behaviour (I won't dig into this), but I
think we can give a knob to allow changing it.  This is the main
intention of the, ugly, new "_default" enum value.

And... as a nice side effect, we'll know when to stop showing warnings
when the user touches lines next to other lines with whitespace errors
that they don't want, or can, change ;-)
