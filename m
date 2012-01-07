From: Sven Strickroth <sven.strickroth@tu-clausthal.de>
Subject: Re: [PATCH 1/2] git-svn, perl/Git.pm: add central method for prompting
 passwords honoring GIT_ASKPASS and SSH_ASKPASS
Date: Sat, 07 Jan 2012 05:27:58 +0100
Message-ID: <4F07C9CE.30905@tu-clausthal.de>
References: <4EC52508.9070907@tu-clausthal.de> <CABPQNSZ0iPAE+BnDU6Nz8_PkrAtPbjL4RoJuQS=Um2wxPt-2DQ@mail.gmail.com> <4EC65DE4.90005@tu-clausthal.de> <CABPQNSbfM0JRVPk3fxfSEq7QaO-fynHM8FBGpPribdgeRqpZKA@mail.gmail.com> <4ED0CE8B.70205@tu-clausthal.de> <20111130064401.GC5317@sigill.intra.peff.net> <4EF907F1.1030801@tu-clausthal.de> <m3d3baf5kd.fsf@localhost.localdomain> <4EF9D8B9.9060106@tu-clausthal.de> <4EF9EBF4.7070200@tu-clausthal.de> <4EF9ED58.8080205@tu-clausthal.de> <7vd3b967ql.fsf@alter.siamese.dyndns.org> <7vty4l4rr8.fsf@alter.siamese.dyndns.org> <4EFA5EB3.4000802@tu-clausthal.de> <CACBZZX7P9PEq0wZp0d3dSwDjF6J6Z3cO4VtWc9_frBengtqPLw@mail.gmail.com> <7vboqks8la.fsf@alter.siamese.dyndns.org> <4F038EC8.505@tu-clausthal.de> <7v39bws4xi.fsf@alter.siamese.dyndns.org> <4F0405D4.9090102@tu-
 clausthal.de> <4F040E46.5030001@tu-clausthal.de> <7vipkrp9pq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 07 05:28:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RjNtG-0007F9-82
	for gcvg-git-2@lo.gmane.org; Sat, 07 Jan 2012 05:28:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758538Ab2AGE14 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jan 2012 23:27:56 -0500
Received: from hades.rz.tu-clausthal.de ([139.174.2.20]:35584 "EHLO
	hades.rz.tu-clausthal.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751832Ab2AGE14 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jan 2012 23:27:56 -0500
Received: from hades.rz.tu-clausthal.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id A9AC44220AF;
	Sat,  7 Jan 2012 05:27:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; s=dkim1;
	 bh=lqAiN+L6xCTApXuisF0NjlDoff0=; b=LrElUJY/28jZv4Ta0Zs4Hke20oWQ
	WmbVwdkY3T6dhHLfVX5FTpLC8dQNtGFbNcTgXYDg7AZ+5jZ3Vu49BO+tIF5QEbAd
	TWUcvebRnwD+LqLInmiijnI0oiLAs0X48sk2ZBqQehzGQN+bVTSUS/y+CF3b9+Is
	HbsBTs7rodMI0cs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; q=dns; s=
	dkim1; b=nca7Pldk695jRZV3C0kRjPpW20FAE1r4umLw9wfJkcfXvnj82KH7A0a
	YFzwhg4TABhI5QfdvpQKHTUYTk7WLi5Gm19iCr0EodEWPcRGwCs7xLLZDSvlF3wB
	a2G6jNdwOKzP0kC8PGUPo8aF/88yK1Y9u6XFqnQyu5BLCcbyMvSI=
Received: from tu-clausthal.de (hathor.rz.tu-clausthal.de [139.174.2.1])
	by hades.rz.tu-clausthal.de (Postfix) with ESMTP id 68E3242202A;
	Sat,  7 Jan 2012 05:27:53 +0100 (CET)
Received: from [139.174.5.137] (account sstri@tu-clausthal.de [139.174.5.137] verified)
  by tu-clausthal.de (CommuniGate Pro SMTP 5.4.3)
  with ESMTPSA id 25774080; Sat, 07 Jan 2012 05:27:53 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <7vipkrp9pq.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.3.4
X-Virus-Scanned: by Sophos PureMessage V5.6 at tu-clausthal.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188062>

Hi,

Am 04.01.2012 20:08 schrieb Junio C Hamano:
> Is there a way to ask Term::ReadKey (or possibly some other module) if we
> will be able to interact with the terminal _before_ we give that prompt?
> 
> The simplest would be to do this, I would think, but I didn't test it.
> 
> 	if (!defined $ret && -t) {
> 		print STDERR $prompt;
> 		if ($isPassword) {
>                 	...
> 	}

-t does not help, but I think it's not a big deal if the prompt is printed on
the terminal and also on the ASKPASS-helper.

Using Term::ReadLine seems to help:
...
		$ret = _prompt($ENV{'SSH_ASKPASS'}, $prompt);
	}
	if (!defined $ret) {
		use Term::Readline;
		my $term = Term::ReadLine->new("Git.pm");
		if ($isPassword) {
			require Term::ReadKey;
			Term::ReadKey::ReadMode('noecho');
		}
		$ret = $term->readline($prompt);
		if ($isPassword) {
			Term::ReadKey::ReadMode('restore');
			print STDERR "\n";
			
		}
	}
	if (!defined $ret) {
		$ret = _prompt($ENV{'SSH_ASKPASS'}, $prompt);
...

But I'm not sure if this is what we want, because you can go with the cursor
over the whole terminal.

A better (working) alternative might be:
...
		$ret = _prompt($ENV{'SSH_ASKPASS'}, $prompt);
	}
	use Term::Readline;
	my $term = Term::ReadLine->new("Git.pm");
	if (!defined $ret && fileno($term->IN)) {
 		print STDERR $prompt;
 		if ($isPassword) {
                 	...
 	}
...

-- 
Best regards,
 Sven Strickroth
 ClamAV, a GPL anti-virus toolkit   http://www.clamav.net
 PGP key id F5A9D4C4 @ any key-server
