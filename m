From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Setting up Git Server over SSH
Date: Mon, 15 Nov 2010 10:38:21 -0800
Message-ID: <AANLkTimF2N-rYFYjOMm5kRRqRueLnmzJGpUoaCK3jsAC@mail.gmail.com>
References: <B99C7057496B47E48E5ABED7DE6BA51A@denny>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Dennis <dennisfm@friendlymatch.com>
X-From: git-owner@vger.kernel.org Mon Nov 15 19:38:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PI3x2-0004FM-Sz
	for gcvg-git-2@lo.gmane.org; Mon, 15 Nov 2010 19:38:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758160Ab0KOSio (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Nov 2010 13:38:44 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:55942 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758126Ab0KOSin (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Nov 2010 13:38:43 -0500
Received: by gyh4 with SMTP id 4so3144233gyh.19
        for <git@vger.kernel.org>; Mon, 15 Nov 2010 10:38:43 -0800 (PST)
Received: by 10.42.176.135 with SMTP id be7mr112439icb.232.1289846321884; Mon,
 15 Nov 2010 10:38:41 -0800 (PST)
Received: by 10.231.162.65 with HTTP; Mon, 15 Nov 2010 10:38:21 -0800 (PST)
In-Reply-To: <B99C7057496B47E48E5ABED7DE6BA51A@denny>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161500>

On Mon, Nov 15, 2010 at 10:20 AM, Dennis <dennisfm@friendlymatch.com> wrote:
> I am doing this, but it fails:
>
>> git clone ssh://hostname.com:/home/user/.git
>
> Cloning into user...
> fatal: protocol error: bad line length character: logi

This looks to me like your server is echoing back text upon login.
That text is being confused for Git protocol data by the Git client,
but its not as expected, so it aborts with an error message.

Try getting the simple case to work first:

  ssh hostname.com echo hello

This should *only* print "hello".  If it prints anything else (and
right now I suspect it prints "login ..."), that will confuse Git.
You need to adjust your server's shell login scripts to stop echoing
information during a non-interactive shell.  Or you may need to adjust
your SSH client to ensure the authentication proceeds smoothly.  Those
"Access denied" errors look like you aren't actually authenticating to
the server.

-- 
Shawn.
