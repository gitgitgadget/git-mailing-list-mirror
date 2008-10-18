From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv6 3/5] gitweb: use_pathinfo filenames start with /
Date: Sun, 19 Oct 2008 01:57:08 +0200
Message-ID: <cb7bb73a0810181657i67d6b9f8o66db9f57bcf01dd3@mail.gmail.com>
References: <1224188831-17767-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <1224188831-17767-3-git-send-email-giuseppe.bilotta@gmail.com>
	 <1224188831-17767-4-git-send-email-giuseppe.bilotta@gmail.com>
	 <200810190126.06697.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Petr Baudis" <pasky@suse.cz>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 19 01:58:34 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrLgg-0005tB-C2
	for gcvg-git-2@gmane.org; Sun, 19 Oct 2008 01:58:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752019AbYJRX5L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Oct 2008 19:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751993AbYJRX5K
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Oct 2008 19:57:10 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:65072 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751798AbYJRX5J (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Oct 2008 19:57:09 -0400
Received: by gxk9 with SMTP id 9so2492556gxk.13
        for <git@vger.kernel.org>; Sat, 18 Oct 2008 16:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=yZ3vOgAMBxq9Dxjw2bbFNqD1kdHuu3Bim5xtczqtcCc=;
        b=hyslwFA1gAM6xtUusMmDxHc4oGTj1YhDOPo4L2HGYNbFFzrCS1XzRu7bYQxJJEpm8t
         8VkA+AXLioWphe3LpbebxJc1cqsYDvINHCTbIIY1+krImGPUqil6YoiebT8p6SjuHq8q
         euUUc9jyybPVA6l5SAvQkuF8atSi98Xpffl2Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=gGQaYOKWLcSf4bCBHEHwTE65r9hw2USieDX5BAUtwU8+jYevMzLaaWmVKgI4I7EF1J
         St2aihsTGtO73g4l06JeVHRXhzIaBQAvDfP49pf3acOGAlOOvEpq46RH0S0+rko3lDTI
         GKoHU82jBv4nN8hA+A6qotIEcsbk50aBpt6Rc=
Received: by 10.90.49.3 with SMTP id w3mr2673040agw.80.1224374228386;
        Sat, 18 Oct 2008 16:57:08 -0700 (PDT)
Received: by 10.90.33.8 with HTTP; Sat, 18 Oct 2008 16:57:08 -0700 (PDT)
In-Reply-To: <200810190126.06697.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98583>

On Sun, Oct 19, 2008 at 1:26 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> On Thu, 16 Oct 2008, Giuseppe Bilotta wrote:
>
>> When using path info, make filenames start with a / (right after the :
>> that separates them from the hash base). This minimal change allows
>> relative navigation to work properly when viewing HTML files in raw
>> ('blob_plain') mode.
>
> This means generating project/action/hash_base:/filename rather than
> earlier project/action/hash_base:filename, isn't it?

Exactly. We _accept_ paths with or without the /, but we always
generate paths with it.

> For example for http://repo.or.cz/w/git.git/html:/git.html links leads
> to correct HTML pages, while for http://repo.or.cz/w/git.git/html:git.html
> they lead to empty gitweb page (no errors, so link checker would be
> fooled).

An idea that could be taken into consideration, if the ability to
navigate web documents is deemed of primary importance, would be a
redirect from the no-slash URL (a hand-coded one, given that with this
patch we only generate slashed URLs) to the slashed URL. Not sure it's
worth the effort (and reparsing) though: it would obviously be MUCH
nicer if we could change the URL without having to actually reload the
document ...


-- 
Giuseppe "Oblomov" Bilotta
