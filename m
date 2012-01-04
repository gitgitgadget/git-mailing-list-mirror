From: Sven Strickroth <sven.strickroth@tu-clausthal.de>
Subject: Re: [PATCH 1/2] git-svn, perl/Git.pm: add central method for prompting
 passwords honoring GIT_ASKPASS and SSH_ASKPASS
Date: Wed, 04 Jan 2012 20:20:00 +0100
Message-ID: <4F04A660.4020000@tu-clausthal.de>
References: <4EC52508.9070907@tu-clausthal.de> <CABPQNSZ0iPAE+BnDU6Nz8_PkrAtPbjL4RoJuQS=Um2wxPt-2DQ@mail.gmail.com> <4EC65DE4.90005@tu-clausthal.de> <CABPQNSbfM0JRVPk3fxfSEq7QaO-fynHM8FBGpPribdgeRqpZKA@mail.gmail.com> <4ED0CE8B.70205@tu-clausthal.de> <20111130064401.GC5317@sigill.intra.peff.net> <4EF907F1.1030801@tu-clausthal.de> <m3d3baf5kd.fsf@localhost.localdomain> <4EF9D8B9.9060106@tu-clausthal.de> <4EF9EBF4.7070200@tu-clausthal.de> <4EF9ED58.8080205@tu-clausthal.de> <7vd3b967ql.fsf@alter.siamese.dyndns.org> <7vty4l4rr8.fsf@alter.siamese.dyndns.org> <4EFA5EB3.4000802@tu-clausthal.de> <CACBZZX7P9PEq0wZp0d3dSwDjF6J6Z3cO4VtWc9_frBengtqPLw@mail.gmail.com> <7vboqks8la.fsf@alter.siamese.dyndns.org> <4F038EC8.505@tu-clausthal.de> <7v39bws4xi.fsf@alter.siamese.dyndns.org> <4F0405D4.9090102@tu-
 clausthal.de> <7vmxa3pa6e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 04 20:20:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RiWO2-0005EL-Dd
	for gcvg-git-2@lo.gmane.org; Wed, 04 Jan 2012 20:20:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752506Ab2ADTUR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jan 2012 14:20:17 -0500
Received: from poseidon.rz.tu-clausthal.de ([139.174.2.21]:46857 "EHLO
	poseidon.rz.tu-clausthal.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751685Ab2ADTT5 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Jan 2012 14:19:57 -0500
Received: from poseidon.rz.tu-clausthal.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 5A278252E2;
	Wed,  4 Jan 2012 20:19:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; s=dkim1;
	 bh=1zLSz6Xso88zOMcdrVxs3qWIFPw=; b=ej3sy+O9AoEMMUUwMMDsaot8FMoe
	pFYidCGLv7TBR99lAamszsTHp78/vlp+pTsGHrqVM2K7/+z3W/L99M8b9GvK2AG7
	25Ui0vsuweed52FA3tbWAlmXsbaH3xuGt/0FJp2Mqvdnhd+FWdQ75TZHNNKtkaRD
	+sL9+vPJOukMPaw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; q=dns; s=
	dkim1; b=P3IWlKzobcafrOWRJGval31KkHaPtg9J1QzhMr8Q0ePsuzYmDj/WBDM
	He52RtTftTcwu/s5Ky8u7Qxa3o21pBPKl521yHgne13gYsmVMVv2E/eC12HcprpA
	kuPNRD2wH5RgmL/LR5/B2w7QKQHTmjKyHOs8FOGxp9zY4Ezj/t3I=
Received: from tu-clausthal.de (hathor.rz.tu-clausthal.de [139.174.2.1])
	by poseidon.rz.tu-clausthal.de (Postfix) with ESMTP id 35D22252DB;
	Wed,  4 Jan 2012 20:19:56 +0100 (CET)
Received: from [139.174.242.80] (account sstri@tu-clausthal.de [139.174.242.80] verified)
  by tu-clausthal.de (CommuniGate Pro SMTP 5.4.3)
  with ESMTPSA id 25693902; Wed, 04 Jan 2012 20:19:56 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <7vmxa3pa6e.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.3.4
X-Virus-Scanned: by Sophos PureMessage V5.6 at tu-clausthal.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187940>

Am 04.01.2012 19:58 schrieb Junio C Hamano:
> Depending on how widespread such implementations of Perl are, a patch to
> fix other uses of chomps might deserve to be on the maintenance track
> independent from this patch series. I seem to find many hits to:
> 
>     $ git grep -e 'chomp *([^)@]*='
> 
> already in our codebase.

I'm not sure if this is a general chomp problem. I think that this is
more related to a variable which is accessed after a readfailure on STDIN.

Reported to msys team.

-- 
Best regards,
 Sven Strickroth
 ClamAV, a GPL anti-virus toolkit   http://www.clamav.net
 PGP key id F5A9D4C4 @ any key-server
