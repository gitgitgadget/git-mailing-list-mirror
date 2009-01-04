From: Matt Kraai <kraai@ftbfs.org>
Subject: Re: [PATCH] gitweb: merge boolean feature subroutines
Date: Sun, 4 Jan 2009 07:58:58 -0800
Message-ID: <20090104155858.GC4205@ftbfs.org>
References: <1230996692-7182-1-git-send-email-kraai@ftbfs.org> <9b18b3110901030818i242d81ccl20ef3f264ec64cad@mail.gmail.com> <7vvdsv3af6.fsf@gitster.siamese.dyndns.org> <9b18b3110901040341n5ff5fa09s878228131d11d2a6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 04 17:00:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJVPK-00082k-7j
	for gcvg-git-2@gmane.org; Sun, 04 Jan 2009 17:00:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751643AbZADP7b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Jan 2009 10:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751273AbZADP7b
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jan 2009 10:59:31 -0500
Received: from neon.ftbfs.org ([83.168.236.214]:48925 "EHLO neon.ftbfs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751222AbZADP7a (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jan 2009 10:59:30 -0500
Received: from pool-71-119-193-199.lsanca.dsl-w.verizon.net
	([71.119.193.199] helo=macbookpro.ftbfs.org ident=Debian-exim)
	by neon.ftbfs.org with esmtpa (Exim 4.63)
	(envelope-from <kraai@ftbfs.org>)
	id 1LJVNZ-00030w-GH; Sun, 04 Jan 2009 07:59:13 -0800
Received: from kraai by macbookpro.ftbfs.org with local (Exim 4.69)
	(envelope-from <kraai@ftbfs.org>)
	id 1LJVNS-0000nd-Oi; Sun, 04 Jan 2009 07:58:58 -0800
Content-Disposition: inline
In-Reply-To: <9b18b3110901040341n5ff5fa09s878228131d11d2a6@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Score-Int: -40
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104521>

On Sun, Jan 04, 2009 at 12:41:14PM +0100, demerphq wrote:
> Why execute more opcodes, and return a slightly surprising false, when
> you dont have to?
> 
> Is it really deep perl magic to do:
> 
>   return $val eq 'true';
> 
> instead of
> 
>   return $val eq 'true' ? 1 : 0;
> 
> or the actual use:
> 
>    if ($val eq 'true') {
>       return 1
>    } else {
>       return 0
>    }
>
> Isn't the former superior just on pure minimalism metrics? Theres less
> code to understand, less code to go wrong, and as a bonus it returns a
> true boolean. Isn't that just a win-win-win? I mean most perl
> programmers I know would instantly convert the latter two to the first
> just on the grounds that the first version is the clearest expression
> of the desired intent.

I agree that what you suggest is better than the alternatives you
present.  Unfortunately, none of them match the current behavior.
Here's the current code:

	if ($val eq 'true') {
		return 1;
	} elsif ($val eq 'false') {
		return 0;
	}

	return $_[0];

Is there a way to use the form you suggest while falling back to the
default if $val isn't set to 'true' or 'false'?

-- 
Matt                                                 http://ftbfs.org/
