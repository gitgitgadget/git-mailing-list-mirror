From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Feature request: Allow extracting revisions into directories
Date: Mon, 04 Feb 2013 06:12:36 +0530
Message-ID: <510F03FC.6080501@gmail.com>
References: <1359901085.24730.11.camel@t520> <510E8F82.9050306@gmail.com> <1359915086.24730.19.camel@t520>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Robert Clausecker <fuzxxl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 01:43:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2A9J-00005S-PU
	for gcvg-git-2@plane.gmane.org; Mon, 04 Feb 2013 01:43:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753659Ab3BDAmn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2013 19:42:43 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36580 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753658Ab3BDAmm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2013 19:42:42 -0500
Received: by mail-pa0-f46.google.com with SMTP id kp14so3005658pab.5
        for <git@vger.kernel.org>; Sun, 03 Feb 2013 16:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=KsYlKUr2I+8P8ppYO6aEQzNToV2QdeG8hgBqLCF0rQ8=;
        b=zLNcZjc/DnKKG6pymobtv3fT9nTz13TdQ+H3mbmpFDhHRvjMAJQ/EVgRW1pR7ciJvP
         lnQ4xhuklNgcLPfT+u+eymuxKTUtlB9d3xaExRX581f9/W69aU4ZZvtROzRp4HsedxSM
         FRXY7piKQRw9T9x/4mCSnOoUFwg+qFMeCqp+m2D8VyZOdXtcuJ9LfAF5cdWMJbV/XYhl
         ASdnon+PQYJ57nrKm9hFOJV/XVcE0u1eJDYjpzzzBP+Fa9iRhERmIPyPPbOUnU2xrM+x
         RVBNzA/O3psGSuPKCvIxWZt/ZYD1GBshfRhkIO+HW3UeQQyjjV+bqy5igKHiDg5ZRc2C
         ooXQ==
X-Received: by 10.68.229.169 with SMTP id sr9mr50145371pbc.120.1359938561883;
        Sun, 03 Feb 2013 16:42:41 -0800 (PST)
Received: from sita-lt.atc.tcs.com ([219.64.79.30])
        by mx.google.com with ESMTPS id l8sm17072100pax.9.2013.02.03.16.42.38
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 03 Feb 2013 16:42:41 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130110 Thunderbird/17.0.2
In-Reply-To: <1359915086.24730.19.camel@t520>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215346>

On 02/03/2013 11:41 PM, Robert Clausecker wrote:
> 
> Am Sonntag, den 03.02.2013, 21:55 +0530 schrieb Sitaram Chamarty:
>> Could you help me understand why piping it to tar (actually 'tar -C
>> /dest/dir -x') is not sufficient to achieve what you want?
> 
> Piping the output of git archive into tar is of course a possible
> solution; I just don't like the fact that you need to pipe the output
> into a separate program to do something that should be possible with a
> simple switch and not an extra command. It feels unintuitive and like a
> workaround to make an archive just to unpack it on-the-fly. Also, adding
> such a command (or at least documenting the way to do this using a pipe
> to tar somewhere in the man pages) is a small and simple change that
> improves usability.

I realise it appears to be the fashion these days to get away from the
Unix philosophy of having different tools do different things and
combining them as needed.

Ignoring the option-heavy GNU, and looking at the more traditional BSD
tar manpage [1], I notice the following flags that could still be
potentially needed by someone running 'git archive': '-t' (instead of
'-x'), '-C dir', '--exclude/include', '-k', '-m', '--numeric-owner', -o,
-P, -p, -q, -s, -T, -U, -v, -w, and -X.

And I'm ignoring the esoteric ones like "--chroot" and "-S" (sparse mode).

How many of these options would you like included in git?  And if you
say "I don't need any of those; I just need '-x'", that's not relevant.
 Someone else may need any or all of those flags, and if you accept "-x"
you have to accept some of the others too.

Also, I often want to deploy to a different host, and I might do that
like so:

    git archive ... | ssh host tar -C /deploy/dir -x

Why not put that ssh functionality into git also?

What about computing a checksum and putting out a "sha1sums.txt" file?
People do that also.  How about a flag for that?

Where does this end?

[1]: http://www.unix.com/man-page/FreeBSD/1/tar/
