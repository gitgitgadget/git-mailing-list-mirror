Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF4518C332
	for <git@vger.kernel.org>; Fri, 18 Oct 2024 21:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729287367; cv=none; b=l8Qd5RvHbzPp5yKEG1kLmwvrlOfFWlqmKQhTeciEQUgl3n91YTFtsutSAP7x7wojdm1u/o/1J6mXWQKRB6O2y657nnO60vOz9fmKb6aoK1sxpAzePsq5Ix0BgfW4zgD1+dkddgm/ZHtjvUm2LDHu+/wQc8WxX5orwj1gllN9vi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729287367; c=relaxed/simple;
	bh=xJ2gQrh0y9gF/tlqwhj+bw/Eq2Vg7Ah9dBmKZlNbDLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GwZUsBv6DHgcygMv9xjxx3jGWThzinZ5MIPBUkLNYBMFANDPfGjoopqNwqHuzuc3S8lMC2YNaRKhG3Kn1iX1/kHGIRrDfcHz6Ndt6uuYelTaqvL0LV+Up10rvEPh+seySotlA68wtz19mELjSYadVSmS0TZU31bFdrFEKqKjbg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=1hnrkebF; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="1hnrkebF"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6e396a69062so25053327b3.0
        for <git@vger.kernel.org>; Fri, 18 Oct 2024 14:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729287361; x=1729892161; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m3Bzw1C/2dVPfnIgcrXVcH0EyhHR2z5VMQ5wmViobds=;
        b=1hnrkebF2MO9rXEg9rDzXJbq2Q/7Z3VKFN18DYaPdcerg44K9PtxdCKb3VPZPUNyOO
         KnOq8J76+PTWqxnTkoSoEueLWYmB1bth7TlXK8/g8cOG51/vd4j0DlbX4PPSnuumFh8H
         H1UtLRgTrkFW6Mubu0pwzdroINaVOrY4TakHVD2P6R0jT+I3RnaPkmQnXRu9rn0Zr6ZF
         mXKiK9aNHbezvnpb94jDUOZIE/ry+8jkR5+FxvA9KRtllQUaFE0qiUwYwDFEiSmU5zCy
         b1E6oF/YbCOd9YBtoJFDnkOBOTxv/RDl7J2Spqmb4QG4Cg3kR/BOGpx39cahSM0P+Cii
         u4Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729287361; x=1729892161;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m3Bzw1C/2dVPfnIgcrXVcH0EyhHR2z5VMQ5wmViobds=;
        b=nO5fLuQ5kIn0zWjZ7AvJV/UsJKQ33fbW+FFfila6I1tzr2tXJQ71K3QJwOEiYIR3cE
         twYCjiikQJA2FuNU1ClKmWNhqHc+fZnqDW8aOPhe6eOY+hLFmgD43MEd1cLbfgVl7G3K
         MaCUJFiHbRFrwb0UkMbh7yMmiG1P6DyknNv86PT3YUJwpXhDlac/gAaNYo50Y0sM1lQ9
         FNmEyJo/0zHz5n/5kGqDdoeoXKIOcb3RRRgs6CJOV74wWQcBrqIWv6Oa8p8dvIvrC54U
         6ycwKgvCeT0u3eMVTJ8FijT1gpWZDKTq7wZAF5WIrqa7yqe3E6vXRdvS6c/GRT54eHVJ
         +HfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBJ9o7tK5guesc01U+UizAuQQlXGiQGXMuQZvGkf0vKkfzZW/iNdjjKQwRbl5RYpJw184=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAMOKn3mS9wZLAWdoxT+i9WgLJRzxTs3rgWlQIocJtJgAY1Uac
	VyA4NjxaqxS8vVilenEQkeP8Dy1Ni2np06fmWD3Rj41rMh5QQpYHnCTvbistTVQ=
X-Google-Smtp-Source: AGHT+IH0HAjRnZnAyOXvACUke1GSJLQNFe4X8CC+9sKMIWteF1JOoAn2NBmcEVgN21KChPo3tbrzow==
X-Received: by 2002:a05:690c:6484:b0:6e5:bca9:cb75 with SMTP id 00721157ae682-6e5bfc84b07mr50131887b3.19.1729287361209;
        Fri, 18 Oct 2024 14:36:01 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5c0111fc3sm4736127b3.62.2024.10.18.14.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 14:36:00 -0700 (PDT)
Date: Fri, 18 Oct 2024 17:35:58 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH v2 0/3] parse: replace atoi() with strtoul_ui() and
 strtol_i()
Message-ID: <ZxLUvlN9f7QP+kdY@nand.local>
References: <pull.1810.git.git.1728774574.gitgitgadget@gmail.com>
 <pull.1810.v2.git.git.1729259580.gitgitgadget@gmail.com>
 <ZxLRdu4cPDgPLpCz@nand.local>
 <CAPSxiM_dcpmpAsbo9wmXSDqGWXxU==QLfdVpowK5Xv-LW9iLCQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPSxiM_dcpmpAsbo9wmXSDqGWXxU==QLfdVpowK5Xv-LW9iLCQ@mail.gmail.com>

On Fri, Oct 18, 2024 at 09:29:44PM +0000, Usman Akinyemi wrote:
> On Fri, Oct 18, 2024 at 9:22 PM Taylor Blau <me@ttaylorr.com> wrote:
> >
> > On Fri, Oct 18, 2024 at 01:52:57PM +0000, Usman Akinyemi via GitGitGadget wrote:
> > > Changes from Version 1:
> > >
> > >  * In my initial commit, I mistakenly included changes from a different
> > >    patch and commit. This issue has now been resolved.
> >
> > Should we treat this as a new series, then? Or is this a true reroll of
> > the previous round and should be kept together?
> Hello Taylor,
> Yeah, this should be treated as a new series different from the two below.
>  - t3404: replace test with test_line_count()
>  - t3404: avoid losing exit status with focus on `git show` and `git cat-file`

Gotcha. So in the original ua/t3404-cleanup series from my tree, I
should drop the third and final patch:

  parse: replace atoi() with strtoul_ui() and strtol_i()

?

Thanks,
Taylor
