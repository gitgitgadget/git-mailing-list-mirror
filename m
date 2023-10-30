Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D993733E8
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 09:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F97D46
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 02:54:02 -0700 (PDT)
Received: (qmail 1724 invoked by uid 109); 30 Oct 2023 09:54:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 30 Oct 2023 09:54:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9833 invoked by uid 111); 30 Oct 2023 09:54:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 30 Oct 2023 05:54:07 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 30 Oct 2023 05:54:01 -0400
From: Jeff King <peff@peff.net>
To: Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Alexander Mills <alexander.d.mills@gmail.com>, git@vger.kernel.org
Subject: Re: please add link / url to remote - when - git push
Message-ID: <20231030095401.GA848451@coredump.intra.peff.net>
References: <CA+KyZp5mwGJ6YOvjKtfnDMDb9ci3vSq5KNUep6-8EfkHNaxREg@mail.gmail.com>
 <20231030063633.GA7451@tb-raspi4>
 <20231030085205.GF6241@kitsune.suse.cz>
 <20231030090626.GA84866@coredump.intra.peff.net>
 <20231030093023.GG6241@kitsune.suse.cz>
 <20231030093919.GF84866@coredump.intra.peff.net>
 <20231030094556.GI6241@kitsune.suse.cz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231030094556.GI6241@kitsune.suse.cz>

On Mon, Oct 30, 2023 at 10:45:56AM +0100, Michal Suchánek wrote:

> > Yes, this is a problem. Those messages are streamed out as we receive
> > them from the server, and before we get any status report back. I don't
> > think we'd want to buffer them, as they can be arbitrarily large (and
> > may even be progress reports that are meant to be shown in real-time).
> 
> Not when the user asked to not show progress.

Sure, if you make the buffering behavior dependent on the presence of
"-q". I guess that is not that hard to do, but it does increase the
complexity of the code (you have both a streaming and a buffering code
path).

Anyway, I am not all that convinced this is a fruitful path versus just
fixing the server side. But if you want to look into writing a patch, go
for it.

-Peff
