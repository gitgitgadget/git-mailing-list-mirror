Received: from vuizook.err.no (vuizook.err.no [178.255.151.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACA82C859
	for <git@vger.kernel.org>; Thu,  4 Jan 2024 22:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glandium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=glandium.org
Received: from p3911224-ipxg00k01tokaisakaetozai.aichi.ocn.ne.jp ([114.166.160.224] helo=glandium.org)
	by vuizook.err.no with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mh@glandium.org>)
	id 1rLW9Y-00472s-2V;
	Thu, 04 Jan 2024 22:25:30 +0000
Received: from glandium by goemon.lan with local (Exim 4.96)
	(envelope-from <mh@glandium.org>)
	id 1rLW9R-002y44-0y;
	Fri, 05 Jan 2024 07:25:21 +0900
Date: Fri, 5 Jan 2024 07:25:21 +0900
From: Mike Hommey <mh@glandium.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: Stefan Haller <lists@haller-berlin.de>, Taylor Blau <me@ttaylorr.com>,
	Patrick Steinhardt <ps@pks.im>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, git@vger.kernel.org
Subject: Re: Concurrent fetch commands
Message-ID: <20240104222521.nb3fxipg7ayolxvo@glandium.org>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
References: <xmqqy1daffk8.fsf@gitster.g>
 <ZZUNxNciNb_xZveY@tanuki>
 <ZZUWmy3rTjpBsH-w@tanuki>
 <ZZU1TCyQdLqoLxPw@ugly>
 <ZZU5s4LKQF1NLgnC@tanuki>
 <ZZWOBObBmLW9Nid6@nand.local>
 <xmqqwmsq83v3.fsf@gitster.g>
 <80efcb43-122c-421a-b763-6da6ff620538@haller-berlin.de>
 <20240104205408.h5wvcissfbat7acw@glandium.org>
 <xmqq34vc7nl1.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq34vc7nl1.fsf@gitster.g>

On Thu, Jan 04, 2024 at 02:14:50PM -0800, Junio C Hamano wrote:
> Mike Hommey <mh@glandium.org> writes:
> 
> > On Thu, Jan 04, 2024 at 01:01:26PM +0100, Stefan Haller wrote:
> >> On 03.01.24 23:10, Junio C Hamano wrote:
> >> > Folks who invented "git maintenance" designed their "prefetch" task
> >> > to perform the best practice, without interfering any foreground
> >> > fetches by not touching FETCH_HEAD and the remote-tracking branches.
> >> 
> >> That's good, but it's for a very different purpose than an IDE's
> >> background fetch. git maintenance's prefetch is just to improve
> >> performance for the next pull; the point of an IDE's background fetch is
> >> to show me which of my remote branches have new stuff that I might be
> >> interested in pulling, without having to fetch myself. So I *want* this
> >> to be mucking with my remote-tracking branches.
> >
> > Use `git remote update`?
> 
> Hmph, it seems that it does not pass "--no-write-fetch-head" so it
> would interfere with the foreground "fetch" or "pull" the end user
> consciously makes, exactly the same way Stefan's demonstration in
> the first message in the thread, no?

Interesting, I never realized it updated FETCH_HEAD, but it does. All
the entries are marked "not-for-merge", though, whatever that implies.

Mike
