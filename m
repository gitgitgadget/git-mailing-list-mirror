From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: StGIT mail configuration
Date: Mon, 13 Feb 2006 21:45:56 +0000
Message-ID: <b0943d9e0602131345r43b02496g@mail.gmail.com>
References: <43F0F072.90609@stormboxes.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 13 22:46:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8lWY-0007E7-BT
	for gcvg-git@gmane.org; Mon, 13 Feb 2006 22:46:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932371AbWBMVqE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Feb 2006 16:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932443AbWBMVqD
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Feb 2006 16:46:03 -0500
Received: from xproxy.gmail.com ([66.249.82.206]:42292 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932371AbWBMVqB convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2006 16:46:01 -0500
Received: by xproxy.gmail.com with SMTP id h31so781475wxd
        for <git@vger.kernel.org>; Mon, 13 Feb 2006 13:46:00 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QkTFHl3hltMuN0cYLFn2PigZ72GfAhG/KhEX8F84KQGXnfxu4Wy7gDiwGi1MaLKvYx+TQzroIKwGWfCMFRc6hF8vpCkIWEztmSvtce22509Ksl1x3LEGLRzxbr9psWxMNXG8XRg2GKwqY58jDhNPOb85PUqVeXZ3BhXc9Mq3od8=
Received: by 10.70.94.6 with SMTP id r6mr1363038wxb;
        Mon, 13 Feb 2006 13:45:57 -0800 (PST)
Received: by 10.70.53.7 with HTTP; Mon, 13 Feb 2006 13:45:56 -0800 (PST)
To: Aubin LaBrosse <aubin@stormboxes.com>
In-Reply-To: <43F0F072.90609@stormboxes.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16083>

On 13/02/06, Aubin LaBrosse <aubin@stormboxes.com> wrote:
> I'm using StGIT 0.8.1 on top of the latest release of Cogito - in
> .git/stgitrc of a local git repo, I have the following part related to
> my mail configuration:
>
> smtpserver: mail.stormboxes.com:25
> smtpuser: username@stormboxes.com
> smtppassword: myPassword
>
> (actual username and password redacted, of course) - the point is, the
> username actually is that entire string 'username@stormboxes.com' (no
> quotes) because the box it's on is a virtual server for many domains and
> the usernames must contain the domain to which they belong.  anyway, i
> was getting authentication failures, so i hacked up mail.py and set the
> debug level on the smtp object - i found out that it's trying to auth
> using CRAM-MD5.  And I'm not sure whether the server doesn't support
> that or not, but i didn't see anything in the python doc that would
> indicate that i could make the login() method use auth login or auth
> plain or something else

At least with Python 2.4, the authentication type is detected
automatically based on server's response to the ehlo command. It
supports cram-md5, plain and login (and I think it tries them in this
order). If the server responds with something different, the login()
command would raise an exception like "No suitable authentication
method found.". You could print s.esmtp_features["auth"] in mail.py in
StGIT after ehlo.

I haven't read the RFC2554 but you could also try to replace the '@' with '%40'.

> thunderbird works fine but i can't figure out which auth type
> it's using. (suppose i could tcpdump it and see) I have, of course,
> triple checked my auth credentials at this point.

Probably using tcpdump or ethereal would be the easiest.

--
Catalin
