From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: [PATCH v2 4/5] Make boundary characters for --color-words
	configurable
Date: Sat, 3 May 2008 21:41:26 +0300
Message-ID: <20080503184126.GA21187@mithlond.arda.local>
References: <46dff0320805020726y2592732cj9aef0111e5b2288a@mail.gmail.com> <1209815828-6548-1-git-send-email-pkufranky@gmail.com> <1209815828-6548-2-git-send-email-pkufranky@gmail.com> <1209815828-6548-3-git-send-email-pkufranky@gmail.com> <1209815828-6548-4-git-send-email-pkufranky@gmail.com> <1209815828-6548-5-git-send-email-pkufranky@gmail.com> <7vy76rtfns.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ping Yin <pkufranky@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 03 20:42:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsMgl-0007L4-1B
	for gcvg-git-2@gmane.org; Sat, 03 May 2008 20:42:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751745AbYECSle (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2008 14:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751721AbYECSle
	(ORCPT <rfc822;git-outgoing>); Sat, 3 May 2008 14:41:34 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:51172 "EHLO
	jenni2.rokki.sonera.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751633AbYECSld (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2008 14:41:33 -0400
Received: from mithlond.arda.local (80.220.180.181) by jenni2.rokki.sonera.fi (8.0.013.9)
        id 481789310035A942; Sat, 3 May 2008 21:41:29 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1JsMfm-0005Zp-IC; Sat, 03 May 2008 21:41:26 +0300
Content-Disposition: inline
In-Reply-To: <7vy76rtfns.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81113>

Junio C Hamano wrote (2008-05-03 11:18 -0700):

> Has this series been ever tested?
> 
> $ git diff one two
> diff --git a/one b/two
> index f9facd3..10c6195 100644
> --- a/one
> +++ b/two
> @@ -1 +1 @@
> -A quick(brown) fox
> +A quick(yellow) fox
> 
> $ tail -n 2 .git/config
> [diff]
>         nonwordchars = "()"
> 
> $ git diff --color-words one two
> diff --git a/one b/two
> index f9facd3..10c6195 100644
> --- a/one
> +++ b/two
> @@ -1 +1 @@
> A quick(<red>brown)</red><green>yellow)</green> fox

I've been testing but not quite sure what to think about the above
output. Is this more natural and expected output:

  A quick(<red>brown</red><green>yellow</green>) fox

i.e. no ()'s between the changed words? Although this

  -A quick brown fox
  +A quick yellow fox

has always became this:

  A quick <red>brown</red> <green>yellow</green> fox
                    ------^
  (Notice space here)           

So there is kind of "added space" but I guess technically it's actually
like this:

  A quick <red>brown </red><green>yellow </green>fox

So I think space is consistent with parentheses in your example.
