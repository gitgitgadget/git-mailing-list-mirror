From: Sven Strickroth <sven.strickroth@tu-clausthal.de>
Subject: Re: [PATCH 2/2] git-svn, perl/Git.pm: extend and use Git->prompt
 method for querying users
Date: Fri, 30 Dec 2011 15:53:30 +0100
Message-ID: <4EFDD06A.3010708@tu-clausthal.de>
References: <7vd3b967ql.fsf@alter.siamese.dyndns.org> <7vty4l4rr8.fsf@alter.siamese.dyndns.org> <4EFA5F08.2060705@tu-clausthal.de> <7vpqf91kqo.fsf@alter.siamese.dyndns.org> <4EFAF241.9050806@tu-clausthal.de> <7v39c41keo.fsf@alter.siamese.dyndns.org> <7vpqf8z8a6.fsf@alter.siamese.dyndns.org> <4EFB8E78.4090205@tu-clausthal.de> <7vlipwz5xs.fsf@alter.siamese.dyndns.org> <4EFD40CF.8000801@tu-clausthal.de> <20111230135423.GA1684@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Dec 30 15:53:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rgdpt-00081t-PE
	for gcvg-git-2@lo.gmane.org; Fri, 30 Dec 2011 15:53:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751809Ab1L3Oxa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Dec 2011 09:53:30 -0500
Received: from hades.rz.tu-clausthal.de ([139.174.2.20]:60093 "EHLO
	hades.rz.tu-clausthal.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751769Ab1L3Ox3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Dec 2011 09:53:29 -0500
Received: from hades.rz.tu-clausthal.de (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id C8810422071;
	Fri, 30 Dec 2011 15:53:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; s=dkim1;
	 bh=nKn+LFXQczTy1iIJHlojZ2VdEoA=; b=h7d1LAWd0N1x6shHCLCoKitkY7HD
	WSqKuQfjNeQF2qooWNS9X4pRvcyNIbNSyubZKCLuA0v7gNVdoAaOuhD8npIrsSWa
	n3h3smvBzXpPWrc1UQN8WKRMfnmmSSYEh9VWsS+U1WbBMpjGUgnHDMB86+PJodtV
	D2FbYD9tXr4rO0E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=tu-clausthal.de; h=
	message-id:date:from:mime-version:to:cc:subject:references
	:in-reply-to:content-type:content-transfer-encoding; q=dns; s=
	dkim1; b=JuD77yjU5/+tf9UcERbJl0LjE5GdLYgBDAixh7fD4peqvRQvtO6doGH
	cvoCq7G0vErawEKVC5WMwb/eoWJJuYZTN9+QbLoqU6We5/Sk2G2p/q8B75CczpcZ
	bjyRee7qQhoU/E0gbxFO0394j78F6pZEUpz7+TlBv+qyxfYNB9P4=
Received: from tu-clausthal.de (hathor.rz.tu-clausthal.de [139.174.2.1])
	by hades.rz.tu-clausthal.de (Postfix) with ESMTP id 893B4422065;
	Fri, 30 Dec 2011 15:53:27 +0100 (CET)
Received: from [84.132.158.28] (account sstri@tu-clausthal.de HELO [192.168.178.20])
  by tu-clausthal.de (CommuniGate Pro SMTP 5.4.3)
  with ESMTPSA id 25563912; Fri, 30 Dec 2011 15:53:27 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <20111230135423.GA1684@sigill.intra.peff.net>
X-Enigmail-Version: 1.3.4
X-Virus-Scanned: by Sophos PureMessage V5.6 at tu-clausthal.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187805>

Am 30.12.2011 14:54 schrieb Jeff King:
>>> I thought that was updated with Peff's series recently?
>>
>> So, was this changed? git-core doesn't ask for a username using
>> *_ASKPASS helpers anymore?
> 
> No, it will. It's only that we will echo characters when using the
> terminal prompt. In theory we could have an ASKPASS-style interface that
> would would echo characters, but there's no such interface in common
> use (i.e., we would have to invent it).

I also updated the _ASKPASS helper of TortoiseGit so that it only shows
asterisks if "pass" is not contained in the prompt.

> For credentials, it would be nice to be able to create a multi-field
> dialog, like:
> 
>   Username: <text input>
>   Password: <text input>
>   Remember password? [checkbox]
> 
> I was planning to do something custom for credentials as an extension to
> the credential helper protocol, but this could also fall under the
> heading of a general prompt helper.

This might be problematic, because (for git-svn) username and password
are not requested together.

-- 
Best regards,
 Sven Strickroth
 ClamAV, a GPL anti-virus toolkit   http://www.clamav.net
 PGP key id F5A9D4C4 @ any key-server
