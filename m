From: Aaron Schrab <aaron@schrab.com>
Subject: Re: [Opinion gathering] Git remote whitelist/blacklist
Date: Tue, 24 May 2016 18:24:51 -0400
Message-ID: <20160524222451.GA23162@pug>
References: <1040142021.5607762.1463753271105.JavaMail.zimbra@ensimag.grenoble-inp.fr>
 <584027154.5608416.1463754104066.JavaMail.zimbra@ensimag.grenoble-inp.fr>
 <001001d1b2a3$06d7bbb0$14873310$@nexbridge.com>
 <1929221963.5686879.1464007899902.JavaMail.zimbra@ensimag.grenoble-inp.fr>
 <1884904685.12056.1464084750628.JavaMail.zimbra@ensimag.grenoble-inp.fr>
 <84BDC4A4-FBE1-4542-868C-FA77A25469F3@gmail.com>
 <vpq37p74nu1.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Francois Beutin <beutinf@ensimag.grenoble-inp.fr>,
	"Randall S. Becker" <rsbecker@nexbridge.com>, git@vger.kernel.org,
	simon rabourg <simon.rabourg@ensimag.grenoble-inp.fr>,
	wiliam duclot <wiliam.duclot@ensimag.grenoble-inp.fr>,
	antoine queru <antoine.queru@ensimag.grenoble-inp.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed May 25 00:31:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5Kqt-0006JU-SC
	for gcvg-git-2@plane.gmane.org; Wed, 25 May 2016 00:31:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751759AbcEXWa7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 18:30:59 -0400
Received: from pug.qqx.org ([50.116.43.67]:55626 "EHLO pug.qqx.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751075AbcEXWa6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 18:30:58 -0400
Received: by pug.qqx.org (Postfix, from userid 1000)
	id 05D3D1D8AF; Tue, 24 May 2016 18:24:52 -0400 (EDT)
Mail-Followup-To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Lars Schneider <larsxschneider@gmail.com>,
	Francois Beutin <beutinf@ensimag.grenoble-inp.fr>,
	"Randall S. Becker" <rsbecker@nexbridge.com>, git@vger.kernel.org,
	simon rabourg <simon.rabourg@ensimag.grenoble-inp.fr>,
	wiliam duclot <wiliam.duclot@ensimag.grenoble-inp.fr>,
	antoine queru <antoine.queru@ensimag.grenoble-inp.fr>
Content-Disposition: inline
In-Reply-To: <vpq37p74nu1.fsf@anie.imag.fr>
User-Agent: Mutt/1.6.1+70 (g71ac0c0) (2016-04-27)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295540>

At 14:55 +0200 24 May 2016, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
>So, when trying a forbidden push, Git would deny it and the only way to
>force the push would be to remove the blacklist from the config, right?
>
>Probably the sanest way to go. I thought about adding a "git push
>--force-even-if-in-blacklist" or so, but I don't think the feature
>deserves one specific option (hence add some noise in `git push -h`).

It might make sense to bypass the blacklist checking if the existing 
--no-verify is used.  In the past I've used a pre-push hook to implement 
a similar method of preventing accidental pushes, and found that to be a 
good way to skip the checking when I wanted to override the check for a 
specific push.  The builtin blacklist checking could be seen as another 
type of verification.  The downside to that would be that if the 
blacklist was used along with a pre-push hook for different types of 
checks users would likely only be able to see the error message from one 
of them; but that could also apply to a pre-push hook that implements 
different types of checks and short circuits at the first failure.
