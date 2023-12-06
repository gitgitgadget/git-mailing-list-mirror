Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B137CBA
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 11:54:08 -0800 (PST)
Received: (qmail 5401 invoked by uid 109); 6 Dec 2023 19:54:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 06 Dec 2023 19:54:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28146 invoked by uid 111); 6 Dec 2023 19:54:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 06 Dec 2023 14:54:09 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 6 Dec 2023 14:54:07 -0500
From: Jeff King <peff@peff.net>
To: Vito Caputo <vcaputo@pengaru.com>
Cc: git@vger.kernel.org
Subject: Re: Minor UX annoyance w/`git add --patch untracked/file`
Message-ID: <20231206195407.GD103708@coredump.intra.peff.net>
References: <20231130192637.wqpmidfv2roqmxdx@shells.gnugeneration.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231130192637.wqpmidfv2roqmxdx@shells.gnugeneration.com>

On Thu, Nov 30, 2023 at 11:26:37AM -0800, Vito Caputo wrote:

> Couldn't the following two steps be done automagically by --patch:
> 
> ```
> git add -N path/to/untracked/file/wishing/to/partially/add
> git add --patch path/to/untracked/file/wishing/to/partially/add
> ```
> 
> when one simply does:
> 
> `git add --patch path/to/untracked/file/wishing/to/partially/add`
> 
> ?

They _could_, but keep in mind that the argument is not strictly a path.
It is a pathspec that may match multiple paths. So:

  git add -p path/to/

for example will pick up the tracked files in path/to/, but not your
untracked one.

It would be possible to distinguish the two cases, and only auto-add
files which are explicitly mentioned as full paths. But we usually shy
away from too many special cases like this, as the resulting behavior
can end up confusing and hard to explain.

-Peff
