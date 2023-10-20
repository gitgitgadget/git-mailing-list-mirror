Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66A1C2DF
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 06:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5F8D46
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 23:27:39 -0700 (PDT)
Received: (qmail 13214 invoked by uid 109); 20 Oct 2023 06:27:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 20 Oct 2023 06:27:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11378 invoked by uid 111); 20 Oct 2023 06:27:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 20 Oct 2023 02:27:43 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 20 Oct 2023 02:27:38 -0400
From: Jeff King <peff@peff.net>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Daniel Santos <daniel.dlds@gmail.com>, git@vger.kernel.org
Subject: Re: Pulling from a linux box to a Solaris 9 OS
Message-ID: <20231020062738.GA1642714@coredump.intra.peff.net>
References: <20A47898-41F6-4E94-822C-10509EC1E3B9@gmail.com>
 <ZTHK7o5LXvMB5EeJ@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZTHK7o5LXvMB5EeJ@tapette.crustytoothpaste.net>

On Fri, Oct 20, 2023 at 12:33:50AM +0000, brian m. carlson wrote:

> By default, if the SSH binary is the default ("ssh"), Git assumes that
> it's OpenSSH and sends certain options to enable protocol v2, including
> -o SendEnv.
> 
> If you don't want that, you can set "ssh.variant" to "simple", in which
> case Git will send only the username and the host, but not -p port, -4,
> -6, or -o.  If you do need a different port, then you're out of luck,
> and will either have to install Putty (in which case, the ssh.variant
> value would need to be "putty") or upgrade OpenSSH.  Otherwise, the
> simple value should work fine.

I think your suggestion is the most straight-forward one, but just in
case the "out of luck" part is a problem, you should also be able to
side-step the issue with:

  git -c protocol.version=0 fetch ...

That would allow other features (assuming this older ssh version
supports them!) without triggering the SendEnv option.

-Peff
