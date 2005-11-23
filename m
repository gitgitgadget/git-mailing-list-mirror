From: Kalle Valo <Kalle.Valo@iki.fi>
Subject: Re: [PATCH] Support username and password inside URL
Date: Wed, 23 Nov 2005 22:56:04 +0200
Message-ID: <87d5kraxsr.fsf@litku.valo.iki.fi>
References: <87u0e71zpx.fsf@litku.valo.iki.fi>
	<873blriqh0.fsf@litku.valo.iki.fi>
	<7vwtj3xe72.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 23 21:57:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ef1f5-0002Ut-V6
	for gcvg-git@gmane.org; Wed, 23 Nov 2005 21:56:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932404AbVKWU4L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Nov 2005 15:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932412AbVKWU4L
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Nov 2005 15:56:11 -0500
Received: from fep01-0.kolumbus.fi ([193.229.0.41]:46998 "EHLO
	fep01-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S932404AbVKWU4J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2005 15:56:09 -0500
Received: from litku.valo.iki.fi ([81.197.35.21]) by fep01-app.kolumbus.fi
          with ESMTP
          id <20051123205605.BEOV1311.fep01-app.kolumbus.fi@litku.valo.iki.fi>;
          Wed, 23 Nov 2005 22:56:05 +0200
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vwtj3xe72.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 20 Nov 2005 12:21:53 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12650>

Junio C Hamano <junkio@cox.net> writes:

> Kalle Valo <Kalle.Valo@iki.fi> writes:
>
>> Currently usage of curl was so that netrc was mandatory and passwords in URL
>> weren't allowed. Change netrc to optional to make HTTP basic authentication
>> with username and password in URL also work.
>
> HTTP "basic"?  Let's at least say "digest" for starters ;-).

Sorry, I didn't understand this. But anyway, I have always used the
basic authentication because it has been sufficient for my needs.

> I am modestly against letting users use auth-embedding URLs, and
> fairly strongly against encouraging users to do so.

I didn't even think about security implications when I sent the patch,
sorry about that. Now that I think of it, I even remember that some
browser removed this feature altogether. Yeah, it was IE:

http://support.microsoft.com/kb/834489

And Firefox seems to show a dialog confirmation dialog if I open an
URL with username and password. So I have to agree with you, it isn't
a good idea to embed the credentials to the URL.

> If you are using the password protected URL yourself, I'd
> imagine having them in your netrc would not be such a big deal,

Yes, I can manage with netrc for now. The only problem is that you
can't specify multiple usernames and passwords per host. (Or at least
that's how I understood the netrc man page.) If there's a way to do
that in git, I would really like to know about that.

> so I suspect your expected usage is not for yourself, but more
> like giving a temporary, even one-shot, access to others like
> the above example, and making it more convenient for them (even
> in that case, if it is not one-shot but for repeated use, I'd
> imagine it would not be such a big deal to ask them to do
> appropriate netrc).

Actually I'm going to be only user of the private git repository and
it's going to be permanent. I have multiple computers in different
locations (servers, workstations, laptops) and I would like to
distribute my private files (configuration files, scripts etc.) to all
of them using git. The files are not really that secret, but I just
don't want to share them with the whole world. That's why I'm using
just HTTP authentication and nothing secure.

> If that is what is going on here, then IMNSHO it would be better to
> make it clear that you are doing security-by-obscurity by not using
> username password pair, which makes you pretend that you are doing
> _some_ security.

I agree with you. I don't consider HTTP authentication secure at all.
It can just block search engines and casual readers from accessing the
page, nothing more. The problem with randomized URL (like you
suggested) is that if some person or a search engine finds the URL
somehow, then there's nothing stopping the information leak. HTTP
authentication at least stops search engines accessing the page.

-- 
Kalle Valo
