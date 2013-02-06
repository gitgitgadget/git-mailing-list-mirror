From: Ted Zlatanov <tzz@lifelogs.com>
Subject: Re: [PATCHv5] Add contrib/credentials/netrc with GPG support
Date: Tue, 05 Feb 2013 19:34:00 -0500
Organization: =?utf-8?B?0KLQtdC+0LTQvtGAINCX0LvQsNGC0LDQvdC+0LI=?= @
 Cienfuegos
Message-ID: <87a9rip9fr.fsf@lifelogs.com>
References: <87ehgvua6h.fsf@lifelogs.com>
	<20130204211726.GB13186@sigill.intra.peff.net>
	<87mwvjsqjc.fsf_-_@lifelogs.com>
	<7vvca6u47f.fsf@alter.siamese.dyndns.org>
	<87k3qmr8yc.fsf@lifelogs.com> <87fw1ar3og.fsf_-_@lifelogs.com>
	<87ehgvua6h.fsf@lifelogs.com>
	<20130204211726.GB13186@sigill.intra.peff.net>
	<87mwvjsqjc.fsf_-_@lifelogs.com>
	<7vvca6u47f.fsf@alter.siamese.dyndns.org>
	<87k3qmr8yc.fsf@lifelogs.com>
	<7vhalqsfkf.fsf@alter.siamese.dyndns.org>
	<8738xaqy40.fsf_-_@lifelogs.com>
	<7vip66qu0u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 06 01:34:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2syN-000205-3p
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 01:34:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753778Ab3BFAeS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2013 19:34:18 -0500
Received: from plane.gmane.org ([80.91.229.3]:59542 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752034Ab3BFAeS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2013 19:34:18 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1U2sy8-0001rt-7p
	for git@vger.kernel.org; Wed, 06 Feb 2013 01:34:32 +0100
Received: from c-65-96-148-157.hsd1.ma.comcast.net ([65.96.148.157])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 06 Feb 2013 01:34:32 +0100
Received: from tzz by c-65-96-148-157.hsd1.ma.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 06 Feb 2013 01:34:32 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: c-65-96-148-157.hsd1.ma.comcast.net
X-Face: bd.DQ~'29fIs`T_%O%C\g%6jW)yi[zuz6;d4V0`@y-~$#3P_Ng{@m+e4o<4P'#(_GJQ%TT= D}[Ep*b!\e,fBZ'j_+#"Ps?s2!4H2-Y"sx"
User-Agent: Gnus/5.130006 (Ma Gnus v0.6) Emacs/24.3.50 (gnu/linux)
Cancel-Lock: sha1:M0q7HxwGe7rartSryYoyZexVi/0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215554>

On Tue, 05 Feb 2013 14:24:01 -0800 Junio C Hamano <gitster@pobox.com> wrote: 

JCH> Ted Zlatanov <tzz@lifelogs.com> writes:
>> +		$f =~ s/([;<>\*\|`&\$!#\(\)\[\]\{\}:'"])/\\$1/g;

JCH> Yuck.  If you really have to quote, it is often far simpler to take
JCH> advantage of the fact that quoting rule for shell is much simpler
JCH> inside '', i.e.

JCH> 	sub sq {
JCH> 		my ($string) = @_;
JCH> 		$string =~ s|'|'\\''|g;
JCH> 		return "'$string'";
JCH> 	}

Oh, that's nice.  Thanks.  We don't need it anymore, but I'm sad to see
it go unused.

JCH> I think it is saner to do something like this instead here:
JCH> 				$mach = { machine => undef }

JCH> Otherwise your log_debug() will be filled by the tokens used for the
JCH> default entry, and also this "undef $mach" here will break your
JCH> macdef skipping logic if the default entry has a macdef, I think.

JCH> You can ignore an entry with undefined "machine" in the loop at the
JCH> end of load_netrc.

Cool, I merged your changes into PATCHv6.  I'll keep in mind about
merging the trailing else braces, too.  I forgot that setting for
cperl-mode (`cperl-merge-trailing-else . t').

Thanks
Ted
