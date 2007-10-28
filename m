From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH 4/8] rev-parse: teach "git rev-parse --symbolic" to print the full ref name
Date: Sun, 28 Oct 2007 11:10:15 -0400
Message-ID: <3849CD8A-A86C-4297-899F-F1B7C1E81F2C@silverinsanity.com>
References: <119350380778-git-send-email-prohaska@zib.de> <11935038081211-git-send-email-prohaska@zib.de> <11935038081650-git-send-email-prohaska@zib.de> <1193503808519-git-send-email-prohaska@zib.de> <11935038083369-git-send-email-prohaska@zib.de> <7v3avvy9yc.fsf@gitster.siamese.dyndns.org> <79CE31EE-0975-48EB-8B3E-FC9D6A8EB3E4@zib.de> <20071028080654.GS14735@spearce.org> <30641295-495B-4E5E-9D44-5CAF7C480DF2@zib.de>
Mime-Version: 1.0 (Apple Message framework v912)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Oct 28 16:10:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Im9ma-0000y9-My
	for gcvg-git-2@gmane.org; Sun, 28 Oct 2007 16:10:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751563AbXJ1PKW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2007 11:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbXJ1PKV
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Oct 2007 11:10:21 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:56178 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219AbXJ1PKU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2007 11:10:20 -0400
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id EC3331FFC151;
	Sun, 28 Oct 2007 15:10:17 +0000 (UTC)
In-Reply-To: <30641295-495B-4E5E-9D44-5CAF7C480DF2@zib.de>
X-Mailer: Apple Mail (2.912)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62564>


On Oct 28, 2007, at 4:56 AM, Steffen Prohaska wrote:

> I can't teach vim to always place the '*' correctly. At least I
> don't know how to do this.

I did some research (I was curious), and the following in your .vimrc  
will do it:  (Mildly tested)

-----8<-----

" Needed to avoid 'char * '
func s:Eatchar(pat)
let c = nr2char(getchar(0))
return (c =~ a:pat) ? '' : c
endfunc

" Make creating the abbreviation for multiple types easier
func s:FixPointer(type)
exec "iabbr " . a:type . "* " . a:type . " *<C-R>=<SID>Eatchar('\ 
\s')<CR>"
endfunc
command -nargs=1 FixPointer call <SID>FixPointer(<args>)

" Change the following pointer types (char* var -> char *var)
FixPointer 'char'
FixPointer 'int'
FixPointer 'void'

-----8<-----

Repeating the last line for each type you want to fix the pointers  
for.  There may be a simpler way to do some of this, but I don't know  
it.  But once it's set up each time you type in "char* var", Vim will  
auto-correct to "char *var".

Changing this to operate only in C, or only if you're starting in your  
git repository is left as an exercise for the reader.  ;-)

~~ Brian
