Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="kUEyamzf"
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608DD198E
	for <git@vger.kernel.org>; Fri,  8 Dec 2023 14:58:54 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-77f58040770so39310785a.2
        for <git@vger.kernel.org>; Fri, 08 Dec 2023 14:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1702076333; x=1702681133; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3zPzapZV75TLMx2wm/7Djlv8cYN9RHdSET46BZyw5wM=;
        b=kUEyamzfaWTp5eHL/wFnwwtfXa9ideOmMXYaVsxVDN+bU0X7Im28rlzXHqYY3RrEcT
         60GS5Fna6tOfYxDtyWsFr59OHuemYMrOM1ZA0iWmkHeQeFfBhyRfAODQyb4L1qjdnVCo
         PLJR/E1JWLdizU+BbCb/SBFFZJ9tXlyPv46mSV61epECMrqfrLFOKStK4o7ZCzObiGAb
         KKwGrA50U9bFf3mXOQtDdeejAEC6tUOusaL4CIN7etE4ViZh3P74oa8Ehwx2KpFyy5+n
         JvQ9GuBRjUYHUgAmTUcxiZXidylJdRsKE0PRs8xuH2fWLxYob9y0nzE1FaOZ3s2H9wn6
         Tg6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702076333; x=1702681133;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3zPzapZV75TLMx2wm/7Djlv8cYN9RHdSET46BZyw5wM=;
        b=nEmYd5Vf5PcSIbHywIN/gRFIeNrpn4+d7fKrXAlIT5Y2gUEzITpI4tWujgEPG1ZuWJ
         tqCZxZoZBnJUaD86MwcM90RTVElR8Kk8+3TVsEuK4sD8G3U4/Lvf5qbBigcUPipdi+WF
         MLRsuc7fXZ0tachUNfBr+e7C9crrQI7HLSYsZ5EViKEm7OSRe1SmiNOQ5Avkdu+17XC9
         VK7VgPkl9Jb5GxfScFqvluA3Vvy7fSxtGMadt1+MOlKAAPvW1n9+hFTv8XZ3PJaK4aOf
         peCVh1xl5Plh0tDqExBkLHc+eP/bvg48sxityQxebqfe5aETJwmgh6JxOo6shDR2WaUD
         pV5g==
X-Gm-Message-State: AOJu0YxoGedIBTCXOj/0QACb4lkJRQg5kNmvnZLoBWzYxHFWeI10wiH7
	4F3L2mNeOGwUPkeNRPbcNrlDgdbZXymWt/hAWFo=
X-Google-Smtp-Source: AGHT+IFfOSlSVw9LkinfedwdnPQe2CNU9I3GkCzYUK1r1pE5dk7qu7iYuFgSpRddAKGT1w1k8aMwtQ==
X-Received: by 2002:a05:620a:389b:b0:77d:cc40:252e with SMTP id qp27-20020a05620a389b00b0077dcc40252emr760617qkn.51.1702076333518;
        Fri, 08 Dec 2023 14:58:53 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s8-20020a05620a080800b0077d742fb27esm1013383qks.49.2023.12.08.14.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 14:58:53 -0800 (PST)
Date: Fri, 8 Dec 2023 17:58:52 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 3/9] imap-send: don't use git_die_config() inside callback
Message-ID: <ZXOfrKYsmOjOHGmj@nand.local>
References: <20231207072338.GA1277727@coredump.intra.peff.net>
 <20231207072458.GC1277973@coredump.intra.peff.net>
 <ZXGJE-pkb3BjlO-d@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZXGJE-pkb3BjlO-d@tanuki>

On Thu, Dec 07, 2023 at 09:57:55AM +0100, Patrick Steinhardt wrote:
> On Thu, Dec 07, 2023 at 02:24:58AM -0500, Jeff King wrote:
> [snip]
> > diff --git a/imap-send.c b/imap-send.c
> > index 996651e4f8..5b0fe4f95a 100644
> > --- a/imap-send.c
> > +++ b/imap-send.c
> > @@ -1346,7 +1346,7 @@ static int git_imap_config(const char *var, const char *val,
> >  		server.port = git_config_int(var, val, ctx->kvi);
> >  	else if (!strcmp("imap.host", var)) {
> >  		if (!val) {
> > -			git_die_config("imap.host", "Missing value for 'imap.host'");
> > +			return error("Missing value for 'imap.host'");
>
> Nit: while at it we might also mark this error for translation. Not
> worth a reroll on its own though.

This string goes away entirely in the next patch, so I don't think we
need to mark it here.

Thanks,
Taylor
