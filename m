From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 2/5] gitweb: Do not use bareword filehandles
Date: Sun, 10 May 2009 09:50:53 +0200
Message-ID: <20090510075053.GA6058@machine.or.cz>
References: <200905100203.51744.jnareb@gmail.com> <200905100236.20158.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 10 09:51:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M33oP-0004rd-RA
	for gcvg-git-2@gmane.org; Sun, 10 May 2009 09:51:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751699AbZEJHu5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 May 2009 03:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751510AbZEJHu5
	(ORCPT <rfc822;git-outgoing>); Sun, 10 May 2009 03:50:57 -0400
Received: from w241.dkm.cz ([62.24.88.241]:56420 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751502AbZEJHu5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2009 03:50:57 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 11BFC125A0E8; Sun, 10 May 2009 09:50:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200905100236.20158.jnareb@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118708>

On Sun, May 10, 2009 at 02:36:19AM +0200, Jakub Narebski wrote:
> The script was using bareword filehandles.  This is considered a bad
> practice so they have been changed to indirect filehandles.
> Changes touch git_get_project_ctags and mimetype_guess_file.
> 
> While at it rename local variable from $mime to $mimetype (in
> mimetype_guess_file) to better reflect its value (its contents).
> 
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> ---
> Perl::Critic::Policy::InputOutput::ProhibitBarewordFileHandles
> 
>   Write open my $fh, q{<}, $filename; instead of open FH, q{<}, $filename;.
> 
>   Using bareword symbols to refer to file handles is particularly evil
>   because they are global, and you have no idea if that symbol already
>   points to some other file handle. You can mitigate some of that risk by
>   'local'izing the symbol first, but that's pretty ugly. Since Perl 5.6, you
>   can use an undefined scalar variable as a lexical reference to an
>   anonymous filehandle.
> 
> See also Damian Conway's book "Perl Best Practices",
> chapter "10.1. Filehandles" (Don't use bareword filehandles.)
> 
> 
> This follows similar patch for git-send-email.perl by Bill Pemberton
> http://permalink.gmane.org/gmane.comp.version-control.git/117886
> 
> CC-ed Pasky, who is responsible for code in both cases...

Yeah, the book I learnt Perl from many years ago used bareword
filehandles (but it was an excellent textbook in most other aspects)
so this is a custom I have to work hard to evict. ;-)

Acked-by: Petr Baudis <pasky@suse.cz>
