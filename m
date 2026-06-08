Received: from cventin.lip.ens-lyon.fr (cventin.lip.ens-lyon.fr [140.77.13.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4C133F5AB
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 11:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.77.13.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780916679; cv=none; b=CzLx5DcQK5j7A2w2OdpeX3DCwb6F4r6KbSs7rrKLXYzFpNHGLdOglC3hy1J39Wuie0MjKexUwbnjZzx9B6JSjCfFQ31om77jurdOToat1NdmziphAF4Fa+ta7dfPC4c2BawfUP65uDrCoiGX8vq/J/Ge2/P/xNBMYh9FEmemcJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780916679; c=relaxed/simple;
	bh=J259+8vbMxsc+W3Wai2ZTQ2rAea1o3UYVzD3Wzabpd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mhooq7pRUX3uxep3hcnIYZ+B/smQHjThM9vSkl9k1SlRSVzS+/UOE5Mkv3HiabwD0kjjhCorO4Q19BhGpG15oLJ0FwMywl0PNF0q4131wSLyj304cnDe7Q7idTaalwHjNG7oUFReq27sNGw+RvLI0oJYe9ytzYeWfT/BKphOO3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vinc17.net; spf=pass smtp.mailfrom=vinc17.net; arc=none smtp.client-ip=140.77.13.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vinc17.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vinc17.net
Received: from vlefevre by cventin.lip.ens-lyon.fr with local (Exim 4.99.4)
	(envelope-from <vincent@vinc17.net>)
	id 1wWXgT-00000008bTQ-0vgi;
	Mon, 08 Jun 2026 12:58:21 +0200
Date: Mon, 8 Jun 2026 12:58:21 +0200
From: Vincent Lefevre <vincent@vinc17.net>
To: Michael Montalbo <mmontalbo@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Chris Torek <chris.torek@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Subject: Re: [BUG] "git diff --word-diff" gives a diff while they are only
 space changes
Message-ID: <20260608105821.GA2049040@cventin.lip.ens-lyon.fr>
References: <CAC2QwmKRyYfE+30Fh75gvAEmJjk8g-3k+G=RDiEJ-KGNExAEow@mail.gmail.com>
 <xmqq8q9migqk.fsf@gitster.g>
 <CAC2QwmKORPnsmV4SM_CnmhrbF+X754ae-n9m1fgjvVsL9d-wzg@mail.gmail.com>
 <89224cb5-27b1-45b6-93d8-a0ad5e2447a2@kdbg.org>
 <CAC2Qwm+BLNf-2kvePKNF-FKQX3raOBzSRmwd0ZEdzmo8TqkMGA@mail.gmail.com>
 <CAPx1Gvd_FqnsjCkpAA5uy7aDz9oQnWx7WTvKk-kLWemkqF9PsQ@mail.gmail.com>
 <xmqqo6ic8564.fsf@gitster.g>
 <CAC2QwmLXk=CXNo8+Ja0fL5pN1YYMTkh7XHAUwN1c9VxuFhyy4Q@mail.gmail.com>
 <CAC2QwmKjr2eiFNPPmERq7n-UjE-SF2vE4eHDanYE-4heWxzQVw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC2QwmKjr2eiFNPPmERq7n-UjE-SF2vE4eHDanYE-4heWxzQVw@mail.gmail.com>
X-Mailer-Info: https://www.vinc17.net/mutt/
User-Agent: Mutt/2.3.2+134 (513df32b) vl-188789 (2026-06-03)

On 2026-05-28 12:25:01 -0700, Michael Montalbo wrote:
> > Thanks for the ideas, Chris. Here is my attempt at synthesizing Chris'
> > suggestions and Junio's feedback:
> >
> >   The `--word-diff` option operates by taking the same line-by-line
> >   diff that is produced without the option and computing
> >   word-by-word changes within each hunk.  This may produce a
> >   larger diff than a dedicated word-diff tool would.  If Git
> >   acquires a different implementation in the future, the output
> >   may change.  Note that this is similar to the `--diff-algorithm`
> >   option, which may also change the output.
> >
> > Does this work?
> 
> Updated the patch with the revised wording:
> https://lore.kernel.org/git/pull.2113.git.1778686956622.gitgitgadget@gmail.com/T/#t
> 
> Please feel free to pick up, modify, or drop as appropriate.

Just to say that this new text is fine for me.

-- 
Vincent Lefèvre <vincent@vinc17.net> - Web: <https://www.vinc17.net/>
100% accessible validated (X)HTML - Blog: <https://www.vinc17.net/blog/>
Work: CR INRIA - computer arithmetic / Pascaline project (LIP, ENS-Lyon)
