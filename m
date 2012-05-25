From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC] Possibility to choose ~/.config/git/config instead of ~/.gitconfig
Date: Fri, 25 May 2012 21:13:42 +0200
Message-ID: <vpq396ooyzd.fsf@bauges.imag.fr>
References: <20120525181526.Horde.VibLf3wdC4BPv7AeKacSMiA@webmail.minatec.grenoble-inp.fr>
	<CAE1pOi0eY2=eNzuTUVGmHuvfGWvxoXSJUADWr0CfPpVe5ktxow@mail.gmail.com>
	<7v4nr4t9gc.fsf@alter.siamese.dyndns.org>
	<20120525182558.GC4491@burratino>
	<7vsjeortwu.fsf@alter.siamese.dyndns.org>
	<20120525184408.GA4740@burratino>
	<7vobpcrstn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	nguyenhu@minatec.inpg.fr, git@vger.kernel.org,
	Valentin DUPERRAY <Valentin.Duperray@phelma.grenoble-inp.fr>,
	Franck JONAS <Franck.Jonas@phelma.grenoble-inp.fr>,
	Lucien KONG <Lucien.Kong@phelma.grenoble-inp.fr>,
	Thomas NGUY <Thomas.Nguy@phelma.grenoble-inp.fr>,
	Huynh Khoi Nguyen NGUYEN 
	<Huynh-Khoi-Nguyen.Nguyen@phelma.grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 25 21:14:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXzxl-0006Yv-Uj
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 21:14:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083Ab2EYTOJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 May 2012 15:14:09 -0400
Received: from mx2.imag.fr ([129.88.30.17]:33778 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755467Ab2EYTOH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2012 15:14:07 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q4PJ5ZE2031148
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 25 May 2012 21:05:35 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SXzxH-0005it-6y; Fri, 25 May 2012 21:13:43 +0200
In-Reply-To: <7vobpcrstn.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 25 May 2012 11:58:28 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 25 May 2012 21:05:36 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q4PJ5ZE2031148
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1338577537.11387@r2hiX2xv3WMcNJ3MgAaIhQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198509>

Junio C Hamano <gitster@pobox.com> writes:

>> Besides, with my distro package maintainer hat on, I can tell you that
>> switching the config file to ~/.config/git and not reading
>> ~/.gitconfig would be a complete nonstarter.
>
> Absolutely.  So don't choose to deliberately introduce backward
> incompatibliity.  Problem solved.

It doesn't have to be backward incompatible. The proposal is to _allow_
users to have a ~/.config/git/config file, not to _force_ them to have
one.

If Git reads both files, then ~/.gitconfig lovers can continue with it,
and are not affected.

> Why is it bad to keep using ~/.gitconfig in the first place?  The UNIX
> convention to exclude names that begin with dot is not working for you?

The "It's a convention" argument doesn't work here. XDG is also a rather
widely used convention these days, so "why not follow the convention"
can be used both in favor of ~/.gitconfig or ~/.config/git/config.

~/.gitconfig alone would not be a huge problem, although personnally
hate it already. I like to version my handwritten configuration files,
but I don't want my $HOME to be a git repository. I already have a
~/etc/ directory with my configuration files in it, and ~/.gitconfig is
basically a symbolic link. I wouldn't have to re-structure my $HOME if I
had a structured and standard configuration directory like ~/.config.

Now, the real issue is that we're starting to have several user-wide
config files (core.excludesfile, core.attributesfile, maybe one day
we'll want others like user-wide hooks?), and having multiple
~/.git<something> really feels wrong. Just like we have /etc/<file> for
applications that have only one configuration file, and /etc/<directory>
for ones who need more, it seems sensible to have a configuration
directory for a user, not just a set of configuration files in $HOME.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
