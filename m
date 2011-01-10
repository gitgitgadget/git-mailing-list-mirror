From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Fix wrong failures in config test
Date: Mon, 10 Jan 2011 11:29:31 -0600
Message-ID: <20110110172931.GB7882@burratino>
References: <20110110165251.GB7714@burratino>
 <4d2b3ecd.7c62abb5.bm000@wupperonline.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ingo =?utf-8?Q?Br=C3=BCckl?= <ib@wupperonline.de>
X-From: git-owner@vger.kernel.org Mon Jan 10 18:29:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcLYy-00055i-AE
	for gcvg-git-2@lo.gmane.org; Mon, 10 Jan 2011 18:29:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754533Ab1AJR3k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Jan 2011 12:29:40 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:59315 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754524Ab1AJR3j convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Jan 2011 12:29:39 -0500
Received: by vws16 with SMTP id 16so8189779vws.19
        for <git@vger.kernel.org>; Mon, 10 Jan 2011 09:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=eDhrn3Oe0UFI4xytwvhjPtHuzpnSFN84+sGklGr1mt8=;
        b=Dg4mD+5rs3coyR7cW6jBAaBv7wNFcU9MnmIjLoWEQtdly/zG1QjFVs+vNdIlKIBKva
         14Op5Wm1yl+qgx+fJYIoCRE9RQ5OlKOI6feNpmol3xCqZ4VumBvLy9exRcuBXp+Yh6et
         BK/tnEyr6DjkNVUygjZU7I/Pe3waQniKW869I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=BG35BvCxkLx+fC6WorOhJiS4mlkxJu9EyCtWt7uYZd8cdhvQQkCzy07o1PMubB4NwE
         TL8HLC9/drqkIMoEc+wgF7i2WRLrhz2OXB03thC3PVYDkNGDuDKUXJ1doZ89lLTPw7dw
         z10r0jhoVbDFB7+24JSJD7QPHdzFm7dghlZJo=
Received: by 10.220.181.135 with SMTP id by7mr7785146vcb.258.1294680579001;
        Mon, 10 Jan 2011 09:29:39 -0800 (PST)
Received: from burratino (adsl-69-209-76-37.dsl.chcgil.sbcglobal.net [69.209.76.37])
        by mx.google.com with ESMTPS id r20sm6377323vcf.34.2011.01.10.09.29.37
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 10 Jan 2011 09:29:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4d2b3ecd.7c62abb5.bm000@wupperonline.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164887>

Ingo Br=C3=BCckl wrote:
> Jonathan Nieder wrote on Mon, 10 Jan 2011 10:52:51 -0600:

>> How does output from "sh t1300-repo-config.sh -v -i" end?
>
>   expecting success: git config --rename-section branch.eins branch.z=
wei
>   fatal: No such section!
>   not ok - 50 rename section
>   #       git config --rename-section branch.eins branch.zwei

Thanks.

> The problem is that the last 'git config' worked on other-config due =
to
> variable GIT_CONFIG.

I'm still missing something.

	GIT_CONFIG=3Dother-config git config -l > output
	echo $GIT_CONFIG

should result in no output to stdout, right?  In other words, the
construct

	envvar=3Dvalue git command

is not supposed to pollute the current environment.

It sounds like you've checked that "unset GIT_CONFIG" fixes it; what's
left is to explain why GIT_CONFIG had a value in the first place.

Confused,
Jonathan
