Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE838225416
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 08:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751359860; cv=none; b=tKHLVeLyQANKD03MRhbG3U+SJpU2OxkFXR9+PvZHKLQGR5pr69HFCvE//s8yOKhlwhJCIsGkAz3GNXQeM95TKPMzzYcyUaPXJNNl/q8qPihhNpdtFFIm/wpJKJcS4r+j6f3gnYm6cv1fevUMPT93kRNfLQ4D46DlTdvPgn8invA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751359860; c=relaxed/simple;
	bh=ZQepYDXPNlqDkUNV3tOzR9MIwSGxCrIo0UO+GWV+PR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S7L9SCUChNASqp9m9agi1kmpDT6fpqUlIgOjLMQIVL18tNG0da8d0+8B6XkB31Biv3UrIKWRedLg9r1zwaO6KkhwG1DqAFxXGh+WFUTfuvfPXDN7ligpxwIZq+R6u3VWNi0PAD9LqzjpYTJdZJl6c0gjOoFpezoMC/X6+o2B8wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DUQPfm+X; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DUQPfm+X"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ade5a0442dfso1030415366b.1
        for <git@vger.kernel.org>; Tue, 01 Jul 2025 01:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751359857; x=1751964657; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iDKOcsdHNVVmBZ/RAmC5tYvc7GHf5GEaUy2ywHqjhck=;
        b=DUQPfm+XS2tHMIRdPmJncxik08tY8WKGMvY/dP0dlDtRYTojGGkb+/PAubhon8aUnP
         liBVcgy8dwEhsVA9iX1Jff/Fcn8M4Dh8Gu9FYSIcBrL2W4j89yXQDSeUT6gIs8KvaXgy
         NMVJq5Ci0iKJhbxgO6z+icsMhyNQgU4GMXH3mugod7pRv3LhnfG8MegLqjudGA0jBfhX
         tokYD+iBHBlouvsKAA5401k4ujqvsbO/ws8UIdsUH/dP9+XwkhITX4//W8EEZZn+f+q2
         wMRZ+te6Vv7KaDdpywRjp8xybEz0ZkSbVHbSU4ZnSDvxd8XmnJYIBduDBN8vcr7KU/uo
         eQSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751359857; x=1751964657;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iDKOcsdHNVVmBZ/RAmC5tYvc7GHf5GEaUy2ywHqjhck=;
        b=jS2Dvicm9i0hwu0ZnYc3BVOd6jouiKpY1+BYMhN3sImlZeIUIeRBWqocMIQhQK0wvD
         f7Nbj2Obd/vTy0RkdtSt38HuiWnsmHjPdQGZt4uItbNZhNu6qFAq+6sPyI0u9CGQLjae
         eaR4aGwvjAedMaS8Ud0UAecV4wFPJ0flENJsWV4BfQVWH7t907a1VyCmC8HraTXOUNuB
         Vd45j/7etH+8xumh22hE5LaAbfqYFQfv7yK7wRY3IAjcrZgPlheUfFRUGTUxjoV/dUsU
         zffKsysWkODDXszqawyDJYxTjsNy3XfJ3eJ3vaE4pcqeZsSMUpd5djvlbA/d1341Ze2b
         P0Ig==
X-Forwarded-Encrypted: i=1; AJvYcCVwcuptHR89r11RIbEDOHtAOaMjqsLWjoSuskZ/vXCxoJsGNM6bzWuTOlp/xd3iCGaU+mY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5VEIs4ZD8f0bFbS6aLJJX6kYkBqM39DT8UGqY1ysi2eg5EmW8
	EGRAsOPiSSdRWv57NAcrXyMT2ChjCLTFAiEGhpVNn2i2Mk+VBRh0ZlQU
X-Gm-Gg: ASbGncszJOw6GRppeeVuSvpwG3dC7Qqfhn5QcldH/4nl+6aQnop0Awtu5ywjWsXmMj8
	1WyrWJdy0yUPatYvYKMIVKA2WQftTx7GJ6H0QUcpMd1mKfEbMc6KTk7yJ7KEX4DUtflu/RRSFGW
	rA7MpVHtYMzF6/TqmOqaDRwnrF5EYdkp0GLVi8NGTzBzgrqlvh8YQUAUnn/J5tqZwlvIjjzOsR2
	cxsgmH18YpRAeKr3xNDdgpjXIXiv/6TQt1gzF6pm4sv1WT90pOC4tueECweufpf114jJ8DRQVJ+
	LXwwAEA72m8MWEE34zm+fbl/cdZ2eKHYS+ys+lp7G84XjX1017civrim+bKr9ACJaJkKfl4swiV
	CpGhzNMnr/pQ=
X-Google-Smtp-Source: AGHT+IHq10FsNDvZTqVEyUmcl7PwX//Q+Exv3uLe1qhkbKrsHoxVyuwILINJ5WDujgJ8B2JvIHprpg==
X-Received: by 2002:a17:907:7e95:b0:adb:469d:2246 with SMTP id a640c23a62f3a-ae34fd89929mr1483532966b.17.1751359856703;
        Tue, 01 Jul 2025 01:50:56 -0700 (PDT)
Received: from localhost (94-21-37-48.pool.digikabel.hu. [94.21.37.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae35417b9d8sm814616466b.184.2025.07.01.01.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 01:50:56 -0700 (PDT)
Date: Tue, 1 Jul 2025 10:50:43 +0200
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Lidong Yan <yldhome2d2@gmail.com>, git@vger.kernel.org,
	Lidong Yan <502024330056@smail.nju.edu.cn>
Subject: Re: [PATCH 2/2] bloom: enable multiple pathspec bloom keys
Message-ID: <aGOhY2YuJZNG8ovj@szeder.dev>
References: <20250625125541.3048632-1-502024330056@smail.nju.edu.cn>
 <20250625125541.3048632-3-502024330056@smail.nju.edu.cn>
 <xmqqy0td8fa9.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy0td8fa9.fsf@gitster.g>

On Fri, Jun 27, 2025 at 06:50:22AM -0700, Junio C Hamano wrote:
> Totally outside the topic, but I wonder if we can further optimize
> by adding an early rejection using .nowildcard_len?  Instead of
> allowing a wildcarded "dir/*" pathspec element from disabling the
> Bloom filter altogether, we could say "dir/ is not possibly altered,
> so there may be dir/A, dir/B, etc., in the directory, nothing that
> would match dir/* wildcard would have been modified", couldn't we?

Indeed, that's what I demonstrated back in:

  https://public-inbox.org/git/20200529085038.26008-35-szeder.dev@gmail.com/

