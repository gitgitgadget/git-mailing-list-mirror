From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Question about 'branch -d' safety
Date: Mon, 19 Jul 2010 22:36:20 +0200
Message-ID: <201007192236.21786.jnareb@gmail.com>
References: <20091230065442.6117@nanako3.lavabit.com> <1279523523.3077.8.camel@dreddbeard> <4C448879.4040202@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: wmpalmer@gmail.com, Jonathan Nieder <jrnieder@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Mon Jul 19 22:36:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oax4i-00050F-LW
	for gcvg-git-2@lo.gmane.org; Mon, 19 Jul 2010 22:36:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966708Ab0GSUg1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jul 2010 16:36:27 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:57148 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936465Ab0GSUg1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jul 2010 16:36:27 -0400
Received: by bwz1 with SMTP id 1so2500680bwz.19
        for <git@vger.kernel.org>; Mon, 19 Jul 2010 13:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=xwFrkTHfKeSYBc9Pxkzm8rYiXOrDMH0TvDtBH2bNfX4=;
        b=D3OtW6lptfQiXgHw5Bc+5MbeBMbB6kRyfNcnJxhgfYGMzaRJJw+ZZ7oDlqWlbadHnJ
         djQQQ7SDcO702c5k7CfBB2I5hPJbhlqCAarVgt+tG2cvHS+0bqKq7TtFfUS23Df/pEH2
         1wgqZDckLTdSZFWAEslK+usuuOmj10HtcQAH0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=D+/RIXpSl/BK0PL0F0RKGPnMSIDu4rX70p4a2O8PWA2sYaLaYSsUKuKwR2uWvmJzYy
         rmfwMwR/iNghYRgBD0AQLBrhx5PzUndlbwEdK39h8LvvokitYXnyL+DI7MPrd8hpF0S5
         OR13qhgyxZ9/layqItesXxGBfqV3oIqLOhMGI=
Received: by 10.204.136.71 with SMTP id q7mr4363761bkt.111.1279571785598;
        Mon, 19 Jul 2010 13:36:25 -0700 (PDT)
Received: from [192.168.1.13] (abwh94.neoplus.adsl.tpnet.pl [83.8.231.94])
        by mx.google.com with ESMTPS id x19sm27306853bkv.21.2010.07.19.13.36.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 19 Jul 2010 13:36:24 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4C448879.4040202@workspacewhiz.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151276>

On Mon, 19 Jul 2010, Joshua Jensen wrote:

> My brain has become muddied with all the ~2 stuff.  Explain again why it 
> can't be as simple as this?
> 
> git branch -d integration
> 
> git reflog
> 
> 0000001 HEAD@{0}: (fake)checkout: moving from integration to master 
> (0000001)
> 8000000 HEAD@{1}: branch -d: Deleting integration
> 0000001 HEAD@{2}: (fake)checkout: moving from master to integration 
> (8000000)

Because 'integration' branch nowadays might have been never checked out,
and not be in HEAD, even though 'git branch -d integration' works.
Stuffing unrelated events in HEAD reflog, instead of having it be action
history of HEAD symref is IMVHO a bad idea.

-- 
Jakub Narebski
Poland
