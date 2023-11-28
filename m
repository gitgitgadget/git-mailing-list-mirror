Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jVJZht0V"
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCF3D60
	for <git@vger.kernel.org>; Tue, 28 Nov 2023 04:40:59 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-507c5249d55so8124865e87.3
        for <git@vger.kernel.org>; Tue, 28 Nov 2023 04:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701175257; x=1701780057; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z0xSm3ssuhXB9Dbs/i3I3UysmM/8Z3+kVFydY4+llJ4=;
        b=jVJZht0VZAqpgFimY79XcQ4WYc57wV643dOd2K+Ap41NjqH+iyHqF3stOBZYqrF9cY
         EzAzGdhTt69VmZ0Qn/B16EuzXn49SAf32g3DDAVr64k0NUZJA2FjMOhuICF4HaZ/3yMp
         tc1AbG6iEfalODF4F0Cwxg5maEdTxvbHsisPgoDaImYRYJd8qLQS1ZBHoLcDxMV2hYv5
         egG9YKLlesuNMNfqABc/osRyilIV0l+nZmqeslB4tcOkhkkHgm3GgV4oFprEO3QAKHB1
         Zyrz5Q24lhxH5MWoH4lFlDHOdWbA6Bi+/Y0v6bpAL4e9bVWyEryx6pzEo6CbIyxme2YV
         fKFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701175257; x=1701780057;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z0xSm3ssuhXB9Dbs/i3I3UysmM/8Z3+kVFydY4+llJ4=;
        b=pkVddpxWkU9sl0xlNo6oQ4zIF5siLgx7a5svwOnWHAo3tughHJK5cDEke4TsjKQ3yO
         DdG4q1WWIc7Ex0TqcBEEX3XNRVoGx27iB3YfG4Sbhh40CXXzHLB2sHi8DMDoJdGFxTNd
         lJmAhTDINtst6v9n/HYO/oZqf+oHeilPUJ/pCEG3Y/JYtQOOcR9RgXssY67s+wp3ll+/
         Eqj4JBpX+bxn4gfm6jD3rievkyRW07dK0oJgExAbeXbShVBDB5zQLuNJa1WXehYdPdy1
         MxACEnXRu6JtRgJ2dUlufGxU5zSX8G3DiJUlIW4DT6otocVZ4EwviD3uMhyPy9x+Yxwk
         fp4Q==
X-Gm-Message-State: AOJu0YxgSl2ltxyWuRcQsXa64AUo7uYRjwkqmWA5UnVAP1f/CJt2iXj7
	kVbDlWZTEhMSQ5hHU0HPswE=
X-Google-Smtp-Source: AGHT+IGrLlfr8LQsEVakNuDUi+DUGtBVPWAAsWHs8KKAKfEKG5ZGXVHcAMg2+XxcfE7sv+OZrGUphw==
X-Received: by 2002:a05:6512:31c3:b0:50a:a6d2:b5cd with SMTP id j3-20020a05651231c300b0050aa6d2b5cdmr14141109lfe.53.1701175256954;
        Tue, 28 Nov 2023 04:40:56 -0800 (PST)
Received: from localhost (92-249-246-133.pool.digikabel.hu. [92.249.246.133])
        by smtp.gmail.com with ESMTPSA id g18-20020a05600c4ed200b0040b4ccdcffbsm2028441wmq.2.2023.11.28.04.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 04:40:56 -0800 (PST)
Date: Tue, 28 Nov 2023 13:40:54 +0100
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH] completion: add and use the __git_get_config_subsection
 helper function
Message-ID: <20231128124054.GA1964@szeder.dev>
References: <20231113222528.62771-1-szeder.dev@gmail.com>
 <xmqqzfzh16qp.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqzfzh16qp.fsf@gitster.g>

On Tue, Nov 14, 2023 at 10:08:46AM +0900, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
> > +# Lists all subsections in the given section which contain the given
> > +# config variable, with the section and variable names removed.
> > +__git_get_config_subsections ()
> > +{
> > +	local section="$1" var="$2" i IFS=$'\n'
> > +	for i in $(__git config --name-only --get-regexp "^$section\..*\.$var$"); do
> > +		i=${i#$section.}
> > +		i=${i%.$var}
> 
> As this script is allowed bash-isms, I wondered if we can use
> a single pattern substitution instead of two remove pre/suffix
> pattern substitution, but I guess it would not work, and the above
> is perfectly readable.

Yeah, I don't think it's possible to remove the prefix and suffix with
Bash builtins in a single operation.

> > +		echo "$i"
> 
> As the subsection is designed to contain unbounded set of end-user
> controlled names, we probably should do
> 
> 		printf "%s\n" "$i"
> 
> instead to protect us from interesting names (e.g. ones that begin
> with a dash).

Indeed, will do.

> > +	done
> > +}
> 
> Interesting to see that we do not need to bother deduplicating the
> output from here.

Bash will sort and deduplicate the completion words anyway, so we
don't have to.  Sometimes we do deduplicate them, though, but either
to make testing easier or for performance reasons; in this case
neither of them applies.

> > diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> > index a7c3b4eb63..11ed83d0ed 100755
> > --- a/t/t9902-completion.sh
> > +++ b/t/t9902-completion.sh
> > @@ -2130,6 +2130,19 @@ test_expect_success '__git_get_config_variables' '
> >  	test_cmp expect actual
> >  '
> >  
> > +test_expect_success '__git_get_config_subsections' '
> > +	cat >expect <<-\EOF &&
> > +	subsection-1
> > +	SubSection-2
> > +	sub.section.3
> > +	EOF
> > +	test_config interesting.subsection-1.name good &&
> > +	test_config Interesting.SubSection-2.Name good &&
> > +	test_config interesting.sub.section.3.name good &&
> > +	__git_get_config_subsections interesting name >actual &&
> > +	test_cmp expect actual
> > +'
> 
> Good to see an uppercase character is used here ;-).

That's just for good measure, but not really necessasry here, as that
primarily tests that 'git config' lists the section and variable names
(but not the subsection!) normalized to lowercase, no matter what
CaMeLCase the user might have written them.

