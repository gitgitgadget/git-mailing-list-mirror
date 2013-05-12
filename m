From: Kevin Bracey <kevin@bracey.fi>
Subject: Re: [RFC/PATCH 0/2] merge-base: add --merge-child option
Date: Sun, 12 May 2013 20:29:38 +0300
Message-ID: <518FD182.5020606@bracey.fi>
References: <cover.1368274689.git.john@keeping.me.uk> <518FB8DE.7070004@bracey.fi> <20130512162823.GK2299@serenity.lan> <20130512165829.GM2299@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun May 12 19:29:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uba5j-0000Ex-D6
	for gcvg-git-2@plane.gmane.org; Sun, 12 May 2013 19:29:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754785Ab3ELR3n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 May 2013 13:29:43 -0400
Received: from 6.mo1.mail-out.ovh.net ([46.105.43.205]:59638 "EHLO
	mo1.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754754Ab3ELR3n (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 May 2013 13:29:43 -0400
Received: from mail615.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo1.mail-out.ovh.net (Postfix) with SMTP id 7AFADFF8A10
	for <git@vger.kernel.org>; Sun, 12 May 2013 19:29:41 +0200 (CEST)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 12 May 2013 19:30:04 +0200
Received: from 85-23-153-122.bb.dnainternet.fi (HELO ?192.168.1.10?) (kevin@bracey.fi@85.23.153.122)
  by ns0.ovh.net with SMTP; 12 May 2013 19:30:02 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.0; WOW64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
X-Ovh-Mailout: 178.32.228.1 (mo1.mail-out.ovh.net)
In-Reply-To: <20130512165829.GM2299@serenity.lan>
X-Ovh-Tracer-Id: 15103384301322997761
X-Ovh-Remote: 85.23.153.122 (85-23-153-122.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: -100
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrjeegucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-Spam-Check: DONE|U 0.500015/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrjeegucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224059>

On 12/05/2013 19:58, John Keeping wrote:
>
> With the patch below, the --ancestry-path version drops to under 2
> seconds.
>
> I'm not sure if this is a good idea though.  It helps me say "I know
> nothing that isn't on the ancestry path can be patch-identical, so don't
> bother checking if it is" but it regresses users who want the full
> cherry-pick check while only limiting the output.

Hmm. Should an excluded commit be a valid comparator? Is it 
sensible/correct to show a left commit as "=" to a right commit that has 
been excluded by the revision specifiers? Doesn't sound right to me.

I'm not convinced that there's a valid use-case that you're regressing 
here. If --ancestry-path is being misused (the user's assertion that 
non-ancestry doesn't matter is wrong) the "error" of not noting culled 
patch-identical commits is nothing compared to the fact we're already 
totally omitting the non-identical ones.

Kevin
