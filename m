From: Andreas Gruenbacher <agruen@suse.de>
Subject: Re: Filename quoting / parsing problem
Date: Wed, 6 Jan 2010 01:04:25 +0100
Organization: SUSE Labs
Message-ID: <201001060104.25737.agruen@suse.de>
References: <201001011844.23571.agruen@suse.de> <7v8wcge4kr.fsf@alter.siamese.dyndns.org> <201001022148.47841.agruen@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 06 01:04:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSJO8-0001Y5-1A
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 01:04:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754132Ab0AFAEb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2010 19:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753754Ab0AFAEb
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jan 2010 19:04:31 -0500
Received: from cantor2.suse.de ([195.135.220.15]:39397 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750996Ab0AFAEa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2010 19:04:30 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	by mx2.suse.de (Postfix) with ESMTP id 9E0C286391;
	Wed,  6 Jan 2010 01:04:27 +0100 (CET)
User-Agent: KMail/1.12.2 (Linux/2.6.31.5-0.1-desktop; KDE/4.3.1; x86_64; ; )
In-Reply-To: <201001022148.47841.agruen@suse.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136221>

On Saturday 02 January 2010 09:48:47 pm Andreas Gruenbacher wrote:
> On Saturday 02 January 2010 07:37:08 pm Junio C Hamano wrote:
> > I don't think it happened in the GNU land yet, and you would be the
> > person to know about it ;-).
> 
> I'm working on it ...

The "experimental" branch [*] now has very lightly tested code for parsing 
most extended headers ("index", "rename from", "rename to", "copy from", "copy 
to", "old mode", "new mode", "deleted file mode", "new file mode").  Most 
things should work, except:

 * Doesn't parse filenames in "diff --git" lines.  (I tried to argue why
   those lines are a problem in this thread.)

 * sha1 checksums are not verified right now.  I'm not sure when that should
   happen: always by default, or only optionally?  (Like verifying file modes,
   this is going to surprise a lot of users.)

 * Similarity and dissimilarity headers are ignored.

 * Binary diffs are no supported.  I think GNU patch should recognize them and
   give a reasonable message for now.


[*] http://git.savannah.gnu.org/cgit/patch.git/log/?h=experimental


Can you guys please do something to make parsing of filenames in "diff --git" 
lines a lot easier, or unnecessary?

Thanks!
Andreas
